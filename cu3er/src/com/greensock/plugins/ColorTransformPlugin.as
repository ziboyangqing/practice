//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import flash.display.*;
    import flash.geom.*;
    import com.greensock.*;

    public class ColorTransformPlugin extends TintPlugin {

        public static const API:Number = 1;

        public function ColorTransformPlugin(){
            this.propName = "colorTransform";
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            var _local4:ColorTransform;
            var _local6:String;
            var _local7:Number;
            var _local5:ColorTransform = new ColorTransform();
            if ((_arg1 is DisplayObject)){
                _transform = DisplayObject(_arg1).transform;
                _local4 = _transform.colorTransform;
            } else {
                if ((_arg1 is ColorTransform)){
                    _local4 = (_arg1 as ColorTransform);
                } else {
                    return (false);
                };
            };
            _local5.concat(_local4);
            for (_local6 in _arg2) {
                if ((((_local6 == "tint")) || ((_local6 == "color")))){
                    if (_arg2[_local6] != null){
                        _local5.color = int(_arg2[_local6]);
                    };
                } else {
                    if ((((((_local6 == "tintAmount")) || ((_local6 == "exposure")))) || ((_local6 == "brightness")))){
                    } else {
                        _local5[_local6] = _arg2[_local6];
                    };
                };
            };
            if (!isNaN(_arg2.tintAmount)){
                _local7 = (_arg2.tintAmount / (1 - (((_local5.redMultiplier + _local5.greenMultiplier) + _local5.blueMultiplier) / 3)));
                _local5.redOffset = (_local5.redOffset * _local7);
                _local5.greenOffset = (_local5.greenOffset * _local7);
                _local5.blueOffset = (_local5.blueOffset * _local7);
                _local5.redMultiplier = (_local5.greenMultiplier = (_local5.blueMultiplier = (1 - _arg2.tintAmount)));
            } else {
                if (!isNaN(_arg2.exposure)){
                    _local5.redOffset = (_local5.greenOffset = (_local5.blueOffset = (0xFF * (_arg2.exposure - 1))));
                    _local5.redMultiplier = (_local5.greenMultiplier = (_local5.blueMultiplier = 1));
                } else {
                    if (!isNaN(_arg2.brightness)){
                        _local5.redOffset = (_local5.greenOffset = (_local5.blueOffset = Math.max(0, ((_arg2.brightness - 1) * 0xFF))));
                        _local5.redMultiplier = (_local5.greenMultiplier = (_local5.blueMultiplier = (1 - Math.abs((_arg2.brightness - 1)))));
                    };
                };
            };
            init(_local4, _local5);
            return (true);
        }

    }
}//package com.greensock.plugins 
