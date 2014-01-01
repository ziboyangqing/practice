package myevents {
    import flash.events.*;

    public class MyEvent extends Event {

        public static const INTRO_COMPLETE:String = "onIntroAnimationComplete";
        public static const OUTRO_COMPLETE:String = "onOutroAnimationComplete";
        public static const OUTRO_START:String = "onOutroAnimationStart";
        public static const INTRO_START:String = "onIntroAnimationStart";

        public var data:Object;

        public function MyEvent(_arg1:String, _arg2:Object=null):void{
            super(_arg1, true);
            data = _arg2;
        }
        override public function toString():String{
            return (formatToString("MyEvent", "target", "type", "data"));
        }
        override public function clone():Event{
            return (new MyEvent(type, data));
        }

    }
}//package src.events 
