/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import flash.filters.*;

    public final class RD extends Sprite {

        private var tr:Number = 11;
        private var icon:Sprite;
        private var dot:Sprite;
        private var main:Sprite;
        private var txt:TextField;
        private var _label:String = "";
        private var _selected:Boolean = false;
        private var _enabled:Boolean = true;
        private var format1:TextFormat;
        private var format2:TextFormat;
        private var _value:Number = 0;

        public function RD(_arg1:TextFormat, _arg2:TextFormat):void{
            this.format1 = _arg1;
            this.format2 = _arg2;
            this.icon = new Sprite();
            this.icon.buttonMode = true;
            this.icon.filters = [new DropShadowFilter(0, 0.3)];
            addChild(this.icon);
            this.dot = new Sprite();
            this.icon.addChild(this.dot);
            this.drawIcon(0x999999);
            this.drawDot(0x333333);
            this.dot.visible = this._selected;
            this.main = new Sprite();
            this.main.buttonMode = true;
            addChild(this.main);
            this.txt = new TextField();
            this.txt.mouseEnabled = false;
            this.txt.selectable = false;
            this.txt.autoSize = "left";
            this.main.addChild(this.txt);
            this.main.x = (this.tr + 4);
            this.icon.addEventListener(MouseEvent.CLICK, this.iconHandler);
            this.main.addEventListener(MouseEvent.CLICK, this.mainHandler);
            addEventListener(MouseEvent.MOUSE_OVER, this.over);
            addEventListener(MouseEvent.MOUSE_OUT, this.out);
        }
        private function iconHandler(_arg1:MouseEvent):void{
            var _local2:UIEvent;
            if (this.enabled){
                _local2 = new UIEvent(UIEvent.RADIO_CLICK, this.value);
                dispatchEvent(_local2);
            };
        }
        private function mainHandler(_arg1:MouseEvent):void{
            var _local2:UIEvent;
            if (this.enabled){
                _local2 = new UIEvent(UIEvent.LABEL_CLICK, this.value);
                dispatchEvent(_local2);
            };
        }
        public function get label():String{
            return (this._label);
        }
        public function set label(_arg1:String):void{
            this._label = _arg1;
            this.txt.htmlText = unescape(_arg1);
            this.format();
            SGraphics.drawRect(this.main, 0, 0, this.txt.width, this.txt.height);
        }
        public function set value(_arg1:Number):void{
            this._value = _arg1;
        }
        public function get value():Number{
            return (this._value);
        }
        public function get selected():Boolean{
            return (this._selected);
        }
        public function set selected(_arg1:Boolean):void{
            this._selected = _arg1;
            this.dot.visible = _arg1;
            this.format();
        }
        public function get enabled():Boolean{
            return (this._enabled);
        }
        public function set enabled(_arg1:Boolean):void{
            this._enabled = _arg1;
            if (this._enabled){
                alpha = 1;
            } else {
                alpha = 0.5;
            };
        }
        private function format():void{
            if (this._selected){
                this.setFormat(this.format2);
            } else {
                this.setFormat(this.format1);
            };
        }
        private function setFormat(_arg1:TextFormat):void{
            this.txt.setTextFormat(_arg1);
            this.icon.y = ((this.txt.height - this.tr) * 0.5);
        }
        private function over(_arg1:MouseEvent):void{
            if (!this.enabled){
                return;
            };
            this.drawIcon(0x666666);
            this.drawDot(0);
            this.setFormat(this.format2);
        }
        private function out(_arg1:MouseEvent):void{
            if (!this.enabled){
                return;
            };
            this.drawIcon(0x999999);
            this.drawDot(0x333333);
            if (!this._selected){
                this.setFormat(this.format1);
            };
        }
        private function drawDot(_arg1:Number):void{
            var _local2:Number = (this.tr * 0.5);
            var _local3:Graphics = this.dot.graphics;
            _local3.clear();
            _local3.beginFill(_arg1);
            _local3.drawCircle(_local2, _local2, 2);
            _local3.endFill();
        }
        private function drawIcon(_arg1:Number):void{
            var _local2:Number = (this.tr * 0.5);
            var _local3:Graphics = this.icon.graphics;
            _local3.clear();
            _local3.lineStyle(1, _arg1, 1);
            _local3.beginFill(0xFFFFFF);
            _local3.drawCircle(_local2, _local2, _local2);
            _local3.endFill();
        }

    }
}
