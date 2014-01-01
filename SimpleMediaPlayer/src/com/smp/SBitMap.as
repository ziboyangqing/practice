/*SimpleMediaPlayer*/
package com.smp {
    import flash.display.*;
    import flash.geom.*;

    public final class SBitMap extends Sprite {

        private var dw:Number;
        private var dh:Number;
        private var tw:Number;
        private var th:Number;
        private var data:BitmapData;
        private var map:Bitmap;

        public function SBitMap(bmd:BitmapData){
            this.data = bmd;
            this.dw = (this.tw = this.data.width);
            this.dh = (this.th = this.data.height);
            this.map = new Bitmap(this.data);
            addChild(this.map);
        }
        override public function get width():Number{
            return (this.tw);
        }
        override public function set width(_arg1:Number):void{
            this.size(_arg1, this.th);
        }
        override public function get height():Number{
            return (this.th);
        }
        override public function set height(_arg1:Number):void{
            this.size(this.tw, _arg1);
        }
        public function size(w:Number, h:Number):void{
            this.tw = Math.round(w);
            this.th = Math.round(h);
            this.drawNow();
        }
        private function drawNow():void{
            if ((((((((this.tw <= 0)) || ((this.tw > 2880)))) || ((this.th <= 0)))) || ((this.th > 2880)))){
                visible = false;
                return;
            };
            this.draw();
        }
        private function draw():void{
            var _local2:BitmapData;
            var _local3:int;
            var _local4:int;
            var _local5:Rectangle;
            var _local6:int;
            var _local7:int;
            var _local8:int;
            var _local9:BitmapData;
            var _local10:int;
            var _local11:int;
            var _local12:Rectangle;
            var _local13:int;
            var _local14:int;
            var _local15:int;
            var _local1:BitmapData = this.data.clone();
            if (this.tw != this.dw){
                _local2 = new BitmapData(this.tw, this.dh, true, 0);
                if (this.dw < this.tw){
                    _local3 = int((this.dw * 0.5));
                    _local4 = (this.dw - _local3);
                    _local2.copyPixels(_local1, new Rectangle(0, 0, _local3, this.dh), new Point(0, 0));
                    _local5 = new Rectangle(_local3, 0, 1, this.dh);
                    _local6 = _local3;
                    while (_local6 < (this.tw - _local3)) {
                        _local2.copyPixels(_local1, _local5, new Point(_local6, 0));
                        _local6++;
                    };
                    _local2.copyPixels(_local1, new Rectangle(_local3, 0, _local4, this.dh), new Point((this.tw - _local4), 0));
                } else {
                    if (this.dw > this.tw){
                        _local7 = int((this.tw * 0.5));
                        _local8 = (this.tw - _local7);
                        _local2.copyPixels(_local1, new Rectangle(0, 0, _local7, this.dh), new Point(0, 0));
                        _local2.copyPixels(_local1, new Rectangle((this.dw - _local8), 0, _local8, this.dh), new Point(_local7, 0));
                    };
                };
                _local1.dispose();
                _local1 = _local2;
            };
            if (this.th != this.dh){
                _local9 = new BitmapData(this.tw, this.th, true, 0);
                if (this.dh < this.th){
                    _local10 = int((this.dh * 0.5));
                    _local11 = (this.dh - _local10);
                    _local9.copyPixels(_local1, new Rectangle(0, 0, this.tw, _local10), new Point(0, 0));
                    _local12 = new Rectangle(0, _local10, this.tw, 1);
                    _local13 = _local10;
                    while (_local13 < (this.th - _local10)) {
                        _local9.copyPixels(_local1, _local12, new Point(0, _local13));
                        _local13++;
                    };
                    _local9.copyPixels(_local1, new Rectangle(0, _local10, this.tw, _local11), new Point(0, (this.th - _local11)));
                } else {
                    if (this.dh > this.th){
                        _local14 = int((this.th * 0.5));
                        _local15 = (this.th - _local14);
                        _local9.copyPixels(_local1, new Rectangle(0, 0, this.tw, _local14), new Point(0, 0));
                        _local9.copyPixels(_local1, new Rectangle(0, (this.dh - _local15), this.tw, _local15), new Point(0, _local14));
                    };
                };
                _local1.dispose();
                _local1 = _local9;
            };
            removeChild(this.map);
            this.map = new Bitmap(_local1);
            addChild(this.map);
            if (!visible){
                visible = true;
            };
        }

    }
}
