/*SimpleMediaPlayer*/
package com.ui {
    import com.smp.events.*;
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import interfaces.IT;

    //import flash.geom.*;
    //import flash.ui.*;

    public class SLabel extends BaseButton {

        private static var defaultStyles:Object = {
            icon:null,
            upIcon:null,
            downIcon:null,
            overIcon:null,
            selectedUpIcon:null,
            selectedDownIcon:null,
            selectedOverIcon:null,
            textFormat:null,
            textPadding:5
        };
        public static var createAccessibilityImplementation:Function;

        public var textField:TextField;
        protected var _labelPlacement:String = "right";
        protected var _toggle:Boolean = false;
        protected var icon:DisplayObject;
        protected var oldMouseState:String;
        protected var _label:String = "";
        protected var mode:String = "center";

        public static function getStyleDefinition():Object{
            return mergeStyles(defaultStyles, BaseButton.getStyleDefinition());
        }

        public function get label():String{
            return this._label;
        }
        public function set label(_arg1:String):void{
            _arg1 = String(_arg1);
            if (_arg1 != this._label){
                this._label = _arg1;
                this.textField.htmlText = unescape(this._label);
                dispatchEvent(new SMPCHGEvent(SMPCHGEvent.LABEL_CHANGE));
            };
            invalidate(IT.SIZE);
            invalidate(IT.STYLES);
        }
        public function get labelPlacement():String{
            return (this._labelPlacement);
        }
        public function set labelPlacement(_arg1:String):void{
            this._labelPlacement = _arg1;
            invalidate(IT.SIZE);
        }
        public function get toggle():Boolean{
            return (this._toggle);
        }
        public function set toggle(_arg1:Boolean):void{
            if (((!(_arg1)) && (super.selected))){
                this.selected = false;
            };
            this._toggle = _arg1;
            if (this._toggle){
                addEventListener(MouseEvent.CLICK, this.toggleSelected, false, 0, true);
            } else {
                removeEventListener(MouseEvent.CLICK, this.toggleSelected);
            };
            invalidate(IT.STATE);
        }
        protected function toggleSelected(_arg1:MouseEvent):void{
            this.selected = !(this.selected);
            dispatchEvent(new Event(Event.CHANGE, true));
        }
        override public function get selected():Boolean{
            return ((this._toggle) ? _selected : false);
        }
        override public function set selected(_arg1:Boolean):void{
            _selected = _arg1;
            if (this._toggle){
                invalidate(IT.STATE);
            };
        }
        override protected function configUI():void{
            super.configUI();
            this.textField = new TextField();
            this.textField.type = TextFieldType.DYNAMIC;
            this.textField.selectable = false;
            addChild(this.textField);
        }
        override protected function draw():void{
            this.label = this._label;
            if (isInvalid(IT.STYLES, IT.STATE)){
                drawBackground();
                this.drawIcon();
                this.drawTextFormat();
                invalidate(IT.SIZE, false);
            };
            if (isInvalid(IT.SIZE)){
                this.drawLayout();
            };
            validate();
        }
        protected function drawIcon():void{
            var _local1:DisplayObject = this.icon;
            var _local2:String = mouseState;
            if (this.selected){
                _local2 = (("selected" + _local2.substr(0, 1).toUpperCase()) + _local2.substr(1));
            };
            _local2 = (_local2 + "Icon");
            var _local3:Object = getStyleValue(_local2);
            if (_local3 == null){
                _local3 = getStyleValue("icon");
            };
            if (_local3 != null){
                this.icon = getDisplayObjectInstance(_local3);
            };
            if (this.icon != null){
                addChildAt(this.icon, 1);
            };
            if (((!((_local1 == null))) && (!((_local1 == this.icon))))){
                removeChild(_local1);
            };
        }
        protected function drawTextFormat():void{
            var _local1:Object = UICore.getStyleDefinition();
            var _local2:TextFormat = (_local1.defaultTextFormat as TextFormat);
            this.textField.setTextFormat(_local2);
            var _local3:TextFormat = (getStyleValue("textFormat") as TextFormat);
            if (_local3 != null){
                this.textField.setTextFormat(_local3);
            } else {
                _local3 = _local2;
            };
            this.textField.defaultTextFormat = _local3;
        }
        override protected function drawLayout():void{
            var _local2:String;
            var _local7:Number;
            var _local8:Number;
            var _local1:Number = Number(getStyleValue("textPadding"));
            _local2 = ((this.icon == null) && (this.mode == "center")) ? LayOutPos.TOP : this._labelPlacement;
            this.textField.height = (this.textField.textHeight + 4);
            var _local3:Number = (this.textField.textWidth + 4);
            var _local4:Number = (this.textField.textHeight + 4);
            var _local5:Number = ((this.icon)==null) ? 0 : (this.icon.width + _local1);
            var _local6:Number = ((this.icon)==null) ? 0 : (this.icon.height + _local1);
            this.textField.visible = (this.label.length > 0);
            if (this.icon != null){
                this.icon.x = Math.round(((width - this.icon.width) / 2));
                this.icon.y = Math.round(((height - this.icon.height) / 2));
            };
            if (this.textField.visible == false){
                this.textField.width = 0;
                this.textField.height = 0;
            } else {
                if ((_local2 == LayOutPos.BOTTOM) || (_local2 == LayOutPos.TOP)){
                    _local7 = Math.max(0, Math.min(_local3, (width - (2 * _local1))));
                    if ((height - 2) > _local4){
                        _local8 = _local4;
                    } else {
                        _local8 = (height - 2);
                    };
                    _local3 = _local7;
                    this.textField.width = _local3;
                    _local4 = _local8;
                    this.textField.height = _local4;
                    this.textField.x = Math.round(((width - _local3) / 2));
                    this.textField.y = Math.round(((((height - this.textField.height) - _local6) / 2) + ((_local2)==LayOutPos.BOTTOM) ? _local6 : 0));
                    if (this.icon != null){
                        this.icon.y = Math.round(((_local2)==LayOutPos.BOTTOM) ? (this.textField.y - _local6) : ((this.textField.y + this.textField.height) + _local1));
                    };
                } else {
                    _local7 = Math.max(0, Math.min(_local3, ((width - _local5) - (2 * _local1))));
                    _local3 = _local7;
                    this.textField.width = _local3;
                    this.textField.x = Math.round(((((width - _local3) - _local5) / 2) + ((_local2)!=LayOutPos.LEFT) ? _local5 : 0));
                    this.textField.y = Math.round(((height - this.textField.height) / 2));
                    if (this.icon != null){
                        this.icon.x = Math.round(((_local2)!=LayOutPos.LEFT) ? (this.textField.x - _local5) : ((this.textField.x + _local3) + _local1));
                    };
                };
            };
            super.drawLayout();
        }
        override protected function initializeAccessibility():void{
            if (SLabel.createAccessibilityImplementation != null){
                SLabel.createAccessibilityImplementation(this);
            };
        }

    }
}
