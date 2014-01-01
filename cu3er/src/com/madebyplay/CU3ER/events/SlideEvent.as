package com.madebyplay.CU3ER.events 
{
    import flash.events.*;
    
    public class SlideEvent extends flash.events.Event
    {
        public function SlideEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.madebyplay.CU3ER.events.TransitionEvent(type, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("SlideEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const FADE_IN_START:String="slideFadeInStart";

        public static const FADE_OUT_START:String="slideFadeOutStart";

        public static const FADE_IN_FINISH:String="slideFadeInFinish";

        public static const FADE_OUT_FINISH:String="slideFadeOutFinish";
    }
}
