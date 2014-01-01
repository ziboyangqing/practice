/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.events.*;
    import flash.display.*;
    import com.utils.AppUtil;

    public final class FP extends Sprite {

        public var pgs:Array;
        public var index:Number;
        public var total:Number;

        public function FP():void{
            Main.addEventListener(SMPEvent.PLUGINS_LOAD, this.start);
            Main.addEventListener(SMPEvent.PLUGINS_LOADED, this.loaded);
            Main.addEventListener(SMPEvent.PLUGINS_REMOVE, this.remove);
        }
        public function remove(_arg1:SMPEvent=null):void{
            Main.rm(this);
        }
        public function start(_arg1:SMPEvent):void{
            var _local2:String;
            var _local3:Object;
            var _local4:BPage;
            if (_arg1.data != null){
                Config.plugins = _arg1.data.toString();
            };
            this.remove();
            this.pgs = [];
            if (((Config.plugins) && (!(Config.plugins_disabled)))){
                _local2 = AppUtil.auto(Config.plugins, Config);
                this.pgs = AppUtil.json(_local2);
            };
            if (this.pgs.length){
                Main.ld.init();
                this.total = 0;
                this.index = 0;
                while (this.pgs.length) {
                    _local3 = this.pgs.shift();
                    if (_local3.src){
                        this.total++;
                    };
                    _local4 = new BPage(_local3);
                    _local4.addEventListener(Event.COMPLETE, this.completed);
                    _local4.addEventListener(UIEvent.ZIP_EXTRACT, this.extract);
                    addChild(_local4);
                };
            } else {
                this.finish();
            };
        }
        public function finish():void{
            Main.sendEvent(SMPEvent.PLUGINS_LOADED);
        }
        public function completed(_arg1:Event):void{
            this.index++;
            if ((this.total - this.index) <= 0){
                Main.ld.hide();
                this.finish();
            } else {
                Main.ld.show(this.index, this.total);
            };
        }
        public function extract(_arg1:UIEvent):void{
            var _local7:BPage;
            var _local2:Object = _arg1.data;
            var _local3:Object = _local2.data;
            var _local4:Array = _local2.list;
            var _local5:int = _local4.length;
            this.total = (this.total + (_local5 - 1));
            var _local6:int;
            while (_local6 < _local5) {
                _local7 = new BPage(_local3);
                _local7.addEventListener(Event.COMPLETE, this.completed);
                _local7.bk.loadBytes(_local4[_local6]);
                addChild(_local7);
                _local6++;
            };
        }
        public function loaded(_arg1:SMPEvent):void{
            Main.removeEventListener(SMPEvent.PLUGINS_LOADED, this.loaded);
            Main.sendEvent(SMPEvent.LIST_LOAD);
            Main.ei.api();
        }

    }
}
