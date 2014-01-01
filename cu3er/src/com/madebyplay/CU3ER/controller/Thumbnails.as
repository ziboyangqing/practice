package com.madebyplay.CU3ER.controller 
{
    import com.greensock.*;
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.CU3ER.util.*;
    import com.madebyplay.common.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    
    public class Thumbnails extends flash.events.EventDispatcher
    {
        public function Thumbnails(arg1:com.madebyplay.CU3ER.controller.Player, arg2:com.madebyplay.CU3ER.model.ThumbsData)
        {
            super();
            this._player = arg1;
            this._data = arg2;
            this._holder = new flash.display.MovieClip();
            this._holder.visible = false;
            if (String(this._data.xml.@align_to) != "stage") 
            {
                this._player.holder.addChild(this._holder);
            }
            else 
            {
                this._player.CU3ER.addChild(this._holder);
            }
            this._init();
            this.show();
            return;
        }

        internal function _onAutoHide(arg1:flash.events.TimerEvent):void
        {
            if (!(this._timerHide == null) && this._player.currState == com.madebyplay.CU3ER.controller.Player.STATE_FREE) 
            {
                this.hide();
            }
            return;
        }

        internal function _onScrollWheelNoScroller(arg1:flash.events.MouseEvent):void
        {
            var loc1:*=0;
            if (arg1.delta > 0) 
            {
                loc1 = -Math.min(5, this._maxScrollThumbs * 0.1);
            }
            else if (arg1.delta < 0) 
            {
                loc1 = Math.min(5, this._maxScrollThumbs * 0.1);
            }
            if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
            {
                if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
                {
                    this._thumbs.y = this._thumbs.y + loc1;
                    this._thumbs.y = Math.min(this._thumbs.y, this._thumbnailsStartY);
                    this._thumbs.y = Math.max(this._thumbs.y, this._thumbnailsStartY + this._maxScrollThumbs);
                }
            }
            else 
            {
                this._thumbs.x = this._thumbs.x + loc1;
                this._thumbs.x = Math.min(this._thumbs.x, this._thumbnailsStartX);
                this._thumbs.x = Math.max(this._thumbs.x, this._thumbnailsStartX + this._maxScrollThumbs);
            }
            return;
        }

        internal function _init():void
        {
            com.madebyplay.CU3ER.util.AlignXML.align(this._holder, this._data.xml);
            this._createBackground();
            this._createThumbs();
            return;
        }

        internal function _createBackground():void
        {
            this._bg = new flash.display.Sprite();
            this._bg.graphics.beginFill(this._data.bgColor, this._data.bgAlpha);
            var loc1:*=this._data.bgRoundedCorners.split(",");
            this._bg.graphics.drawRoundRectComplex(0, 0, this._data.width, this._data.height, loc1[0], loc1[1], loc1[3], loc1[2]);
            this._bg.graphics.endFill();
            this._holder.addChild(this._bg);
            this._alignBg = new com.madebyplay.common.view.AlignUtil(new flash.geom.Rectangle(this._bg.x, this._bg.y, this._bg.width, this._bg.height));
            this._alignBg.id = "thumbnails_bg";
            return;
        }

        internal function _createThumbs():void
        {
            this._thumbs = new flash.display.MovieClip();
            this._thumbsMask = new flash.display.Shape();
            this._thumbsMask.x = this._thumbs.x;
            this._thumbsMask.y = this._thumbs.y;
            this._thumbsMask.graphics.beginFill(0, 1);
            this._thumbsMask.graphics.drawRect(0, 0, this._data.width, this._data.height);
            this._thumbsMask.graphics.endFill();
            this._thumbs.mask = this._thumbsMask;
            this._holder.addChild(this._thumbs);
            this._holder.addChild(this._thumbsMask);
            this._fillThumbs();
            return;
        }

        internal function _fillThumbs():void
        {
            var loc9:*=null;
            var loc11:*=0;
            var loc1:*=this._data.thumbsPaddingX;
            var loc2:*=this._data.thumbsPaddingY;
            var loc3:*=1;
            var loc4:*=1;
            var loc5:*=Math.floor((Number(this._data.width) - 2 * loc1 + Number(this._data.thumbSpacingX)) / (Number(this._data.thumbWidth) + Number(this._data.thumbSpacingX)));
            var loc6:*=Math.floor((Number(this._data.height) - 2 * loc2 + this._data.thumbSpacingY) / (this._data.thumbHeight + this._data.thumbSpacingY));
            var loc7:*=false;
            var loc8:*=this._player.data.slides.length;
            if (loc6 * loc5 >= this._player.data.slides.length) 
            {
                loc3 = loc5;
                loc4 = Math.max(loc4, Math.floor((this._player.data.slides.length - 1) / loc3) + 1);
            }
            else 
            {
                loc7 = true;
                if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
                {
                    if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
                    {
                        loc3 = loc5;
                        loc4 = Math.max(loc4, Math.floor((loc8 - 1) / loc3) + 1);
                    }
                }
                else 
                {
                    loc4 = loc6;
                    loc3 = Math.max(loc3, Math.floor((loc8 - 1) / loc4) + 1);
                }
            }
            if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
            {
                if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
                {
                    loc2 = loc2 + (Number(this._data.height) - 2 * Number(this._data.thumbsPaddingY) - (loc4 * (Number(this._data.thumbHeight) + Number(this._data.thumbSpacingX)) - Number(this._data.thumbSpacingY))) / 2;
                }
            }
            else 
            {
                loc1 = loc1 + (Number(this._data.width) - 2 * Number(this._data.thumbsPaddingX) - (loc3 * (Number(this._data.thumbWidth) + Number(this._data.thumbSpacingX)) - Number(this._data.thumbSpacingX))) / 2;
            }
            this._alignBg.addItem(this._thumbs, "TL", loc1, loc2);
            this._alignBg.addItem(this._thumbsMask, "TL", 0, 0);
            this._thumbList = new Array();
            var loc10:*=0;
            while (loc10 < loc4) 
            {
                loc11 = 0;
                while (loc11 < loc3) 
                {
                    if (loc10 * loc3 + loc11 < this._player.data.slides.length) 
                    {
                        (loc9 = new com.madebyplay.CU3ER.controller.Thumb(this, this._thumbs, this._data, loc10 * loc3 + loc11)).view.x = loc11 * (this._data.thumbWidth + this._data.thumbSpacingX);
                        loc9.view.y = loc10 * (this._data.thumbHeight + this._data.thumbSpacingY);
                        this._thumbList.push(loc9);
                    }
                    else 
                    {
                        break;
                    }
                    ++loc11;
                }
                ++loc10;
            }
            this._thumbnailsStartX = this._thumbs.x;
            this._thumbnailsStartY = this._thumbs.y;
            this._thumbnailsWidth = loc3 * (this._data.thumbWidth + this._data.thumbSpacingX) - this._data.thumbSpacingX;
            this._thumbnailsHeight = loc4 * (this._data.thumbHeight + this._data.thumbSpacingY) - this._data.thumbSpacingY;
            if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
            {
                if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
                {
                    this._maxScrollThumbs = -(this._thumbnailsHeight - this._thumbsMask.height + this._data.thumbsPaddingY);
                }
            }
            else 
            {
                this._maxScrollThumbs = -(this._thumbnailsWidth - this._thumbsMask.width + this._data.thumbsPaddingX);
            }
            if (loc7) 
            {
                this._initSlideAreas();
            }
            if (loc7 == (loc7 && this._player.data.thumbsData.showScroller)) 
            {
                this._createSlider();
            }
            else 
            {
                this._holder.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this._onScrollWheelNoScroller, false, 0, true);
            }
            return;
        }

        internal function _createSlider():void
        {
            var loc2:*=NaN;
            this._scroller = new flash.display.MovieClip();
            this._scroller.x = this._data.scroller.x;
            this._scroller.y = this._data.scroller.y;
            this._alignBg.addItem(this._scroller, this._data.scroller.align_pos, this._data.scroller.x, this._data.scroller.y, this._data.scroller.width, this._data.scroller.height);
            this._holder.addChild(this._scroller);
            this._scrollerBar = new flash.display.Shape();
            var loc1:*=this._data.scroller.rounded_corners.split(",");
            this._scrollerBar.graphics.beginFill(this._data.scroller.bar_color, this._data.scroller.bar_alpha);
            this._scrollerBar.graphics.drawRoundRectComplex(0, 0, this._data.scroller.width, this._data.scroller.height, loc1[0], loc1[1], loc1[3], loc1[2]);
            this._scrollerBar.graphics.endFill();
            this._scroller.addChild(this._scrollerBar);
            this._scrollerSlider = new flash.display.Sprite();
            this._scrollerSlider.graphics.beginFill(this._data.scroller.slider_color, this._data.scroller.slider_alpha);
            if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
            {
                if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
                {
                    this._scrollerSlider.y = loc3 = (this._data.scroller.height - this._data.scroller.slider_thickness) / 2;
                    this._scrollerSlider.x = loc3 = loc3;
                    this._sliderMargin = loc3;
                    loc2 = this._thumbsMask.width / this._thumbnailsWidth * (this._scrollerBar.width - this._sliderMargin * 2);
                    loc2 = 50;
                    this._scrollerSlider.graphics.drawRoundRectComplex(0, 0, loc2, this._data.scroller.slider_thickness, loc1[0], loc1[1], loc1[3], loc1[2]);
                    this._maxScroll = this._data.scroller.width - this._sliderMargin * 2 - loc2;
                }
            }
            else 
            {
                var loc3:*;
                this._scrollerSlider.y = loc3 = (this._data.scroller.width - this._data.scroller.slider_thickness) / 2;
                this._scrollerSlider.x = loc3 = loc3;
                this._sliderMargin = loc3;
                loc2 = this._thumbsMask.height / this._thumbnailsHeight * (this._scrollerBar.height - this._sliderMargin * 2);
                this._scrollerSlider.graphics.drawRoundRectComplex(0, 0, this._data.scroller.slider_thickness, loc2, loc1[0], loc1[1], loc1[3], loc1[2]);
                this._maxScroll = this._scrollerBar.height - this._sliderMargin * 2 - loc2;
            }
            this._scrollWheelStep = Math.min(25, this._maxScroll * 0.15);
            this._scrollerSlider.graphics.endFill();
            this._scrollerSlider.buttonMode = true;
            this._scrollerSliderX = this._scrollerSlider.x;
            this._scrollerSliderY = this._scrollerSlider.y;
            this._scroller.addChild(this._scrollerSlider);
            this._initSlider();
            return;
        }

        internal function _initSlider():void
        {
            this._scrollerSlider.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this._onSliderDown, false, 0, true);
            this._holder.addEventListener(flash.events.MouseEvent.MOUSE_WHEEL, this._onScrollWheel, false, 0, true);
            return;
        }

        internal function _onScrollWheel(arg1:flash.events.MouseEvent):void
        {
            if (arg1.delta > 0) 
            {
                if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
                {
                    if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
                    {
                        this._scrollerSlider.y = this._scrollerSlider.y - this._scrollWheelStep;
                        this._scrollerSlider.y = Math.max(this._scrollerSlider.y, this._scrollerSliderY);
                    }
                }
                else 
                {
                    this._scrollerSlider.x = this._scrollerSlider.x - this._scrollWheelStep;
                    this._scrollerSlider.x = Math.max(this._scrollerSlider.x, this._scrollerSliderX);
                }
            }
            else if (arg1.delta < 0) 
            {
                if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
                {
                    if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
                    {
                        this._scrollerSlider.y = this._scrollerSlider.y + this._scrollWheelStep;
                        this._scrollerSlider.y = Math.min(this._scrollerSlider.y, this._scrollerSliderY + this._maxScroll);
                    }
                }
                else 
                {
                    this._scrollerSlider.x = this._scrollerSlider.x + this._scrollWheelStep;
                    this._scrollerSlider.x = Math.min(this._scrollerSlider.x, this._scrollerSliderX + this._maxScroll);
                }
            }
            this._sliderChange();
            return;
        }

        internal function _onSliderDown(arg1:flash.events.MouseEvent):void
        {
            this._player.CU3ER.stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, this._stopUpdateSlider, false, 0, true);
            this._scrollerSlider.addEventListener(flash.events.MouseEvent.MOUSE_UP, this._stopUpdateSlider, false, 0, true);
            if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
            {
                this._scrollerSlider.startDrag(false, new flash.geom.Rectangle(this._scrollerSliderX, this._scrollerSliderY, 0, this._scrollerBar.height - this._sliderMargin * 2 - this._scrollerSlider.height));
            }
            else 
            {
                this._scrollerSlider.startDrag(false, new flash.geom.Rectangle(this._scrollerSliderX, this._scrollerSliderY, this._scrollerBar.width - this._sliderMargin * 2 - this._scrollerSlider.width, 0));
            }
            this._player.CU3ER.stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this._sliderChange, false, 0, true);
            return;
        }

        internal function _sliderChange(arg1:flash.events.Event=null):void
        {
            if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
            {
                if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
                {
                    this._thumbs.y = this._thumbnailsStartY + (this._scrollerSlider.y - this._scrollerSliderY) / (this._maxScroll - this._scrollerSliderY) * this._maxScrollThumbs;
                }
            }
            else 
            {
                this._thumbs.x = this._thumbnailsStartX + (this._scrollerSlider.x - this._scrollerSliderX) / (this._maxScroll - this._scrollerSliderX) * this._maxScrollThumbs;
            }
            return;
        }

        internal function _updateSliderPos():void
        {
            if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
            {
                if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
                {
                    this._scrollerSlider.y = this._sliderMargin + (this._thumbs.y - this._thumbnailsStartY) / (this._maxScrollThumbs - this._thumbnailsStartY) * this._maxScroll;
                }
            }
            else 
            {
                this._scrollerSlider.x = this._sliderMargin + (this._thumbs.x - this._thumbnailsStartX) / (this._maxScrollThumbs - this._thumbnailsStartX) * this._maxScroll;
            }
            return;
        }

        internal function _stopUpdateSlider(arg1:flash.events.MouseEvent):void
        {
            this._player.CU3ER.stage.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this._stopUpdateSlider);
            this._scrollerSlider.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this._stopUpdateSlider);
            this._player.CU3ER.stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this._sliderChange);
            this._scrollerSlider.stopDrag();
            return;
        }

        internal function _initSlideAreas():void
        {
            this._holder.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this._onSlideArea_mouseMove, false, 0, true);
            this._holder.addEventListener(flash.events.MouseEvent.ROLL_OUT, this._onSlideArea_rollOut, false, 0, true);
            if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
            {
                this._slideArea_cfg = {"minTop":0, "maxTop":this._slideArea_size * this._bg.height, "minBottom":(1 - this._slideArea_size) * this._bg.height, "maxBottom":this._bg.height};
            }
            else 
            {
                this._slideArea_cfg = {"minLeft":0, "maxLeft":this._slideArea_size * this._bg.width, "minRight":(1 - this._slideArea_size) * this._bg.width, "maxRight":this._bg.width};
            }
            return;
        }

        internal function _onSlideArea_rollOut(arg1:flash.events.MouseEvent):void
        {
            this._slideArea_targetStep = 0;
            return;
        }

        internal function _onSlideArea_mouseMove(arg1:flash.events.MouseEvent):void
        {
            if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
            {
                if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
                {
                    if (this._bg.mouseY >= this._slideArea_cfg.minTop && this._bg.mouseY <= this._slideArea_cfg.maxTop) 
                    {
                        this._slideArea_targetStep = (-this._slideArea_maxStep) * (this._bg.mouseY - this._slideArea_cfg.maxTop) / (this._slideArea_cfg.maxTop - this._slideArea_cfg.minTop);
                    }
                    else if (this._bg.mouseY >= this._slideArea_cfg.minBottom && this._bg.mouseY <= this._slideArea_cfg.maxBottom) 
                    {
                        this._slideArea_targetStep = (-this._slideArea_maxStep) * (this._bg.mouseY - this._slideArea_cfg.minBottom) / (this._slideArea_cfg.maxBottom - this._slideArea_cfg.minBottom);
                    }
                }
            }
            else if (this._bg.mouseX >= this._slideArea_cfg.minLeft && this._bg.mouseX <= this._slideArea_cfg.maxLeft) 
            {
                this._slideArea_targetStep = (-this._slideArea_maxStep) * (this._bg.mouseX - this._slideArea_cfg.maxLeft) / (this._slideArea_cfg.maxLeft - this._slideArea_cfg.minLeft);
            }
            else if (this._bg.mouseX >= this._slideArea_cfg.minRight && this._bg.mouseX <= this._slideArea_cfg.maxRight) 
            {
                this._slideArea_targetStep = (-this._slideArea_maxStep) * (this._bg.mouseX - this._slideArea_cfg.minRight) / (this._slideArea_cfg.maxRight - this._slideArea_cfg.minRight);
            }
            if (!(this._slideArea_targetStep == 0) && !this._thumbs.hasEventListener(flash.events.Event.ENTER_FRAME)) 
            {
                this._thumbs.addEventListener(flash.events.Event.ENTER_FRAME, this._onScrollArea_enterFrame, false, 0, true);
            }
            return;
        }

        internal function _onScrollArea_enterFrame(arg1:flash.events.Event):void
        {
            this._slideArea_currStep = this._slideArea_currStep + (this._slideArea_targetStep - this._slideArea_currStep) / 5;
            if (Math.abs(this._slideArea_currStep) < 0.05) 
            {
                this._thumbs.removeEventListener(flash.events.Event.ENTER_FRAME, this._onScrollArea_enterFrame);
            }
            else 
            {
                if (this._data.scroll != com.madebyplay.CU3ER.model.ThumbsData.SCROLL_HORIZONTAL) 
                {
                    if (this._data.scroll == com.madebyplay.CU3ER.model.ThumbsData.SCROLL_VERTICAL) 
                    {
                        if (this._slideArea_currStep < 0) 
                        {
                            this._thumbs.y = Math.max(this._maxScrollThumbs + this._thumbsMask.y, this._thumbs.y + Math.round(this._slideArea_currStep));
                        }
                        else 
                        {
                            this._thumbs.y = Math.min(this._thumbsMask.y + this._data.thumbsPaddingY, this._thumbs.y + Math.round(this._slideArea_currStep));
                        }
                    }
                }
                else if (this._slideArea_currStep < 0) 
                {
                    this._thumbs.x = Math.max(this._maxScrollThumbs + this._thumbsMask.x, this._thumbs.x + Math.round(this._slideArea_currStep));
                }
                else 
                {
                    this._thumbs.x = Math.min(this._thumbsMask.x + this._data.thumbsPaddingX, this._thumbs.x + Math.round(this._slideArea_currStep));
                }
                if (this._scroller != null) 
                {
                    this._updateSliderPos();
                }
            }
            return;
        }

        public function blockThumbs(arg1:Number):void
        {
            var loc1:*=0;
            while (loc1 < this._thumbList.length) 
            {
                if (loc1 == arg1) 
                {
                    (this._thumbList[arg1] as com.madebyplay.CU3ER.controller.Thumb).select();
                }
                else 
                {
                    (this._thumbList[loc1] as com.madebyplay.CU3ER.controller.Thumb).deselect();
                    (this._thumbList[loc1] as com.madebyplay.CU3ER.controller.Thumb).view.mouseEnabled = false;
                    (this._thumbList[loc1] as com.madebyplay.CU3ER.controller.Thumb).view.buttonMode = false;
                }
                ++loc1;
            }
            return;
        }

        public function unblockThumbs(arg1:Number):*
        {
            var loc1:*=0;
            while (loc1 < this._thumbList.length) 
            {
                if (loc1 != arg1) 
                {
                    (this._thumbList[loc1] as com.madebyplay.CU3ER.controller.Thumb).view.mouseEnabled = true;
                    (this._thumbList[loc1] as com.madebyplay.CU3ER.controller.Thumb).view.buttonMode = true;
                }
                ++loc1;
            }
            return;
        }

        public function show():void
        {
            this._hidden = false;
            this._holder.visible = true;
            if (this._tween != null) 
            {
                this._tween.kill();
            }
            this._tween = com.greensock.TweenLite.to(this._holder, 0.3, {"alpha":1});
            return;
        }

        public function hide():void
        {
            this._hidden = true;
            if (this._tween != null) 
            {
                this._tween.kill();
            }
            this._tween = com.greensock.TweenLite.to(this._holder, 0.3, {"alpha":0, "visible":false});
            return;
        }

        public function showHideOnTransition():void
        {
            if (this._data.hideOnTransition && !this._hiddenOnTransition && this._hidden) 
            {
                this.show();
            }
            return;
        }

        public function hideOnTransition():void
        {
            if (this._data.hideOnTransition) 
            {
                this._hiddenOnTransition = this._hidden;
                if (this._data.hideOnTransition && !this._hidden) 
                {
                    this.hide();
                }
            }
            return;
        }

        public function initAutoHide():void
        {
            if (!this._hideTimersInitialized) 
            {
                this._hideTimersInitialized = true;
                if (this._data.autoHide) 
                {
                    if (!(this._timerHide == null) && this._timerHide.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                    {
                        this._timerHide.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide);
                    }
                    this._timerHide = new flash.utils.Timer(this._data.autoHide_time * 1000, 1);
                    this._timerHide.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide, false, 0, true);
                }
            }
            return;
        }

        public function resetHideTimers():void
        {
            if (this._timerHide != null) 
            {
                this._timerHide.reset();
            }
            return;
        }

        public function startHideTimers():void
        {
            if (this._timerHide != null) 
            {
                this._timerHide.start();
            }
            return;
        }

        public function showAutoHide():void
        {
            if (this._data.autoHide && this._hidden) 
            {
                this.show();
            }
            return;
        }

        public function clearAutoHide():void
        {
            if (this._hideTimersInitialized) 
            {
                if (!(this._timerHide == null) && this._timerHide.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                {
                    this._timerHide.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide);
                }
            }
            return;
        }

        public function getHideTime():Number
        {
            return 0.3;
        }

        public function get player():com.madebyplay.CU3ER.controller.Player
        {
            return this._player;
        }

        public function set player(arg1:com.madebyplay.CU3ER.controller.Player):void
        {
            this._player = arg1;
            return;
        }

        internal var _player:com.madebyplay.CU3ER.controller.Player;

        internal var _data:com.madebyplay.CU3ER.model.ThumbsData;

        internal var _holder:flash.display.MovieClip;

        internal var _bg:flash.display.Sprite;

        internal var _scroller:flash.display.MovieClip;

        internal var _scrollerBar:flash.display.Shape;

        internal var _hiddenOnTransition:Boolean=false;

        internal var _sliderMargin:Number=0;

        internal var _thumbs:flash.display.MovieClip;

        internal var _thumbsMask:flash.display.Shape;

        internal var _thumbList:Array;

        internal var _thumbnailsWidth:Number;

        internal var _thumbnailsHeight:Number;

        internal var _scrollerSliderX:Number;

        internal var _scrollerSliderY:Number;

        internal var _maxScroll:Number;

        internal var _thumbnailsStartX:Number;

        internal var _thumbnailsStartY:Number;

        internal var _maxScrollThumbs:Number;

        internal var _scrollWheelStep:Number;

        internal var _slideArea_maxStep:Number=10;

        internal var _slideArea_size:Number=0.3;

        internal var _slideArea_targetStep:Number=0;

        internal var _slideArea_currStep:Number=0;

        internal var _slideArea_cfg:Object;

        internal var _alignBg:com.madebyplay.common.view.AlignUtil;

        internal var _hideTimersInitialized:Boolean=false;

        internal var _timerHide:flash.utils.Timer;

        internal var _tween:com.greensock.TweenLite;

        internal var _hidden:Boolean=false;

        internal var _scrollerSlider:flash.display.Sprite;
    }
}
