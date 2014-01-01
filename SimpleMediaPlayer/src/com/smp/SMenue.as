/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.SMPEvent;
    
    import flash.events.ContextMenuEvent;
    import flash.events.Event;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import com.utils.AppUtil;

    public final class SMenue {

        public function SMenue():void{
            Main.addEventListener(SMPEvent.SKIN_LOADED, this.init);
        }
        public function init(_arg1:SMPEvent):void{
            var _local5:Array;
            var _local6:ContextMenuItem;
            var _local7:ContextMenuItem;
            var _local8:ContextMenuItem;
            var _local9:ContextMenuItem;
            var _local10:ContextMenuItem;
            var _local11:ContextMenuItem;
            var _local12:ContextMenuItem;
            var _local2:ContextMenu = new ContextMenu();
            _local2.hideBuiltInItems();
            var _local3 :int= 1;
            var _local4:String = AppUtil.gOP(Main.sk.skin_xml, "context_menu", "");
            if (_local4.length){
                _local3 = parseInt(_local4);
            } else {
                _local3 = Config.context_menu;
            };
            if (_local3){
				Main.main.stage.showDefaultContextMenu = true;
                _local5 = [];
                _local6 = new ContextMenuItem(Config.name, true);
                _local6.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.openPage);
                _local5.push(_local6);
                _local7 = new ContextMenuItem(Main.info.queryMessage("menu_fullscreen"), true);
                _local7.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.fullscreenHandler);
                _local5.push(_local7);
                if (_local3 == 1){
                    _local9 = new ContextMenuItem(Main.info.queryMessage("menu_list"), true);
                    _local9.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.listHandler);
                    _local5.push(_local9);
                    _local10 = new ContextMenuItem(Main.info.queryMessage("menu_lrc"), false);
                    _local10.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.lrcHandler);
                    _local5.push(_local10);
                    _local11 = new ContextMenuItem(Main.info.queryMessage("menu_video"), false);
                    _local11.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.videoHandler);
                    _local5.push(_local11);
                    _local12 = new ContextMenuItem(Main.info.queryMessage("menu_option"), false);
                    _local12.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.optionHandler);
                    _local5.push(_local12);
                };
                _local8 = new ContextMenuItem(Main.sk.skin_xml.@name, true);
                _local8.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.skinHandler);
                _local5.push(_local8);
                _local2.customItems = _local5;
				trace("RC.init",_local3);
                
            } else {
                //CMP.cmp.stage.showDefaultContextMenu = false;
                _local2.customItems = [];
            };
            Main.main.contextMenu = _local2;
			
        }
        public function openPage(_arg1:Event):void{
            AppUtil.open(Config.link, Config.link_target);
        }
        public function fullscreenHandler(_arg1:Event):void{
            Main.sendEvent(SMPEvent.VIEW_FULLSCREEN);
        }
        public function listHandler(_arg1:Event):void{
            Main.sendEvent(SMPEvent.VIEW_LIST);
        }
        public function lrcHandler(_arg1:Event):void{
            Main.sendEvent(SMPEvent.VIEW_LRC);
        }
        public function videoHandler(_arg1:Event):void{
            Main.sendEvent(SMPEvent.VIEW_VIDEO);
        }
        public function optionHandler(_arg1:Event):void{
            Main.sendEvent(SMPEvent.VIEW_OPTION);
        }
        public function skinHandler(_arg1:Event):void{
            Main.sendEvent(SMPEvent.SKIN_CHANGE);
        }

    }
}
