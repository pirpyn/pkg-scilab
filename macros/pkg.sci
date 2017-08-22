function pkg(varargin)
  data = pkgInitData()
  
  figure_handle=pkgInitFrame(data)
  
  pkgBuildFrame(figure_handle,data)
  figure_handle.visible='on'
endfunction
