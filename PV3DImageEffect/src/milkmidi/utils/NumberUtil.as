//Created by Action Script Viewer - http://www.buraks.com/asv
package milkmidi.utils {
    import flash.errors.*;

    public class NumberUtil {

        public function NumberUtil(){
            throw (new IllegalOperationError("NetUtil cannot be instantiated."));
        }
        public static function getBrown():Number{
            return ((((Math.random() * 20) - 10) * 0.02));
        }
        public static function random(_arg1:Number, _arg2:Number, _arg3:Boolean=true):Number{
            var _local4:Number = ((Math.random() * (_arg2 - _arg1)) + _arg1);
            return ((_arg3) ? (_local4 >> 0) : _local4);
        }
        public static function addComma(_arg1:Number):String{
            var _local2:String = String(Math.abs(Math.floor(_arg1)));
            var _local3:int = _local2.length;
            if (_local3 <= 3){
                return (_local2);
            };
            var _local4 = "";
            var _local5:int;
            while (_local5 < _local3) {
                _local4 = (_local4 + ((((_local3 - _local5) % 3) == 0)) ? ("," + _local2.charAt(_local5)) : _local2.charAt(_local5));
                _local5++;
            };
            return (_local4);
        }
        public static function randomBoolean():Boolean{
            return (((Math.random())<0.5) ? true : false);
        }
        public static function getCoin(_arg1:Number=1):Number{
            return (((Math.random())<0.5) ? (1 * _arg1) : (-1 * _arg1));
        }
        public static function radian2Degree(_arg1:Number):Number{
            return ((_arg1 * (180 / Math.PI)));
        }
        public static function degree2Radian(_arg1:Number):Number{
            return ((_arg1 * (Math.PI / 180)));
        }

    }
}//package milkmidi.utils 
