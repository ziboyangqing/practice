/*SimpleMediaPlayer*/
package com.smp {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.LoaderInfo;
    import flash.events.MouseEvent;

    public final class N extends Plane {

        private var nw:Number;
        private var nh:Number;
        private var l:uint = 12;
        private var bin:Array;
        private var n1:SmartSprite;
        private var n2:SmartSprite;
        private var n3:SmartSprite;
        private var n4:SmartSprite;
        private var n5:SmartSprite;
        private var n6:SmartSprite;
        private var i1:int;
        private var i2:int;
        private var i3:int;
        private var i4:int;
        private var i5:int;
        private var i6:int;
        private var reverse:Boolean = true;
        private var countdown:Boolean = true;

        public function N():void{
            this.bin = [];
            this.n1 = new SmartSprite();
            this.n2 = new SmartSprite();
            this.n3 = new SmartSprite();
            this.n4 = new SmartSprite();
            this.n5 = new SmartSprite();
            this.n6 = new SmartSprite();
            super();
            addEventListener(MouseEvent.CLICK, this.clickHd);
            addEventListener(MouseEvent.MOUSE_OVER, this.overHd);
            addEventListener(MouseEvent.MOUSE_OUT, this.outHd);
            addChild(this.n1);
            addChild(this.n2);
            addChild(this.n3);
            addChild(this.n4);
            addChild(this.n5);
            addChild(this.n6);
            this.init();
        }
        private function init():void{
            this.i1 = this.i2 = this.i3 = this.i4 = this.i5 = this.i6 = 13;
        }
        public function show(_arg1:Number, _arg2:Number):void{
            if (!visible){
                return;
            };
            if (this.reverse){
                if (_arg2 > _arg1){
                    _arg1 = (_arg2 - _arg1);
                    this.countdown = true;
                } else {
                    this.countdown = false;
                };
            } else {
                this.countdown = false;
            };
            var _local3:int = int((_arg1 / 60));
            var _local4:int = (_local3 % 10);
            var _local5:int = int((_local3 * 0.1));
            var _local6:int = (_local5 % 10);
            var _local7:int = 12;
            var _local8:int = int((_local5 * 0.1));
            if (this.countdown){
                _local7 = 11;
            } else {
                if (_local8 > 0){
                    _local7 = (_local8 % 10);
                };
            };
            var _local9:int = int((_arg1 % 60));
            var _local10:int = (_local9 % 10);
            var _local11:int = int((_local9 * 0.1));
            var _local12:int = (_local11 % 10);
            var _local13:int = 10;
            this.draw([_local7, _local6, _local4, _local13, _local12, _local10]);
        }
        override public function size():void{
            this.nw = Math.round((tw / 6));
            this.nh = th;
            this.n2.x = (this.nw * 1);
            this.n3.x = (this.nw * 2);
            this.n4.x = (this.nw * 3);
            this.n5.x = (this.nw * 4);
            this.n6.x = (this.nw * 5);
        }
        override public function srcComplete(_arg1:LoaderInfo):void{
            visible = false;
            var _local2:BitmapData = Zip.GetBMD(_arg1);
            if (_local2){
                this.bin = Zip.SplitBMD(_local2, this.l, 1);
                this.init();
                visible = true;
                this.draw([12, 0, 0, 10, 0, 0]);
            };
        }
        private function draw(_arg1:Array):void{
            if (((!(this.nw)) || (!(this.nh)))){
                return;
            };
            if (_arg1[0] != this.i1){
                this.i1 = _arg1[0];
                this.n1.show(new Bitmap(this.bin[this.i1]), this.nw, this.nh);
            };
            if (_arg1[1] != this.i2){
                this.i2 = _arg1[1];
                this.n2.show(new Bitmap(this.bin[this.i2]), this.nw, this.nh);
            };
            if (_arg1[2] != this.i3){
                this.i3 = _arg1[2];
                this.n3.show(new Bitmap(this.bin[this.i3]), this.nw, this.nh);
            };
            if (_arg1[3] != this.i4){
                this.i4 = _arg1[3];
                this.n4.show(new Bitmap(this.bin[this.i4]), this.nw, this.nh);
            };
            if (_arg1[4] != this.i5){
                this.i5 = _arg1[4];
                this.n5.show(new Bitmap(this.bin[this.i5]), this.nw, this.nh);
            };
            if (_arg1[5] != this.i6){
                this.i6 = _arg1[5];
                this.n6.show(new Bitmap(this.bin[this.i6]), this.nw, this.nh);
            };
        }
        private function clickHd(_arg1:MouseEvent):void{
            this.init();
            this.reverse = !(this.reverse);
            this.hT();
        }
        private function overHd(_arg1:MouseEvent):void{
            this.sT();
        }
        private function outHd(_arg1:MouseEvent):void{
            this.hT();
        }
        private function sT():void{
            if (this.countdown){
                Main.tp.show(this, ((tips[1]) || (tips[0])));
            } else {
                Main.tp.show(this, tips[0]);
            };
        }
        private function hT():void{
            Main.tp.hide();
        }

    }
}
