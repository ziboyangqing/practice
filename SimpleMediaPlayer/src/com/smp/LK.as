/*SimpleMediaPlayer*/
package com.smp {
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import flash.geom.*;

    public final class LK extends Sprite {

        public var th:Number = 20;
        public var t:TextField;
        public var fb:TextFormat;
        public var fu:TextFormat;
        public var ico:DisplayObject;
        public var str:String;
        public var txt:String;
        public var ctf:ColorTransform;
        public var tips:String;

        public function LK(_arg1:TextFormat, _arg2:TextFormat, _arg3:DisplayObject, _arg4:String, _arg5:String=""):void{
            this.fb = _arg1;
            this.fu = _arg2;
            this.ico = _arg3;
            this.str = _arg4;
            this.txt = _arg5;
            this.ctf = new ColorTransform();
            this.t = new TextField();
            this.t.mouseEnabled = false;
            this.t.defaultTextFormat = this.fb;
            this.t.autoSize = "left";
            addChild(this.t);
            addChild(this.ico);
            addEventListener(MouseEvent.ROLL_OVER, this.linkOver, false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT, this.linkOut, false, 0, true);
            buttonMode = true;
            this.draw();
        }
        public function draw():void{
            this.ico.x = (this.ico.y = (this.th * 0.5));
            this.t.text = this.str;
            this.t.x = this.th;
            this.t.y = ((this.th - this.t.height) * 0.5);
            SGraphics.drawRect(this, 0, 0, width, height);
        }
        private function linkOver(_arg1:MouseEvent):void{
            this.t.setTextFormat(this.fu);
            this.ctf.color = (this.fu.color as uint);
            this.ico.transform.colorTransform = this.ctf;
            if (this.tips){
                Main.tp.show(this, this.tips);
            };
        }
        private function linkOut(_arg1:MouseEvent):void{
            this.t.setTextFormat(this.fb);
            this.ctf.color = (this.fb.color as uint);
            this.ico.transform.colorTransform = this.ctf;
            if (this.tips){
                Main.tp.hide();
            };
        }
        public function clicked():void{
            this.t.text = this.txt;
            this.t.setTextFormat(this.fu);
            setTimeout(this.reset, 1000);
        }
        private function reset():void{
            this.t.text = this.str;
        }

    }
}
