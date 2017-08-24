function st=pkgDisplayInfo(str,colr)
  st = %t
  infobar = pkgFindObj('infobar')
  dte =getdate()
  infobar.string=sprintf('[%02d:%02d:%02d]%s',dte(7),dte(8),dte(9),str)
  if argn(2)>1 then
    infobar.foregroundcolor=colr
  end
endfunction
