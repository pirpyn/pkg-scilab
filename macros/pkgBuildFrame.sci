function fig_handle=pkgBuildFrame(data)
  fig_handle = figure('dockable','off',..
  'figure_name','Scilab Atoms Package Creator',..
  'tag','pkgMainWindow',..
  'menubar_visible','off',..
  'toolbar_visible','off',..
  'infobar_visible','off',..
  'visible','off',..
  'user_data',data,..
  'layout','gridbag')
  
  frame_constraints = createConstraints('gridbag',[1,1,1,1],[1,1],'both','center',[1,1],[0,0])
  center_frame = uicontrol(fig_handle,'style','frame','constraints',frame_constraints,'layout','gridbag')
  
  tabs = uicontrol(center_frame,'style','tab','constraints',createConstraints('gridbag',[1,1,1,1],[1,1],'both','center'))
  // order of tabs and order of declaration are opposite because fig.children(1) is the last uicontrol added
  optn_tab = uicontrol(tabs,'style','frame','layout','gridbag','String','Optionnal Settings')
  basic_tab = uicontrol(tabs,'style','frame','layout','gridbag','String','Basic Settings')
  
  pkgBuildSettings(basic_tab)
  pkgBuildOptSettings(optn_tab)
  
  frame_constraints = createConstraints('gridbag',[1,2,1,1],[1,0],'both','center',[1,1],[0,60])
  bottom_frame = uicontrol(fig_handle,'style','frame','constraints',frame_constraints,'layout','gridbag')
  pkgAddControl(bottom_frame,'pushbutton','Save',[],[1,1],[],'pkgSave()')
  pkgAddControl(bottom_frame,'pushbutton','Generate',[],[2,1],[2,1],'pkgCreate()')
  h=pkgAddControl(bottom_frame,'pushbutton','Install',[],[4,1],[],'pkgInstall()')
  h.enable='off'
endfunction

function pkgBuildSettings(f)
  pkgAddControl(f,'edit','Toolbox Name','Toolbox',[1,1],[],[])
  pkgAddControl(f,'edit','Toolbox Title','Title',[1,2],[],[])
  pkgAddControl(f,'edit',[],'Summary',[1,3],[],[])
  pkgAddControl(f,'edit',[],'Version',[1,4],[],[])
  pkgAddControl(f,'edit',[],'Author',[1,5],[],[])
  hdes=pkgAddControl(f,'edit',[],'Description',[1,6],[3,3],[])
  hdes.max =2
  pkgAddControl(f,'edit','Save toolbox at','Path',[1,10],[2,1],[])
  pkgAddControl(f,'pushbutton','Browse','Path',[4,10],[],'pkgGetPaths(''%dir'',''Select the directory to save'');pkUpdate();')
endfunction

function pkgBuildOptSettings(f)
  pkgAddControl(f,'edit',[],'Mail',[1,1],[],[])
  pkgAddControl(f,'edit','License file','LicensePath',[1,2],[2,1],[])
  pkgAddControl(f,'pushbutton','Browse','LicensePath',[4,2],[],'pkgGetPaths(''*.txt'',''Select the license file'',%f);pkgUpdate();')
  pkgAddControl(f,'edit','Atoms Category','Category',[1,3],[],[])
  pkgAddControl(f,'edit','Help language','HelpLang',[1,4],[],[])

endfunction

function uicontrol_handle=pkgAddControl(frame_handle,style,text,tag,uipos,uisize,callback)
  weight = [1,1];
  alignment = 'left';
  backgroundcolor = [-1,-1,-1];
  user_data = []
  
  if uisize == [] then
    select style
    case 'edit'
      uisize = [3,1]
    else
      uisize = [1,1]
    end
  end
  
  if callback == [] 
     callback = 'pkgUpdate();';
  end
  if tag == [] then
     tag = ''
  end
  if text == [] then
     text = tag
  end
  if uipos == [] then
     uipos = [1,1]
  end
  
  select style
  case 'text'
    weight = [0,1]
    alignment = 'right'
  case 'edit'
    pkgAddControl(frame_handle,'text',text,'',uipos,[1,1],'')
    f = pkgGetRootHandle(frame_handle)
    data = f.user_data
    text = data(tag)
    uipos = uipos + [1,0]
    backgroundcolor = [1,1,1]
  case 'pushbutton'
    weight =[1,1]
    alignment = 'center'
    user_data = tag;
    tag =''
  end
  
  ui_h=uicontrol(frame_handle,..
  'style',style,..
  'Constraints',createConstraints('gridbag',[uipos,uisize],weight,'both','center'),..
  'FontName','Monospaced',..
  'Min',0,..
  'String',text,..
  'Tag',tag,..
  'Verticalalignment','middle',..
  'Callback','pkgUpdate();',..
  'backgroundcolor',backgroundcolor,..
  'horizontalalignment',alignment,...
  'callback',callback,..
  'callback_type',0,..
  'user_data',user_data)
  uicontrol_handle = ui_h
endfunction

