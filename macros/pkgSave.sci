function pkgSave()
  f = pkgGetRootHandle(gcbo)
  n = size(f.children,'*')
  for i = 1:n
    if f.children(i).type == 'uicontrol'
      if f.children(i).style == 'edit'
        if f.children(i).tag <> ''
          disp(f.children(i).tag)
          f.user_data(f.children(i).tag) = f.children(i).string
        end
      end
    end
  end
endfunction
