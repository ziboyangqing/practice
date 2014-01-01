//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import com.greensock.*;

    public class ShortRotationPlugin extends TweenPlugin {

        public static const API:Number = 1;

        public function ShortRotationPlugin(){
            this.propName = "shortRotation";
            this.overwriteProps = [];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            var _local5:String;
            if (typeof(_arg2) == "number"){
                return (false);
            };
            var _local4:Boolean = Boolean((_arg2.useRadians == true));
            for (_local5 in _arg2) {
                if (_local5 != "useRadians"){
                    this.initRotation(_arg1, _local5, _arg1[_local5], ((typeof(_arg2[_local5]))=="number") ? Number(_arg2[_local5]) : (_arg1[_local5] + Number(_arg2[_local5])), _local4);
                };
            };
            return (true);
        }
        public function initRotation(_arg1:Object, _arg2:String, _arg3:Number, _arg4:Number, _arg5:Boolean=false):void{
            var _local6:Number = (_arg5) ? (Math.PI * 2) : 360;
            var _local7:Number = ((_arg4 - _arg3) % _local6);
            if (((_arg4 - _arg3) % _local6) != (_local7 % (_local6 / 2))){
                _local7 = ((_local7)<0) ? (_local7 + _local6) : (_local7 - _local6);
            };
            addTween(_arg1, _arg2, _arg3, (_arg3 + _local7), _arg2);
            this.overwriteProps[this.overwriteProps.length] = _arg2;
        }

    }
}//package com.greensock.plugins 
