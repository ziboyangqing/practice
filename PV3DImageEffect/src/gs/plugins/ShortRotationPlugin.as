//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;

    public class ShortRotationPlugin extends TweenPlugin {

        public static const VERSION:Number = 1;
        public static const API:Number = 1;

        public function ShortRotationPlugin(){
            this.propName = "shortRotation";
            this.overwriteProps = [];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            var _local4:String;
            if (typeof(_arg2) == "number"){
                trace("WARNING: You appear to be using the old shortRotation syntax. Instead of passing a number, please pass an object with properties that correspond to the rotations values For example, TweenMax.to(mc, 2, {shortRotation:{rotationX:-170, rotationY:25}})");
                return (false);
            };
            for (_local4 in _arg2) {
                this.initRotation(_arg1, _local4, _arg1[_local4], _arg2[_local4]);
            };
            return (true);
        }
        public function initRotation(_arg1:Object, _arg2:String, _arg3:Number, _arg4:Number):void{
            var _local5:Number = ((_arg4 - _arg3) % 360);
            if (((_arg4 - _arg3) % 360) != (_local5 % 180)){
                _local5 = ((_local5)<0) ? (_local5 + 360) : (_local5 - 360);
            };
            addTween(_arg1, _arg2, _arg3, (_arg3 + _local5), _arg2);
            this.overwriteProps[this.overwriteProps.length] = _arg2;
        }

    }
}//package gs.plugins 
