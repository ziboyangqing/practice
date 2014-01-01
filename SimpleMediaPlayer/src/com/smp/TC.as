/*SimpleMediaPlayer*/
package com.smp {
    import com.ui.CR;
    import com.ui.LSD;
    
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.LoaderInfo;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.ByteArray;
    import com.skin.iconDelete;
    import com.utils.AppUtil;

    public class TC extends CR {

        public var ld:LSD;
        public var tn:TN;
        public var ic:IC;
        public var btD:SButton;
        public var image:SImage;
        public var desc:TextField;
        public var tx:Number;
        public var ty:Number;
        public var tw:Number;
        public var th:Number;
        public var formatBase:TextFormat;
        public var formatUpon:TextFormat;

        public function TC():void{
            var _local1:TextFormat;
            var _local4:iconDelete;
            var _local5:ColorTransform;
            this.formatBase = new TextFormat();
            this.formatUpon = new TextFormat();
            super();
            this.image = new SImage();
            addChild(this.image);
            _local1 = AppUtil.format_merge(Main.tr.formatBase);
            _local1.bold = false;
            this.desc = new TextField();
            this.desc.selectable = false;
            this.desc.multiline = true;
            this.desc.wordWrap = true;
            this.desc.defaultTextFormat = _local1;
            addChild(this.desc);
            if (!Main.tr.image){
                this.image.visible = (this.desc.visible = false);
            };
            this.btD = new SButton();
            var _local2:Array = [];
            var _local3:int;
            while (_local3 < 3) {
                _local4 = new iconDelete();
                _local5 = new ColorTransform();
                _local5.color = (_local3 < 2) ? Main.tr.colorBase : Main.tr.colorUpon;
                _local4.transform.colorTransform = _local5;
                _local2.push(_local4);
                _local3++;
            };
            this.btD.ds(0, 0, 10, 10, _local2);
            addChild(this.btD);
            if (Config.list_delete || Main.tr.show_delete){
                addEventListener(MouseEvent.MOUSE_MOVE, this.dOver);
            } else {
                this.btD.visible = false;
            };
            Zip.GetSrc(Main.tr.row_src, this.srcComplete);
            Zip.GetSrc(Main.tr.row_mask, this.maskComplete);
            addEventListener(MouseEvent.CLICK, this.clickHandler);
            addEventListener(MouseEvent.DOUBLE_CLICK, this.clickHandler);
        }
		
        public function srcComplete(_arg1:LoaderInfo):void{
            var _local3:Array;
            var _local4:SBitMap;
            var _local5:SBitMap;
            var _local6:SBitMap;
            var _local7:SBitMap;
            var _local8:SBitMap;
            var _local9:SBitMap;
            var _local2:BitmapData = Zip.GetBMD(_arg1);
            if (_local2){
                _local3 = Zip.SplitBMD(_local2, 3, 2);
                _local4 = new SBitMap(_local3[0]);
                _local5 = new SBitMap(_local3[1]);
                _local6 = new SBitMap(_local3[2]);
                _local7 = new SBitMap(_local3[3]);
                _local8 = new SBitMap(_local3[4]);
                _local9 = new SBitMap(_local3[5]);
                setStyle("upSkin", _local4);
                setStyle("overSkin", _local5);
                setStyle("downSkin", _local6);
                setStyle("selectedUpSkin", _local7);
                setStyle("selectedOverSkin", _local8);
                setStyle("selectedDownSkin", _local9);
            };
        }
        public function maskComplete(_arg1:LoaderInfo):void{
            addChild(Zip.getLD(_arg1));
        }
        public function lo():void{
            this.tx = ((this.tn.level - 1) * 20);
            if (((icon) && (Main.tr.show_icon))){
                icon.x = (this.tx + 5);
                this.tx = (this.tx + (icon.width + 10));
            } else {
                this.tx = (this.tx + 2);
            };
            if (this.image.visible){
                this.image.x = this.tx;
                this.image.y = ((height - Main.tr.image_height) * 0.5);
                this.tx = (this.tx + (Main.tr.image_width + 2));
            };
            var _local1:Number = 0;
            if (this.btD.visible){
                this.btD.x = ((width - this.btD.width) - 5);
                this.btD.y = ((height - this.btD.height) * 0.5);
                _local1 = (this.btD.width + 8);
            };
            this.tw = ((width - this.tx) - _local1);
            textField.x = this.tx;
            textField.width = this.tw;
            this.desc_ll();
            this.dOver();
        }
        public function clickHandler(_arg1:MouseEvent):void{
            if (this.is_on(icon)){
                if (this.tn.node_type == CS.NODE_LIST){
                    _arg1.stopImmediatePropagation();
                    this.tn.toggle();
                };
            } else {
                if (this.is_on(this.btD)){
                    _arg1.stopImmediatePropagation();
                    this.tn.remove();
                };
            };
        }
        public function dOver(_arg1:MouseEvent=null):void{
            if (this.btD.visible){
                this.btD.reverse = this.is_on(this.btD);
            };
        }
        public function is_on(_arg1:DisplayObject):Boolean{
            var _local2:Rectangle;
            if (_arg1){
                if (_arg1.visible){
                    _local2 = new Rectangle(_arg1.x, _arg1.y, _arg1.width, _arg1.height);
                    if (_local2.contains(mouseX, mouseY)){
                        return (true);
                    };
                };
            };
            return (false);
        }
        override public function set lsd(_arg1:LSD):void{
            this.ld = _arg1;
            this.tn.tc = this;
            if (Main.tr.show_icon){
                if (this.ic){
                    if (this.ic.tn != this.tn){
                        this.ic.remove();
                    };
                };
                this.ic = new IC(this.tn);
                setStyle("icon", this.ic);
            };
        }
        override public function set selected(_arg1:Boolean):void{
            super.selected = _arg1;
            var _local2:TextFormat = (_arg1) ? this.formatUpon : this.formatBase;
            setStyle("textFormat", _local2);
        }
        override public function get lsd():LSD{
            return (this.ld);
        }
        override public function set data(_arg1:Object):void{
            this.tn = (_arg1 as TN);
            this.formatBase = Main.tr.formatBase;
            this.formatUpon = Main.tr.formatUpon;
            var _local2:XMLList = new XMLList(this.tn.xml);
            var _local3:TextFormat = AppUtil.format(_local2);
            var _local4:TextFormat = AppUtil.format(_local2, 1);
            this.formatBase = AppUtil.format_merge(this.formatBase, _local3);
            this.formatUpon = AppUtil.format_merge(this.formatUpon, _local4);
            var _local5:String = "";
            if (((this.tn.error) && (Config.list_error))){
                _local5 = (_local5 + (((Main.info.queryMessage("view_error") + "(") + this.tn.error) + ") - "));
            };
            _local5 = (_local5 + this.tn.label);
            label = _local5;
            if (this.image.visible){
                this.image.show(this.tn);
                this.desc_show();
            };
        }
        override public function get data():Object{
            return (this.tn);
        }
        public function desc_show():void{
            if (this.tn.text){
                this.desc.visible = true;
                this.desc.htmlText = unescape(this.tn.text);
            } else {
                this.desc.visible = false;
                this.desc_load();
            };
        }
        public function desc_load():void{
            if (!Config.text_handler){
                return;
            };
            var _local1:String = Config.text_handler;
            _local1 = AppUtil.auto(_local1, this.tn);
            _local1 = Main.fU(_local1);
            new SURLLodader(_local1, this.dError, this.dProgress, this.dLoaded);
        }
        public function dProgress(_arg1:uint, _arg2:uint):void{
        }
        public function dError(_arg1:String):void{
        }
        public function dLoaded(_arg1:ByteArray):void{
            var _local2:Array;
            if (_arg1){
                _local2 = Zip.extract(_arg1);
                _arg1 = _local2[0];
                this.tn.text = _arg1.toString();
                this.desc_show();
                this.desc_ll();
            };
        }
        public function desc_ll():void{
            var _local1:Number;
            var _local2:Number;
            if (!this.desc.visible){
                return;
            };
            this.th = textField.height;
            _local1 = (height - this.th);
            if (_local1 >= this.th){
                this.desc.x = this.tx;
                this.desc.width = this.tw;
                this.desc.autoSize = "left";
                _local2 = 0;
                if (this.desc.height > _local1){
                    this.desc.autoSize = "none";
                    this.desc.height = _local1;
                } else {
                    _local2 = ((_local1 - this.desc.height) * 0.5);
                };
                this.desc.y = (this.th + _local2);
                textField.y = _local2;
            } else {
                this.desc.visible = false;
            };
        }
        override protected function drawLayout():void{
            super.drawLayout();
            this.lo();
        }

    }
}
