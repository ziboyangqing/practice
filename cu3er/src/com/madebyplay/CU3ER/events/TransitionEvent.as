package com.madebyplay.CU3ER.events 
{
    import flash.events.*;
    
    public class TransitionEvent extends flash.events.Event
    {
        public function TransitionEvent(arg1:String, arg2:Boolean=false, arg3:Boolean=false)
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
            return formatToString("TransitionEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public static const START:String="transitionStart";

        public static const COMPLETE:String="transitionComplete";
    }
}
