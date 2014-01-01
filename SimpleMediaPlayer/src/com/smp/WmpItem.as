/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    import com.utils.AppUtil;

    public final class WmpItem extends SMedia {

        public var state:String;
        public var ec:Number;
        public var ts:String;
        public var t1:Number;
        public var t2:Number;
        public var bp:Number;
        public var dp:Number;
        public var ed:Boolean;
        public var started:Boolean;
        public var timeid:uint;

        public function WmpItem():void{
            this.stop();
        }
        override public function load():void{
            Main.sendState(SMPStates.CONNECTING);
            this.stop();
            url = Main.item.url;
            if (Config.flash_js){
                Main.ei.load(url);
                interval("add", [this.stateHandler]);
            } else {
                Main.sendEvent(SMPEvent.MODEL_ERROR, "Invalid External Player Model");
            };
        }
        override public function play():void{
            Main.ei.play();
            this.volume();
            interval("add", [this.timeHandler]);
        }
        override public function pause():void{
            if (Main.item.duration){
                Main.ei.pause();
            } else {
                Main.ei.stop();
            };
            interval("del", [this.timeHandler]);
            Main.sendState(SMPStates.PAUSED);
        }
        override public function stop():void{
            interval("del", [this.timeHandler, this.stateHandler, this.progressHandler]);
            clearTimeout(this.timeid);
            Main.ei.stop();
            position = 0;
            this.ec = 0;
            this.ts = SMPStates.STOPPED;
            this.t1 = 0;
            this.t2 = 0;
            this.bp = 0;
            this.dp = 0;
            this.ed = false;
            this.started = false;
        }
        override public function volume():void{
            var _local1:Number = Math.round((Config.volume * 100));
            var _local2:Number = Math.round((Config.panning * 100));
            Main.ei.volume(_local1, _local2);
        }
        override public function seek(_arg1:Number):void{
            var _local2:Number;
            if (Main.item.duration){
                if ((((_arg1 < 0)) || ((_arg1 > 1)))){
                    _local2 = (position + _arg1);
                } else {
                    _local2 = (Main.item.duration * _arg1);
                };
                Main.ei.seek(_local2);
            };
        }
        public function getInfo():void{
            var _local2:String;
            var _local1:Object = Main.ei.info();
            if (_local1){
                for (_local2 in _local1) {
                    _local1[_local2] = AppUtil.backslash(String(_local1[_local2]));
                };
                _local1.type = CS.WMP;
                Main.sendEvent(SMPEvent.MODEL_META, _local1);
            };
        }
        public function stateHandler(_arg1:Event):void{
            var _local3:String;
            if (Main.item.type != CS.WMP){
                this.stop();
                return;
            };
            var _local2:Array = Main.ei.status();
            if (!_local2){
                return;
            };
            this.ec = _local2[0];
            this.ts = _local2[1];
            this.t1 = _local2[2];
            this.t2 = _local2[3];
            this.bp = _local2[4];
            this.dp = _local2[5];
            this.ed = _local2[6];
            if (this.ec > 0){
                _local3 = Main.ei.error();
                this.stop();
                Main.sendEvent(SMPEvent.MODEL_ERROR, ((_local3) || ("External Player Error")));
                return;
            };
            this.state = this.ts;
            if (this.ed){
                if ((((this.state == SMPStates.STOPPED)) || ((this.state == SMPStates.COMPLETED)))){
                    finish();
                    return;
                };
            };
            position = this.t1;
            if (!this.started){
                if ((((this.state == SMPStates.BUFFERING)) || ((this.state == SMPStates.PLAYING)))){
                    this.started = true;
                    Main.item.data = true;
                    interval("add", [this.progressHandler, this.timeHandler]);
                    this.volume();
                    Main.sendEvent(SMPEvent.MODEL_START);
                    clearTimeout(this.timeid);
                    this.timeid = setTimeout(this.getInfo, 2000);
                };
            };
        }
        public function progressHandler(_arg1:Event):void{
            if ((((this.dp < 100)) && ((this.t2 > 0)))){
                Main.sendEvent(SMPEvent.MODEL_LOADING, (this.dp * 0.01));
            } else {
                interval("del", [this.progressHandler]);
                Main.sendEvent(SMPEvent.MODEL_LOADED);
            };
        }
        public function timeHandler(_arg1:Event):void{
            if (this.state == SMPStates.BUFFERING){
                Config.buffer_percent = this.bp;
                Main.sendState(SMPStates.BUFFERING);
            } else {
                if (Config.state != SMPStates.PLAYING){
                    Main.sendState(SMPStates.PLAYING);
                };
            };
            if (((!((Main.item.position == position))) && ((Config.state == SMPStates.PLAYING)))){
                Main.item.position = position;
                Main.item.duration = this.t2;
                Main.sendEvent(SMPEvent.MODEL_TIME);
            };
        }

    }
}
