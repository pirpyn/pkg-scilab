function pkgRemoveMacros()
  h=pkgFindObj('MacrosPath')
  if size(h.value,'*')>0 then
    h.string(h.value)=[];
  else
    pkgDisplayInfo('error: No macros selected',[0.5,0,0])
  end
endfunction
