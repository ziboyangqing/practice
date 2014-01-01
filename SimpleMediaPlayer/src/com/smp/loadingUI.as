package com.smp {
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
   // import flash.ui.*;
	//进度指示器
    public final class loadingUI extends Sprite {

        private var f:TextFormat;
        private var t:TextField;
        private var r:Sprite;

        public function loadingUI(_arg1:uint=0x888888, _arg2:uint=8, _arg3:uint=10):void{
            var cos:* = NaN;
            var sin:* = NaN;
            var tx:* = NaN;
            var ty:* = NaN;
            var i:* = 0;
            var color:int = _arg1;
            var size:int = _arg2;
            var radius:int = _arg3;
            super();
			//数字显示
            this.f = new TextFormat("Arial", size, color);
            this.t = new TextField();
            this.t.autoSize = "center";
            this.t.selectable = false;
            this.t.defaultTextFormat = this.f;
            this.t.htmlText = " ";
            this.t.x = (-(this.t.width) * 0.5);
            this.t.y = (-(this.t.height) * 0.5);
            addChild(this.t);
            this.r = new Sprite();
            var total:* = (radius * 2);
            var trans:* = (1 / total);
            var degree:* = (360 / total);
            var radian:* = ((degree * Math.PI) / 180);
            var _local5:* = this.r.graphics;
			//绘制
            with (_local5) {
                clear();
                i = 0;
                while (i < total) {
                    beginFill(color, (i * trans));
                    cos = Math.cos((i * radian));
                    sin = Math.sin((i * radian));
                    tx = (size * cos);
                    ty = (size * sin);
                    moveTo(tx, ty);
                    tx = (radius * cos);
                    ty = (radius * sin);
                    lineTo(tx, ty);
                    cos = Math.cos(((i + 1) * radian));
                    sin = Math.sin(((i + 1) * radian));
                    tx = (radius * cos);
                    ty = (radius * sin);
                    lineTo(tx, ty);
                    tx = (size * cos);
                    ty = (size * sin);
                    lineTo(tx, ty);
                    endFill();
                    i++;
                };
            };
            addChild(this.r);
            this.g();
			//添加帧侦听
        }
        public function g():void{
            addEventListener(Event.ENTER_FRAME, this.o, false, 0, true);
        }
		//移除帧侦听
        public function e():void{
            removeEventListener(Event.ENTER_FRAME, this.o);
        }
		//设置显示文字
        public function s(_arg1:String=""):void{
            this.t.text = String(_arg1);
        }
		//动画旋转
        private function o(_arg1:Event):void{
            this.r.rotation = (this.r.rotation + 10);
        }

    }
}
