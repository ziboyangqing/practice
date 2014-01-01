/*SimpleMediaPlayer*/
package com.ui {
    import com.smp.events.*;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import interfaces.IT;

    public class BaseScrollPanel extends UICore {

        protected static const SCROLL_BAR_STYLES:Object = {
            upArrowDownSkin:"upArrowDownSkin",
            upArrowOverSkin:"upArrowOverSkin",
            upArrowUpSkin:"upArrowUpSkin",
            downArrowDownSkin:"downArrowDownSkin",
            downArrowOverSkin:"downArrowOverSkin",
            downArrowUpSkin:"downArrowUpSkin",
            thumbDownSkin:"thumbDownSkin",
            thumbOverSkin:"thumbOverSkin",
            thumbUpSkin:"thumbUpSkin",
            thumbIcon:"thumbIcon",
            trackDownSkin:"trackDownSkin",
            trackOverSkin:"trackOverSkin",
            trackUpSkin:"trackUpSkin",
            repeatDelay:"repeatDelay",
            repeatInterval:"repeatInterval"
        };

        private static var defaultStyles:Object = {
            repeatDelay:500,
            repeatInterval:35,
            skin:null,
            contentPadding:0
        };

        protected var _verticalSCB:SCB;
        protected var contentScrollRect:Rectangle;
        protected var background:DisplayObject;
        protected var contentWidth:Number = 0;
        protected var contentHeight:Number = 0;
        protected var contentPadding:Number = 0;
        protected var availableWidth:Number;
        protected var availableHeight:Number;
        protected var vOffset:Number = 0;
        protected var vSCB:Boolean;
        protected var _verticalPageScrollSize:Number = 0;
        protected var defaultLineScrollSize:Number = 20;

        public static function getStyleDefinition():Object{
            return (mergeStyles(defaultStyles, SCB.getStyleDefinition()));
        }

        override public function set enabled(_arg1:Boolean):void{
            if (enabled == _arg1){
                return;
            };
            this._verticalSCB.enabled = _arg1;
            super.enabled = _arg1;
        }
        public function get verticalLineScrollSize():Number{
            return (this._verticalSCB.lineScrollSize);
        }
        public function set verticalLineScrollSize(_arg1:Number):void{
            this._verticalSCB.lineScrollSize = _arg1;
        }
        public function get verticalScrollPosition():Number{
            return (this._verticalSCB.scrollPosition);
        }
        public function set verticalScrollPosition(_arg1:Number):void{
            drawNow();
            this._verticalSCB.scrollPosition = _arg1;
            this.setVerticalScrollPosition(this._verticalSCB.scrollPosition, false);
        }
        public function get maxVerticalScrollPosition():Number{
            drawNow();
            return (Math.max(0, (this.contentHeight - this.availableHeight)));
        }
        public function get verticalPageScrollSize():Number{
            if (isNaN(this.availableHeight)){
                drawNow();
            };
            return (((((this._verticalPageScrollSize == 0)) && (!(isNaN(this.availableHeight))))) ? this.availableHeight : this._verticalPageScrollSize);
        }
        public function set verticalPageScrollSize(_arg1:Number):void{
            this._verticalPageScrollSize = _arg1;
            invalidate(IT.SIZE);
        }
        public function get verticalSCB():SCB{
            return (this._verticalSCB);
        }
        override protected function configUI():void{
            super.configUI();
            this.contentScrollRect = new Rectangle(0, 0, 85, 85);
            this._verticalSCB = new SCB();
            this._verticalSCB.addEventListener(ScrollEvent.SCROLL, this.handleScroll, false, 0, true);
            this._verticalSCB.visible = false;
            this._verticalSCB.lineScrollSize = this.defaultLineScrollSize;
            addChild(this._verticalSCB);
            copyStylesToChild(this._verticalSCB, SCROLL_BAR_STYLES);
            addEventListener(MouseEvent.MOUSE_WHEEL, this.handleWheel, false, 0, true);
        }
        protected function setContentSize(_arg1:Number, _arg2:Number):void{
            if ((((this.contentWidth == _arg1)) && ((this.contentHeight == _arg2)))){
                return;
            };
            this.contentWidth = _arg1;
            this.contentHeight = _arg2;
            invalidate(IT.SIZE);
        }
        protected function handleScroll(_arg1:ScrollEvent):void{
            this.setVerticalScrollPosition(_arg1.position);
        }
        protected function handleWheel(_arg1:MouseEvent):void{
            if (((((!(enabled)) || (!(this._verticalSCB.visible)))) || ((this.contentHeight <= this.availableHeight)))){
                return;
            };
            this._verticalSCB.scrollPosition = (this._verticalSCB.scrollPosition - (_arg1.delta * this.verticalLineScrollSize));
            this.setVerticalScrollPosition(this._verticalSCB.scrollPosition);
            dispatchEvent(new ScrollEvent(_arg1.delta, this.verticalScrollPosition));
        }
        protected function setVerticalScrollPosition(_arg1:Number, _arg2:Boolean=false):void{
        }
        override protected function draw():void{
            if (isInvalid(IT.STYLES)){
                this.setStyles();
                this.drawBackground();
                if (this.contentPadding != getStyleValue("contentPadding")){
                    invalidate(IT.SIZE, false);
                };
            };
            if (isInvalid(IT.SIZE, IT.STATE)){
                this.drawLayout();
            };
            this.updateChildren();
            super.draw();
        }
        protected function setStyles():void{
            copyStylesToChild(this._verticalSCB, SCROLL_BAR_STYLES);
        }
        protected function drawBackground():void{
            var _local1:DisplayObject = this.background;
            this.background = getDisplayObjectInstance(getStyleValue("skin"));
            if (this.background){
                size(this.background, width, height);
                addChildAt(this.background, 0);
            };
            if (((!((_local1 == null))) && (!((_local1 == this.background))))){
                removeChild(_local1);
            };
        }
        protected function drawLayout():void{
            this.calculateAvailableSize();
            this.calculateContentWidth();
            size(this.background, width, height);
            if (this.vSCB){
                this._verticalSCB.visible = true;
                this._verticalSCB.x = ((width - this._verticalSCB.WIDTH) - this.contentPadding);
                this._verticalSCB.y = this.contentPadding;
                this._verticalSCB.height = this.availableHeight;
            } else {
                this._verticalSCB.visible = false;
            };
            this._verticalSCB.setScrollProperties(this.availableHeight, 0, (this.contentHeight - this.availableHeight), this.verticalPageScrollSize);
            this.setVerticalScrollPosition(this._verticalSCB.scrollPosition, false);
        }
        public function updateSize(_arg1:Number, _arg2:Number):void{
            this._verticalSCB.updateSize(_arg1, _arg2);
            invalidate(IT.SIZE);
        }
        protected function calculateAvailableSize():void{
            var _local1:Number = this._verticalSCB.WIDTH;
            var _local2:Number = (this.contentPadding = Number(getStyleValue("contentPadding")));
            var _local3:Number = ((height - (2 * _local2)) - this.vOffset);
            this.vSCB = (this.contentHeight > _local3);
            var _local4:Number = width - (this.vSCB ? _local1 : 0) - 2 * _local2;
            this.availableHeight = (_local3 + this.vOffset);
            this.availableWidth = _local4;
        }
        protected function calculateContentWidth():void{
        }
        protected function updateChildren():void{
            this._verticalSCB.drawNow();
        }

    }
}
