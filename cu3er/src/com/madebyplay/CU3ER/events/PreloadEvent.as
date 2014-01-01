package com.madebyplay.CU3ER.events 
{
    import flash.events.*;
    
    public class PreloadEvent extends flash.events.Event
    {
        public function PreloadEvent(arg1:String, arg2:String="", arg3:Number=0, arg4:Boolean=false, arg5:Boolean=false)
        {
            super(arg1, arg4, arg5);
            this._slideId = arg2;
            this._percent = arg3;
            return;
        }

        public override function clone():flash.events.Event
        {
            return new com.madebyplay.CU3ER.events.PreloadEvent(type, this._slideId, this._percent, bubbles, cancelable);
        }

        public override function toString():String
        {
            return formatToString("PreloadEvent", "type", "bubbles", "cancelable", "eventPhase");
        }

        public function get percent():Number
        {
            return this._percent;
        }

        public function set percent(arg1:Number):void
        {
            this._percent = arg1;
            return;
        }

        public function get slideId():String
        {
            return this._slideId;
        }

        public function set slideId(arg1:String):void
        {
            this._slideId = arg1;
            return;
        }

        public function get slideNo():Number
        {
            return this._slideNo;
        }

        public function set slideNo(arg1:Number):void
        {
            this._slideNo = arg1;
            return;
        }

        public static const LOAD_XML_COMPLETE:String="loadXMLComplete";

        public static const LOAD_BG_IMAGE_COMPLETE:String="loadBgImageComplete";

        public static const LOAD_LIBRARY_INFO_COMPLETE:String="loadLibraryInfoComplete";

        public static const LOAD_FONTS_COMPLETE:String="loadFontsComplete";

        public static const LOAD_SHADOW_COMPLETE:String="loadFontsComplete";

        public static const LOAD_ADDITIONAL_FONT_COMPLETE:String="loadFontsComplete";

        public static const LOAD_FIRST_SLIDE_COMPLETE:String="loadFirstSlideComplete";

        public static const LOAD_SLIDE_START:String="loadSlideStart";

        public static const LOAD_SLIDE_COMPLETE:String="loadSlideComplete";

        public static const LOAD_SLIDE_ERROR:String="loadSlideError";

        public static const LOAD_COMPLETE:String="loadComplete";

        public static const LOAD_PROGRESS:String="loadProgress";

        internal var _percent:Number=0;

        internal var _slideId:String="";

        internal var _slideNo:Number=-1;
    }
}
