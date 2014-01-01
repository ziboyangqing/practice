/*SimpleMediaPlayer*/
package com.smp {
    import flash.display.*;
	/** 
	 * Button Base class
	 */
    public class ButtonBase extends Sprite {

        public var bt:SimpleButton;
        public var tw:Number;
        public var th:Number;
        public var up:DisplayObject;
        public var over:DisplayObject;
        public var down:DisplayObject;

        public function ButtonBase():void{
            this.bt = new SimpleButton();
            this.bt.useHandCursor = true;//false;
            addChild(this.bt);
        }
		/**
		 * Set Button Style:4 states
		 */
        public function style(upState:DisplayObject, overState:DisplayObject, downState:DisplayObject):void{
            this.up = upState;
            this.over = overState;
            this.down = downState;
            this.update();
        }
        public function update():void{
            this.bt.hitTestState = this.up;
            this.bt.upState = this.up;
            this.bt.overState = this.over;
            this.bt.downState = this.down;
            this.layout();
        }
        public function move(_arg1:Number, _arg2:Number):void{
            x = _arg1;
            y = _arg2;
        }
        public function size(_arg1:Number, _arg2:Number):void{
            if (((!((this.tw == _arg1))) || (!((this.th == _arg2))))){
                this.tw = _arg1;
                this.th = _arg2;
                this.layout();
            };
        }
        public function layout():void{
            if (((((this.bt.hitTestState) && (this.tw))) && (this.th))){
                if (this.bt.width != this.tw){
                    this.bt.width = this.tw;
                };
                if (this.bt.height != this.th){
                    this.bt.height = this.th;
                };
            };
        }

    }
}
