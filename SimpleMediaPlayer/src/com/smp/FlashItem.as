/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    import flash.net.*;
    import flash.media.*;

    public final class FlashItem extends SMedia {

        public var transform:SoundTransform;
        public var frameSpeed:int = 30;
        public var loader:Loader;
        public var info:LoaderInfo;
        public var time:int;
        public var timeNow:int;
        public var timePos:Number;
        public var type:String = "image";
        public var mc:MovieClip;

        public function FlashItem():void{
            this.transform = new SoundTransform();
        }
        override public function load():void{
            Main.sendState(SMPStates.CONNECTING);
            position = 0;
            this.timePos = 0;
            loaded = false;
            url = Main.item.url;
            this.loader = new Loader();
            this.info = this.loader.contentLoaderInfo;
            this.info.addEventListener(Event.COMPLETE, this.loadedHandler);
            this.info.addEventListener(Event.INIT, this.initHandler);
            this.info.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            this.info.addEventListener(ProgressEvent.PROGRESS, this.progressHandler);
            try {
                this.loader.load(new URLRequest(url));
            } catch(e:Error) {
                errorHandler(e);
            };
        }
        override public function play():void{
            if (this.type == CS.MOVIE){
                this.mc.play();
            };
            this.time = getTimer();
            interval("add", [this.timeHandler]);
            Main.sendState(SMPStates.PLAYING);
        }
        override public function pause():void{
            if (this.type == CS.MOVIE){
                this.mc.stop();
            };
            this.timePos = position;
            interval("del", [this.timeHandler]);
            Main.sendState(SMPStates.PAUSED);
        }
        override public function stop():void{
            interval("del", [this.timeHandler]);
            this.mc = null;
            this.type = CS.IMAGE;
            position = 0;
            this.timePos = 0;
            if (this.info){
                this.info.removeEventListener(Event.COMPLETE, this.loadedHandler);
                this.info.removeEventListener(Event.INIT, this.initHandler);
                this.info.removeEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
                this.info.removeEventListener(ProgressEvent.PROGRESS, this.progressHandler);
                this.info = null;
            };
            if (this.loader){
                try {
                    this.loader.close();
                } catch(e:Error) {
                };
                try {
                    this.loader.unloadAndStop();
                } catch(e:Error) {
                };
                this.loader = null;
            };
            SoundMixer.stopAll();
        }
        override public function volume():void{
            this.transform.volume = Config.volume;
            this.transform.pan = Config.panning;
            SoundMixer.soundTransform = this.transform;
        }
        override public function seek(_arg1:Number):void{
            if (this.type != CS.MOVIE){
                return;
            };
            if ((((_arg1 < 0)) || ((_arg1 > 1)))){
                position = ((this.mc.currentFrame / this.frameSpeed) + _arg1);
            } else {
                if (Main.item.duration){
                    position = (Main.item.duration * _arg1);
                } else {
                    return;
                };
            };
            var _local2:int = Math.round(((position / Main.item.duration) * this.mc.totalFrames));
            this.mc.gotoAndStop(_local2);
            this.play();
        }
        public function timeHandler(_arg1:Event):void{
            if (this.type == CS.MOVIE){
                position = (this.mc.currentFrame / this.frameSpeed);
            } else {
                this.timeNow = getTimer();
                position = (((this.timeNow - this.time) * 0.001) + this.timePos);
            };
            if (((Main.item.duration) && ((position >= Main.item.duration)))){
                finish();
                return;
            };
            if (position != Main.item.position){
                Main.item.position = position;
                Main.sendEvent(SMPEvent.MODEL_TIME);
            };
        }
        public function loadedHandler(_arg1:Event):void{
            Main.sendEvent(SMPEvent.MODEL_LOADED);
            loaded = true;
        }
        public function initHandler(_arg1:Event):void{
            var _local2:Number;
            var _local3:Bitmap;
            position = 0;
            Main.item.data = true;
            if (this.info.contentType == CS.APP_FLASH){
                if (this.info.childAllowsParent){
                    if ((this.info.content is AVM1Movie)){
                        this.type = CS.FLASH;
                    } else {
                        if ((this.info.content is MovieClip)){
                            this.mc = (this.info.content as MovieClip);
                            this.frameSpeed = ((this.info.frameRate) || (1));
                            _local2 = (((this.mc.totalFrames) || (1)) / this.frameSpeed);
                            if (_local2 > 1){
                                this.type = CS.MOVIE;
                                Main.item.duration = _local2;
                            } else {
                                this.type = CS.FLASH;
                            };
                        } else {
                            this.type = CS.FLASH;
                        };
                    };
                } else {
                    this.type = CS.FLASH;
                };
            } else {
                this.type = CS.IMAGE;
                if (this.info.childAllowsParent){
                    _local3 = (this.info.content as Bitmap);
                    try {
                        _local3.smoothing = true;
                    } catch(e:Error) {
                    };
                };
            };
            Main.mv.showMedia(this.loader);
            Main.sendEvent(SMPEvent.MODEL_START);
            this.play();
        }
        public function errorHandler(_arg1:Object):void{
            Main.sendEvent(SMPEvent.MODEL_ERROR, _arg1);
        }
        public function progressHandler(_arg1:ProgressEvent):void{
            bt = _arg1.bytesTotal;
            bl = _arg1.bytesLoaded;
            Main.item.bytes = bt;
            var _local2:Number = 0;
            if (bt){
                _local2 = (bl / bt);
            };
            Main.sendEvent(SMPEvent.MODEL_LOADING, _local2);
            if (this.type == CS.IMAGE){
                Config.buffer_percent = Math.round((_local2 * 100));
                Main.sendState(SMPStates.BUFFERING);
            };
        }

    }
}
