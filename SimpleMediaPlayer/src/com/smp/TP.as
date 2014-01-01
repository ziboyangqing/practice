/*SimpleMediaPlayer*/
package com.smp {
    import flash.utils.*;
    import flash.display.*;
    import flash.text.*;
    import flash.filters.*;
    import flash.geom.*;
    import com.utils.AppUtil;

    public final class TP extends Sprite {

        private var py:Number;
        private var ph:Number;
        private var ts:String;
        private var tt:TextField;
        private var tf:TextFormat;
        private var timeoutId:uint;

        public function TP():void{
            this.tf = this.gF();
            this.tt = this.gT();
            addChild(this.tt);
            this.hide();
        }
        public function show(_arg1:DisplayObject, _arg2:String):void{
            var _local3:Point = _arg1.localToGlobal(new Point(0, 0));
            this.py = _local3.y;
            this.ph = _arg1.height;
            this.ts = _arg2;
            clearTimeout(this.timeoutId);
            if (((_arg2) && (Main.sk.show_tips))){
                this.timeoutId = setTimeout(this.showNow, (Main.sk.show_tips * 1000));
            };
        }
        private function showNow():void{
            var _local4:Number;
            this.tt.htmlText = unescape(this.ts);
            this.tt.setTextFormat(this.tf);
            var _local1:Number = (stage.mouseX - (this.tt.width * 0.5));
            var _local2:Number = (Config.width - this.tt.width);
            _local1 = AppUtil.clamp(_local1, 0, _local2);
            var _local3:Number = (this.py - this.tt.height);
            if (_local3 < 0){
                _local4 = (stage.mouseY + 10);
                _local3 = (this.py + this.ph);
                if (_local3 < _local4){
                    _local3 = _local4;
                };
            };
            this.tt.x = _local1;
            this.tt.y = _local3;
            visible = true;
            clearTimeout(this.timeoutId);
            this.timeoutId = setTimeout(this.hide, 3000);
        }
        public function hide():void{
            clearTimeout(this.timeoutId);
            visible = false;
        }
        private function gF():TextFormat{
            var _local1:TextFormat = new TextFormat();
            _local1.size = 12;
            _local1.leading = 2;
            _local1.font = "Verdana";
            _local1.leftMargin = 3;
            _local1.rightMargin = 2;
            return (_local1);
        }
        private function gT():TextField{
            var _local1:TextField = new TextField();
            _local1.selectable = false;
            _local1.mouseEnabled = false;
            _local1.autoSize = "left";
            _local1.background = true;
            _local1.backgroundColor = 16777185;
            _local1.filters = [new DropShadowFilter(0, 0.2, 4)];
            return (_local1);
        }

    }
}
