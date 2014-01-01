//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.core {

    public final class PropTween {

        public var target:Object;
        public var property:String;
        public var start:Number;
        public var change:Number;
        public var name:String;
        public var priority:int;
        public var isPlugin:Boolean;
        public var nextNode:PropTween;
        public var prevNode:PropTween;

        public function PropTween(_arg1:Object, _arg2:String, _arg3:Number, _arg4:Number, _arg5:String, _arg6:Boolean, _arg7:PropTween=null, _arg8:int=0){
            this.target = _arg1;
            this.property = _arg2;
            this.start = _arg3;
            this.change = _arg4;
            this.name = _arg5;
            this.isPlugin = _arg6;
            if (_arg7){
                _arg7.prevNode = this;
                this.nextNode = _arg7;
            };
            this.priority = _arg8;
        }
    }
}//package com.greensock.core 
