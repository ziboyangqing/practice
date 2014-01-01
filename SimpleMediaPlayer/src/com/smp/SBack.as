/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    //import flash.net.*;
    //import flash.ui.*;
    //import flash.system.*;
    import com.utils.AppUtil;

    public final class SBack extends Plane {

        public var cw:Number;
        public var ch:Number;
        public var scalemode:String;
        public var bgcolor:String;
        public var lock:String = "true";//锁定无法拖动
        public var repeat:String;
        public var bin:BitmapData;
        public var loader:SLoader;
        public var key:String;
        public var info:LoaderInfo;
        public var bb:BaseBack;

        public function SBack(_arg1:BaseBack):void{
            this.bb = _arg1;
        }
        public function rm():void{
            graphics.clear();
            if (parent){
                parent.removeChild(this);
            };
            if (this.key){
                Main.ca.removeKey(this.key);
                Main.apirm(this.info);
                this.info = null;
            };
            if (this.bin){
                this.bin.dispose();
            };
            if (this.loader){
                try {
                    this.loader.close();
                } catch(e:Error) {
                };
                try {
                    this.loader.unloadAndStop();
                } catch(e:Error) {
                };
                this.loader = null;
            };
        }
        override public function lo():void{
            var _local1:Array;
            var _local4:Array;
            var _local5:Array;
            var _local6:Array;
            var _local7:Number;
            if (!visible){
                return;
            };
            _local1 = AppUtil.xywh(_xywh, _pw, _ph);
            tx = _local1[0];
            ty = _local1[1];
            tw = _local1[2];
            th = _local1[3];
            graphics.clear();
            var _local2:Number = ((tw) || (_pw));
            var _local3:Number = ((th) || (_ph));
            if (this.bgcolor){
                SGraphics.drawRect(this, tx, ty, _local2, _local3, 1, AppUtil.color(this.bgcolor));
            };
            if (this.bin){
                graphics.beginBitmapFill(this.bin, null, true);
                graphics.drawRect(tx, ty, _local2, _local3);
                graphics.endFill();
                return;
            };
            x = tx;
            y = ty;
            if (this.loader){
                this.cw = this.loader.width;
                this.ch = this.loader.height;
            };
            if ((((this.cw > 0)) && ((this.ch > 0)))){
                if (xywh){
                    if ((((tw > 0)) && ((th > 0)))){
                        width = tw;
                        height = th;
                    } else {
                        _local4 = AppUtil.array(_xywh);
                        _local5 = AppUtil.ns(_local4[0]);
                        _local6 = AppUtil.ns(_local4[1]);
                        x = AppUtil.mxoy(tx, _local5[1], this.cw);
                        y = AppUtil.mxoy(ty, _local6[1], this.ch);
                    };
                } else {
                    _local7 = parseInt(this.scalemode);
                    if (!isNaN(_local7)){
                        AppUtil.fit(this, _pw, _ph, _local7);
                    };
                };
            };
        }
        override public function set xywh(_arg1:String):void{
            _xywh = _arg1;
        }
        public function nxywh():void{
            if (((!((tx == x))) || (!((ty == y))))){
                tx = x;
                ty = y;
                _xywh = AppUtil.nxywh(_xywh, tx, ty, ((tw) || (this.cw)), ((th) || (this.ch)), _pw, _ph);
            };
        }
        override public function ss(_arg1:XMLList, _arg2:int, _arg3:int):void{
            var _local5:XML;
            var _local6:String;
            _pw = _arg2;
            _ph = _arg3;
            var _local4:XMLList = _arg1.attributes();
            for each (_local5 in _local4) {
                _local6 = _local5.localName();
                if (this.hasOwnProperty(_local6)){
                    try {
                        this[_local6] = AppUtil.parse(_local5.toString());
                    } catch(e:Error) {
                    };
                };
            };
        }
        override public function set src(_arg1:String):void{
            _src = _arg1;
            _src = Main.fU(_src, true);
            new SURLLodader(_src, this.bkE, this.bkP, this.bkL);
        }
        public function bkP(_arg1:uint, _arg2:uint):void{
        }
        public function bkE(_arg1:String):void{
            O.o(src, _arg1);
            this.finish();
            this.bb.rm();
        }
        public function bkL(_arg1:ByteArray):void{
            var _local3:Object;
            var _local2:Array = Zip.extract(_arg1);
            if (_arg1 == _local2[0]){
                this.loadBytes(_arg1);
            } else {
                delete this.bb.dt.src;
                _local3 = {
                    data:this.bb.dt,
                    list:_local2
                };
                this.bb.dispatchEvent(new UIEvent(UIEvent.ZIP_EXTRACT, _local3));
                this.bb.rm();
            };
        }
        public function loadBytes(_arg1:ByteArray):void{
            this.loader = new SLoader(_arg1, this.loaded, true);
        }
        public function loaded(_arg1:LoaderInfo):void{
            this.info = _arg1;
            if (this.info){
                this.key = Main.api(this.info);
                this.cw = this.loader.width;
                this.ch = this.loader.height;
                if (((((((this.info.childAllowsParent) && (this.cw))) && (this.ch))) && (AppUtil.tof(this.repeat)))){
                    this.bin = new BitmapData(this.cw, this.ch, true, 0);
                    this.bin.draw(this.loader);
                } else {
                    addChild(this.loader);
                };
            } else {
                O.o(("Error: " + src));
            };
            this.lo();
            this.finish();
        }
        public function finish():void{
            this.bb.dispatchEvent(new Event(Event.COMPLETE));
        }

    }
}
