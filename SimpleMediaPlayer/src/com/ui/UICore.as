/*SimpleMediaPlayer*/
package com.ui {
    import com.smp.events.SMPCHGEvent;
    
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextFormat;
    import flash.utils.Dictionary;
    import flash.utils.getDefinitionByName;
    import interfaces.IT;

    public class UICore extends Sprite {

        public static var inCallLaterPhase:Boolean = false;
        private static var defaultStyles:Object = {
            textFormat:new TextFormat(),
            defaultTextFormat:new TextFormat()
        };
        public static var createAccessibilityImplementation:Function;

        protected var instanceStyles:Object;
        protected var sharedStyles:Object;
        protected var callLaterMethods:Dictionary;
        protected var _enabled:Boolean = true;
        protected var invalidHash:Object;
        protected var _width:Number;
        protected var _height:Number;
        protected var _x:Number;
        protected var _y:Number;
        protected var startWidth:Number;
        protected var startHeight:Number;

        public function UICore(){
            this.instanceStyles = {};
            this.sharedStyles = {};
            this.invalidHash = {};
            this.callLaterMethods = new Dictionary();
            StyleManager.registerInstance(this);
            this.configUI();
            this.invalidate(IT.ALL);
            addEventListener(Event.ENTER_FRAME, this.hookAccessibility, false, 0, true);
        }
        public static function getStyleDefinition():Object{
            return (defaultStyles);
        }
        public static function mergeStyles(... _args):Object{
            var _local5:Object;
            var _local6:String;
            var _local2:Object = {};
            var _local3:uint = _args.length;
            var _local4:uint;
            while (_local4 < _local3) {
                _local5 = _args[_local4];
                for (_local6 in _local5) {
                    if (_local2[_local6] != null){
                    } else {
                        _local2[_local6] = _args[_local4][_local6];
                    };
                };
                _local4++;
            };
            return (_local2);
        }

        public function get enabled():Boolean{
            return (this._enabled);
        }
        public function set enabled(_arg1:Boolean):void{
            if (_arg1 == this._enabled){
                return;
            };
            this._enabled = _arg1;
            this.invalidate(IT.STATE);
        }
        public function setSize(_arg1:Number, _arg2:Number):void{
            this._width = _arg1;
            this._height = _arg2;
            this.invalidate(IT.SIZE);
            dispatchEvent(new SMPCHGEvent(SMPCHGEvent.RESIZE, false));
        }
        override public function get width():Number{
            return (this._width);
        }
        override public function set width(_arg1:Number):void{
            if (this._width == _arg1){
                return;
            };
            this.setSize(_arg1, this.height);
        }
        override public function get height():Number{
            return (this._height);
        }
        override public function set height(_arg1:Number):void{
            if (this._height == _arg1){
                return;
            };
            this.setSize(this.width, _arg1);
        }
        public function setStyle(_arg1:String, _arg2:Object):void{
            if ((((this.instanceStyles[_arg1] === _arg2)) && (!((_arg2 is TextFormat))))){
                return;
            };
            this.instanceStyles[_arg1] = _arg2;
            this.invalidate(IT.STYLES);
        }
        public function clearStyle(_arg1:String):void{
            this.setStyle(_arg1, null);
        }
        public function getStyle(_arg1:String):Object{
            return (this.instanceStyles[_arg1]);
        }
        public function move(_arg1:Number, _arg2:Number):void{
            this._x = _arg1;
            this._y = _arg2;
            super.x = Math.round(_arg1);
            super.y = Math.round(_arg2);
            dispatchEvent(new SMPCHGEvent(SMPCHGEvent.MOVE));
        }
        override public function get x():Number{
            return ((isNaN(this._x)) ? super.x : this._x);
        }
        override public function set x(_arg1:Number):void{
            this.move(_arg1, this._y);
        }
        override public function get y():Number{
            return ((isNaN(this._y)) ? super.y : this._y);
        }
        override public function set y(_arg1:Number):void{
            this.move(this._x, _arg1);
        }
        override public function get visible():Boolean{
            return (super.visible);
        }
        override public function set visible(_arg1:Boolean):void{
            if (super.visible == _arg1){
                return;
            };
            super.visible = _arg1;
            var _local2:String = (_arg1) ? SMPCHGEvent.SHOW : SMPCHGEvent.HIDE;
            dispatchEvent(new SMPCHGEvent(_local2, true));
        }
        public function validateNow():void{
            this.invalidate(IT.ALL, false);
            this.draw();
        }
        public function invalidate(_arg1:String="all", _arg2:Boolean=true):void{
            this.invalidHash[_arg1] = true;
            if (_arg2){
                this.callLater(this.draw);
            };
        }
        public function setSharedStyle(_arg1:String, _arg2:Object):void{
            if ((((this.sharedStyles[_arg1] === _arg2)) && (!((_arg2 is TextFormat))))){
                return;
            };
            this.sharedStyles[_arg1] = _arg2;
            if (this.instanceStyles[_arg1] == null){
                this.invalidate(IT.STYLES);
            };
        }
        public function setFocus():void{
            if (stage){
                stage.stageFocusRect = false;
                stage.focus = this;
            };
        }
        public function getFocus():InteractiveObject{
            if (stage){
                return (stage.focus);
            };
            return (null);
        }
        public function size(_arg1:DisplayObject, _arg2:Number, _arg3:Number):void{
            var _local4:Object;
            if (_arg1){
                if (_arg1.hasOwnProperty("size")){
                    _local4 = _arg1;
                    _local4.size(_arg2, _arg3);
                } else {
                    _arg1.width = _arg2;
                    _arg1.height = _arg3;
                };
            };
        }
        public function drawNow():void{
            this.draw();
        }
        protected function configUI():void{
            var _local1:Number = rotation;
            rotation = 0;
            var _local2:Number = super.width;
            var _local3:Number = super.height;
            var _local4:int = 1;
            super.scaleY = _local4;
            super.scaleX = _local4;
            this.setSize(_local2, _local3);
            this.move(super.x, super.y);
            rotation = _local1;
            this.startWidth = _local2;
            this.startHeight = _local3;
            if (numChildren > 0){
                removeChildAt(0);
            };
        }
        protected function isInvalid(_arg1:String, ... _args):Boolean{
            if (((this.invalidHash[_arg1]) || (this.invalidHash[IT.ALL]))){
                return (true);
            };
            while (_args.length > 0) {
                if (this.invalidHash[_args.pop()]){
                    return (true);
                };
            };
            return (false);
        }
        protected function validate():void{
            this.invalidHash = {};
        }
        protected function draw():void{
            this.validate();
        }
        protected function getDisplayObjectInstance(_arg1:Object):DisplayObject{
            var name:* = null;
            var obj:* = null;
            var skin:* = _arg1;
            if (skin == null){
                return (null);
            };
            if ((skin is Class)){
                return ((new (skin)() as DisplayObject));
            };
            if ((skin is DisplayObject)){
                obj = (skin as DisplayObject);
                obj.x = 0;
                obj.y = 0;
                return (obj);
            };
            name = (skin + "");
            var classDef:* = null;
            try {
                classDef = getDefinitionByName(name);
            } catch(e:Error) {
                try {
                    classDef = loaderInfo.applicationDomain.getDefinition(name);
                } catch(e:Error) {
                };
            };
            if (classDef){
                return ((new (classDef)() as DisplayObject));
            };
            return (null);
        }
        protected function getStyleValue(_arg1:String):Object{
            return (((this.instanceStyles[_arg1])==null) ? this.sharedStyles[_arg1] : this.instanceStyles[_arg1]);
        }
        protected function copyStylesToChild(_arg1:UICore, _arg2:Object):void{
            var _local3:String;
            for (_local3 in _arg2) {
                _arg1.setStyle(_local3, this.getStyleValue(_arg2[_local3]));
            };
        }
        protected function callLater(_arg1:Function):void{
            if (inCallLaterPhase){
                return;
            };
            this.callLaterMethods[_arg1] = true;
            if (stage != null){
                this.addStageRender();
            } else {
                addEventListener(Event.ADDED_TO_STAGE, this.callLaterDispatcher, false, 0, true);
            };
        }
        private function addStageRender():void{
            stage.addEventListener(Event.RENDER, this.callLaterDispatcher, false, 0, true);
            stage.invalidate();
        }
        private function callLaterDispatcher(_arg1:Event):void{
            var _local3:Object;
            if (_arg1.type == Event.ADDED_TO_STAGE){
                removeEventListener(Event.ADDED_TO_STAGE, this.callLaterDispatcher);
                this.addStageRender();
                return;
            };
            _arg1.target.removeEventListener(Event.RENDER, this.callLaterDispatcher);
            if (stage == null){
                addEventListener(Event.ADDED_TO_STAGE, this.callLaterDispatcher, false, 0, true);
                return;
            };
            inCallLaterPhase = true;
            var _local2:Dictionary = this.callLaterMethods;
            for (_local3 in _local2) {
                _local3();
                delete _local2[_local3];
            };
            inCallLaterPhase = false;
        }
        protected function hookAccessibility(_arg1:Event):void{
            removeEventListener(Event.ENTER_FRAME, this.hookAccessibility);
            this.initializeAccessibility();
        }
        protected function initializeAccessibility():void{
            if (UICore.createAccessibilityImplementation != null){
                UICore.createAccessibilityImplementation(this);
            };
        }

    }
}
