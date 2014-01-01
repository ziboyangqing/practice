/*SimpleMediaPlayer*/
package com.smp {
    import flash.utils.*;
    import flash.display.*;
    import flash.text.*;
    import flash.geom.*;

    public final class DE extends Sprite {

        private var tw:Number;
        private var th:Number;
        private var f:TextFormat;
        private var s:String = "";
        private var timeid:uint;
        private var t:TextField;
        private var draging:Boolean;
        public var main:Sprite;
        public var overflow:Boolean;
        public var lc:SLrc;

        public function DE(_arg1:SLrc):void{
            this.f = new TextFormat();
            this.t = new TextField();
            this.main = new Sprite();
            super();
            this.lc = _arg1;
            this.t.condenseWhite = true;
            this.t.autoSize = "left";
            this.t.multiline = true;
            this.t.wordWrap = true;
            this.main.addChild(this.t);
            addChild(this.main);
            mouseEnabled = false;
            mouseChildren = false;
        }
        public function ll(_arg1:int, _arg2:int):void{
            this.tw = _arg1;
            this.th = _arg2;
            this.lo();
        }
        public function lo():void{
            this.t.width = this.tw;
            this.main.y = 0;
            this.auto();
        }
        public function ss(_arg1:TextFormat):void{
            this.f = _arg1;
            this.t.defaultTextFormat = this.f;
            this.html(this.s);
        }
        public function init(_arg1:String=""):void{
            visible = true;
            this.lc.lrc.visible = false;
            this.lc.kmc.visible = false;
            _arg1 = unescape(_arg1);
            this.html(_arg1);
            this.lo();
        }
        public function text(_arg1:String=""):void{
            this.t.text = String(_arg1);
            this.main.y = 0;
        }
        public function html(_arg1:String=""):void{
            this.s = _arg1;
            this.t.htmlText = String(this.s);
            this.main.y = 0;
        }
        public function stop():void{
            visible = false;
            this.text();
            this.clear();
        }
        public function clear():void{
            clearTimeout(this.timeid);
        }
        public function idrag():void{
            var _local1:Number;
            var _local2:Rectangle;
            this.clear();
            if (this.overflow){
                this.draging = true;
                _local1 = this.main.height;
                _local2 = new Rectangle(0, (this.th - _local1), 0, (_local1 - this.th));
                this.main.startDrag(false, _local2);
            };
        }
        public function edrag():void{
            this.draging = false;
            this.main.stopDrag();
            this.auto();
        }
        public function hover(_arg1:Boolean):void{
            if (this.draging){
                return;
            };
            if (_arg1){
                this.clear();
            } else {
                if (this.main.y == 0){
                    this.auto();
                } else {
                    this.auto(false);
                };
            };
        }
        public function auto(_arg1:Boolean=true):void{
            this.clear();
            this.overflow = false;
            if ((((this.main.height > this.th)) && ((this.t.numLines > 1)))){
                this.overflow = true;
                if (_arg1){
                    this.timeid = setTimeout(this.scoll, 3000);
                } else {
                    this.scoll();
                };
            };
            this.lc.drag_init();
        }
        private function scoll():void{
            this.clear();
            var _local1:Number = (1 - this.main.y);
            var _local2:Number = (this.main.height - this.th);
            if (_local1 < _local2){
                this.timeid = setTimeout(this.scoll, 200);
            } else {
                if (_local1 == _local2){
                    this.timeid = setTimeout(this.scoll, 3000);
                } else {
                    _local1 = 0;
                    this.timeid = setTimeout(this.scoll, 3000);
                };
            };
            this.main.y = -(_local1);
        }

    }
}
