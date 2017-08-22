function pkgGetPaths(mask,titl,multifiles)
  if ~exists('mask') then
    mask = ['*.sce','*.txt','*.xml','*.sci']
  elseif  mask =='%dir'
    paths = uigetdir(home,titl)
  else
    paths = uigetfile(mask,home,titl,multifiles)
  end
  

  fig=pkgGetRootHandle(gcbo)
  tag = gcbo.user_data
  fig.user_data(tag) = paths
  ui_h=get(tag)
  ui_h.String = paths
endfunction
