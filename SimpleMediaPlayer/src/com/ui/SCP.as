/*SimpleMediaPlayer*/
package com.ui {
    import com.smp.events.*;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.system.*;
    import interfaces.IT;

    public class SCP extends BaseScrollPanel {

        private static var defaultStyles:Object = {
            skin:null,
            contentPadding:0
        };

        protected var _source:Object;
        protected var contentClip:Sprite;
        protected var xOffset:Number;
        protected var yOffset:Number;
        protected var scrollDragHPos:Number;
        protected var scrollDragVPos:Number;
        protected var currentContent:Object;

        public static function getStyleDefinition():Object{
            return (mergeStyles(defaultStyles, BaseScrollPanel.getStyleDefinition()));
        }

        public function update():void{
            var _local1:DisplayObject = this.contentClip.getChildAt(0);
            setContentSize(_local1.width, _local1.height);
        }
        public function get content():DisplayObject{
            return ((this.currentContent as DisplayObject));
        }
        public function get source():Object{
            return (this._source);
        }
        public function set source(_arg1:Object):void{
            var _local2:*;
            this.clearContent();
            this._source = _arg1;
            if (this._source == null){
                return;
            };
            this.currentContent = getDisplayObjectInstance(_arg1);
            if (this.currentContent != null){
                _local2 = this.contentClip.addChild((this.currentContent as DisplayObject));
                dispatchEvent(new Event(Event.INIT));
                this.update();
            };
        }
        override protected function setVerticalScrollPosition(_arg1:Number, _arg2:Boolean=false):void{
            var _local3:* = this.contentClip.scrollRect;
            _local3.y = _arg1;
            this.contentClip.scrollRect = _local3;
        }
        override protected function drawLayout():void{
            super.drawLayout();
            contentScrollRect = this.contentClip.scrollRect;
            contentScrollRect.width = availableWidth;
            contentScrollRect.height = availableHeight;
            this.contentClip.cacheAsBitmap = true;
            this.contentClip.scrollRect = contentScrollRect;
            this.contentClip.x = (this.contentClip.y = contentPadding);
        }
        protected function onContentLoad(_arg1:Event):void{
            this.update();
            var _local2:* = this.calculateAvailableHeight();
            calculateAvailableSize();
            verticalSCB.setScrollProperties(_local2, 0, (contentHeight - _local2), _local2);
            this.passEvent(_arg1);
        }
        protected function passEvent(_arg1:Event):void{
            dispatchEvent(_arg1);
        }
        override protected function handleScroll(_arg1:ScrollEvent):void{
            this.passEvent(_arg1);
            super.handleScroll(_arg1);
        }
        override protected function draw():void{
            if (isInvalid(IT.STYLES)){
                drawBackground();
            };
            super.draw();
        }
        protected function clearContent():void{
            if (this.contentClip.numChildren == 0){
                return;
            };
            this.contentClip.removeChildAt(0);
            this.currentContent = null;
        }
        protected function calculateAvailableHeight():Number{
            var _local1:Number = Number(getStyleValue("contentPadding"));
            return ((height - (_local1 * 2)));
        }
        override protected function configUI():void{
            super.configUI();
            this.contentClip = new Sprite();
            addChild(this.contentClip);
            this.contentClip.scrollRect = contentScrollRect;
        }

    }
}
