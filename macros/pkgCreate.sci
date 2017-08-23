function pkgCreate()
  f = pkgGetRootHandle(gcbo)
  data = f.user_data

  createdir(data.Path)
  createdir(data.Path+filesep()+data.Version)
  data.Path = data.Path+filesep()+data.Version
  pkgCreateBuilder(data)
  pkgCreateEtc(data)
  pkgCreateHelp(data)
  pkgCreateMacros(data)

  pkgCreateDESCRIPTION(data)
  pkgCreateLicense(data)

  pkgShowToolbox(data.Path)
endfunction

function pkgCreateBuilder(data)
  builder_file=[..
  pkgHeader(data);..
  'mode(-1);'
  'lines(0);'
  ''
  'function main_builder()'
  '    TOOLBOX_NAME  = '''+data.Toolbox+''';'
  '    TOOLBOX_TITLE = '''+data.Title+''';'
  '    toolbox_dir   = get_absolute_file_path(''builder.sce'');'
  ''
  '    // Check Scilab''s version'
  '    // ============================================================================='
  ''
  '    try'
  '        v = getversion(''scilab'');'
  '    catch'
  '        error(gettext(''Scilab 5.3 or more is required.''));'
  '    end'
  ''
  '    if v(1) < 5 & v(2) < 3 then'
  '        // new API in scilab 5.3'
  '        error(gettext(''Scilab 5.3 or more is required.''));'
  '    end'
  ''
  '   // Check modules_manager module availability'
  '   // ============================================================================='
  ''
  '    if ~isdef(''tbx_build_loader'') then'
  '        error(msprintf(gettext(''%s module not installed.''), ''modules_manager''));'
  '    end'
  ''
  '    // Action'
  '    // ============================================================================='
  ''
  '    tbx_builder_macros(toolbox_dir);'
  '    tbx_builder_help(toolbox_dir);'
  '    tbx_build_loader(TOOLBOX_NAME, toolbox_dir);'
  '    tbx_build_cleaner(TOOLBOX_NAME, toolbox_dir);'
  'endfunction'
  '// ============================================================================='
  'main_builder();'
  'clear main_builder; // remove main_builder on stack'
  '// ============================================================================='
  ]

  mputl(builder_file,data.Path+filesep()+'builder.sce')

endfunction

function pkgCreateEtc(data)
  s = filesep();
  createdir(data.Path+s+'etc')

  start_file = [..
  pkgHeader(data);..
  ''
  'function tbxlib = startModule()'
  ''
  '    TOOLBOX_NAME  = '''+data.Toolbox+''';'
  '    TOOLBOX_TITLE = '''+data.Title+''';'
  ''
  '  mprintf(''Start '' + TOOLBOX_TITLE + ''\n'');'
  ''
  '  if isdef(TOOLBOX_TITLE+''lib'') then'
  '    warning(TOOLBOX_TILE+'' library is already loaded'');'
  '    return;'
  '  end'
  ''
  '  etc_tlbx  = get_absolute_file_path(TOOLBOX_NAME+''.start'');'
  '  etc_tlbx  = getshortpathname(etc_tlbx);'
  '  root_tlbx = strncpy( etc_tlbx, length(etc_tlbx)-length(''\etc\'') );'
  ''
  '  //Load  functions library'
  '  // ============================================================================='
  '    mprintf(''\tLoad macros\n'');'
  '    pathmacros = pathconvert( root_tlbx ) + ''macros'' + filesep();'
  '    tbxlib = lib(pathmacros);'
  '  '
  '  // Load and add help chapter'
  '  // ============================================================================='
  '  if or(getscilabmode() == [''NW'';''STD'']) then'
  '    mprintf(''\tLoad help\n'');'
  '    path_addchapter = pathconvert(root_tlbx+''/jar'');'
  '    if ( isdir(path_addchapter) <> [] ) then'
  '      add_help_chapter(TOOLBOX_NAME, path_addchapter, %F);'
  '    end'
  '  end'
  'endfunction'
  ''
  data.Toolbox+'lib = startModule();'
  'clear startModule; // remove startModule on stack'
  ''
  ]

  quit_file = [..
  pkgHeader(data);..
  ]

  mputl(start_file,data.Path+s+'etc'+s+data.Toolbox+'.start')
  mputl(quit_file,data.Path+s+'etc'+s+data.Toolbox+'.quit')
endfunction

function pkgCreateHelp(data)
  s = filesep()

  builder_help_file=[..
  pkgHeader(data);..
  'tbx_builder_help_lang(['''+data.HelpLang+'''],get_absolute_file_path(''builder_help.sce''));'
  ]

  cleaner_help_file=[..
  pkgHeader(data);
  'function cleaner_help()'
  '  path = get_absolute_file_path(""cleaner_help.sce"");'
  '  langdirs = dir(path);'
  '  langdirs = langdirs.name(langdirs.isdir);'
  ''
  '  for l = 1:size(langdirs, ""*"")'
  '      masterfile = fullpath(path + filesep() + langdirs(l) + ""/master_help.xml"");'
  '      mdelete(masterfile);'
  ''
  '     jarfile = fullpath(path + ""/../jar/scilab_"" + langdirs(l) + ""_help.jar"");'
  '      mdelete(jarfile);'
  ''
  '      tmphtmldir = fullpath(path + ""/"" + langdirs(l) + ""/scilab_"" + langdirs(l) + ""_help"");'
  '      rmdir(tmphtmldir, ""s"");'
  '  end'
  'endfunction'
  ''
  'cleaner_help();'
  'clear cleaner_help;'
  ''
  ]

  createdir(data.Path+s+'help')
  mputl(builder_help_file,data.Path+s+'help'+s+'builder_help.sce')
  mputl(cleaner_help_file,data.Path+s+'help'+s+'cleaner_help.sce')

  build_help_file=[..
  pkgHeader(data);..
  'tbx_build_help(TOOLBOX_TITLE,get_absolute_file_path(''build_help.sce''));'
  ]

  createdir(data.Path+s+'help'+s+data.HelpLang)
  mputl(build_help_file,data.Path+s+'help'+s+data.HelpLang+s+'build_help.sce')
endfunction

function pkgCreateMacros(data)
  s = filesep()

  buildmacros_file=[..
  pkgHeader(data);..
  'function buildmacros()'
  '  macros_path = get_absolute_file_path(''buildmacros.sce'');'
  '  tbx_build_macros(TOOLBOX_NAME, macros_path);'
  'endfunction'  
  ''
  'buildmacros();'
  'clear buildmacros; // remove buildmacros on stack'
  ''
  ]

  cleanmacros_file=[..
  pkgHeader(data);..
  'function cleanmacros()'
  ''
  '  libpath = get_absolute_file_path(''cleanmacros.sce'');'
  ''
  '  binfiles = ls(libpath+''/*.bin'');'
  '  for i = 1:size(binfiles,''*'')'
  '     mdelete(binfiles(i));'
  '  end'
  ''
  ' mdelete(libpath+''/names'');'
  ' mdelete(libpath+''/lib'');'
  'endfunction'
  ''
  'cleanmacros();'
  'clear cleanmacros; // remove cleanmacros on stack'
  ''
  ]

  createdir(data.Path+s+'macros')
  mputl(buildmacros_file,data.Path+s+'macros'+s+'buildmacros.sce')
  mputl(cleanmacros_file,data.Path+s+'macros'+s+'cleanmacros.sce')
endfunction

function pkgCreateDESCRIPTION(data)
  fields=fieldnames(data)

  description_file = [..
  'Toolbox: '+data.Toolbox
  ''
  'Title: '+data.Title
  ''
  'Summary: '+data.Summary
  ''
  'Version: '+data.Version
  ''
  'Author: '+data.Author
  ''
  'Maintainer: '+data.Maintainer+' <'+data.Mail+'>'
  ''
  'Category: '+data.Category(1)
  ' '+data.Category(2:$)
  ''
  'Entity: '+data.Entity
  ''
  'WebSite: '+data.WebSite
  ''
  'License: '+data.License
  ''
  'ScilabVersion: '+data.ScilabVersion
  ''
  'Depends: '+data.Depends(1)
  ' '+data.Depends(2:$)
  ''
  'Date: '+data.Date
  ''
  'Description: '+data.Description(1)
  '  '+data.Description(2:$)
  ''
  ]

  mputl(description_file,data.Path+filesep()+'DESCRIPTION')
endfunction

function pkgCreateLicense(data)
  s = filesep()

  if data.LicensePath <> '' then
    copyfile(data.LicensePath,data.Path+s+'license.txt')
  else
    license_file=[..
    'License '+data.License+' Copyright (c) '+data.Date+', '+data.Author+' <'+data.Mail+'>'
    'All rights reserved.'
    'Redistribution and use in source and binary forms, with or without'
    'modification, are permitted provided that the following conditions are met:'
    ''
    '* Redistributions of source code must retain the above copyright'
    '  notice, this list of conditions and the following disclaimer.'
    '* Redistributions in binary form must reproduce the above copyright'
    '  notice, this list of conditions and the following disclaimer in the'
    '  documentation and/or other materials provided with the distribution.'
    '* Neither the name of the author nor the names of its contributors may'
    '  be used to endorse or promote products derived from this software '
    '  without specific prior written permission.'
    ''
    'THIS SOFTWARE IS PROVIDED  ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES,'
    'INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY  '
    'AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL '
    'THE REGENTS AND CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,'
    'SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,'
    'PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;'
    'OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,'
    'WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE '
    'OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF '
    'ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.'
    ''
    ]
    mputl(license_file,data.Path+s+'license.txt')
  end

endfunction

function str=pkgHeader(data)
  str = [..
  '// Package '+data.Toolbox+' by '+data.Author+' <'+data.Mail+'>, made with Scilab Atoms Package Creator v1.0'
  '// This package is released under the '+data.License+' license. See license.txt'
  '// ========================================================================================================'
  ]
endfunction
