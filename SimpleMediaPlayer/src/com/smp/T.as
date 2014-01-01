/*SimpleMediaPlayer*/
package com.smp {
    //import flash.utils.*;
    //import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    //import flash.geom.*;
    import com.utils.AppUtil;

    public class T extends Plane {

        public var shim:SmartSprite;
        public var text:TextField;
        public var _str:String;
        public var formatBase:TextFormat;
        public var formatUpon:TextFormat;

        public function T(_arg1:String="dynamic"):void{
            this.shim = new SmartSprite();
            this.text = new TextField();
            this.formatBase = new TextFormat();
            this.formatUpon = new TextFormat();
            super();
            addChild(this.shim);
            this.text.multiline = false;
            this.text.type = _arg1;
            this.text.width = 0;
            this.text.height = 0;
            addChild(this.text);
        }
        public function show(_arg1:String):void{
            if (this._str != _arg1){
                this._str = _arg1;
                this.text.htmlText = unescape(this._str);
                this.setFormat();
            };
        }
        public function setFormat(_arg1:Boolean=true):void{
            if (_arg1){
                this.text.setTextFormat(this.formatUpon);
            } else {
                this.text.setTextFormat(this.formatBase);
            };
        }
        override public function size():void{
            this.text.width = tw;
            this.text.height = th;
        }
        override public function ss(_arg1:XMLList, _arg2:int, _arg3:int):void{
            _pw = _arg2;
            _ph = _arg3;
            xywh = _arg1.@xywh;
            this.formatBase = AppUtil.format(_arg1);
            this.formatUpon = AppUtil.format(_arg1, 1);
            this.text.defaultTextFormat = this.formatUpon;
            this.text.setTextFormat(this.formatUpon);
            var _local4:String = _arg1.@borderColor;
            if (_local4){
                this.text.border = true;
                this.text.borderColor = AppUtil.color(_local4);
            } else {
                this.text.border = false;
            };
            var _local5:String = _arg1.@backgroundColor;
            if (_local5){
                this.text.background = true;
                this.text.backgroundColor = AppUtil.color(_local5);
            } else {
                this.text.background = false;
            };
            display = AppUtil.gOP(_arg1, "display", visible);
            alpha = AppUtil.per(AppUtil.gOP(_arg1, "alpha", 1));
            filters = SGraphics.filters(_arg1);
            src = _arg1.@src;
        }
        override public function srcComplete(_arg1:LoaderInfo):void{
            this.shim.show(Zip.getLD(_arg1), tw, th);
        }

    }
}
