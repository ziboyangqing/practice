/*SimpleMediaPlayer*/
package com.smp.events {
    import flash.events.*;

    public class ScrollEvent extends Event {

        public static const SCROLL:String = "scroll";

        private var _delta:Number;
        private var _position:Number;

        public function ScrollEvent(_arg1:Number, _arg2:Number){
            super(ScrollEvent.SCROLL, false, false);
            this._delta = _arg1;
            this._position = _arg2;
        }
        public function get delta():Number{
            return (this._delta);
        }
        public function get position():Number{
            return (this._position);
        }
        override public function clone():Event{
            return (new ScrollEvent(this._delta, this._position));
        }

    }
}
