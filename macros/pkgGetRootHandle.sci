function f=pkgGetRootHandle(h)
  f=h
  count =1
  while f.Type <> 'Figure'
    f=f.Parent
    if count > 100 then 
      error('pkgGetRootHandle: too many''s parent')
      end
  end
endfunction
