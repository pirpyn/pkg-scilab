function pkgSave()
  f = pkgGetRootHandle(gcbo)
  data = pkgGetAllInfo(f)
  f.user_data=data
  pkgDisplayInfo('Updated info successfully',[0,0.7,0])
endfunction

function data=pkgGetAllInfo(frame,data)
  if argn(2)==1 then
    data = struct()
  end
  if frame.children == [] then
    if frame.type == 'uicontrol' then
      select frame.style
      case 'edit' then
        if frame.tag <> '' then
          data(frame.tag) = frame.string
        end
      case 'listbox' then
        if frame.tag <> '' then
          data(frame.tag) = frame.string
        end
      case 'checkbox'
        if frame.tag <> '' then
          data(frame.tag) = frame.value
        end
      end
    end
  else
    for i=1:size(frame.children,'*')
      data=pkgGetAllInfo(frame.children(i),data)
    end
  end
endfunction
