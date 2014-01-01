/*SimpleMediaPlayer*/
package com.smp.events {
    import flash.events.*;

    public class ListEvent extends Event {

        public static const ITEM_ROLL_OUT:String = "itemRollOut";
        public static const ITEM_ROLL_OVER:String = "itemRollOver";
        public static const ITEM_CLICK:String = "itemClick";
        public static const ITEM_DOUBLE_CLICK:String = "itemDoubleClick";

        protected var _rowIndex:int;
        protected var _columnIndex:int;
        protected var _index:int;
        protected var _item:Object;

        public function ListEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false, _arg4:int=-1, _arg5:int=-1, _arg6:int=-1, _arg7:Object=null){
            super(_arg1, _arg2, _arg3);
            this._rowIndex = _arg5;
            this._columnIndex = _arg4;
            this._index = _arg6;
            this._item = _arg7;
        }
        public function get rowIndex():Object{
            return (this._rowIndex);
        }
        public function get columnIndex():int{
            return (this._columnIndex);
        }
        public function get index():int{
            return (this._index);
        }
        public function get item():Object{
            return (this._item);
        }
        override public function toString():String{
            return (formatToString("ListEvent", "type", "bubbles", "cancelable", "columnIndex", "rowIndex", "index", "item"));
        }
        override public function clone():Event{
            return (new ListEvent(type, bubbles, cancelable, this._columnIndex, this._rowIndex));
        }

    }
}
