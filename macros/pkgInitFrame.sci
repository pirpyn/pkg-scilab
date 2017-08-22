function fig_handle=pkgInitFrame(data)
  fig_handle = figure('dockable','off',..
  'figure_size',[500,700],..
  'figure_name','Scilab Atoms Package Creator',..
  'tag','pkgMainWindow',..
  'menubar_visible','off',..
  'toolbar_visible','off',..
  'infobar_visible','off',..
  'visible','off',..
  'user_data',data,..
  'layout','gridbag')
endfunction

function pkgBuildFrame(fig_handle,data)
  f = fig_handle;
  pkgAddControl(f,'edit','Toolbox',[1,1])
  pkgAddControl(f,'edit','Title',[1,2])
  pkgAddControl(f,'edit','Summary',[1,3])
  pkgAddControl(f,'edit','Description',[1,4],multiline=1)
  pkgAddControl(f,'edit','Author',[1,5])
  pkgAddControl(f,'edit','Mail',[1,6])
  pkgAddControl(f,'edit','License',[1,7])
  pkgAddControl(f,'edit','LicensePath',[1,8],[2,1])
  pkgAddControl(f,'pushbutton','LicensePath',[4,8],callback='pkgGetPaths(''*.txt'',''Select the license file'',%f);')
  pkgAddControl(f,'edit','Version',[1,9])
  pkgAddControl(f,'edit','Category',[1,10])
  pkgAddControl(f,'edit','HelpLang',[1,11])
  pkgAddControl(f,'edit','Path',[1,12],[2,1])
  pkgAddControl(f,'pushbutton','Path',[4,12],callback='pkgGetPaths(''%dir'',''Select the directory to save'');')
endfunction

function uicontrol_handle=pkgAddControl(frame_handle,style,text,uipos,uisize,multiline,callback)
  try 
    uisize 
  catch 
    if style == 'edit'
      uisize = [3,1]
    else 
      uisize = [1,1]
    end
  end
  
  try multiline; catch multiline = 0;end
  tag =''
  fill = [1,1];
  alignment = 'left';
  backgroundcolor = [-1,-1,-1];
  user_data =[]
  select style
  case 'text'
    fill = [0,1]
    alignment = 'right'
  case 'edit'
    pkgAddControl(frame_handle,'text',text,uipos,[1,1],multiline=0,callback='')
    data = f.user_data
    tag = text
    text = data(tag)
    uipos = uipos + [1,0]
    backgroundcolor = [1,1,1]
  case 'pushbutton'
    alignment = 'center'
    user_data = text;
    text = 'Browse'
  end
  
  ui_h=uicontrol(frame_handle,..
  'style',style,..
  'Constraints',createConstraints('gridbag',[uipos,uisize],fill,'both','center'),..
  'FontName','Monospaced',..
  'Max',multiline,..
  'Min',-1,..
  'String',text,..
  'Tag',tag,..
  'Verticalalignment','middle',..
  'Callback','pkgUpdate();',..
  'user_data',user_data)
  
  if exists('backgroundcolor') then ui_h.backgroundcolor = backgroundcolor;  end
  if exists('alignment') then ui_h.horizontalalignment = alignment; end
  if exists('callback') then ui_h.callback = callback+'pkgUpdate();'; ui_h.callback_type = 0;end

  uicontrol_handle = ui_h
endfunction
