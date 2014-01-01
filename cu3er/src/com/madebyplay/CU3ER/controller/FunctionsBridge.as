package com.madebyplay.CU3ER.controller 
{
    public class FunctionsBridge extends Object
    {
        public function FunctionsBridge()
        {
            this.playCU3ER = new Function();
            this.pauseCU3ER = new Function();
            this.next = new Function();
            this.prev = new Function();
            this.skipTo = new Function();
            this.onSlide = new Function();
            this.onTransition = new Function();
            this.onLoadComplete = new Function();
            super();
            if (instance) 
            {
                throw new Error("FunctionsBridge is a Singleton and can only be accessed through FunctionsBridge.getInstance()");
            }
            return;
        }

        public static function getInstance():com.madebyplay.CU3ER.controller.FunctionsBridge
        {
            return instance;
        }

        
        {
            instance = new FunctionsBridge();
        }

        public var playCU3ER:Function;

        public var pauseCU3ER:Function;

        public var next:Function;

        public var prev:Function;

        public var skipTo:Function;

        public var onSlide:Function;

        public var onTransition:Function;

        public var onLoadComplete:Function;

        internal static var instance:com.madebyplay.CU3ER.controller.FunctionsBridge;
    }
}
