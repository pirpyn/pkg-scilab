function pkgShowToolbox(path)
  select getos()
  case 'Linux'
    unix('xdg-open '+path)
  case 'Windows'
    unix('explorer.exe '+path)
  end
endfunction
