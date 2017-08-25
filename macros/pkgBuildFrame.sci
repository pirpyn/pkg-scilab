function fig_handle=pkgBuildFrame()
  fig_handle = figure('dockable','off',..
  'figure_name','Scilab Atoms Package Creator',..
  'tag','pkgMainWindow',..
  'figure_size',[600,600],..
  'menubar_visible','off',..
  'toolbar_visible','off',..
  'infobar_visible','on',..
  'resize','on',..
  'visible','off',..
  'layout','gridbag')

  setting_frame = uicontrol(fig_handle,'style','frame','layout','gridbag',..
  'constraints',createConstraints('gridbag',[1,2,1,1],[0,1],'vertical','lower_left',[0,0],[-1,-1]))
  macro_frame   = uicontrol(fig_handle,'style','frame','layout','gridbag',..
  'constraints',createConstraints('gridbag',[2,2,1,1],[1,1],'both','lower_right'),'layout','gridbag')
  info_frame    = uicontrol(fig_handle,'style','frame','layout','gridbag',..
  'constraints',createConstraints('gridbag',[1,1,2,1],[1,0],'horizontal','upper_right'))
  bottom_frame  = uicontrol(fig_handle,'style','frame','layout','gridbag',....
  'constraints',createConstraints('gridbag',[1,4,2,1],[0,0],'both','lower',[0,0],[100,60]))

  //  defining the tabs
  setting_tabs = uicontrol(setting_frame,'style','tab','constraints',createConstraints('gridbag',[1,1,1,1],[1,1],'both','center'))
  macro_tabs   = uicontrol(macro_frame,'style','tab','constraints',createConstraints('gridbag',[1,1,1,1],[1,1],'both','center'))
  info_tabs    = uicontrol(info_frame,'style','tab','constraints',createConstraints('gridbag',[1,1,1,1],[1,1],'both','center'))

  sett_tab  = uicontrol(setting_tabs,'style','frame','layout','gridbag','String','Settings','backgroundcolor',[0,0.5,0])
  macro_tab = uicontrol(macro_tabs,'style','frame','layout','gridbag','String','Macros manager')

  // for tabs: fig.children(1) is the last uicontrol added, so last tab is the first to be defined and so on
  optn_tab  = uicontrol(info_tabs,'style','frame','layout','gridbag','String','Optionnal infos','scrollable',%t)
  basic_tab = uicontrol(info_tabs,'style','frame','layout','gridbag','String','Mandatory infos','scrollable',%t)




  // build the basic panel
  pkgAddControl(basic_tab,'edit','Toolbox Name','Toolbox',[1,1])
  pkgAddControl(basic_tab,'edit','Toolbox Title','Title',[1,2])
  pkgAddControl(basic_tab,'edit',[],'Summary',[1,3])
  pkgAddControl(basic_tab,'edit',[],'Version',[1,4])
  pkgAddControl(basic_tab,'edit',[],'Author',[1,5])
  hdes=pkgAddControl(basic_tab,'edit',[],'Description',[1,6],[3,3],[])
  hdes.max =2
  pkgAddControl(basic_tab,'edit','Save toolbox at','Path',[1,10],[2,1],[])
  pkgAddControl(basic_tab,'pushbutton','Browse','Path',[4,10],[],'pkgGetPaths(''%dir'',''Select the directory to save'');')

  // Build the optionnal panel
  pkgAddControl(optn_tab,'edit',[],'Maintainer',[1,1])
  pkgAddControl(optn_tab,'edit',[],'Mail',[1,2])
  pkgAddControl(optn_tab,'edit',[],'Entity',[1,3])
  pkgAddControl(optn_tab,'edit',[],'WebSite',[1,4])
  pkgAddControl(optn_tab,'edit','License file','LicensePath',[1,5],[2,1],[])
  pkgAddControl(optn_tab,'edit','License','License',[1,5],[2,1],[])
  pkgAddControl(optn_tab,'pushbutton','Browse','LicensePath',[4,5],[],'pkgGetPaths(''*.txt'',''Select the license file'');')
  pkgAddControl(optn_tab,'edit',[],'Date',[1,6])
  pkgAddControl(optn_tab,'edit','Scilab version','ScilabVersion',[1,7])
  depnd=pkgAddControl(optn_tab,'edit','Dependencies','Depends',[1,8])
  depnd.max=2
  pkgAddControl(optn_tab,'edit','Atoms Category','Category',[1,9])
  pkgAddControl(optn_tab,'edit','Help language','HelpLang',[1,10])

  // Build the macro tab
  lst=pkgAddControl(macro_tab,'listbox','Path to the sources .sci','MacrosPath',[1,1],[1,1],[])
  lst.max =2
  lst.tooltipstring = 'toto'
  macro_button_frame=uicontrol(macro_tab,'style','frame','layout','gridbag',..
  'constraints',createConstraints('gridbag',[1,2,1,1],[1,0],'horizontal','lower',[0,0],[0,40]))
  btn=pkgAddControl(macro_button_frame,'pushbutton','Add','MacrosPath',[1,4],[],'pkgGetPaths(''*.sci'',''Select .sci files'',%t);')
  pkgAddControl(macro_button_frame,'pushbutton','Remove','MacrosPath',[2,4],[],'pkgRemoveMacros()')
  pkgAddControl(macro_button_frame,'pushbutton','Edit','MacrosPath',[3,4],[],'pkgEditMacros()')

  // Build the settings tab
  pkgAddControl(sett_tab,'checkbox','Force overwrite','OverWrite',[1,1])
  pkgAddControl(sett_tab,'checkbox','Open toolbox','OpenToolbox',[1,2])

  // button of the bottom frame
  pkgAddControl(bottom_frame,'pushbutton','Generate',[],[2,1],[2,1],'pkgSave();pkgCreate()')
  h=pkgAddControl(bottom_frame,'pushbutton','Install',[],[4,1],[],'pkgInstall()')
  h.tag='install_tag'
  h.enable='off'

  //info=pkgAddControl(bottom_frame,'text',' ','infobar',[1,2],[5,1],'')
  //info.horizontalalignment='center'

endfunction

function uicontrol_handle=pkgAddControl(frame_handle,style,text,tag,uipos,uisize,callback,preferredsize)
  weight = [1,1];
  alignment = 'left';
  backgroundcolor = [-1,-1,-1];
  user_data = []
  fill = 'both'
  anchor = 'center'
  callback_type=0
  function bol=pkgExists(varstr)
    bol = %f
    if exists(varstr) then
      if evstr(varstr+'<>[]') then
        bol = %t
      end
    end
  endfunction

  if ~pkgExists('preferredsize')
    preferredsize = [-1,-1]
  end

  if ~pkgExists('uisize')
    select style
    case 'edit'
      uisize = [3,1]
    else
      uisize = [1,1]
    end
  end

  if ~pkgExists('callback')
    callback = '';
    callback_type=-1;
  end
  if ~pkgExists('tag')
    tag = ''
  end
  if ~pkgExists('text')
    text = tag
  end
  if ~pkgExists('uipos')
    uipos = [1,1]
  end

  select style
  case 'text'
    fill = 'both'
    weight = [0,1]
    alignment = 'right'
    //preferredsize=[-1,20]
  case 'edit'
    fill = 'both'
    //preferredsize=[-1,20]
    pkgAddControl(frame_handle,'text',text,'',uipos,[1,1],'')
    uipos = uipos+[1,0]
    text= pkgInitData(tag)
    backgroundcolor = [1,1,1]
  case 'listbox'
    text = pkgInitData(tag)
  case 'pushbutton'
    alignment = 'center'
    user_data = tag;
    preferredsize = [-1,20]
    tag =''
  case 'checkbox'
    backgroundcolor = [0.7,0.2,0.2]
    fill = 'horizontal'
    weight = [0,0]
    anchor = 'lower'
  end

  uicontrol_handle=uicontrol(frame_handle,..
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
  'callback_type',callback_type,..
  'user_data',user_data)
endfunction

