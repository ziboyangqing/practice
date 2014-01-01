//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.easing {

    public class Expo {

        public static function easeIn(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return (((_arg1)==0) ? _arg2 : (((_arg3 * Math.pow(2, (10 * ((_arg1 / _arg4) - 1)))) + _arg2) - (_arg3 * 0.001)));
        }
        public static function easeOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return (((_arg1)==_arg4) ? (_arg2 + _arg3) : ((_arg3 * (-(Math.pow(2, ((-10 * _arg1) / _arg4))) + 1)) + _arg2));
        }
        public static function easeInOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            if (_arg1 == 0){
                return (_arg2);
            };
            if (_arg1 == _arg4){
                return ((_arg2 + _arg3));
            };
            _arg1 = (_arg1 / (_arg4 * 0.5));
            if (_arg1 < 1){
                return ((((_arg3 * 0.5) * Math.pow(2, (10 * (_arg1 - 1)))) + _arg2));
            };
            --_arg1;
            return ((((_arg3 * 0.5) * (-(Math.pow(2, (-10 * _arg1))) + 2)) + _arg2));
        }

    }
}//package com.greensock.easing 
