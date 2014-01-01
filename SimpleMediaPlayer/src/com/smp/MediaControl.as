/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.SMPEvent;
    import com.smp.events.SMPStates;
    import com.smp.events.UIEvent;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.utils.clearInterval;
    import flash.utils.clearTimeout;
    import flash.utils.setInterval;
    import flash.utils.setTimeout;
    import com.utils.AppUtil;

    public final class MediaControl extends W {

        public var bas:Sprite;
        public var top:Sprite;
        public var image:Y;
        public var progress:Slide;
        public var volume:Slide;
        public var indicator:IN;
        public var bt_play:SButton;
        public var bt_stop:SButton;
        public var bt_prev:SButton;
        public var bt_next:SButton;
        public var bt_rewind:SButton;
        public var bt_forward:SButton;
        public var bt_mute:SButton;
        public var bt_random:SButton;
        public var bt_repeat:SButton;
        public var bt_single:SButton;
        public var bt_list:SButton;
        public var bt_lrc:SButton;
        public var bt_video:SButton;
        public var bt_option:SButton;
        public var bt_fullscreen:SButton;
        public var bt_link:SButton;
        public var bt_more:SButton;
        public var title:TT;
        public var status:TT;
        public var time:TT;
        public var time_position:TT;
        public var time_duration:TT;
        public var number:N;
        public var hover_volume:Boolean = false;
        public var SLIDERS:Object;
        public var BUTTONS:Object;
        private var outid:uint;
        private var intid:uint;

        public function MediaControl():void{
            var _local1:String;
            var _local2:String;
            var _local3:Slide;
            var _local4:SButton;
            this.bas = new Sprite();
            this.top = new Sprite();
            this.image = new Y();
            this.progress = new Slide(false, true, true);
            this.volume = new Slide(true, false, false);
            this.indicator = new IN();
            this.bt_play = new SButton();
            this.bt_stop = new SButton();
            this.bt_prev = new SButton();
            this.bt_next = new SButton();
            this.bt_rewind = new SButton();
            this.bt_forward = new SButton();
            this.bt_mute = new SButton();
            this.bt_random = new SButton();
            this.bt_repeat = new SButton();
            this.bt_single = new SButton();
            this.bt_list = new SButton();
            this.bt_lrc = new SButton();
            this.bt_video = new SButton();
            this.bt_option = new SButton();
            this.bt_fullscreen = new SButton();
            this.bt_link = new SButton();
            this.bt_more = new SButton();
            this.title = new TT();
            this.status = new TT();
            this.time = new TT(false);
            this.time_position = new TT(false);
            this.time_duration = new TT(false);
            this.number = new N();
            this.SLIDERS = {
                progress:SMPEvent.VIEW_PROGRESS,
                volume:SMPEvent.VIEW_VOLUME
            };
            this.BUTTONS = {
                bt_play:SMPEvent.VIEW_PLAY,
                bt_stop:SMPEvent.VIEW_STOP,
                bt_prev:SMPEvent.VIEW_PREV,
                bt_next:SMPEvent.VIEW_NEXT,
                bt_rewind:SMPEvent.VIEW_REWIND,
                bt_forward:SMPEvent.VIEW_FORWARD,
                bt_mute:SMPEvent.VIEW_MUTE,
                bt_random:SMPEvent.VIEW_RANDOM,
                bt_repeat:SMPEvent.VIEW_REPEAT,
                bt_single:SMPEvent.VIEW_SINGLE,
                bt_list:SMPEvent.VIEW_LIST,
                bt_lrc:SMPEvent.VIEW_LRC,
                bt_video:SMPEvent.VIEW_VIDEO,
                bt_option:SMPEvent.VIEW_OPTION,
                bt_fullscreen:SMPEvent.VIEW_FULLSCREEN,
                bt_link:SMPEvent.VIEW_LINK,
                bt_more:SMPEvent.VIEW_MORE
            };
            super();
            this.bas.mouseEnabled = false;
            main.addChild(this.bas);
            this.top.mouseEnabled = false;
            main.addChild(this.top);
            this.bas.addChild(this.image);
            for (_local1 in this.SLIDERS) {
                _local3 = this[_local1];
                if (_local3){
                    _local3.name = _local1;
                    _local3.addEventListener(UIEvent.SLIDER_PERCENT, this.percentHandler);
                    this.bas.addChild(_local3);
                };
            };
            this.progress.addEventListener(MouseEvent.MOUSE_OVER, this.indicatorHandler);
            this.progress.addEventListener(MouseEvent.MOUSE_OUT, this.indicatorHandler);
            this.progress.addEventListener(MouseEvent.MOUSE_MOVE, this.indicatorHandler);
            for (_local2 in this.BUTTONS) {
                _local4 = this[_local2];
                if (_local4){
                    _local4.name = _local2;
                    _local4.addEventListener(MouseEvent.CLICK, this.buttonHandler);
                    _local4.addEventListener(MouseEvent.MOUSE_DOWN, this.buttonHandler);
                    _local4.addEventListener(MouseEvent.MOUSE_UP, this.buttonHandler);
                    this.bas.addChild(_local4);
                };
            };
            this.bt_link.useHandCursor = true;
            this.bt_more.useHandCursor = true;
            this.top.addChild(this.title);
            this.top.addChild(this.status);
            this.top.addChild(this.time);
            this.top.addChild(this.time_position);
            this.top.addChild(this.time_duration);
            this.top.addChild(this.number);
            Main.addEventListener(SMPEvent.CONTROL_MUTE, this.muteHandler);
            Main.addEventListener(SMPEvent.CONTROL_VOLUME, this.volumeHandler);
            Main.addEventListener(SMPEvent.CONTROL_PLAYMODE, this.playmodeHandler);
            Main.addEventListener(SMPEvent.CONTROL_FULLSCREEN, this.fsHandler);
            Main.addEventListener(SMPEvent.CONTROL_WINBT, this.winbtHandler);
            Main.addEventListener(SMPEvent.CONTROL_LOAD, this.loadHandler);
            Main.addEventListener(SMPEvent.MODEL_STATE, this.stateHandler);
            Main.addEventListener(SMPEvent.MODEL_TIME, this.timeHandler);
            Main.addEventListener(SMPEvent.MODEL_LOADING, this.modelLoadingHandler);
            Main.addEventListener(SMPEvent.MODEL_LOADED, this.modelLoadedHandler);
            Main.addEventListener(SMPEvent.CONFIG_LOADED, this.init);
        }
        public function init(_arg1:SMPEvent):void{
            this.title.visible = (this.status.visible = (this.time.visible = (this.time_position.visible = (this.time_duration.visible = false))));
            this.showTitle(Config.name);
            this.showTime("00:00", "00:00");
            this.number.show(0, 0);
        }
        public function showStatus(_arg1:String):void{
            this.status.show(_arg1);
        }
        public function showTitle(_arg1:String):void{
            this.title.show(_arg1);
        }
        public function showTime(_arg1:String, _arg2:String):void{
            var _local3:String = _arg1;
            if (_arg2){
                _local3 = (_local3 + (" / " + _arg2));
            };
            this.time.show(_local3);
            this.time_position.show(_arg1);
            this.time_duration.show(_arg2);
        }
        public function showPreload(_arg1:Number):void{
            this.progress.preload = _arg1;
            Main.vc.seek.preload = _arg1;
        }
        public function showPercent(_arg1:Number):void{
            this.progress.percent = _arg1;
            Main.vc.seek.percent = _arg1;
        }
        public function volumeHandler(_arg1:SMPEvent=null):void{
            this.volume.percent = Config.volume;
            Config.mute = (Config.volume) ? false : true;
        }
        public function muteHandler(_arg1:SMPEvent=null):void{
            this.bt_mute.reverse = Config.mute;
        }
        public function buttonHandler(_arg1:MouseEvent):void{
            var _local2:String = _arg1.currentTarget.name;
            var _local3:String = this.BUTTONS[_local2];
            if ((((_local2 == "bt_forward")) || ((_local2 == "bt_rewind")))){
                if (_arg1.type == MouseEvent.MOUSE_DOWN){
                    clearTimeout(this.outid);
                    this.outid = setTimeout(this.buttonDown, 500, _local3);
                } else {
                    if (_arg1.type == MouseEvent.MOUSE_UP){
                        clearTimeout(this.outid);
                        clearInterval(this.intid);
                    };
                };
            };
            if (_arg1.type == MouseEvent.CLICK){
                Main.sendEvent(_local3);
            };
        }
        private function buttonDown(_arg1:String):void{
            clearInterval(this.intid);
            this.intid = setInterval(Main.sendEvent, 100, _arg1);
        }
		/**
		 * 进度、音量控制
		 */
        public function percentHandler(e:UIEvent):void{
            var value:Number = AppUtil.per(e.currentTarget.percent);
            var type:String = this.SLIDERS[e.currentTarget.name];
			trace("WC:PERCENThANDLER",value,type);
            Main.sendEvent(type, value);
        }
        public function modelLoadingHandler(_arg1:SMPEvent):void{
            var _local2:Number = AppUtil.per(_arg1.data);
            this.showPreload(_local2);
        }
        public function modelLoadedHandler(_arg1:SMPEvent):void{
            //this.showPreload(0);//加载完成隐藏进度条
        }
        public function stateHandler(_arg1:SMPEvent):void{
            var _local2:Boolean;
            var _local3:String = "";
            var _local4:String = Config.state;
            switch (_local4){
                case SMPStates.CONNECTING:
                    if (Main.item.reload){
                        _local4 = "reconnecting";
                    };
                    _local2 = true;
                    break;
                case SMPStates.BUFFERING:
                    if (Config.buffer_percent > 0){
                        _local3 = (_local3 + ((" " + Config.buffer_percent) + "%"));
                    };
                    break;
                case SMPStates.PLAYING:
                    _local2 = true;
                    this.bt_more.visible = true;
                    break;
                case SMPStates.PAUSED:
                    break;
                case SMPStates.COMPLETED:
                    this.showPercent(1);
                    break;
                case SMPStates.STOPPED:
                    this.showPercent(0);
                    this.showPreload(0);
                    this.showTitle(Config.name);
                    this.showTime("00:00", "00:00");
                    this.number.show(0, 0);
                    this.bt_more.visible = false;
                    break;
            };
            this.showStatus((Main.info.queryMessage(("state_" + _local4)) + _local3));
            this.bt_play.reverse = _local2;
        }
        public function timeHandler(_arg1:SMPEvent):void{
            var _local2:Number = Main.item.duration;
            var _local3:Number = Main.item.position;
            var _local4:String = "LIVE";
            if (Main.item.type == CS.FLASH){
                _local4 = "";
            };
            var _local5:Number = 0;
            if (((_local2) && ((_local3 <= _local2)))){
                _local4 = AppUtil.time(_local2);
                _local5 = AppUtil.per((_local3 / _local2));
            };
            this.showPercent(_local5);
            this.showTime(AppUtil.time(_local3), _local4);
            this.number.show(_local3, _local2);
        }
        public function playmodeHandler(_arg1:SMPEvent=null):void{
            this.bt_random.reverse = false;
            this.bt_repeat.reverse = false;
            this.bt_single.reverse = false;
            if (Config.play_mode == CS.MODE_REPEAT){
                this.bt_repeat.reverse = true;
            } else {
                if (Config.play_mode == CS.MODE_RANDOM){
                    this.bt_random.reverse = true;
                } else {
                    if (Config.play_mode == CS.MODE_SINGLE){
                        this.bt_single.reverse = true;
                    };
                };
            };
        }
        public function fsHandler(_arg1:SMPEvent=null):void{
            this.bt_fullscreen.reverse = Config.fullscreen;
        }
        public function winbtHandler(_arg1:SMPEvent):void{
            var _local2:W = (_arg1.data as W);
            var _local3:Boolean = !(_local2.visible);
            switch (_local2){
                case Main.wl:
                    this.bt_list.reverse = _local3;
                    break;
                case Main.wm:
                    this.bt_video.reverse = _local3;
                    break;
                case Main.wr:
                    this.bt_lrc.reverse = _local3;
                    break;
                case Main.wo:
                    this.bt_option.reverse = _local3;
                    break;
            };
        }
        public function loadHandler(_arg1:SMPEvent):void{
            this.showTitle(Main.item.label);
            this.showPercent(0);
            this.showPreload(0);
            this.progress.dragable = Main.item.seekable;
        }
        public function hover(_arg1:MouseEvent):void{
            var _local2:Number;
            var _local3:Number;
            if (_arg1.buttonDown){
                return;
            };
            if (_arg1.type == MouseEvent.ROLL_OVER){
                if (_arg1.currentTarget == this.bt_mute){
                    this.volume.visible = true;
                };
            };
            if (_arg1.type == MouseEvent.ROLL_OUT){
                _local2 = _arg1.stageX;
                _local3 = _arg1.stageY;
                if ((((((_arg1.currentTarget == this.bt_mute)) && (!(this.volume.hitTestPoint(_local2, _local3))))) || ((((_arg1.currentTarget == this.volume)) && (!(this.bt_mute.hitTestPoint(_local2, _local3))))))){
                    this.volume.visible = false;
                };
            };
        }
        public function indicatorHandler(_arg1:MouseEvent):void{
            var _local2:Number;
            var _local3:Number;
            var _local4:Number;
            var _local5:String;
            if (_arg1.type == MouseEvent.MOUSE_OUT){
                this.indicator.visible = false;
            } else {
                if ((((_arg1.type == MouseEvent.MOUSE_OVER)) || ((_arg1.type == MouseEvent.MOUSE_MOVE)))){
                    if (((((((!(Main.item)) || (!(Main.item.duration)))) || ((Config.state == SMPStates.STOPPED)))) || ((this.indicator.display == CS.FALSE)))){
                        return;
                    };
                    if (_arg1.type == MouseEvent.MOUSE_OVER){
                        this.indicator.visible = true;
                    };
                    _local2 = ((tx + this.progress.tx) + this.progress.mouseX);
                    _local3 = (ty + this.progress.ty);
                    _local4 = 0;
                    if (this.progress.width){
                        _local4 = (this.progress.mouseX / this.progress.width);
                    };
                    _local5 = AppUtil.time(Math.round((_local4 * Main.item.duration)));
                    this.indicator.move(_local2, _local3, _local5);
                };
            };
        }
        override protected function skinHandler(_arg1:SMPEvent):void{
            var _local3:String;
            var _local4:SButton;
            var _local2:XMLList = Main.sk.skin_xml.console;
            ss(_local2, 0, 0);
            this.image.ss(_local2.image, tw, th);
            this.volume.ss(_local2.volume, tw, th);
            this.progress.ss(_local2.progress, tw, th);
            this.indicator.ss(_local2.indicator, tw, th);
            if (((((_local2.volume.length()) && (_local2.progress.length()))) && ((_local2.volume.childIndex() < _local2.progress.childIndex())))){
                this.bas.setChildIndex(this.progress, 0);
            } else {
                this.bas.setChildIndex(this.volume, 0);
            };
            for (_local3 in this.BUTTONS) {
                _local4 = this[_local3];
                if (_local4){
                    _local4.ss(_local2[_local3], tw, th);
                };
            };
            this.playmodeHandler();
            this.volumeHandler();
            this.muteHandler();
            this.hover_volume = AppUtil.tof(AppUtil.gOP(_local2.bt_mute, "hover_volume", false));
            if (this.hover_volume){
                this.bt_mute.addEventListener(MouseEvent.ROLL_OVER, this.hover);
                this.bt_mute.addEventListener(MouseEvent.ROLL_OUT, this.hover);
                this.volume.addEventListener(MouseEvent.ROLL_OUT, this.hover);
                this.volume.visible = false;
            } else {
                this.bt_mute.removeEventListener(MouseEvent.ROLL_OVER, this.hover);
                this.bt_mute.removeEventListener(MouseEvent.ROLL_OUT, this.hover);
                this.volume.removeEventListener(MouseEvent.ROLL_OUT, this.hover);
            };
            this.title.ss(_local2.title, tw, th);
            this.status.ss(_local2.status, tw, th);
            this.time.ss(_local2.time, tw, th);
            this.time_position.ss(_local2.time_position, tw, th);
            this.time_duration.ss(_local2.time_duration, tw, th);
            this.number.ss(_local2.number, tw, th);
            if (Config.state != SMPStates.PLAYING){
                this.bt_more.visible = false;
            };
        }
        override protected function closeHandler(_arg1:MouseEvent):void{
            Main.sendEvent(SMPEvent.VIEW_CONSOLE);
        }
        override protected function ws():void{
            var _local1:String;
            var _local2:SButton;
            this.image.ll(tw, th);
            this.volume.ll(tw, th);
            this.progress.ll(tw, th);
            if (this.hover_volume){
                this.volume.visible = false;
            };
            for (_local1 in this.BUTTONS) {
                _local2 = this[_local1];
                if (_local2){
                    _local2.ll(tw, th);
                };
            };
            this.title.ll(tw, th);
            this.status.ll(tw, th);
            this.time.ll(tw, th);
            this.time_position.ll(tw, th);
            this.time_duration.ll(tw, th);
            this.number.ll(tw, th);
        }

    }
}
