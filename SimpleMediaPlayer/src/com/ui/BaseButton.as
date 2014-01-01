﻿/*SimpleMediaPlayer*/
package com.ui {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    import interfaces.IT;

    public class BaseButton extends UICore {

        private static var defaultStyles:Object = {
            upSkin:null,
            downSkin:null,
            overSkin:null,
            selectedUpSkin:null,
            selectedDownSkin:null,
            selectedOverSkin:null,
            repeatDelay:500,
            repeatInterval:35
        };

        protected var background:DisplayObject;
        protected var mouseState:String;
        protected var _selected:Boolean = false;
        protected var _autoRepeat:Boolean = false;
        protected var pressTimer:Timer;
        private var _mouseStateLocked:Boolean = false;
        private var unlockedMouseState:String;

        public function BaseButton(){
            buttonMode = true;
            mouseChildren = false;
            useHandCursor = false;
            this.setupMouseEvents();
            this.setMouseState("up");
            this.pressTimer = new Timer(1, 0);
            this.pressTimer.addEventListener(TimerEvent.TIMER, this.buttonDown, false, 0, true);
        }
        public static function getStyleDefinition():Object{
            return (defaultStyles);
        }

        public function get selected():Boolean{
            return (this._selected);
        }
        public function set selected(_arg1:Boolean):void{
            if (this._selected == _arg1){
                return;
            };
            this._selected = _arg1;
            invalidate(IT.STATE);
        }
        public function get autoRepeat():Boolean{
            return (this._autoRepeat);
        }
        public function set autoRepeat(_arg1:Boolean):void{
            this._autoRepeat = _arg1;
        }
        public function set mouseStateLocked(_arg1:Boolean):void{
            this._mouseStateLocked = _arg1;
            if (_arg1 == false){
                this.setMouseState(this.unlockedMouseState);
            } else {
                this.unlockedMouseState = this.mouseState;
            };
        }
        public function setMouseState(_arg1:String):void{
            if (this._mouseStateLocked){
                this.unlockedMouseState = _arg1;
                return;
            };
            if (this.mouseState == _arg1){
                return;
            };
            this.mouseState = _arg1;
            invalidate(IT.STATE);
        }
        protected function setupMouseEvents():void{
            addEventListener(MouseEvent.ROLL_OVER, this.mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.MOUSE_DOWN, this.mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.MOUSE_UP, this.mouseEventHandler, false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT, this.mouseEventHandler, false, 0, true);
        }
        protected function mouseEventHandler(_arg1:MouseEvent):void{
            if (_arg1.type == MouseEvent.MOUSE_DOWN){
                this.setMouseState("down");
                this.startPress();
            } else {
                if ((((_arg1.type == MouseEvent.ROLL_OVER)) || ((_arg1.type == MouseEvent.MOUSE_UP)))){
                    this.setMouseState("over");
                    this.endPress();
                } else {
                    if (_arg1.type == MouseEvent.ROLL_OUT){
                        this.setMouseState("up");
                        this.endPress();
                    };
                };
            };
        }
        protected function startPress():void{
            if (this._autoRepeat){
                this.pressTimer.delay = Number(getStyleValue("repeatDelay"));
                this.pressTimer.start();
            };
            dispatchEvent(new SMPCHGEvent(SMPCHGEvent.BUTTON_DOWN, true));
        }
        protected function buttonDown(_arg1:TimerEvent):void{
            if (!this._autoRepeat){
                this.endPress();
                return;
            };
            if (this.pressTimer.currentCount == 1){
                this.pressTimer.delay = Number(getStyleValue("repeatInterval"));
            };
            dispatchEvent(new SMPCHGEvent(SMPCHGEvent.BUTTON_DOWN, true));
        }
        protected function endPress():void{
            this.pressTimer.reset();
        }
        override protected function draw():void{
            if (isInvalid(IT.STYLES, IT.STATE)){
                this.drawBackground();
                invalidate(IT.SIZE, false);
            };
            if (isInvalid(IT.SIZE)){
                this.drawLayout();
            };
            super.draw();
        }
        protected function drawBackground():void{
            var _local1:String = this.mouseState;
            if (this.selected){
                _local1 = (("selected" + _local1.substr(0, 1).toUpperCase()) + _local1.substr(1));
            };
            _local1 = (_local1 + "Skin");
            var _local2:DisplayObject = this.background;
            this.background = getDisplayObjectInstance(getStyleValue(_local1));
            if (this.background){
                addChildAt(this.background, 0);
            };
            if (((!((_local2 == null))) && (!((_local2 == this.background))))){
                removeChild(_local2);
            };
        }
        protected function drawLayout():void{
            size(this.background, width, height);
        }

    }
}
