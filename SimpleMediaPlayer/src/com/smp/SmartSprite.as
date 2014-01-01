/*SimpleMediaPlayer*/
package com.smp {
    import flash.display.*;

    public final class SmartSprite extends Sprite {

        private var shim:DisplayObject;

        public function SmartSprite():void{
        }
        public function show(target:DisplayObject, w:Number=0, h:Number=0):void{
            if (this.shim){
                if (contains(this.shim)){
                    removeChild(this.shim);
                };
            };
            addChild(target);
            this.shim = target;
            this.size(w, h);
        }
        public function size(_arg1:Number, _arg2:Number):void{
            var _local3:SBitMap;
            if (_arg1 > 0 && _arg2 > 0){
                if (this.shim){
                    if (this.shim is SBitMap){
                        _local3 = this.shim as SBitMap;
                        _local3.size(_arg1, _arg2);
                    } else {
                        if (this.shim.width != _arg1){
                            this.shim.width = _arg1;
                        };
                        if (this.shim.height != _arg2){
                            this.shim.height = _arg2;
                        };
                    };
                };
                visible = true;
            } else {
                visible = false;
            };
        }

    }
}
