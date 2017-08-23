function pkgQuit()
  f = pkgGetRootHandle(gcbo)
  btn = messagebox('All modification will be lost.','Exit','warning',['Continue','Cancel'],'modal')
  
  if btn==1 then
    xdel(f.figure_id)
  end
endfunction
