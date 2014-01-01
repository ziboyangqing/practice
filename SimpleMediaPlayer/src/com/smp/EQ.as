/*SimpleMediaPlayer*/
package com.smp {
    import flash.utils.*;
    import com.utils.AppUtil;

    public final class EQ {

        public static const length:int = 0x2000;
        private static const FS:Array = [31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 1600];
        private static const Q:Number = 1.9;

        private static var fl:int = 10;
        private static var fs:Array = [];
        private static var es:Array = [];
        private static var enabled:Boolean;
        private static var sound_eq:String;

        private static function init(_arg1:String):void{
            var _local2:Number;
            var _local3:Array;
            var _local4:Array;
            var _local5:Number;
            var _local6:Number;
            var _local7:int;
            sound_eq = Config.sound_eq;
            enabled = false;
            if (_arg1){
                fs = FS;
                _local2 = Q;
                _local3 = _arg1.split(AppUtil.COLON);
                if (_local3.length > 1){
                    _local2 = AppUtil.clamp(Number(_local3[0]), 0.33, 12);
                    if (isNaN(_local2)){
                        _local2 = Q;
                    };
                    _arg1 = _local3[1];
                    if (_local3.length > 2){
                        fs = AppUtil.array(_local3[2]);
                    };
                    if (_local3.length > 3){
                    };
                };
                fl = fs.length;
                _local4 = AppUtil.array(_arg1);
                if (_local4.length != fl){
                    _local4.length = fl;
                };
                enabled = true;
                es = [];
                _local7 = 0;
                while (_local7 < fl) {
                    _local5 = AppUtil.clamp(Number(_local4[_local7]), -12, 12);
                    if (isNaN(_local5)){
                        _local5 = 0;
                    };
                    _local6 = AppUtil.clamp(Number(fs[_local7]), 20, 20000);
                    if (isNaN(_local6)){
                        _local6 = 900;
                    };
                    es.push(new E(_local6, _local5, _local2));
                    _local7++;
                };
            };
        }
        public static function filter(_arg1:ByteArray):ByteArray{
            var _local3:Number;
            var _local4:Number;
            if (Config.sound_eq != sound_eq){
                init(Config.sound_eq);
            };
            if (!enabled){
                return (_arg1);
            };
            var _local2:Array = [];
            _arg1.position = 0;
            while (_arg1.bytesAvailable) {
                _local3 = _arg1.readFloat();
                if (_arg1.bytesAvailable){
                    _local4 = _arg1.readFloat();
                };
                _local2.push([_local3, _local4]);
            };
            var _local5:int;
            while (_local5 < fl) {
                _local2 = es[_local5].filter(_local2);
                _local5++;
            };
            var _local6:ByteArray = new ByteArray();
            var _local7:int = _local2.length;
            var _local8:int;
            while (_local8 < _local7) {
                _local6.writeFloat(_local2[_local8][0]);
                _local6.writeFloat(_local2[_local8][1]);
                _local8++;
            };
            _local6.position = 0;
            return (_local6);
        }

    }
}
