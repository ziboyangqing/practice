/*SimpleMediaPlayer*/
package com.smp {
    import com.utils.AppUtil;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.LoaderInfo;
    import flash.events.MouseEvent;
    
    import interfaces.IPlane;

    //import flash.text.*;
	/**
	 * Button  class
	 */
    public class SButton extends ButtonBase implements IPlane {

        private var _xywh:String;
        private var _pw:int;
        private var _ph:int;
        private var tx:int;
        private var ty:int;
        private var _display:Boolean = true;
        private var _src:String;
        private var _reverse:Boolean = false;
	
        public var skins:Array;
        public var tips:Array;

        public function SButton():void{
            this.skins = [];
            this.tips = [];
            super();
            useHandCursor = true;//false;
            addEventListener(MouseEvent.ROLL_OVER, this.overHd);
            addEventListener(MouseEvent.ROLL_OUT, this.outHd);
            addEventListener(MouseEvent.CLICK, this.clickHd);
        }
        public function get reverse():Boolean{
            return (this._reverse);
        }
        public function set reverse(_arg1:Boolean):void{
            if (this._reverse == _arg1){
                return;
            };
            this._reverse = _arg1;
            this.show();
        }
        public function ds(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Array):void{
            this.tx = _arg1;
            this.ty = _arg2;
            tw = _arg3;
            th = _arg4;
            this.skins = _arg5;
            this.show();
            move(this.tx, this.ty);
            size(tw, th);
        }
        public function lo():void{
            if (((((!(this._xywh)) || (!(this._pw)))) || (!(this._ph)))){
                visible = false;
                return;
            };
            var _local1:Array = AppUtil.xywh(this._xywh, this._pw, this._ph);
            this.tx = _local1[0];
            this.ty = _local1[1];
            tw = _local1[2];
            th = _local1[3];
            move(this.tx, this.ty);
            if ((((tw > 0)) && ((th > 0)))){
                size(tw, th);
                visible = true;
            } else {
                visible = false;
            };
        }
        public function set xywh(_arg1:String):void{
            if (this._xywh != _arg1){
                this._xywh = _arg1;
                this.lo();
            };
        }
        public function get xywh():String{
            return (this._xywh);
        }
        public function ll(_arg1:int, _arg2:int):void{
            if (((!((this._pw == _arg1))) || (!((this._ph == _arg2))))){
                this._pw = _arg1;
                this._ph = _arg2;
                this.lo();
            };
        }
        public function ss(_arg1:XMLList, _arg2:int, _arg3:int):void{
            this._pw = _arg2;
            this._ph = _arg3;
            this._xywh = _arg1.@xywh;
            this.lo();
            bt.useHandCursor = AppUtil.gOP(_arg1, "useHandCursor", useHandCursor);
            this.display = AppUtil.gOP(_arg1, "display", visible);
            rotation = parseInt(AppUtil.gOP(_arg1, "rotation", 0));
            alpha = AppUtil.per(AppUtil.gOP(_arg1, "alpha", 1));
            this.tips = AppUtil.array(AppUtil.gOP(_arg1, "tips", ""));
            filters = SGraphics.filters(_arg1);
            this.src = _arg1.@src;
        }
        public function set display(_arg1:String):void{
            this._display = AppUtil.tof(_arg1);
            visible = this._display;
        }
        public function get display():String{
            return (this._display.toString());
        }
        public function set src(_arg1:String):void{
            this._src = _arg1;
            Zip.GetSrc(_arg1, this.srcComplete);
        }
        public function get src():String{
            return (this._src);
        }
        private function srcComplete(_arg1:LoaderInfo):void{
            var _local3:Array;
            var _local2:BitmapData = Zip.GetBMD(_arg1);
            if (_local2){
                _local3 = Zip.SplitBMD(_local2, 4, 1);//横向4纵向1分割
                this.skins = [new Bitmap(_local3[0]), new Bitmap(_local3[1]), new Bitmap(_local3[2]), new Bitmap(_local3[3])];
                this.show();
            } else {
                this.init();
            };
        }
        public function init():void{
            this.skins = null;
            style(null, null, null);
        }
		/**
		 * 设置不合理会出现闪烁/图标跳动现象
		 */
        public function show():void{
            if (this.skins){
                if (this._reverse){
                    style(this.skins[2], this.skins[3], this.skins[3]);
                } else {
                    style(this.skins[0], this.skins[1], this.skins[1]);
                };
            } else {
                this.init();
            };
        }
        private function clickHd(_arg1:MouseEvent):void{
            this.hT();
			trace("Sbutton:CLICKED");
        }
        private function overHd(_arg1:MouseEvent):void{
            parent.setChildIndex(this, (parent.numChildren - 1));
            this.sT();
        }
        private function outHd(_arg1:MouseEvent):void{
            this.hT();
        }
        private function sT():void{
            if (this.reverse){
                Main.tp.show(this, ((this.tips[1]) || (this.tips[0])));
            } else {
                Main.tp.show(this, this.tips[0]);
            };
        }
        private function hT():void{
            Main.tp.hide();
        }

    }
}
