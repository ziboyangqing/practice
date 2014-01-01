//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import com.greensock.*;
    import flash.filters.*;

    public class BevelFilterPlugin extends FilterPlugin {

        public static const API:Number = 1;

        private static var _propNames:Array = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];

        public function BevelFilterPlugin(){
            this.propName = "bevelFilter";
            this.overwriteProps = ["bevelFilter"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = BevelFilter;
            initFilter(_arg2, new BevelFilter(0, 0, 0xFFFFFF, 0.5, 0, 0.5, 2, 2, 0, ((_arg2.quality) || (2))), _propNames);
            return (true);
        }

    }
}//package com.greensock.plugins 
