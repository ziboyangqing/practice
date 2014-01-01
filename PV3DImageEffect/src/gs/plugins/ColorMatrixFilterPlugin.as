//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;
    import flash.filters.*;

    public class ColorMatrixFilterPlugin extends FilterPlugin {

        public static const API:Number = 1;
        public static const VERSION:Number = 1.01;

        protected static var _lumG:Number = 0.71516;
        protected static var _lumR:Number = 0.212671;
        protected static var _idMatrix:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
        protected static var _lumB:Number = 0.072169;

        protected var _matrix:Array;
        protected var _matrixTween:EndArrayPlugin;

        public function ColorMatrixFilterPlugin(){
            this.propName = "colorMatrixFilter";
            this.overwriteProps = ["colorMatrixFilter"];
        }
        public static function setSaturation(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            var _local3:Number = (1 - _arg2);
            var _local4:Number = (_local3 * _lumR);
            var _local5:Number = (_local3 * _lumG);
            var _local6:Number = (_local3 * _lumB);
            var _local7:Array = [(_local4 + _arg2), _local5, _local6, 0, 0, _local4, (_local5 + _arg2), _local6, 0, 0, _local4, _local5, (_local6 + _arg2), 0, 0, 0, 0, 0, 1, 0];
            return (applyMatrix(_local7, _arg1));
        }
        public static function setHue(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            _arg2 = (_arg2 * (Math.PI / 180));
            var _local3:Number = Math.cos(_arg2);
            var _local4:Number = Math.sin(_arg2);
            var _local5:Array = [((_lumR + (_local3 * (1 - _lumR))) + (_local4 * -(_lumR))), ((_lumG + (_local3 * -(_lumG))) + (_local4 * -(_lumG))), ((_lumB + (_local3 * -(_lumB))) + (_local4 * (1 - _lumB))), 0, 0, ((_lumR + (_local3 * -(_lumR))) + (_local4 * 0.143)), ((_lumG + (_local3 * (1 - _lumG))) + (_local4 * 0.14)), ((_lumB + (_local3 * -(_lumB))) + (_local4 * -0.283)), 0, 0, ((_lumR + (_local3 * -(_lumR))) + (_local4 * -((1 - _lumR)))), ((_lumG + (_local3 * -(_lumG))) + (_local4 * _lumG)), ((_lumB + (_local3 * (1 - _lumB))) + (_local4 * _lumB)), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            return (applyMatrix(_local5, _arg1));
        }
        public static function setThreshold(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            var _local3:Array = [(_lumR * 0x0100), (_lumG * 0x0100), (_lumB * 0x0100), 0, (-256 * _arg2), (_lumR * 0x0100), (_lumG * 0x0100), (_lumB * 0x0100), 0, (-256 * _arg2), (_lumR * 0x0100), (_lumG * 0x0100), (_lumB * 0x0100), 0, (-256 * _arg2), 0, 0, 0, 1, 0];
            return (applyMatrix(_local3, _arg1));
        }
        public static function applyMatrix(_arg1:Array, _arg2:Array):Array{
            var _local6:int;
            var _local7:int;
            if (((!((_arg1 is Array))) || (!((_arg2 is Array))))){
                return (_arg2);
            };
            var _local3:Array = [];
            var _local4:int;
            var _local5:int;
            _local6 = 0;
            while (_local6 < 4) {
                _local7 = 0;
                while (_local7 < 5) {
                    if (_local7 == 4){
                        _local5 = _arg1[(_local4 + 4)];
                    } else {
                        _local5 = 0;
                    };
                    _local3[(_local4 + _local7)] = (((((_arg1[_local4] * _arg2[_local7]) + (_arg1[(_local4 + 1)] * _arg2[(_local7 + 5)])) + (_arg1[(_local4 + 2)] * _arg2[(_local7 + 10)])) + (_arg1[(_local4 + 3)] * _arg2[(_local7 + 15)])) + _local5);
                    _local7++;
                };
                _local4 = (_local4 + 5);
                _local6++;
            };
            return (_local3);
        }
        public static function colorize(_arg1:Array, _arg2:Number, _arg3:Number=1):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            if (isNaN(_arg3)){
                _arg3 = 1;
            };
            var _local4:Number = (((_arg2 >> 16) & 0xFF) / 0xFF);
            var _local5:Number = (((_arg2 >> 8) & 0xFF) / 0xFF);
            var _local6:Number = ((_arg2 & 0xFF) / 0xFF);
            var _local7:Number = (1 - _arg3);
            var _local8:Array = [(_local7 + ((_arg3 * _local4) * _lumR)), ((_arg3 * _local4) * _lumG), ((_arg3 * _local4) * _lumB), 0, 0, ((_arg3 * _local5) * _lumR), (_local7 + ((_arg3 * _local5) * _lumG)), ((_arg3 * _local5) * _lumB), 0, 0, ((_arg3 * _local6) * _lumR), ((_arg3 * _local6) * _lumG), (_local7 + ((_arg3 * _local6) * _lumB)), 0, 0, 0, 0, 0, 1, 0];
            return (applyMatrix(_local8, _arg1));
        }
        public static function setBrightness(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            _arg2 = ((_arg2 * 100) - 100);
            return (applyMatrix([1, 0, 0, 0, _arg2, 0, 1, 0, 0, _arg2, 0, 0, 1, 0, _arg2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1], _arg1));
        }
        public static function setContrast(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            _arg2 = (_arg2 + 0.01);
            var _local3:Array = [_arg2, 0, 0, 0, (128 * (1 - _arg2)), 0, _arg2, 0, 0, (128 * (1 - _arg2)), 0, 0, _arg2, 0, (128 * (1 - _arg2)), 0, 0, 0, 1, 0];
            return (applyMatrix(_local3, _arg1));
        }

        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = ColorMatrixFilter;
            var _local4:Object = _arg2;
            initFilter({}, new ColorMatrixFilter(_idMatrix.slice()));
            this._matrix = ColorMatrixFilter(_filter).matrix;
            var _local5:Array = [];
            if (((!((_local4.matrix == null))) && ((_local4.matrix is Array)))){
                _local5 = _local4.matrix;
            } else {
                if (_local4.relative == true){
                    _local5 = this._matrix.slice();
                } else {
                    _local5 = _idMatrix.slice();
                };
                _local5 = setBrightness(_local5, _local4.brightness);
                _local5 = setContrast(_local5, _local4.contrast);
                _local5 = setHue(_local5, _local4.hue);
                _local5 = setSaturation(_local5, _local4.saturation);
                _local5 = setThreshold(_local5, _local4.threshold);
                if (!isNaN(_local4.colorize)){
                    _local5 = colorize(_local5, _local4.colorize, _local4.amount);
                };
            };
            this._matrixTween = new EndArrayPlugin();
            this._matrixTween.init(this._matrix, _local5);
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            this._matrixTween.changeFactor = _arg1;
            ColorMatrixFilter(_filter).matrix = this._matrix;
            super.changeFactor = _arg1;
        }

    }
}//package gs.plugins 
