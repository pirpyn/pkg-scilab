function [child,st]=pkgFindObj(tag,parent)
  // same as findobj, but only compute it on the given parent frame
  // usefull if 2 frames have uicontrol with the same tag value
  if argn(2) == 1
    if exists('gcbo')
      parent = pkgGetRootHandle(gcbo)
    else
      parent=gcf()
    end
  end
  st = %f
  child=[]
  if parent.tag == tag then
    st = %t
    child=parent
  else
    if parent.children <> [] then
      for i=1:size(parent.children,'*')
        if ~st then
          [child,st]=pkgFindObj(tag,parent.children(i))
        end
      end
    end
  end
endfunction
