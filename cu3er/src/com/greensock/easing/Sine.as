//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.easing {

    public class Sine {

        private static const _HALF_PI:Number = 1.5707963267949;

        public static function easeIn(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return ((((-(_arg3) * Math.cos(((_arg1 / _arg4) * _HALF_PI))) + _arg3) + _arg2));
        }
        public static function easeOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return (((_arg3 * Math.sin(((_arg1 / _arg4) * _HALF_PI))) + _arg2));
        }
        public static function easeInOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return ((((-(_arg3) * 0.5) * (Math.cos(((Math.PI * _arg1) / _arg4)) - 1)) + _arg2));
        }

    }
}//package com.greensock.easing 
