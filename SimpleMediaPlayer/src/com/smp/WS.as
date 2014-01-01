/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    //import flash.events.*;
    import flash.display.*;

    public final class WS extends Sprite {

        public var wins:Object;
        public var list:Array;
        public var main:Sprite;

        public function WS(){
            var _local1:W;
            this.list = [];
            this.main = new Sprite();
            super();
            addChild(this.main);
            Main.addEventListener(SMPEvent.SKIN_LOADED, this.skinHandler, false, 200);
            Main.wc = new MediaControl();
            Main.wm = new WM();
            Main.wr = new WR();
            Main.wl = new WL();
            Main.wo = new WO();
            this.wins = {
                media:Main.wm,
                lrc:Main.wr,
                list:Main.wl,
                console:Main.wc,
                option:Main.wo
            };
            for each (_local1 in this.wins) {
                _local1.addEventListener(UIEvent.WIN_COMPLETE, this.winHandler);
                this.main.addChild(_local1);
            };
            addChild(Main.wc.indicator);
        }
        public function skinHandler(_arg1:SMPEvent):void{
			trace("WS:skinHandle")
            var _local6:String;
            var _local7:W;
            var _local8:String;
            this.list = [];
            var _local2:Object = {};
            var _local3:XMLList = Main.sk.skin_xml.children();
            var _local4:int = _local3.length();
            var _local5:int;
            while (_local5 < _local4) {
                _local6 = _local3[_local5].name();
                _local7 = (this.wins[_local6] as W);
                if (_local7){
                    this.main.setChildIndex(_local7, 0);
                    _local8 = _local3[_local5].@group;
                    if (_local8){
                        if (_local2[_local8]){
                            _local2[_local8].push(_local7);
                        } else {
                            _local2[_local8] = [_local7];
                        };
                    };
                };
                _local5++;
            };
			//trace("WS:group",_local2);
            Main.group = _local2;
        }
        public function winHandler(_arg1:UIEvent):void{
            this.list.push(_arg1.data);
            if (this.list.length == 5){
                Main.sendEvent(SMPEvent.SKIN_COMPLETE);
            };
        }

    }
}
