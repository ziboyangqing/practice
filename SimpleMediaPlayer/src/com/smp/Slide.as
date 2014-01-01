/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    //import flash.text.*;
    import flash.geom.*;
    import com.utils.AppUtil;
	
	/**
	 * Slider Progress Template
	 */
    public final class Slide extends Plane {

        public var bw:int;
        public var bh:int;
        public var _thumb_src:String;
        public var _track_src:String;
        public var back:Sprite;
        public var trackBackgnd:SmartSprite;
        public var trackPreload:SmartSprite;
        public var trackForegnd:SmartSprite;
        public var trackSeekbar:Sprite;
        public var btThumb:ButtonBase;
        public var preMask:Sprite;
        public var perMask:Sprite;
        public var _preload:Number = 0;
        public var _percent:Number = 0;
        public var trackSkins:Array;
        public var thumbSkins:Array;
        public var rect:Rectangle;
        public var lock:Boolean = false;
        public var realtime:Boolean = false;
        public var autohide:Boolean = false;
        public var _autohide:Boolean = false;
        public var dragable:Boolean = true;
        public var f_t:uint;

        public function Slide(realtime:Boolean=false, autohide:Boolean=false, preload:Boolean=false){
            this.back = new Sprite();
            this.trackBackgnd = new SmartSprite();
            this.trackPreload = new SmartSprite();
            this.trackForegnd = new SmartSprite();
            this.trackSeekbar = new Sprite();
            this.btThumb = new ButtonBase();
            this.preMask = new Sprite();
            this.perMask = new Sprite();
            this.rect = new Rectangle(0, 0, 0, 0);
            super();
            this.realtime = realtime;
            this.autohide = this._autohide = autohide;
            addChild(this.back);
            addChild(this.trackBackgnd);
            if (preload){
                this.trackPreload.alpha = 0.3;
                addChild(this.trackPreload);
                SGraphics.drawRect(this.preMask, 0, 0, 2, 2);
                addChild(this.preMask);
                this.trackPreload.mask = this.preMask;
                this.preMask.width = 0;
            };
            addChild(this.trackForegnd);
            SGraphics.drawRect(this.perMask, 0, 0, 2, 2);
            addChild(this.perMask);
            this.trackForegnd.mask = this.perMask;
            SGraphics.drawRect(this.trackSeekbar, 0, 0, 2, 2);
            this.trackSeekbar.buttonMode = false;//true;
            this.trackSeekbar.addEventListener(MouseEvent.CLICK, this.seekHandler);
            addChild(this.trackSeekbar);
            this.btThumb.addEventListener(MouseEvent.MOUSE_DOWN, this.thumbHandler);
            this.btThumb.addEventListener(MouseEvent.MOUSE_OVER, this.thumbHandler);
            this.btThumb.addEventListener(MouseEvent.MOUSE_OUT, this.thumbHandler);
            this.btThumb.addEventListener(MouseEvent.CLICK, this.thumbHandler);
            addChild(this.btThumb);
            this.autohideThumb();
        }
        public function get preload():Number{
            return (this._preload);
        }
        public function set preload(_arg1:Number):void{
            _arg1 = AppUtil.per(_arg1);
            if (this._preload != _arg1){
                this._preload = _arg1;
                this.preMask.width = (tw * this._preload);
            };
        }
        public function get percent():Number{
            return (this._percent);
        }
        public function set percent(_arg1:Number):void{
            _arg1 = AppUtil.per(_arg1);
            if (this._percent != _arg1){
                this._percent = _arg1;
                this.updatePosition();
            };
        }
        public function autohideThumb():void{
            clearTimeout(this.f_t);
            removeEventListener(MouseEvent.MOUSE_OVER, this.showThumb);
            removeEventListener(MouseEvent.MOUSE_OUT, this.hideThumb);
            this.btThumb.alpha = 1;
            this.btThumb.visible = true;
            if (this.autohide){
                addEventListener(MouseEvent.MOUSE_OVER, this.showThumb);
                addEventListener(MouseEvent.MOUSE_OUT, this.hideThumb);
                this.btThumb.alpha = 0;
                this.btThumb.visible = false;
            };
        }
        public function showThumb(_arg1:MouseEvent):void{
            clearTimeout(this.f_t);
            Effects.e(this.btThumb);
            this.btThumb.alpha = 1;
            this.btThumb.visible = true;
        }
        public function hideThumb(_arg1:MouseEvent):void{
            this.f_t = setTimeout(this.hideStart, 3000);
        }
        public function hideStart():void{
            clearTimeout(this.f_t);
            Effects.f(this.btThumb);
        }
        public function thumbHandler(_arg1:MouseEvent):void{
            if (_arg1.type == MouseEvent.MOUSE_DOWN){
                if (!this.dragable){
                    return;
                };
                this.lock = true;
                this.btThumb.startDrag(false, this.rect);
                stage.addEventListener(MouseEvent.MOUSE_UP, this.upHandler);
                stage.addEventListener(Event.ENTER_FRAME, this.realtimeUpdate);
            } else {
                if (_arg1.type == MouseEvent.MOUSE_OVER){
                    Main.tp.show(this.btThumb, tips[0]);
                } else {
                    if ((((_arg1.type == MouseEvent.MOUSE_OUT)) || ((_arg1.type == MouseEvent.CLICK)))){
                        Main.tp.hide();
                    };
                };
            };
        }
        public function upHandler(_arg1:MouseEvent):void{
            this.lock = false;
            this.btThumb.stopDrag();
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.upHandler);
            stage.removeEventListener(Event.ENTER_FRAME, this.realtimeUpdate);
            this.updateDragPercent();
            this.completePercent();
        }
        public function realtimeUpdate(_arg1:Event):void{
            this.updateDragPercent();
            if (this.realtime){
                this.completePercent();
            };
        }
        public function seekHandler(_arg1:MouseEvent):void{
            if (!this.dragable){
                return;
            };
            var _local2:Number = mouseX;
            var _local3:Number = 0;
            if (tw > this.bw){
                _local3 = ((_local2 - (this.bw * 0.5)) / (tw - this.bw));
            };
            if (_local2 < (this.bw * 0.5)){
                _local3 = 0;
            } else {
                if (_local2 > (tw - (this.bw * 0.5))){
                    _local3 = 1;
                };
            };
            if (this._percent != _local3){
                this._percent = _local3;
                this.updatePosition();
                this.completePercent();
            };
        }
        public function updateDragPercent():void{
            var _local1:Number = ((mouseX - this.btThumb.mouseX) / (tw - this.bw));
            if (this._percent != _local1){
                this._percent = _local1;
                this.updateTrackPosition();
            };
        }
        public function completePercent():void{
            dispatchEvent(new UIEvent(UIEvent.SLIDER_PERCENT));
        }
        public function updatePosition():void{
            if (!this.lock){
                this.updateThumbPosition();
                this.updateTrackPosition();
            };
        }
        public function updateThumbPosition():void{
            var _local1:Number = Math.round(((tw - this.bw) * this._percent));
            this.btThumb.x = _local1;
        }
        public function updateTrackPosition():void{
            this.perMask.width = Math.round((tw * this._percent));
        }
        public function ds(_arg1:Array, _arg2:Array, _arg3:String, _arg4:Number, _arg5:Number):void{
            this.thumbSkins = _arg1;
            this.trackSkins = _arg2;
            _pw = _arg4;
            _ph = _arg5;
            _xywh = _arg3;
            lo();
            this.setThumbSkin();
            this.setTrackSkin();
        }
        override public function size():void{
            this.trackBackgnd.size(tw, th);
            this.trackPreload.size(tw, th);
            this.trackForegnd.size(tw, th);
            this.trackSeekbar.width = tw;
            this.trackSeekbar.height = th;
            this.initThumb();
            this.updatePosition();
            this.setBack();
        }
        override public function ss(_arg1:XMLList, _arg2:int, _arg3:int):void{
            super.ss(_arg1, _arg2, _arg3);
            this.autohide = AppUtil.gOP(_arg1, "thumb_autohide", this._autohide);
            this.autohideThumb();
            this.thumb_src = _arg1.@thumb_src;
            this.track_src = _arg1.@track_src;
        }
        override public function set src(_arg1:String):void{
            Main.rm(this.back);
            super.src = _arg1;
        }
        override public function srcComplete(_arg1:LoaderInfo):void{
            if (_arg1){
                this.back.addChild(_arg1.loader);
            };
            this.setBack();
        }
        public function setBack():void{
            if (this.back.numChildren){
                this.back.x = Math.round(((tw - this.back.width) * 0.5));
                this.back.y = Math.round(((th - this.back.height) * 0.5));
            };
        }
        public function set thumb_src(_arg1:String):void{
            this._thumb_src = _arg1;
            Zip.GetSrc(_arg1, this.thumbComplete);
        }
        public function get thumb_src():String{
            return (this._thumb_src);
        }
        public function thumbComplete(_arg1:LoaderInfo):void{
            var _local3:Array;
            this.thumbSkins = [new Bitmap(), new Bitmap(), new Bitmap(), new Bitmap()];
            var _local2:BitmapData = Zip.GetBMD(_arg1);
            if (_local2){
                _local3 = Zip.SplitBMD(_local2, 4, 1);
                this.thumbSkins = [new Bitmap(_local3[0]), new Bitmap(_local3[1]), new Bitmap(_local3[2]), new Bitmap(_local3[3])];
            };
            this.setThumbSkin();
        }
        public function initThumb():void{
            this.btThumb.y = ((th - this.bh) * 0.5);
            this.rect = new Rectangle(0, ((th - this.bh) * 0.5), (tw - this.bw), 0);
        }
        public function setThumbSkin():void{
            this.bw = this.thumbSkins[0].width;
            this.bh = this.thumbSkins[0].height;
            this.btThumb.size(this.bw, this.bh);
            this.btThumb.style(this.thumbSkins[0], this.thumbSkins[1], this.thumbSkins[2]);
            this.preMask.height = th;
            this.perMask.height = th;
            this.trackSeekbar.width = tw;
            this.trackSeekbar.height = th;
            this.initThumb();
            this.updatePosition();
        }
        public function set track_src(_arg1:String):void{
            this._track_src = _arg1;
            Zip.GetSrc(_arg1, this.trackComplete);
        }
        public function get track_src():String{
            return (this._track_src);
        }
        public function trackComplete(_arg1:LoaderInfo):void{
            var _local3:Array;
            this.trackSkins = [new Bitmap(), new Bitmap(), new Bitmap()];
            var _local2:BitmapData = Zip.GetBMD(_arg1);
            if (_local2){
                _local3 = Zip.SplitBMD(_local2, 1, 3);//提取内容,横向一个，纵向两个/三个
                this.trackSkins = [new SBitMap(_local3[0]), new SBitMap(_local3[1]), new SBitMap(_local3[2])];
            };
            this.setTrackSkin();
        }
        public function setTrackSkin():void{
            this.trackBackgnd.show(this.trackSkins[0], tw, th);//背景
            this.trackPreload.show(this.trackSkins[1], tw, th);//加载进度条
            this.trackForegnd.show(this.trackSkins[2], tw, th);//播放进度条
        }

    }
}
