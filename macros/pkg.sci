function pkg(varargin)
  data = pkgInitData()
  
  figure_handle=pkgBuildFrame(data)
  
  figure_handle.visible='on'
endfunction
