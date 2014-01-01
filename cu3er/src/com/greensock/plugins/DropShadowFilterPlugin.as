//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import com.greensock.*;
    import flash.filters.*;

    public class DropShadowFilterPlugin extends FilterPlugin {

        public static const API:Number = 1;

        private static var _propNames:Array = ["distance", "angle", "color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"];

        public function DropShadowFilterPlugin(){
            this.propName = "dropShadowFilter";
            this.overwriteProps = ["dropShadowFilter"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = DropShadowFilter;
            initFilter(_arg2, new DropShadowFilter(0, 45, 0, 0, 0, 0, 1, ((_arg2.quality) || (2)), _arg2.inner, _arg2.knockout, _arg2.hideObject), _propNames);
            return (true);
        }

    }
}//package com.greensock.plugins 
