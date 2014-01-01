//Created by Action Script Viewer - http://www.buraks.com/asv
package org.flashsandy.display {
    import flash.display.*;
    import flash.geom.*;

    public class DistortImage {

        protected var _sMat:Matrix;
        protected var _tMat:Matrix;
        protected var _xMin:Number;
        protected var _xMax:Number;
        protected var _yMin:Number;
        protected var _yMax:Number;
        protected var _hseg:uint;
        protected var _vseg:uint;
        protected var _hsLen:Number;
        protected var _vsLen:Number;
        protected var _p:Array;
        protected var _tri:Array;
        protected var _w:Number;
        protected var _h:Number;
        public var smoothing:Boolean = true;

        public function DistortImage(_arg1:Number, _arg2:Number, _arg3:uint=2, _arg4:uint=2):void{
            this._w = _arg1;
            this._h = _arg2;
            this._vseg = _arg4;
            this._hseg = _arg3;
            this.__init();
        }
        protected function __init():void{
            var _local1:Number;
            var _local2:Number;
            var _local5:Number;
            var _local6:Number;
            this._p = new Array();
            this._tri = new Array();
            var _local3:Number = (this._w / 2);
            var _local4:Number = (this._h / 2);
            this._xMin = (this._yMin = 0);
            this._xMax = this._w;
            this._yMax = this._h;
            this._hsLen = (this._w / (this._hseg + 1));
            this._vsLen = (this._h / (this._vseg + 1));
            _local1 = 0;
            while (_local1 < (this._vseg + 2)) {
                _local2 = 0;
                while (_local2 < (this._hseg + 2)) {
                    _local5 = (_local1 * this._hsLen);
                    _local6 = (_local2 * this._vsLen);
                    this._p.push({
                        x:_local5,
                        y:_local6,
                        sx:_local5,
                        sy:_local6
                    });
                    _local2++;
                };
                _local1++;
            };
            _local1 = 0;
            while (_local1 < (this._vseg + 1)) {
                _local2 = 0;
                while (_local2 < (this._hseg + 1)) {
                    this._tri.push([this._p[(_local2 + (_local1 * (this._hseg + 2)))], this._p[((_local2 + (_local1 * (this._hseg + 2))) + 1)], this._p[(_local2 + ((_local1 + 1) * (this._hseg + 2)))]]);
                    this._tri.push([this._p[((_local2 + ((_local1 + 1) * (this._hseg + 2))) + 1)], this._p[(_local2 + ((_local1 + 1) * (this._hseg + 2)))], this._p[((_local2 + (_local1 * (this._hseg + 2))) + 1)]]);
                    _local2++;
                };
                _local1++;
            };
        }
        public function setTransform(_arg1:Graphics, _arg2:BitmapData, _arg3:Point, _arg4:Point, _arg5:Point, _arg6:Point):void{
            var _local12:Object;
            var _local13:Number;
            var _local14:Number;
            var _local15:Number;
            var _local16:Number;
            var _local7:Number = (_arg6.x - _arg3.x);
            var _local8:Number = (_arg6.y - _arg3.y);
            var _local9:Number = (_arg5.x - _arg4.x);
            var _local10:Number = (_arg5.y - _arg4.y);
            var _local11:Number = this._p.length;
            while (--_local11 > -1) {
                _local12 = this._p[_local11];
                _local13 = ((_local12.x - this._xMin) / this._w);
                _local14 = ((_local12.y - this._yMin) / this._h);
                _local15 = (_arg3.x + (_local14 * _local7));
                _local16 = (_arg3.y + (_local14 * _local8));
                _local12.sx = (_local15 + (_local13 * ((_arg4.x + (_local14 * _local9)) - _local15)));
                _local12.sy = (_local16 + (_local13 * ((_arg4.y + (_local14 * _local10)) - _local16)));
            };
            this.__render(_arg1, _arg2);
        }
        public function update(_arg1:Graphics, _arg2:BitmapData):void{
            this.__render(_arg1, _arg2);
        }
        protected function __render(_arg1:Graphics, _arg2:BitmapData):void{
            var _local3:Number;
            var _local4:Array;
            var _local5:Object;
            var _local6:Object;
            var _local7:Object;
            var _local8:Array;
            var _local10:Number;
            var _local11:Number;
            var _local12:Number;
            var _local13:Number;
            var _local14:Number;
            var _local15:Number;
            var _local16:Number;
            var _local17:Number;
            var _local18:Number;
            var _local19:Number;
            var _local20:Number;
            var _local21:Number;
            this._sMat = new Matrix();
            this._tMat = new Matrix();
            var _local9:Number = this._tri.length;
            while (--_local9 > -1) {
                _local8 = this._tri[_local9];
                _local5 = _local8[0];
                _local6 = _local8[1];
                _local7 = _local8[2];
                _local10 = _local5.sx;
                _local11 = _local5.sy;
                _local12 = _local6.sx;
                _local13 = _local6.sy;
                _local14 = _local7.sx;
                _local15 = _local7.sy;
                _local16 = _local5.x;
                _local17 = _local5.y;
                _local18 = _local6.x;
                _local19 = _local6.y;
                _local20 = _local7.x;
                _local21 = _local7.y;
                this._tMat.tx = _local16;
                this._tMat.ty = _local17;
                this._tMat.a = ((_local18 - _local16) / this._w);
                this._tMat.b = ((_local19 - _local17) / this._w);
                this._tMat.c = ((_local20 - _local16) / this._h);
                this._tMat.d = ((_local21 - _local17) / this._h);
                this._sMat.a = ((_local12 - _local10) / this._w);
                this._sMat.b = ((_local13 - _local11) / this._w);
                this._sMat.c = ((_local14 - _local10) / this._h);
                this._sMat.d = ((_local15 - _local11) / this._h);
                this._sMat.tx = _local10;
                this._sMat.ty = _local11;
                this._tMat.invert();
                this._tMat.concat(this._sMat);
                _arg1.beginBitmapFill(_arg2, this._tMat, false, this.smoothing);
                _arg1.moveTo(_local10, _local11);
                _arg1.lineTo(_local12, _local13);
                _arg1.lineTo(_local14, _local15);
                _arg1.endFill();
            };
        }
        public function setSize(_arg1:Number, _arg2:Number):void{
            this._w = _arg1;
            this._h = _arg2;
            this.__init();
        }
        public function setPrecision(_arg1:Number, _arg2:Number):void{
            this._hseg = _arg1;
            this._vseg = _arg2;
            this.__init();
        }
        public function get width():Number{
            return (this._w);
        }
        public function get height():Number{
            return (this._h);
        }
        public function get hPrecision():uint{
            return (this._hseg);
        }
        public function get vPrecision():uint{
            return (this._vseg);
        }

    }
}//package org.flashsandy.display 
