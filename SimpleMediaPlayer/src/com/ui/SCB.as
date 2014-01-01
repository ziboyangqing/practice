/*SimpleMediaPlayer*/
package com.ui {
    import com.smp.events.*;
    import flash.events.*;
    import com.skin.thumbIcon;
    import com.skin.scrollArrowDown_downSkin;
    import com.skin.scrollArrowDown_overSkin;
    import com.skin.scrollArrowDown_upSkin;
    import com.skin.scrollArrowUp_downSkin;
    import com.skin.scrollArrowUp_overSkin;
    import com.skin.scrollArrowUp_upSkin;
    import com.skin.scrollThumb_downSkin;
    import com.skin.scrollThumb_overSkin;
    import com.skin.scrollThumb_upSkin;
    import com.skin.scrollTrack_skin;
    import interfaces.IT;

    public class SCB extends UICore {

        protected static const DOWN_ARROW_STYLES:Object = {
            downSkin:"downArrowDownSkin",
            overSkin:"downArrowOverSkin",
            upSkin:"downArrowUpSkin",
            repeatDelay:"repeatDelay",
            repeatInterval:"repeatInterval"
        };
        protected static const THUMB_STYLES:Object = {
            downSkin:"thumbDownSkin",
            overSkin:"thumbOverSkin",
            upSkin:"thumbUpSkin",
            icon:"thumbIcon",
            textPadding:0
        };
        protected static const TRACK_STYLES:Object = {
            downSkin:"trackDownSkin",
            overSkin:"trackOverSkin",
            upSkin:"trackUpSkin",
            repeatDelay:"repeatDelay",
            repeatInterval:"repeatInterval"
        };
        protected static const UP_ARROW_STYLES:Object = {
            downSkin:"upArrowDownSkin",
            overSkin:"upArrowOverSkin",
            upSkin:"upArrowUpSkin",
            repeatDelay:"repeatDelay",
            repeatInterval:"repeatInterval"
        };

        private static var defaultStyles:Object = {
            downArrowDownSkin:scrollArrowDown_downSkin,
            downArrowOverSkin:scrollArrowDown_overSkin,
            downArrowUpSkin:scrollArrowDown_upSkin,
            thumbDownSkin:scrollThumb_downSkin,
            thumbOverSkin:scrollThumb_overSkin,
            thumbUpSkin:scrollThumb_upSkin,
            trackDownSkin:scrollTrack_skin,
            trackOverSkin:scrollTrack_skin,
            trackUpSkin:scrollTrack_skin,
            upArrowDownSkin:scrollArrowUp_downSkin,
            upArrowOverSkin:scrollArrowUp_overSkin,
            upArrowUpSkin:scrollArrowUp_upSkin,
            thumbIcon:thumbIcon,
            repeatDelay:500,
            repeatInterval:35
        };

        public var WIDTH:Number = 15;
        public var HEIGHT:Number = 14;
        private var _pageSize:Number = 10;
        private var _pageScrollSize:Number = 0;
        private var _lineScrollSize:Number = 1;
        private var _minScrollPosition:Number = 0;
        private var _maxScrollPosition:Number = 0;
        private var _scrollPosition:Number = 0;
        private var thumbScrollOffset:Number;
        protected var inDrag:Boolean = false;
        protected var upArrow:BaseButton;
        protected var downArrow:BaseButton;
        protected var thumb:SLabel;
        protected var track:BaseButton;

        public function SCB(){
            this.setStyles();
        }
        public static function getStyleDefinition():Object{
            return (defaultStyles);
        }

        override public function setSize(_arg1:Number, _arg2:Number):void{
            super.setSize(_arg1, _arg2);
        }
        override public function get width():Number{
            return (super.width);
        }
        override public function get height():Number{
            return (super.height);
        }
        override public function get enabled():Boolean{
            return (super.enabled);
        }
        override public function set enabled(_arg1:Boolean):void{
            super.enabled = _arg1;
            this.downArrow.enabled = (this.track.enabled = (this.thumb.enabled = (this.upArrow.enabled = ((this.enabled) && ((this._maxScrollPosition > this._minScrollPosition))))));
            this.updateThumb();
        }
        public function setScrollProperties(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number=0):void{
            this.pageSize = _arg1;
            this._minScrollPosition = _arg2;
            this._maxScrollPosition = _arg3;
            if (_arg4 >= 0){
                this._pageScrollSize = _arg4;
            };
            this.enabled = (this._maxScrollPosition > this._minScrollPosition);
            this.setScrollPosition(this._scrollPosition, false);
            this.updateThumb();
        }
        public function get scrollPosition():Number{
            return (this._scrollPosition);
        }
        public function set scrollPosition(_arg1:Number):void{
            this.setScrollPosition(_arg1, true);
        }
        public function get minScrollPosition():Number{
            return (this._minScrollPosition);
        }
        public function set minScrollPosition(_arg1:Number):void{
            this.setScrollProperties(this._pageSize, _arg1, this._maxScrollPosition);
        }
        public function get maxScrollPosition():Number{
            return (this._maxScrollPosition);
        }
        public function set maxScrollPosition(_arg1:Number):void{
            this.setScrollProperties(this._pageSize, this._minScrollPosition, _arg1);
        }
        public function get pageSize():Number{
            return (this._pageSize);
        }
        public function set pageSize(_arg1:Number):void{
            if (_arg1 > 0){
                this._pageSize = _arg1;
            };
        }
        public function get pageScrollSize():Number{
            return (((this._pageScrollSize)==0) ? this._pageSize : this._pageScrollSize);
        }
        public function set pageScrollSize(_arg1:Number):void{
            if (_arg1 >= 0){
                this._pageScrollSize = _arg1;
            };
        }
        public function get lineScrollSize():Number{
            return (this._lineScrollSize);
        }
        public function set lineScrollSize(_arg1:Number):void{
            if (_arg1 > 0){
                this._lineScrollSize = _arg1;
            };
        }
        override protected function configUI():void{
            super.configUI();
            this.track = new BaseButton();
            this.track.useHandCursor = false;
            this.track.autoRepeat = true;
            addChild(this.track);
            this.thumb = new SLabel();
            this.thumb.label = "";
            addChild(this.thumb);
            this.downArrow = new BaseButton();
            this.downArrow.autoRepeat = true;
            addChild(this.downArrow);
            this.upArrow = new BaseButton();
            this.upArrow.autoRepeat = true;
            addChild(this.upArrow);
            this.layout();
            this.upArrow.addEventListener(SMPCHGEvent.BUTTON_DOWN, this.scrollPressHandler, false, 0, true);
            this.downArrow.addEventListener(SMPCHGEvent.BUTTON_DOWN, this.scrollPressHandler, false, 0, true);
            this.track.addEventListener(SMPCHGEvent.BUTTON_DOWN, this.scrollPressHandler, false, 0, true);
            this.thumb.addEventListener(MouseEvent.MOUSE_DOWN, this.thumbPressHandler, false, 0, true);
            this.enabled = false;
        }
        public function layout():void{
            this.track.move(0, this.HEIGHT);
            this.thumb.setSize(this.WIDTH, this.HEIGHT);
            this.thumb.move(0, this.HEIGHT);
            this.downArrow.setSize(this.WIDTH, this.HEIGHT);
            this.upArrow.setSize(this.WIDTH, this.HEIGHT);
            this.upArrow.move(0, 0);
        }
        public function updateSize(_arg1:Number, _arg2:Number):void{
            if (isNaN(_arg1)){
                _arg1 = 15;
            };
            if (isNaN(_arg2)){
                _arg2 = 14;
            };
            if (((!((_arg1 == this.WIDTH))) || (!((_arg2 == this.HEIGHT))))){
                this.WIDTH = _arg1;
                this.HEIGHT = _arg2;
                this.layout();
                invalidate(IT.SIZE);
            };
        }
        override protected function draw():void{
            var _local1:Number;
            if (isInvalid(IT.SIZE)){
                _local1 = super.height;
                this.downArrow.move(0, Math.max(this.upArrow.height, (_local1 - this.downArrow.height)));
                this.track.setSize(this.WIDTH, Math.max(0, (_local1 - (this.downArrow.height + this.upArrow.height))));
                this.updateThumb();
            };
            if (isInvalid(IT.STYLES, IT.STATE)){
                this.setStyles();
            };
            this.downArrow.drawNow();
            this.upArrow.drawNow();
            this.track.drawNow();
            this.thumb.drawNow();
            validate();
        }
        protected function scrollPressHandler(_arg1:SMPCHGEvent):void{
            var _local2:Number;
            var _local3:Number;
            _arg1.stopImmediatePropagation();
            if (_arg1.currentTarget == this.upArrow){
                this.setScrollPosition((this._scrollPosition - this._lineScrollSize));
            } else {
                if (_arg1.currentTarget == this.downArrow){
                    this.setScrollPosition((this._scrollPosition + this._lineScrollSize));
                } else {
                    _local2 = (((this.track.mouseY / this.track.height) * (this._maxScrollPosition - this._minScrollPosition)) + this._minScrollPosition);
                    _local3 = ((this.pageScrollSize)==0) ? this.pageSize : this.pageScrollSize;
                    if (this._scrollPosition < _local2){
                        this.setScrollPosition(Math.min(_local2, (this._scrollPosition + _local3)));
                    } else {
                        if (this._scrollPosition > _local2){
                            this.setScrollPosition(Math.max(_local2, (this._scrollPosition - _local3)));
                        };
                    };
                };
            };
        }
        protected function thumbPressHandler(_arg1:MouseEvent):void{
            this.inDrag = true;
            this.thumbScrollOffset = (mouseY - this.thumb.y);
            this.thumb.mouseStateLocked = true;
            mouseChildren = false;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.handleThumbDrag, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_UP, this.thumbReleaseHandler, false, 0, true);
        }
        protected function handleThumbDrag(_arg1:MouseEvent):void{
            var _local2:Number = Math.max(0, Math.min((this.track.height - this.thumb.height), ((mouseY - this.track.y) - this.thumbScrollOffset)));
            this.setScrollPosition((((_local2 / (this.track.height - this.thumb.height)) * (this._maxScrollPosition - this._minScrollPosition)) + this._minScrollPosition));
        }
        protected function thumbReleaseHandler(_arg1:MouseEvent):void{
            this.inDrag = false;
            mouseChildren = true;
            this.thumb.mouseStateLocked = false;
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.handleThumbDrag);
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.thumbReleaseHandler);
        }
        public function setScrollPosition(_arg1:Number, _arg2:Boolean=true):void{
            var _local3:Number = this.scrollPosition;
            this._scrollPosition = Math.max(this._minScrollPosition, Math.min(this._maxScrollPosition, _arg1));
            if (_local3 == this._scrollPosition){
                return;
            };
            if (_arg2){
                dispatchEvent(new ScrollEvent((this.scrollPosition - _local3), this.scrollPosition));
            };
            this.updateThumb();
        }
        protected function setStyles():void{
            copyStylesToChild(this.downArrow, DOWN_ARROW_STYLES);
            copyStylesToChild(this.thumb, THUMB_STYLES);
            copyStylesToChild(this.track, TRACK_STYLES);
            copyStylesToChild(this.upArrow, UP_ARROW_STYLES);
        }
        protected function updateThumb():void{
            var _local1:Number = ((this._maxScrollPosition - this._minScrollPosition) + this._pageSize);
            if ((((((this.track.height <= 12)) || ((this._maxScrollPosition <= this._minScrollPosition)))) || ((((_local1 == 0)) || (isNaN(_local1)))))){
                this.thumb.height = 12;
                this.thumb.visible = false;
            } else {
                this.thumb.height = Math.max(13, ((this._pageSize / _local1) * this.track.height));
                this.thumb.y = (this.track.y + ((this.track.height - this.thumb.height) * ((this._scrollPosition - this._minScrollPosition) / (this._maxScrollPosition - this._minScrollPosition))));
                this.thumb.visible = this.enabled;
            };
        }

    }
}
