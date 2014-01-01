/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.SMPEvent;
    import com.smp.events.UIEvent;
    
    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.events.Event;
    import com.utils.AppUtil;

    public final class BackGround extends Sprite {

        public var bgcolor:Number;
        public var bgs:Array;

        public function BackGround():void{
            Main.addEventListener(SMPEvent.RESIZE, this.resizeHandler);
            Main.addEventListener(SMPEvent.PLUGINS_LOAD, this.start);
            Main.addEventListener(SMPEvent.PLUGINS_REMOVE, this.remove);
            Main.addEventListener(SMPEvent.CONFIG_LOADED, this.init);
            this.init();
        }
        public function init(_arg1:SMPEvent=null):void{
            if (Config.bgcolor){
                this.bgcolor = AppUtil.color(Config.bgcolor);
                this.resizeHandler();
            };
        }
        public function resizeHandler(_arg1:SMPEvent=null):void{
            var e:SMPEvent = _arg1;
            if (this.bgcolor){
                var _local3:Graphics = graphics;
                with (_local3) {
                    beginFill(bgcolor);
                    drawRect(0, 0, Config.width, Config.height);
                    endFill();
                };
            };
        }
        public function remove(_arg1:SMPEvent=null):void{
            Main.rm(this);
        }
        public function start(_arg1:SMPEvent):void{
            var _local2:String;
            this.remove();
            this.bgs = [];
            if (((Config.backgrounds) && (!(Config.plugins_disabled)))){
                _local2 = AppUtil.auto(Config.backgrounds, Config);
                this.bgs = AppUtil.json(_local2);
            };
            this.load();
        }
        public function load():void{
            if (!this.bgs.length){
                return;
            };
            var _local1:Object = this.bgs.shift();
            var _local2:BPage = new BPage(_local1);
            _local2.addEventListener(Event.COMPLETE, this.completed);
            _local2.addEventListener(UIEvent.ZIP_EXTRACT, this.extract);
            addChild(_local2);
            if (!_local1.src){
                this.load();
            };
        }
        public function completed(_arg1:Event):void{
            this.load();
        }
        public function extract(_arg1:UIEvent):void{
            var _local7:BPage;
            var _local2:Object = _arg1.data;
            var _local3:Object = _local2.data;
            var _local4:Array = _local2.list;
            var _local5:int = _local4.length;
            var _local6:int;
            while (_local6 < _local5) {
                _local7 = new BPage(_local3);
                _local7.bk.loadBytes(_local4[_local6]);
                addChild(_local7);
                _local6++;
            };
            this.load();
        }

    }
}
