function pkgBuildFrame(data)
  fig_handle = figure('dockable','off',..
  'figure_size',[600,700],..
  'figure_name','Scilab Atoms Package Creator',..
  'tag','pkgMainWindow',..
  'menubar_visible','off',..
  'toolbar_visible','off',..
  'infobar_visible','off',..
  'visible','on',..
  'user_data',data,..
  'layout','gridbag')
  
  frame_constraints = createConstraints('gridbag',[1,1,1,1],[1,1],'both','center',[0,0],[600,700])
  fset = uicontrol(fig_handle,'style','frame','constraints',frame_constraints,'layout','gridbag')
  
  tab = uicontrol(fset,'style','tab')
  // order of tabs and order of declaration are opposite because fig.children(1) is the last uicontrol added
  fadv = uicontrol(tab,'style','frame','layout','gridbag','String','Optionnal Settings')
  fbase = uicontrol(tab,'style','frame','layout','gridbag','String','Basic Settings')
  
  pkgBuildSettings(fbase)
  pkgBuildOptSettings(fadv)
  
  frame_constraints = createConstraints('gridbag',[1,2,1,1],[1,1],'both','center',[0,0],[600,700])
  fbut = uicontrol(fig_handle,'style','frame','constraints',frame_constraints,'layout','gridbag')
  pkgAddControl(fbut,'pushbutton','Save',[],[1,1],[],'pkgSave',[])
  pkgAddControl(fbut,'pushbutton','Create',[],[2,1],[2,1],'pkgCreate',[])
  h=pkgAddControl(fbut,'pushbutton','Install',[],[4,1],[],'pkgInstall',[])
  h.enable='off'
endfunction

function pkgBuildSettings(f)
  pkgAddControl(f,'edit','Toolbox Name','Toolbox',[1,1],[],[],[])
  pkgAddControl(f,'edit','Toolbox Title','Title',[1,2],[],[],[])
  pkgAddControl(f,'edit',[],'Summary',[1,3],[],[],[])
  pkgAddControl(f,'edit',[],'Version',[1,4],[],[],[])
  pkgAddControl(f,'edit',[],'Author',[1,5],[],[],[])
  pkgAddControl(f,'edit',[],'Description',[1,6],[],[],2)
  pkgAddControl(f,'edit','Save toolbox at','Path',[1,7],[2,1],[],[])
  pkgAddControl(f,'pushbutton','Browse','Path',[3,7],[],'pkgGetPaths(''%dir'',''Select the directory to save'');pkUpdate();',[])
endfunction

function pkgBuildOptSettings(f)
  pkgAddControl(f,'edit',[],'Mail',[1,1],[],[],[])
  pkgAddControl(f,'edit','License file','LicensePath',[1,2],[2,1],[],[])
  pkgAddControl(f,'pushbutton','Browse','LicensePath',[3,2],[],'pkgGetPaths(''*.txt'',''Select the license file'',%f);pkgUpdate();',[])
  pkgAddControl(f,'edit','Atoms Category','Category',[1,3],[],[],[])
  pkgAddControl(f,'edit','Help language','HelpLang',[1,4],[],[],[])

endfunction

function uicontrol_handle=pkgAddControl(frame_handle,style,text,tag,uipos,uisize,callback,multiline)
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
  if multiline == [] then
     multiline = -1
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
    weight =[0,1]
    alignment = 'center'
    user_data = tag;
    tag =''
  end
  
  ui_h=uicontrol(frame_handle,..
  'style',style,..
  'Constraints',createConstraints('gridbag',[uipos,uisize],weight,'both','center'),..
  'FontName','Monospaced',..
  'Max',multiline,..
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
  if multiline > 1 then
    ui_h.scrollable ='on'
  end
  uicontrol_handle = ui_h
endfunction

