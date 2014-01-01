/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.SMPEvent;
    
    import flash.display.Sprite;
    import flash.events.Event;

    public final class LD extends Sprite {

        private var ld:loadingUI;

        public function LD():void{
            Main.addEventListener(SMPEvent.RESIZE, this.ll);
            this.ld = new loadingUI();
            addChild(this.ld);
        }
        public function show(_arg1:uint, _arg2:uint):void{
            if (!visible){
                return;
            };
            var _local3:String = "";
            if (_arg2){
                _local3 = Math.round(((_arg1 / _arg2) * 100)).toString();
            };
            this.ld.s(_local3);
        }
        public function init():void{
            this.ld.s();
            visible = true;
            this.ld.g();
            this.ll();
        }
        public function hide():void{
            visible = false;
            this.ld.e();
        }
        private function ll(_arg1:Event=null):void{
            x = (Config.width * 0.5);
            y = (Config.height * 0.5);
        }

    }
}
