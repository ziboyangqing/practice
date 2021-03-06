﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import com.greensock.*;
    import flash.filters.*;

    public class BlurFilterPlugin extends FilterPlugin {

        public static const API:Number = 1;

        private static var _propNames:Array = ["blurX", "blurY", "quality"];

        public function BlurFilterPlugin(){
            this.propName = "blurFilter";
            this.overwriteProps = ["blurFilter"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = BlurFilter;
            initFilter(_arg2, new BlurFilter(0, 0, ((_arg2.quality) || (2))), _propNames);
            return (true);
        }

    }
}//package com.greensock.plugins 
