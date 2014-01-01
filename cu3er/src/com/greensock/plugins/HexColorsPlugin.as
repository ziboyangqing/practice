//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import com.greensock.*;

    public class HexColorsPlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected var _colors:Array;

        public function HexColorsPlugin(){
            this.propName = "hexColors";
            this.overwriteProps = [];
            this._colors = [];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            var _local4:String;
            for (_local4 in _arg2) {
                this.initColor(_arg1, _local4, uint(_arg1[_local4]), uint(_arg2[_local4]));
            };
            return (true);
        }
        public function initColor(_arg1:Object, _arg2:String, _arg3:uint, _arg4:uint):void{
            var _local5:Number;
            var _local6:Number;
            var _local7:Number;
            if (_arg3 != _arg4){
                _local5 = (_arg3 >> 16);
                _local6 = ((_arg3 >> 8) & 0xFF);
                _local7 = (_arg3 & 0xFF);
                this._colors[this._colors.length] = [_arg1, _arg2, _local5, ((_arg4 >> 16) - _local5), _local6, (((_arg4 >> 8) & 0xFF) - _local6), _local7, ((_arg4 & 0xFF) - _local7)];
                this.overwriteProps[this.overwriteProps.length] = _arg2;
            };
        }
        override public function killProps(_arg1:Object):void{
            var _local2:int = (this._colors.length - 1);
            while (_local2 > -1) {
                if (_arg1[this._colors[_local2][1]] != undefined){
                    this._colors.splice(_local2, 1);
                };
                _local2--;
            };
            super.killProps(_arg1);
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local3:Array;
            var _local2:int = this._colors.length;
            while (--_local2 > -1) {
                _local3 = this._colors[_local2];
                _local3[0][_local3[1]] = ((((_local3[2] + (_arg1 * _local3[3])) << 16) | ((_local3[4] + (_arg1 * _local3[5])) << 8)) | (_local3[6] + (_arg1 * _local3[7])));
            };
        }

    }
}//package com.greensock.plugins 
