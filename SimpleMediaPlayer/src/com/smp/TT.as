/*SimpleMediaPlayer*/
package com.smp {
    import flash.utils.*;

    public final class TT extends T {

        private var roll:Boolean = true;
        private var id:uint;
        private var pos:int = 0;
        private var max:int = 0;
        private var str:String;

        public function TT(_arg1:Boolean=true):void{
            this.roll = _arg1;
            text.selectable = false;
            mouseEnabled = false;
            mouseChildren = false;
        }
        override public function show(_arg1:String):void{
            super.show(_arg1);
            this.lo();
        }
        override public function lo():void{
            super.lo();
            if (((!(this.roll)) || (!(visible)))){
                return;
            };
            clearTimeout(this.id);
            text.scrollH = 0;
            this.max = text.maxScrollH;
            if (this.max){
                this.pos = 0;
                this.id = setTimeout(this.scoll, 3000);
            };
        }
        private function scoll():void{
            clearTimeout(this.id);
            this.pos++;
            if (this.pos < this.max){
                this.id = setTimeout(this.scoll, 200);
            } else {
                if (this.pos == this.max){
                    this.id = setTimeout(this.scoll, 3000);
                } else {
                    this.pos = 0;
                    this.id = setTimeout(this.scoll, 3000);
                };
            };
            text.scrollH = this.pos;
        }

    }
}
