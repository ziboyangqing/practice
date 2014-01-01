/*SimpleMediaPlayer*/
package com.smp {
    import flash.utils.*;

    public final class E {

        private var b0:Number = 0;
        private var b1:Number = 0;
        private var b2:Number = 0;
        private var a0:Number = 0;
        private var a1:Number = 0;
        private var a2:Number = 0;
        private var lxnm1:Number = 0;
        private var lxnm2:Number = 0;
        private var lynm1:Number = 0;
        private var lynm2:Number = 0;
        private var rxnm1:Number = 0;
        private var rxnm2:Number = 0;
        private var rynm1:Number = 0;
        private var rynm2:Number = 0;
        private var gain:Number;

        public function E(_arg1:Number, _arg2:Number, _arg3:Number):void{
            this.gain = _arg2;
            var _local4:Number = Math.pow(10, (_arg2 / 40));
            var _local5:Number = (((2 * Math.PI) * _arg1) / 44100);
            var _local6:Number = Math.sin(_local5);
            var _local7:Number = Math.cos(_local5);
            var _local8:Number = (_local6 / (2 * _arg3));
            this.b0 = (1 + (_local8 * _local4));
            this.b1 = (-2 * _local7);
            this.b2 = (1 - (_local8 * _local4));
            this.a0 = (1 + (_local8 / _local4));
            this.a1 = (-2 * _local7);
            this.a2 = (1 - (_local8 / _local4));
            this.b0 = (this.b0 / this.a0);
            this.b1 = (this.b1 / this.a0);
            this.b2 = (this.b2 / this.a0);
            this.a1 = (this.a1 / this.a0);
            this.a2 = (this.a2 / this.a0);
        }
        public function filter(_arg1:Array):Array{
            var _local2:Number;
            var _local3:Number;
            var _local4:Number;
            var _local5:Number;
            var _local7:Array;
            if (this.gain == 0){
                return (_arg1);
            };
            var _local6:int = _arg1.length;
            var _local8:int;
            while (_local8 < _local6) {
                _local7 = _arg1[_local8];
                _local2 = _local7[0];
                _local3 = (((((this.b0 * _local2) + (this.b1 * this.lxnm1)) + (this.b2 * this.lxnm2)) - (this.a1 * this.lynm1)) - (this.a2 * this.lynm2));
                this.lxnm2 = this.lxnm1;
                this.lxnm1 = _local2;
                this.lynm2 = this.lynm1;
                this.lynm1 = _local3;
                _local4 = _local7[1];
                _local5 = (((((this.b0 * _local4) + (this.b1 * this.rxnm1)) + (this.b2 * this.rxnm2)) - (this.a1 * this.rynm1)) - (this.a2 * this.rynm2));
                this.rxnm2 = this.rxnm1;
                this.rxnm1 = _local4;
                this.rynm2 = this.rynm1;
                this.rynm1 = _local5;
                _arg1[_local8] = [_local3, _local5];
                _local8++;
            };
            return (_arg1);
        }

    }
}
