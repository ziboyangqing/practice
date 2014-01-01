/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.SMPEvent;
    import com.smp.events.SMPStates;
    
    import flash.display.StageDisplayState;
    import flash.events.EventDispatcher;
    import flash.geom.Rectangle;
    import flash.system.Capabilities;
    import com.utils.AppUtil;

    public final class SMPCore extends EventDispatcher {

        public function SMPCore():void{
            Main.addEventListener(SMPEvent.VIEW_ITEM, this.itemHandler);
            Main.addEventListener(SMPEvent.VIEW_PLAY, this.playHandler);
            Main.addEventListener(SMPEvent.VIEW_STOP, this.stopHandler);
            Main.addEventListener(SMPEvent.VIEW_PREV, this.prevHandler);
            Main.addEventListener(SMPEvent.VIEW_NEXT, this.nextHandler);
            Main.addEventListener(SMPEvent.VIEW_REWIND, this.rewindHandler);
            Main.addEventListener(SMPEvent.VIEW_FORWARD, this.forwardHandler);
            Main.addEventListener(SMPEvent.VIEW_MUTE, this.muteHandler);
            Main.addEventListener(SMPEvent.VIEW_RANDOM, this.randomHandler);
            Main.addEventListener(SMPEvent.VIEW_REPEAT, this.repeatHandler);
            Main.addEventListener(SMPEvent.VIEW_SINGLE, this.singleHandler);
            Main.addEventListener(SMPEvent.VIEW_LIST, this.wlHandler);
            Main.addEventListener(SMPEvent.VIEW_LRC, this.wrHandler);
            Main.addEventListener(SMPEvent.VIEW_VIDEO, this.wmHandler);
            Main.addEventListener(SMPEvent.VIEW_OPTION, this.woHandler);
            Main.addEventListener(SMPEvent.VIEW_CONSOLE, this.wcHandler);
            Main.addEventListener(SMPEvent.VIEW_PROGRESS, this.progressHandler);
            Main.addEventListener(SMPEvent.VIEW_VOLUME, this.volumeHandler);
            Main.addEventListener(SMPEvent.VIEW_FULLSCREEN, this.fullscreenHandler);
            Main.addEventListener(SMPEvent.VIEW_LINK, this.linkHandler);
            Main.addEventListener(SMPEvent.VIEW_MORE, this.moreHandler);
            Main.addEventListener(SMPEvent.VIDEO_MAX, this.videoMaxHandler);
            Main.addEventListener(SMPEvent.LRC_MAX, this.lrcMaxHandler);
        }
		//追踪检验
        public static function ck(_arg1:String):void{
            var _local3:Array;
            var _local2:Array = AppUtil.array(_arg1);
            if ((((4 == _local2.length)) && ((59 == _local2.join("").length)))){
                AppUtil.cmp = _local2;
                _local3 = [(Main + ""), Main.NAME, Main.LINK];
				if (AppUtil.same(_local3, AppUtil.cmp)){
                    return;
                };
            };
			trace("-------------");
            Main.sendEvent(CS.ERROR, _local2);
			trace("=============");
        }

        public function itemHandler(_arg1:SMPEvent):void{
            var _local5:TN;
            var _local6:TD;
            var _local2:Boolean = _arg1.data;
            var _local3:int = Main.tr.length;
            var _local4:int = Main.tr.selectedIndex;
            if (_local3 > 0){
                if ((((_local4 == -1)) || ((_local4 >= _local3)))){
                    _local4 = 0;
                    Main.tr.selectedIndex = _local4;
                };
                Config.play_id = (_local4 + 1);
                Main.setCookie("play_id", Config.play_id, true);
                if ((Main.tr.selectedItem is TN)){
                    _local5 = (Main.tr.selectedItem as TN);
                    if ((((_local5.node_type == CS.NODE_ITEM)) || (_local5.src))){
                        this.itemLoad(_local5);
                        return;
                    };
                    if (_local2){
                        _local5.toggle();
                        return;
                    };
                    _local6 = Main.tr.data;
                    if (((!(_local5.opened)) && (((Config.auto_open) || ((_local6.getIndices().length == 0)))))){
                        if (_local5.children.length > 0){
                            _local5.open();
                        } else {
                            _local5.addEventListener(SMPEvent.ITEM_LOADED, this.itemLoaded);
                            _local5.open();
                            return;
                        };
                    };
                    if (this.itemCheck(_local6)){
                        Main.sendEvent(SMPEvent.CONTROL_NEXT);
                        return;
                    };
                };
            };
            Main.sendEvent(SMPEvent.CONTROL_STOP);
        }
        public function itemLoaded(_arg1:SMPEvent):void{
            var _local2:TN = (_arg1.data as TN);
            if (!_local2){
                return;
            };
            _local2.removeEventListener(SMPEvent.ITEM_LOADED, this.itemLoaded);
            if (this.itemCheck(Main.tr.data)){
                Main.sendEvent(SMPEvent.CONTROL_NEXT);
            } else {
                Main.sendEvent(SMPEvent.CONTROL_STOP);
            };
        }
        public function itemCheck(_arg1:TD):Boolean{
            if (_arg1){
                if ((((_arg1.getIndices().length > 0)) || (((Config.auto_open) && ((_arg1.getIndices(false).length > 0)))))){
                    return (true);
                };
            };
            return (false);
        }
        public function itemLoad(_arg1:TN):void{
            _arg1.reload = false;
            _arg1.data = false;
            Main.item = _arg1;
            Main.sendEvent(SMPEvent.CONTROL_LOAD);
        }
        public function playHandler(_arg1:SMPEvent):void{
            var _local2:int;
            if (_arg1.data != null){
                _local2 = parseInt(_arg1.data.toString());
                if (_local2){
                    Config.play_id = _local2;
                    Main.mm.qT((_local2 - 1));
                    return;
                };
            };
            switch (Config.state){
                case SMPStates.CONNECTING:
                    this.stopHandler();
                    break;
                case SMPStates.BUFFERING:
                case SMPStates.PAUSED:
                    Main.sendEvent(SMPEvent.CONTROL_PLAY);
                    break;
                case SMPStates.PLAYING:
                    Main.sendEvent(SMPEvent.CONTROL_PAUSE);
                    break;
                default:
                    Main.sendEvent(SMPEvent.VIEW_ITEM);
            };
        }
        public function stopHandler(_arg1:SMPEvent=null):void{
            Main.sendEvent(SMPEvent.CONTROL_STOP);
        }
        public function prevHandler(_arg1:SMPEvent):void{
            Main.sendEvent(SMPEvent.CONTROL_PREV);
        }
        public function nextHandler(_arg1:SMPEvent):void{
            Main.sendEvent(SMPEvent.CONTROL_NEXT);
        }
        public function rewindHandler(_arg1:SMPEvent):void{
            Main.sendEvent(SMPEvent.CONTROL_PROGRESS, -(Config.forward_time));
        }
        public function forwardHandler(_arg1:SMPEvent):void{
            Main.sendEvent(SMPEvent.CONTROL_PROGRESS, Config.forward_time);
        }
        public function randomHandler(_arg1:SMPEvent):void{
            this.playmodeHandler(CS.MODE_RANDOM);
        }
        public function repeatHandler(_arg1:SMPEvent):void{
            this.playmodeHandler(CS.MODE_REPEAT);
        }
        public function singleHandler(_arg1:SMPEvent):void{
            this.playmodeHandler(CS.MODE_SINGLE);
        }
        public function playmodeHandler(_arg1:String):void{
            if (Config.play_mode != _arg1){
                Config.play_mode = _arg1;
            } else {
                Config.play_mode = CS.MODE_NORMAL;
            };
            Main.sendEvent(SMPEvent.CONTROL_PLAYMODE);
        }
        public function wlHandler(_arg1:SMPEvent):void{
            Main.sendEvent(SMPEvent.CONTROL_WIN, Main.wl);
        }
        public function wmHandler(_arg1:SMPEvent):void{
            Main.sendEvent(SMPEvent.CONTROL_WIN, Main.wm);
        }
        public function wrHandler(_arg1:SMPEvent):void{
            Main.sendEvent(SMPEvent.CONTROL_WIN, Main.wr);
        }
        public function woHandler(_arg1:SMPEvent):void{
            Main.sendEvent(SMPEvent.CONTROL_WIN, Main.wo);
        }
        public function wcHandler(_arg1:SMPEvent):void{
            Main.sendEvent(SMPEvent.CONTROL_WIN, Main.wc);
        }
        public function fullscreenHandler(_arg1:SMPEvent):void{
            var ds:* = null;
            var e:* = _arg1;
            var fs:* = AppUtil.gOP(Main.sk.skin_xml.console.bt_fullscreen, "fullscreen_scale", Config.fullscreen_scale);
            var sc:* = AppUtil.per(fs);
            var sw:* = Math.round((Capabilities.screenResolutionX * sc));
            var sh:* = Math.round((Capabilities.screenResolutionY * sc));
            var rt:* = new Rectangle(0, 0, sw, sh);
            if (Config.fullscreen){
                ds = StageDisplayState.NORMAL;
            } else {
                ds = StageDisplayState.FULL_SCREEN;
            };
            try {
                Main.main.stage.fullScreenSourceRect = rt;
                Main.main.stage.displayState = ds;
            } catch(e:Error) {
                O.o(e);
            };
        }
        public function linkHandler(_arg1:SMPEvent):void{
            var _local2:XMLList = Main.sk.skin_xml.console.bt_link;
            this.linkOpen(_arg1, _local2);
        }
        public function moreHandler(_arg1:SMPEvent):void{
            var _local2:XMLList = Main.sk.skin_xml.console.bt_more;
            this.linkOpen(_arg1, _local2);
        }
        public function linkOpen(_arg1:SMPEvent, _arg2:XMLList):void{
            var _local3:String = AppUtil.gOP(_arg2, "link", Config.link);
            var _local4:String = AppUtil.gOP(_arg2, "target", Config.link_target);
            if (_arg1.data != null){
                _local3 = _arg1.data.toString();
            };
            if (_local3){
                _local3 = AppUtil.auto(_local3, Main.item);
                _local3 = AppUtil.auto(_local3, Config);
                AppUtil.open(_local3, _local4);
            };
        }
        public function videoMaxHandler(_arg1:SMPEvent):void{
            if (_arg1.data != null){
                Config.video_max = AppUtil.tof(_arg1.data.toString());
            } else {
                Config.video_max = !(Config.video_max);
            };
            Config.lrc_max = false;
            this.maxSave();
            Main.sendEvent(SMPEvent.CONTROL_MAX, SMPEvent.VIDEO_MAX);
        }
        public function lrcMaxHandler(_arg1:SMPEvent):void{
            if (_arg1.data != null){
                Config.lrc_max = AppUtil.tof(_arg1.data.toString());
            } else {
                Config.lrc_max = !(Config.lrc_max);
            };
            Config.video_max = false;
            this.maxSave();
            Main.sendEvent(SMPEvent.CONTROL_MAX, SMPEvent.LRC_MAX);
        }
        public function maxSave():void{
            Main.setCookie("video_max", Config.video_max);
            Main.setCookie("lrc_max", Config.lrc_max);
        }
        public function progressHandler(_arg1:SMPEvent):void{
            if (Main.item.seekable){
                Main.sendEvent(SMPEvent.CONTROL_PROGRESS, _arg1.data);
            };
        }
        public function volumeHandler(_arg1:SMPEvent):void{
            var _local2:String;
            var _local3:Array;
            var _local4:Number;
            if (_arg1.data != null){
				//trace("core:volumeHandler_arg1.data",_arg1.data);
                _local2 = _arg1.data.toString();
                _local3 = AppUtil.array(_local2);
                _local4 = AppUtil.per(_local3[0]);
                Config.volume = Number(_local3[0]);//_local4;
                Main.setCookie("volume", _local4);
                if (_local3.length > 1){
                    Config.panning = AppUtil.clamp(Number(_local3[1]), -1, 1);
                };
            };
			//trace("core:volumeHandler",Config.volume);
            Config.mute = (Config.volume) ? false : true;
            Main.sendEvent(SMPEvent.CONTROL_MUTE);
            Main.sendEvent(SMPEvent.CONTROL_VOLUME);
        }
        public function muteHandler(_arg1:SMPEvent):void{
            if (_arg1.data != null){
                Config.mute = AppUtil.tof(_arg1.data.toString());
            } else {
                Config.mute = !(Config.mute);
            };
            if (Config.mute){
                Config.mute_volume = (Config.volume) ? Config.volume : 0.8;
                Config.volume = 0;
            } else {
                Config.volume = Config.mute_volume;
            };
            Main.sendEvent(SMPEvent.CONTROL_MUTE);
            Main.sendEvent(SMPEvent.CONTROL_VOLUME);
        }

    }
}
