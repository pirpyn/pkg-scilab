function data=pkgInitData()
  data = struct()
  data.Toolbox = 'foo'
  data.Title = 'Dummy Toolbox'
  data.Summary = 'A dummy toolbox'
  data.Version = '1.0'
  data.Author = 'John Smith'
  data.Maintainer = data.Author
  data.Category = ''
  data.Entity = ''
  data.WebSite =''
  data.License = 'BSD'
  data.LicensePath =''
  data.ScilabVersion ='>= 5.4'
  data.Depends =''
  dte = getdate()
  data.Date = strsubst(strcat(string(dte([6,2,1]))+'-'),'/\-$/','','r')
  data.Description =[..
  'Put all information here. '
  'This can take several lines'
  ]
  data.Mail = 'john@smith'
  data.HelpLang = 'fr_FR'
  data.Path = TMPDIR+filesep()+data.Toolbox

endfunction
