function fig_handle=pkgBuildFrame()
  fig_handle = figure('dockable','off',..
  'figure_name','Scilab Atoms Package Creator',..
  'tag','pkgMainWindow',..
  'figure_size',[600,900],..
  'menubar_visible','off',..
  'toolbar_visible','off',..
  'infobar_visible','off',..
  'visible','off',..
  'layout','gridbag')

  // fig.children(1) is the last uicontrol added, so last tab is the first to be defined and so on
  setting_frame = uicontrol(fig_handle,'style','frame','constraints',createConstraints('gridbag',[1,3,1,1],[1,1],'both','center',[1,1],[0,0]),'layout','gridbag')
  tabs = uicontrol(setting_frame,'style','tab','constraints',createConstraints('gridbag',[1,1,1,1],[1,1],'both','center'))
  sett_tab = uicontrol(tabs,'style','frame','layout','gridbag','String','pkg Settings')
  
  macro_frame = uicontrol(fig_handle,'style','frame','constraints',createConstraints('gridbag',[2,3,1,1],[1,1],'both','center',[1,1],[0,0]),'layout','gridbag')
  tabs = uicontrol(macro_frame,'style','tab','constraints',createConstraints('gridbag',[1,1,1,1],[1,1],'both','center'))
  macro_tab = uicontrol(tabs,'style','frame','layout','gridbag','String','Macros')
  
  optn_frame = uicontrol(fig_handle,'style','frame','constraints',createConstraints('gridbag',[1,2,2,1],[1,1],'both','center',[1,1],[0,0]),'layout','gridbag')
  tabs = uicontrol(optn_frame,'style','tab','constraints',createConstraints('gridbag',[1,1,1,1],[1,1],'both','center'))
  optn_tab  = uicontrol(tabs,'style','frame','layout','gridbag','String','Optionnal infos')

  basic_frame = uicontrol(fig_handle,'style','frame','constraints',createConstraints('gridbag',[1,1,2,1],[1,1],'both','center',[1,1],[0,0]),'layout','gridbag')
  tabs = uicontrol(basic_frame,'style','tab','constraints',createConstraints('gridbag',[1,1,1,1],[1,1],'both','center'))
  basic_tab = uicontrol(tabs,'style','frame','layout','gridbag','String','Mandatory infos')

  // build the basic panel
  pkgAddControl(basic_tab,'edit','Toolbox Name','Toolbox',[1,1],[],[])
  pkgAddControl(basic_tab,'edit','Toolbox Title','Title',[1,2],[],[])
  pkgAddControl(basic_tab,'edit',[],'Summary',[1,3],[],[])
  pkgAddControl(basic_tab,'edit',[],'Version',[1,4],[],[])
  pkgAddControl(basic_tab,'edit',[],'Author',[1,5],[],[])
  hdes=pkgAddControl(basic_tab,'edit',[],'Description',[1,6],[3,3],[])
  hdes.max =2
  pkgAddControl(basic_tab,'edit','Save toolbox at','Path',[1,10],[2,1],[])
  pkgAddControl(basic_tab,'pushbutton','Browse','Path',[4,10],[],'pkgGetPaths(''%dir'',''Select the directory to save'');')
  
  // Build the optionnal panel
  pkgAddControl(optn_tab,'edit',[],'Maintainer',[1,1],[],[])
  pkgAddControl(optn_tab,'edit',[],'Mail',[1,2],[],[])
  pkgAddControl(optn_tab,'edit',[],'Entity',[1,3],[],[])
  pkgAddControl(optn_tab,'edit',[],'WebSite',[1,4],[],[])
  pkgAddControl(optn_tab,'edit','License file','LicensePath',[1,5],[2,1],[])
  pkgAddControl(optn_tab,'edit','License','License',[1,5],[2,1],[])
  pkgAddControl(optn_tab,'pushbutton','Browse','LicensePath',[4,5],[],'pkgGetPaths(''*.txt'',''Select the license file'');')
  pkgAddControl(optn_tab,'edit',[],'Date',[1,6],[],[])
  pkgAddControl(optn_tab,'edit','Scilab version','ScilabVersion',[1,7],[],[])
  depnd=pkgAddControl(optn_tab,'edit','Dependencies','Depends',[1,8],[],[])
  depnd.max=2
  pkgAddControl(optn_tab,'edit','Atoms Category','Category',[1,9],[],[])
  pkgAddControl(optn_tab,'edit','Help language','HelpLang',[1,10],[],[])
  
  // Build the macro tab
  lst=pkgAddControl(macro_tab,'listbox','Path to the sources .sci','MacrosPath',[1,1],[1,1],[])
  lst.max =2
  macro_button_frame=uicontrol(macro_tab,'style','frame','constraints',createConstraints('gridbag',[1,2,1,1],[1,0],'both','center',[1,1],[0,40]),'layout','gridbag')
  
  btn=pkgAddControl(macro_button_frame,'pushbutton','Add','MacrosPath',[1,4],[],'pkgGetPaths(''*.sci'',''Select .sci files'',%t);')
  pkgAddControl(macro_button_frame,'pushbutton','Remove','MacrosPath',[2,4],[],'pkgRemoveMacros()')
  pkgAddControl(macro_button_frame,'pushbutton','Edit','MacrosPath',[3,4],[],'pkgEditMacros()')

  // Build the settings tab
  pkgAddControl(sett_tab,'checkbox','Force overwrite','OverWrite',[1,1],[],[])
  pkgAddControl(sett_tab,'checkbox','Open toolbox','OpenToolbox',[1,2],[],[])
  
  // Bottom frame with the 2 main button save and install + text infobar
  bottom_frame = uicontrol(fig_handle,'style','frame','constraints',createConstraints('gridbag',[1,4,2,1],[0,0],'both','center',[30,10],[100,60]),'layout','gridbag')
  pkgAddControl(bottom_frame,'pushbutton','Generate',[],[2,1],[2,1],'pkgSave();pkgCreate()')
  h=pkgAddControl(bottom_frame,'pushbutton','Install',[],[4,1],[],'pkgInstall()')
  h.tag='install_tag'
  h.enable='off'
  info=pkgAddControl(bottom_frame,'text',' ','infobar',[1,2],[5,1],'')
  info.horizontalalignment='center'
endfunction

function uicontrol_handle=pkgAddControl(frame_handle,style,text,tag,uipos,uisize,callback)
  weight = [1,1];
  alignment = 'left';
  backgroundcolor = [-1,-1,-1];
  user_data = []
  fill = 'both'
  anchor = 'center'
  
  if uisize == [] then
    select style
    case 'edit'
      uisize = [3,1]
    else
      uisize = [1,1]
    end
  end

  if callback == [] 
    callback = '';
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
    text = pkgInitData(tag)
    uipos = uipos + [1,0]
    backgroundcolor = [1,1,1]
  case 'listbox'
    text = pkgInitData(tag)
    backgroundcolor = [1,1,1]
  case 'pushbutton'
    weight =[1,1]
    alignment = 'center'
    user_data = tag;
    tag =''
  case 'checkbox'
    fill = 'none'
    weight = [1,0]
    anchor = 'upper_left'
  end

  ui_h=uicontrol(frame_handle,..
  'style',style,..
  'Constraints',createConstraints('gridbag',[uipos,uisize],weight,fill,anchor),..
  'FontName','Monospaced',..
  'Max',1,..
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

