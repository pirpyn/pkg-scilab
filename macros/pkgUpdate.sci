function pkgUpdate()
  h = gcbo
  f = pkgGetRootHandle(h)
  select h.type
  case 'edit'
    f.user_data(h.tag) = h.string
  case 'pushbutton'
    h = get()
    h.string = f.user_data(h.tag)
  end
endfunction
