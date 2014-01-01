/*SimpleMediaPlayer*/
package com.smp {
    //import flash.utils.*;
    //import flash.events.*;
    import flash.display.*;
    //import flash.text.*;
    //import flash.geom.*;

    public final class IN extends T {

        public var skins:Array;
        public var arrow:Sprite;

        public function IN(){
            this.skins = [];
            this.arrow = new Sprite();
            addChild(this.arrow);
            visible = false;
            mouseEnabled = false;
            mouseChildren = false;
            super();
        }
        override public function lo():void{
            super.lo();
            this.setArrow();
        }
        override public function ss(_arg1:XMLList, _arg2:int, _arg3:int):void{
            this.clear();
            super.ss(_arg1, _arg2, _arg3);
            visible = false;
        }
        override public function srcComplete(_arg1:LoaderInfo):void{
            var _local3:Array;
            this.skins = [];
            var _local2:BitmapData = Zip.GetBMD(_arg1);
            if (_local2){
                _local3 = Zip.SplitBMD(_local2, 1, 2);
                this.skins = [new SBitMap(_local3[0]), new SBitMap(_local3[1])];
                shim.show(this.skins[0], tw, th);
                this.arrow.addChild(this.skins[1]);
            } else {
                this.clear();
            };
            this.setArrow();
        }
        public function clear():void{
            Main.clear(shim);
            Main.clear(this.arrow);
        }
        public function setArrow():void{
            this.arrow.x = Math.round(((tw - this.arrow.width) * 0.5));
            this.arrow.y = th;
        }
        public function move(_arg1:Number, _arg2:Number, _arg3:String=""):void{
            x = ((_arg1 + tx) - (tw * 0.5));
            y = ((_arg2 + ty) - th);
            show(_arg3);
        }

    }
}
