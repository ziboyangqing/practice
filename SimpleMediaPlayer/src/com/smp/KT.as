/*SimpleMediaPlayer*/
package com.smp {
    import flash.text.*;

    public final class KT extends TextField {

        private var _tx:int = 0;
        public var tw:int;

        public function KT(_arg1:String, _arg2:TextFormat):void{
            autoSize = TextFieldAutoSize.LEFT;
            multiline = false;
            selectable = false;
            text = String(_arg1);
            setTextFormat(_arg2);
            this.tw = textWidth;
        }
        public function set tx(_arg1:Number):void{
            this._tx = _arg1;
            x = _arg1;
        }
        public function get tx():Number{
            return (this._tx);
        }

    }
}
