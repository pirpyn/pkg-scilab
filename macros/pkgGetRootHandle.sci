function f=pkgGetRootHandle(h)
  f=h
  while f.parent <> []
    f=f.parent
  end
endfunction
