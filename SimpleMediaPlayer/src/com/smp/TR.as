/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import com.ui.*;
    //import flash.geom.*;
    import flash.ui.*;
    import com.utils.AppUtil;
    import interfaces.IPlane;

    public final class TR extends List implements IPlane {

        private var _xywh:String;
        private var _pw:int;
        private var _ph:int;
        private var tx:int;
        private var ty:int;
        private var tw:int;
        private var th:int;
        private var _display:Boolean = true;
        private var _src:String;
        private var msg:TextField;
        public var formatBase:TextFormat;
        public var formatUpon:TextFormat;
        public var colorBase:uint;
        public var colorUpon:uint;
        public var show_delete:Boolean = false;
        public var show_icon:Boolean = true;
        public var image:String;
        public var image_width:Number = 40;
        public var image_height:Number = 30;
        public var row_height:Number = 20;
        public var row_src:String;
        public var row_mask:String;
        public var data:TD;

        public function TR():void{
            this.formatBase = new TextFormat();
            this.formatUpon = new TextFormat();
            super();
            this.msg = new TextField();
            this.msg.mouseEnabled = false;
            this.msg.selectable = false;
            this.msg.multiline = true;
            this.msg.wordWrap = true;
            this.msg.x = 2;
            this.msg.y = 2;
            addChild(this.msg);
            setStyle("cr", TC);
            addEventListener(ListEvent.ITEM_ROLL_OVER, this.over);
            addEventListener(ListEvent.ITEM_ROLL_OUT, this.out);
            addEventListener(ListEvent.ITEM_CLICK, this.click);
            addEventListener(ListEvent.ITEM_DOUBLE_CLICK, this.dbclick);
            Main.addEventListener(SMPEvent.LIST_LOADED, this.loaded);
        }
        private function loaded(_arg1:SMPEvent):void{
            if (_arg1.data){
                Main.lst.list_xml.appendChild(SList.celh(_arg1.data));
            };
            SImage.cache = {};
			this.data = new TD(Main.lst.list_xml);
            dp = this.data;
            
            if (Config.play_id <= length){
                this.selectedIndex = (Config.play_id - 1);
                scrollToSelected();
            };
            Main.sendEvent(SMPEvent.LIST_CHANGE);
        }
        public function showMsg(_arg1:String=""):void{
            if (((!(_arg1)) || ((length > 0)))){
                this.msg.visible = false;
            } else {
                this.msg.text = _arg1;
                this.msg.visible = true;
            };
            if (!Config.state){
                Main.wc.showStatus(_arg1);
            };
        }
        public function lo():void{
            if (((((!(this._xywh)) || (!(this._pw)))) || (!(this._ph)))){
                visible = false;
                return;
            };
            var _local1:Array = AppUtil.xywh(this._xywh, this._pw, this._ph);
            this.tx = _local1[0];
            this.ty = _local1[1];
            this.tw = _local1[2];
            this.th = _local1[3];
            move(this.tx, this.ty);
            if ((((this.tw > 0)) && ((this.th > 0)))){
                setSize(this.tw, this.th);
                this.msg.width = (this.tw - 4);
                this.msg.height = (this.th - 4);
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
            this.formatBase = AppUtil.format(_arg1);
            this.formatUpon = AppUtil.format(_arg1, 1);
            this.colorBase = (this.formatBase.color as uint);
            this.colorUpon = (this.formatUpon.color as uint);
            this.msg.defaultTextFormat = this.formatBase;
            this.msg.setTextFormat(this.formatBase);
            this.display = AppUtil.gOP(_arg1, "display", visible);
            this.show_delete = AppUtil.gOP(_arg1, "show_delete", false);
            this.show_icon = AppUtil.gOP(_arg1, "show_icon", true);
            this.image = AppUtil.gOP(_arg1, "image", "");
            this.image_width = AppUtil.gOP(_arg1, "image_width", 40);
            this.image_height = AppUtil.gOP(_arg1, "image_height", 30);
            var _local4:Number = 20;
            if (this.image){
                _local4 = (this.image_height + 4);
            };
            this.row_height = AppUtil.gOP(_arg1, "row_height", _local4);
            if (((isNaN(this.row_height)) || ((this.row_height < 20)))){
                this.row_height = 20;
            };
            verticalLineScrollSize = this.row_height;
            rowHeight = this.row_height;
            SImage.cache = {};
            this.src = _arg1.@src;
            this.row_src = _arg1.@row_src;
            this.row_mask = _arg1.@row_mask;
            filters = SGraphics.filters(_arg1);
            scrollToSelected();
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
            clearStyle("skin");
            if (_arg1){
                setStyle("skin", _arg1.loader);
            };
        }
        private function over(_arg1:ListEvent):void{
            var _local5:String;
            var _local2:Object = _arg1.item;
            var _local3:CR = (itemToCR(_local2) as CR);
            var _local4:int = _local3.textField.maxScrollH;
            if (((_local4) || (_local2.message))){
                _local5 = _local3.label;
                if (_local2.message){
                    _local5 = (_local5 + ("\n" + _local2.message));
                };
                Main.tp.show(_local3, _local5);
            };
        }
        private function out(_arg1:ListEvent):void{
            Main.tp.hide();
        }
        private function click(_arg1:ListEvent):void{
            var _local2:int = (_arg1.index as int);
            this.selectedIndex = _local2;
            if (Config.click_play){
                Main.sendEvent(SMPEvent.VIEW_ITEM, true);
            } else {
                if (Config.click_next){
                    Config.play_id = _local2;
                };
            };
        }
        private function dbclick(_arg1:ListEvent):void{
            Main.sendEvent(SMPEvent.VIEW_ITEM, true);
        }
        public function init():void{
            this.showMsg("");
            if (this.data){
                this.data.init();
            };
        }
        public function find(_arg1:String):void{
            if (this.data){
                this.data.find(_arg1);
                if (this.data.length == 0){
                    this.showMsg(Main.info.queryMessage("view_nothing"));
                } else {
                    this.showMsg("");
                };
            };
        }
        override public function clearSelection():void{
        }
        override public function set selectedIndex(_arg1:int):void{
            super.selectedIndex = _arg1;
            super.caretIndex = _arg1;
        }
        override protected function keyDownHandler(_arg1:KeyboardEvent):void{
            var _local2:TC;
            var _local3:TN;
            if (!visible){
                return;
            };
            if (((_arg1.ctrlKey) || (_arg1.altKey))){
                return;
            };
            super.keyDownHandler(_arg1);
            switch (_arg1.keyCode){
                case Keyboard.LEFT:
                case Keyboard.RIGHT:
                    if (caretIndex == -1){
                        caretIndex = 0;
                    };
                    _local2 = (_arg1.currentTarget as TC);
                    _local3 = (selectedItem as TN);
                    _local3.toggle();
                    _arg1.stopPropagation();
                    break;
            };
        }

    }
}
