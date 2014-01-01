//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.events {
    import flash.events.*;

    public class TweenEvent extends Event {

        public static const UPDATE:String = "update";
        public static const START:String = "start";
        public static const version:Number = 0.9;
        public static const COMPLETE:String = "complete";

        public var info:Object;

        public function TweenEvent(_arg1:String, _arg2:Object=null, _arg3:Boolean=false, _arg4:Boolean=false){
            super(_arg1, _arg3, _arg4);
            this.info = _arg2;
        }
        override public function clone():Event{
            return (new TweenEvent(this.type, this.info, this.bubbles, this.cancelable));
        }

    }
}//package gs.events 
