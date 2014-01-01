/*SimpleMediaPlayer*/
package com.smp.events {
    import flash.events.*;

    public final class UIEvent extends Event {

        public static const SLIDER_PERCENT:String = "slider_percent";
        public static const RADIO_CLICK:String = "radio_click";
        public static const LABEL_CLICK:String = "label_click";
        public static const ICONS_LOADED:String = "icons_loaded";
        public static const WIN_COMPLETE:String = "win_complete";
        public static const ZIP_EXTRACT:String = "zip_extract";

        private var _data:Object;

        public function UIEvent(_arg1:String, _arg2:Object=null, _arg3:Boolean=false, _arg4:Boolean=false):void{
            super(_arg1, _arg3, _arg4);
            this._data = _arg2;
        }
        public function get data():Object{
            return (this._data);
        }
        public function set data(_arg1:Object):void{
            this._data = _arg1;
        }
        override public function toString():String{
            return ("[UIEvent]");
        }
        override public function clone():Event{
            return (new UIEvent(type, bubbles, cancelable));
        }

    }
}
