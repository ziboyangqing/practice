//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.events {
    import flash.events.*;

    public class TweenEvent extends Event {

        public static const VERSION:Number = 1.1;
        public static const START:String = "start";
        public static const UPDATE:String = "change";
        public static const COMPLETE:String = "complete";
        public static const REVERSE_COMPLETE:String = "reverseComplete";
        public static const REPEAT:String = "repeat";
        public static const INIT:String = "init";

        public function TweenEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false){
            super(_arg1, _arg2, _arg3);
        }
        override public function clone():Event{
            return (new TweenEvent(this.type, this.bubbles, this.cancelable));
        }

    }
}//package com.greensock.events 
