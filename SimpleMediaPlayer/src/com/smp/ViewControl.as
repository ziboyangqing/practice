/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    //import flash.geom.*;
    import flash.ui.*;
    import com.utils.AppUtil;

    public final class ViewControl extends Sprite {

        public var tw:Number;
        public var th:Number;
        public var main:Sprite;
        public var bts:Sprite;
        public var btx:Number = 20;
        public var bar:Sprite;
        public var seek:Slide;
        public var btP:SButton;
        public var btN:SButton;
        public var btC:SButton;
        public var btD:SButton;
        public var btF:SButton;
        public var btM:SButton;
        public var btR:SButton;
        public var btB:SButton;
        public var btH:SButton;
        public var btS:SButton;
        public var btW:SButton;
        public var back:Sprite;
        public var BUTTONS:Object;
        public var type:String;
        public var mv:MediaView;
        public var f_t:uint;
        public var clickId:uint;

        public function ViewControl(_arg1:MediaView):void{
            var _local2:String;
            var _local3:SButton;
            var _local4:Array;
            this.main = new Sprite();
            this.bts = new Sprite();
            this.bar = new Sprite();
            this.seek = new Slide(false, true, true);
            this.btP = new SButton();
            this.btN = new SButton();
            this.btC = new SButton();
            this.btD = new SButton();
            this.btF = new SButton();
            this.btM = new SButton();
            this.btR = new SButton();
            this.btB = new SButton();
            this.btH = new SButton();
            this.btS = new SButton();
            this.btW = new SButton();
            this.back = new Sprite();
            super();
            this.mv = _arg1;
            this.type = CS.OTHER;
            this.back.buttonMode = true;
            this.back.doubleClickEnabled = true;
            addEventListener(MouseEvent.ROLL_OVER, this.overHandler);
            addEventListener(MouseEvent.ROLL_OUT, this.outHandler);
            this.back.addEventListener(MouseEvent.MOUSE_MOVE, this.moveHandler);
            this.back.addEventListener(MouseEvent.MOUSE_DOWN, this.bgdownHandler);
            this.back.addEventListener(MouseEvent.CLICK, this.bgclickHandler);
            this.back.addEventListener(MouseEvent.DOUBLE_CLICK, this.bgdbclickHandler);
            addChild(this.back);
            this.main.visible = false;
            addChild(this.main);
            this.bar.visible = false;
            this.main.addChild(this.bar);
            this.seek.addEventListener(UIEvent.SLIDER_PERCENT, this.percentHandler);
            this.bar.addChild(this.seek);
            this.bts.y = 3;
            this.bts.mouseEnabled = false;
            this.main.addChild(this.bts);
            this.BUTTONS = {
                btP:[CS.SOUND, SGraphics.gBtP(20, 20), -120, SMPEvent.MIXER_PREV],
                btN:[CS.SOUND, SGraphics.gBtN(20, 20), -100, SMPEvent.MIXER_NEXT],
                btC:[CS.SOUND, SGraphics.gBtC(20, 20), -80, SMPEvent.MIXER_COLOR],
                btD:[CS.SOUND, SGraphics.gBtD(20, 20), -60, SMPEvent.MIXER_DISPLACE],
                btF:[CS.SOUND, SGraphics.gBtF(20, 20), -40, SMPEvent.MIXER_FILTER],
                btM:[CS.VIDEO, SGraphics.gBtM(20, 20), -120, SMPEvent.VIDEO_SCALEMODE],
                btR:[CS.VIDEO, SGraphics.gBtR(20, 20), -100, SMPEvent.VIDEO_ROTATION],
                btB:[CS.VIDEO, SGraphics.gBtB(20, 20), -80, SMPEvent.VIDEO_BLACKWHITE],
                btH:[CS.VIDEO, SGraphics.gBtH(20, 20), -60, SMPEvent.VIDEO_HIGHLIGHT],
                btS:[CS.VIDEO, SGraphics.gBtS(20, 20), -40, SMPEvent.VIDEO_SMOOTHING],
                btW:[CS.OTHER, SGraphics.gBtW(20, 20), -20, SMPEvent.VIDEO_MAX]
            };
            for (_local2 in this.BUTTONS) {
                _local3 = this[_local2];
                _local3.name = _local2;
                _local4 = this.BUTTONS[_local2];
                _local3.ds(_local4[2], 0, 20, 20, _local4[1]);
                _local3.addEventListener(MouseEvent.CLICK, this.buttonHandler);
                this.bts.addChild(_local3);
            };
            Main.addEventListener(SMPEvent.CONTROL_LOAD, this.startHandler);
            Main.addEventListener(SMPEvent.MODEL_START, this.startHandler);
            Main.addEventListener(SMPEvent.MODEL_STATE, this.stateHandler);
            Main.addEventListener(SMPEvent.VIDEO_RESIZE, this.resizeHandler);
            Main.addEventListener(SMPEvent.CONTROL_MAX, this.maxHandler);
            Main.addEventListener(SMPEvent.CONFIG_LOADED, this.init, false, 0, true);
            Main.addEventListener(SMPEvent.VIDEO_SCALEMODE, this.scalemodeHandler);
            Main.addEventListener(SMPEvent.VIDEO_ROTATION, this.rotationHandler);
            Main.addEventListener(SMPEvent.VIDEO_HIGHLIGHT, this.highlightHandler);
            Main.addEventListener(SMPEvent.VIDEO_BLACKWHITE, this.blackwhiteHandler);
            this.setBTS();
        }
        public function scalemodeHandler(_arg1:SMPEvent):void{
            var _local2:Number;
            if (_arg1.data != null){
                _local2 = parseInt(_arg1.data.toString());
                Config.video_scalemode = (isNaN(_local2)) ? 1 : _local2;
            } else {
                Config.video_scalemode++;
            };
            if (Config.video_scalemode > 3){
                Config.video_scalemode = 0;
            };
            Main.item.xml.@scalemode = (Main.item.scalemode = Config.video_scalemode);
            Main.sendEvent(SMPEvent.VIDEO_RESIZE);
        }
        public function rotationHandler(_arg1:SMPEvent):void{
            var _local3:Number;
            var _local2:int;
            if (_arg1.data != null){
                _local3 = parseInt(_arg1.data.toString());
                _local2 = (isNaN(_local3)) ? 0 : _local3;
            } else {
                _local2 = (Main.item.rotation + 90);
            };
            Main.item.xml.@rotation = (Main.item.rotation = _local2);
            Main.sendEvent(SMPEvent.VIDEO_RESIZE);
        }
        public function highlightHandler(_arg1:SMPEvent):void{
            if (_arg1.data != null){
                Config.video_highlight = AppUtil.tof(_arg1.data.toString());
            } else {
                Config.video_highlight = !(Config.video_highlight);
            };
            Main.sendEvent(SMPEvent.VIDEO_EFFECT);
        }
        public function blackwhiteHandler(_arg1:SMPEvent):void{
            if (_arg1.data != null){
                Config.video_blackwhite = AppUtil.tof(_arg1.data.toString());
            } else {
                Config.video_blackwhite = !(Config.video_blackwhite);
            };
            Main.sendEvent(SMPEvent.VIDEO_EFFECT);
        }
        public function buttonHandler(_arg1:MouseEvent):void{
            var _local2:String = _arg1.currentTarget.name;
            if (_local2 == "btW"){
                this.show();
            };
            Main.sendEvent(this.BUTTONS[_local2][3]);
        }
        public function init(_arg1:SMPEvent):void{
            this.setBTS();
        }
        public function startHandler(_arg1:SMPEvent):void{
            this.start(Main.item.type);
        }
        public function start(_arg1:String=null):void{
            if (_arg1 == this.type){
                return;
            };
            if (_arg1){
                this.type = _arg1;
            };
            var _local2:Boolean;
            if (this.type == CS.FLASH){
                if (Main.mm.model.hasOwnProperty("type")){
                    if (Main.mm.model.type != CS.IMAGE){
                        _local2 = true;
                    };
                };
            };
            this.back.visible = !(_local2);
            this.main.visible = _local2;
            this.setBTS();
            this.resizeHandler();
        }
        public function setBTS():void{
            var _local1:String;
            var _local2:SButton;
            var _local3:Array;
            var _local4:String;
            for (_local1 in this.BUTTONS) {
                _local2 = this[_local1];
                _local3 = this.BUTTONS[_local1];
                _local4 = _local3[0];
                if ((_local4 == this.type) || (_local4 == CS.OTHER)){
                    _local2.visible = true;
                } else {
                    _local2.visible = false;
                };
            };
        }
        public function stateHandler(_arg1:SMPEvent):void{
            if (Config.state == SMPStates.STOPPED){
                this.type = CS.OTHER;
                this.setBTS();
            };
            this.setBar();
        }
        public function resizeHandler(_arg1:SMPEvent=null):void{
            this.tw = Config.video_width;
            this.th = Config.video_height;
            SGraphics.drawRect(this.back, 0, 0, this.tw, this.th);
            SGraphics.drawRect(this.bar, 0, 0, this.tw, 30, 0.8, 0x282828);
            this.bar.y = (this.th - 30);
            this.seek.ds(SGraphics.gSDB(12, 12), SGraphics.gSDT(this.tw, 10), "10, 10, 10B, 10B", this.tw, 30);
            this.bts.x = (this.tw - 5);
            this.setMax();
        }
        public function maxHandler(_arg1:SMPEvent):void{
            if (_arg1.data == SMPEvent.VIDEO_MAX){
                this.setMax();
            };
        }
        public function setMax():void{
            this.btW.reverse = !(Config.video_max);
            this.setBar();
        }
        public function setBar():void{
            if (Config.video_max){
                if (Main.item){
                    if (Main.item.duration){
                        this.bar.visible = true;
                        return;
                    };
                };
            };
            this.bar.visible = false;
        }
        public function overHandler(_arg1:MouseEvent):void{
            this.show();
        }
        public function outHandler(_arg1:MouseEvent):void{
            this.hide();
        }
        public function moveHandler(_arg1:MouseEvent):void{
            this.show();
        }
        public function show():void{
            if ((((((this.tw < 200)) || ((this.th < 60)))) || (!(this.mv.show_buttons)))){
                return;
            };
            Mouse.show();
            this.main.visible = true;
            clearTimeout(this.f_t);
            this.f_t = setTimeout(this.check, 2000);
        }
        public function check():void{
            var _local1:Boolean;
            clearTimeout(this.f_t);
            if (((this.bts.visible) || (this.bar.visible))){
                _local1 = false;
                if (stage){
                    _local1 = ((this.bts.hitTestPoint(stage.mouseX, stage.mouseY, true)) || (this.bar.hitTestPoint(stage.mouseX, stage.mouseY, true)));
                };
                if (_local1){
                    return;
                };
            };
            this.hide();
        }
        public function hide():void{
            if (!this.back.visible){
                return;
            };
            if (((Config.video_max) && (Config.fullscreen))){
                Mouse.hide();
            };
            this.main.visible = false;
        }
        public function bgdownHandler(_arg1:MouseEvent):void{
            clearTimeout(this.clickId);
        }
        public function bgclickHandler(_arg1:MouseEvent):void{
            clearTimeout(this.clickId);
            this.clickId = setTimeout(this.checkDown, 200);
        }
        public function checkDown():void{
            clearTimeout(this.clickId);
            Main.sendEvent(SMPEvent.VIEW_PLAY);
        }
        public function bgdbclickHandler(_arg1:MouseEvent):void{
            if (Config.video_max == Config.fullscreen){
                Main.sendEvent(SMPEvent.VIEW_FULLSCREEN);
            } else {
                Main.sendEvent(SMPEvent.VIDEO_MAX);
            };
        }
        public function percentHandler(_arg1:UIEvent):void{
            Main.sendEvent(SMPEvent.VIEW_PROGRESS, _arg1.currentTarget.percent);
        }

    }
}
