//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.easing {

    public class Bounce {

        public static function easeOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = (_arg1 / _arg4);
            if (_arg1 < (1 / 2.75)){
                return (((_arg3 * ((7.5625 * _arg1) * _arg1)) + _arg2));
            };
            if (_arg1 < (2 / 2.75)){
                _arg1 = (_arg1 - (1.5 / 2.75));
                return (((_arg3 * (((7.5625 * _arg1) * _arg1) + 0.75)) + _arg2));
            };
            if (_arg1 < (2.5 / 2.75)){
                _arg1 = (_arg1 - (2.25 / 2.75));
                return (((_arg3 * (((7.5625 * _arg1) * _arg1) + 0.9375)) + _arg2));
            };
            _arg1 = (_arg1 - (2.625 / 2.75));
            return (((_arg3 * (((7.5625 * _arg1) * _arg1) + 0.984375)) + _arg2));
        }
        public static function easeIn(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return (((_arg3 - easeOut((_arg4 - _arg1), 0, _arg3, _arg4)) + _arg2));
        }
        public static function easeInOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            if (_arg1 < (_arg4 * 0.5)){
                return (((easeIn((_arg1 * 2), 0, _arg3, _arg4) * 0.5) + _arg2));
            };
            return ((((easeOut(((_arg1 * 2) - _arg4), 0, _arg3, _arg4) * 0.5) + (_arg3 * 0.5)) + _arg2));
        }

    }
}//package com.greensock.easing 
