/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.display.*;

    public class R extends Sprite {

        public var tw:int;
        public var th:int;
        public var rowText:String;
        public var nowTime:Number;
        public var main:Sprite;
        public var list:Array;
        public var lc:SLrc;

        public function R(_arg1:SLrc):void{
            this.main = new Sprite();
            this.list = [];
            super();
            this.lc = _arg1;
            addChild(this.main);
            mouseChildren = false;
            mouseEnabled = false;
        }
        public function stop():void{
            visible = false;
            this.list = [];
            Main.clear(this.main);
        }
        public function ll(_arg1:int, _arg2:int):void{
            this.tw = _arg1;
            this.th = _arg2;
        }
        public function rowChange(_arg1:String=""):void{
            if (_arg1 != this.rowText){
                this.rowText = _arg1;
                Main.sendEvent(SMPEvent.LRC_ROWCHANGE, _arg1);
            };
        }

    }
}
