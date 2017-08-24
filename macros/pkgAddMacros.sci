function pkgAddMacros(data)
  for i=1:size(data.MacrosPath,'*')
    if data.MacrosPath(i)==''
      continue
    end
    copyfile(data.MacrosPath(i),data.Path+filesep()+data.Version+filesep()+'macros')
  end
endfunction
