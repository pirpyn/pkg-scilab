function value=pkgInitData(key)
  data = struct()
  data.Toolbox = 'foo'
  data.Title = 'the Foo toolbox'
  data.Summary = 'A dummy toolbox automatically generated'
  data.Version = '1.0'
  data.Author = 'John Smith'
  data.Maintainer = ''
  data.Category = ''
  data.Entity = ''
  data.WebSite =''
  data.License = 'BSD'
  data.LicensePath =''
  data.ScilabVersion ='>= 5.4'
  data.Depends =''
  dte = getdate()
  data.Date = msprintf('%02d-%02d-%4d',dte(6),dte(2),dte(1))
  data.Description =[..
  'Put all information here. '
  'This can take several lines'
  ]
  data.Mail = ''
  data.HelpLang = 'fr_FR'
  data.Path = TMPDIR
  data.MacrosPath=''
  value = data(key)
endfunction
