/*SimpleMediaPlayer*/
package com.smp.events {
    import flash.events.*;

    public class DATACHGEvent extends Event {

        public static const DATA_CHANGE:String = "dataChange";
        public static const PRE_DATA_CHANGE:String = "preDataChange";

        protected var _startIndex:uint;
        protected var _endIndex:uint;
        protected var _changeType:String;
        protected var _items:Array;

        public function DATACHGEvent(_arg1:String, _arg2:String, _arg3:Array, _arg4:int=-1, _arg5:int=-1):void{
            super(_arg1);
            this._changeType = _arg2;
            this._startIndex = _arg4;
            this._items = _arg3;
            this._endIndex = ((_arg5)==-1) ? this._startIndex : _arg5;
        }
        public function get changeType():String{
            return (this._changeType);
        }
        public function get items():Array{
            return (this._items);
        }
        public function get startIndex():uint{
            return (this._startIndex);
        }
        public function get endIndex():uint{
            return (this._endIndex);
        }
        override public function toString():String{
            return (formatToString("DCEvent", "type", "changeType", "startIndex", "endIndex", "bubbles", "cancelable"));
        }
        override public function clone():Event{
            return (new DATACHGEvent(type, this._changeType, this._items, this._startIndex, this._endIndex));
        }

    }
}
