function pkgGetPaths(mask,titl,multifiles)
  if ~exists('mask') then
    mask = ['*.sce','*.txt','*.xml','*.sci']
  elseif  mask =='%dir'
    paths = uigetdir(home,titl)
  else
    paths = matrix(uigetfile(mask,home,titl,multifiles),-1,1)
  end
  
  tag = gcbo.user_data
  ui = pkgFindObj(tag)
  ui.String = paths
endfunction
