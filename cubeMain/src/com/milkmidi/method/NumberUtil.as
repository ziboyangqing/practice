//Created by Action Script Viewer - http://www.buraks.com/asv
package com.milkmidi.method {

    public class NumberUtil {

        public static function random(_arg1:int, _arg2:int):int{
            var _local3:Number;
            var _local4:int;
            var _local5:int;
            _local3 = Math.random();
            _local4 = (_arg2 - _arg1);
            _local5 = (Math.round((_local4 * _local3)) + _arg1);
            return (_local5);
        }
        public static function getHex():uint{
            var _local1:Number;
            var _local2:Number;
            var _local3:Number;
            _local1 = (Math.random() * 0xFF);
            _local2 = (Math.random() * 0xFF);
            _local3 = (Math.random() * 0xFF);
            return ((((Math.round(_local1) << 16) ^ (Math.round(_local2) << 8)) ^ Math.round(_local3)));
        }
        public static function radian2Degree(_arg1:Number):Number{
            return ((_arg1 * (180 / Math.PI)));
        }
        public static function mixColors(_arg1:uint, _arg2:uint, _arg3:Number):Number{
            var _local4:Object;
            var _local5:Object;
            _local4 = {
                r:(_arg1 >> 16),
                g:((_arg1 >> 8) & 0xFF),
                b:(_arg1 & 0xFF)
            };
            _local5 = {
                r:(_arg2 >> 16),
                g:((_arg2 >> 8) & 0xFF),
                b:(_arg2 & 0xFF)
            };
            return (((((_local4.r + ((_local5.r - _local4.r) * _arg3)) << 16) | ((_local4.g + ((_local5.g - _local4.g) * _arg3)) << 8)) | (_local4.b + ((_local5.b - _local4.b) * _arg3))));
        }
        public static function degree2Radian(_arg1:Number):Number{
            return ((_arg1 * (Math.PI / 180)));
        }

    }
}//package com.milkmidi.method 
