/*SimpleMediaPlayer*/
package com.ui {

    public class LSD {

        protected var _icon:Object = null;
        protected var _label:String;
        protected var _owner:UICore;
        protected var _index:uint;
        protected var _row:uint;
        protected var _column:uint;

        public function LSD(_arg1:String, _arg2:Object, _arg3:UICore, _arg4:uint, _arg5:uint, _arg6:uint=0){
            this._label = _arg1;
            this._icon = _arg2;
            this._owner = _arg3;
            this._index = _arg4;
            this._row = _arg5;
            this._column = _arg6;
        }
        public function get label():String{
            return (this._label);
        }
        public function get icon():Object{
            return (this._icon);
        }
        public function get owner():UICore{
            return (this._owner);
        }
        public function get index():uint{
            return (this._index);
        }
        public function get row():uint{
            return (this._row);
        }
        public function get column():uint{
            return (this._column);
        }

    }
}
