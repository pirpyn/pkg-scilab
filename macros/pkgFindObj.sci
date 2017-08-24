function [child,st]=pkgFindObj(tag,parent)
  // same as findobj, but only compute it on the given parent frame
  // usefull if 2 frames have uicontrol with the same tag value
  if argn(2) ==1
    parent = pkgGetRootHandle(gcbo)
  end
  st = %f

  child=parent
  if parent.children == [] then
    if parent.type == 'uicontrol' then
      if parent.tag == tag
        st = %t
      end
    end
  else
    for i=1:size(parent.children,'*')
      if ~st then
       [child,st]=pkgFindObj(tag,parent.children(i))
      end
    end
  end
endfunction
