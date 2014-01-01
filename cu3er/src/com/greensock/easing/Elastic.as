//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.easing {

    public class Elastic {

        private static const _2PI:Number = 6.28318530717959;

        public static function easeIn(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number=0, _arg6:Number=0):Number{
            var _local7:Number;
            if (_arg1 == 0){
                return (_arg2);
            };
            _arg1 = (_arg1 / _arg4);
            if (_arg1 == 1){
                return ((_arg2 + _arg3));
            };
            if (!_arg6){
                _arg6 = (_arg4 * 0.3);
            };
            if (((((!(_arg5)) || ((((_arg3 > 0)) && ((_arg5 < _arg3)))))) || ((((_arg3 < 0)) && ((_arg5 < -(_arg3))))))){
                _arg5 = _arg3;
                _local7 = (_arg6 / 4);
            } else {
                _local7 = ((_arg6 / _2PI) * Math.asin((_arg3 / _arg5)));
            };
            --_arg1;
            return ((-(((_arg5 * Math.pow(2, (10 * _arg1))) * Math.sin(((((_arg1 * _arg4) - _local7) * _2PI) / _arg6)))) + _arg2));
        }
        public static function easeOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number=0, _arg6:Number=0):Number{
            var _local7:Number;
            if (_arg1 == 0){
                return (_arg2);
            };
            _arg1 = (_arg1 / _arg4);
            if (_arg1 == 1){
                return ((_arg2 + _arg3));
            };
            if (!_arg6){
                _arg6 = (_arg4 * 0.3);
            };
            if (((((!(_arg5)) || ((((_arg3 > 0)) && ((_arg5 < _arg3)))))) || ((((_arg3 < 0)) && ((_arg5 < -(_arg3))))))){
                _arg5 = _arg3;
                _local7 = (_arg6 / 4);
            } else {
                _local7 = ((_arg6 / _2PI) * Math.asin((_arg3 / _arg5)));
            };
            return (((((_arg5 * Math.pow(2, (-10 * _arg1))) * Math.sin(((((_arg1 * _arg4) - _local7) * _2PI) / _arg6))) + _arg3) + _arg2));
        }
        public static function easeInOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number=0, _arg6:Number=0):Number{
            var _local7:Number;
            if (_arg1 == 0){
                return (_arg2);
            };
            _arg1 = (_arg1 / (_arg4 * 0.5));
            if (_arg1 == 2){
                return ((_arg2 + _arg3));
            };
            if (!_arg6){
                _arg6 = (_arg4 * (0.3 * 1.5));
            };
            if (((((!(_arg5)) || ((((_arg3 > 0)) && ((_arg5 < _arg3)))))) || ((((_arg3 < 0)) && ((_arg5 < -(_arg3))))))){
                _arg5 = _arg3;
                _local7 = (_arg6 / 4);
            } else {
                _local7 = ((_arg6 / _2PI) * Math.asin((_arg3 / _arg5)));
            };
            if (_arg1 < 1){
                --_arg1;
                return (((-0.5 * ((_arg5 * Math.pow(2, (10 * _arg1))) * Math.sin(((((_arg1 * _arg4) - _local7) * _2PI) / _arg6)))) + _arg2));
            };
            --_arg1;
            return ((((((_arg5 * Math.pow(2, (-10 * _arg1))) * Math.sin(((((_arg1 * _arg4) - _local7) * _2PI) / _arg6))) * 0.5) + _arg3) + _arg2));
        }

    }
}//package com.greensock.easing 
