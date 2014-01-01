/*SimpleMediaPlayer*/
package com.smp {
    //import flash.events.*;
    import flash.display.*;
    import com.utils.AppUtil;
    import interfaces.IPlane;

    public class Plane extends Sprite implements IPlane {

        public var _xywh:String;
        public var _pw:int;
        public var _ph:int;
        public var tx:int;
        public var ty:int;
        public var tw:int;
        public var th:int;
        public var _display:Boolean = true;
        public var _src:String;
        public var tips:Array;

        public function Plane():void{
            this.tips = [];
            super();
        }
        public function lo():void{
            if (!this._xywh || !this._pw || !this._ph){
                visible = false;
                return;
            };
            var _local1:Array = AppUtil.xywh(this._xywh, this._pw, this._ph);
            this.tx = _local1[0];
            this.ty = _local1[1];
            this.tw = _local1[2];
            this.th = _local1[3];
            x = this.tx;
            y = this.ty;
            if ((this.tw > 0) && (this.th > 0)){
                this.size();
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
            if (!(this._pw == _arg1) || !(this._ph == _arg2)){
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
        public function srcComplete(_arg1:LoaderInfo):void{
        }
        public function size():void{
        }

    }
}
