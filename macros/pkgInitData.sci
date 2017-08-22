function data=pkgInitData()
  data = struct()
  data.Toolbox = 'foo'
  data.Title = 'Dummy Toolbox'
  data.Summary = 'A dummy toolbox'
  data.Description =[..
  'Put all needed information here.'
  'This can take several lines'
  ]
  data.Author = 'John Smith'
  data.Mail = 'john@smith'
  data.License = 'CeCiLL'
  data.LicensePath =''
  data.HelpLang = 'fr_FR'
  data.Version = '1.0'
  data.ScilabVersion ='>= 5.4'
  data.Path = TMPDIR+filesep()+data.Toolbox
  data.Category = ''
  data.Maintainer = ''
endfunction
