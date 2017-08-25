function st=pkgDisplayInfo(str,colr)
  st = %t
  f = pkgFindObj('pkgMainWindow')
  dte = getdate()
  f.info_message=sprintf('[%02d:%02d:%02d]%s',dte(7),dte(8),dte(9),str)
endfunction
