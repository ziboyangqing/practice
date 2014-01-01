package com.madebyplay.CU3ER.controller 
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.madebyplay.CU3ER.events.*;
    import com.madebyplay.CU3ER.interfaces.*;
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.common.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;
    import net.stevensacks.utils.*;
    
    public class Slide extends flash.events.EventDispatcher implements com.madebyplay.CU3ER.interfaces.ISlide
    {
        public function Slide(arg1:com.madebyplay.CU3ER.controller.Player, arg2:uint)
        {
            super();
            this._no = arg2;
            this._player = arg1;
            this._data = this._player.data.slides[this._no];
            this._id = "slide_" + String(this._no);
            if (!(arg1.data.descriptionData == null) && this._data.descriptionShow) 
            {
                this._description = new com.madebyplay.CU3ER.controller.Description(arg1, this, this._player.data.descriptionData);
            }
            this._init();
            return;
        }

        public function fadeOut():void
        {
            this._doFadeOut();
            return;
        }

        internal function _doFadeOut(arg1:Number=1):void
        {
            dispatchEvent(new com.madebyplay.CU3ER.events.SlideEvent(com.madebyplay.CU3ER.events.SlideEvent.FADE_OUT_START));
            com.greensock.TweenLite.to(this._slideView, arg1, {"alpha":0, "visible":false, "ease":com.greensock.easing.Sine.easeOut, "onComplete":this._onFadeOutFinish});
            return;
        }

        internal function _onFadeOutFinish():void
        {
            dispatchEvent(new com.madebyplay.CU3ER.events.SlideEvent(com.madebyplay.CU3ER.events.SlideEvent.FADE_OUT_FINISH));
            return;
        }

        public function get data():com.madebyplay.CU3ER.model.SlideData
        {
            return this._data;
        }

        public function set data(arg1:com.madebyplay.CU3ER.model.SlideData):void
        {
            this._data = arg1;
            return;
        }

        public function showDescription():void
        {
            this._isDescriptionHidden = true;
            if (!(this._player.data.descriptionData == null) && this._data.descriptionShow && this._player.data.descriptionData.hideOnTransition && this._player.data.descriptionData.bakeOnTransition) 
            {
                this._description.view.showFast();
                this._isDescriptionHidden = false;
            }
            else if (!(this._player.data.descriptionData == null) && this._data.descriptionShow) 
            {
                this._description.view.show();
                this._isDescriptionHidden = false;
            }
            return;
        }

        public function get bitmapData():flash.display.BitmapData
        {
            return this._bitmapData;
        }

        public function set bitmapData(arg1:flash.display.BitmapData):void
        {
            this._bitmapData = arg1;
            return;
        }

        public function get description():com.madebyplay.CU3ER.controller.Description
        {
            return this._description;
        }

        public function get no():uint
        {
            return this._no;
        }

        public function set no(arg1:uint):void
        {
            this._no = arg1;
            return;
        }

        public function get bitmapData_noDesc():flash.display.BitmapData
        {
            return this._bitmapData_noDesc;
        }

        public function get isDescriptionHidden():Boolean
        {
            return this._isDescriptionHidden;
        }

        public function set isDescriptionHidden(arg1:Boolean):void
        {
            this._isDescriptionHidden = arg1;
            return;
        }

        public function get hideTime():Number
        {
            return this._hideTime;
        }

        internal function _init(arg1:com.madebyplay.CU3ER.events.PreloadEvent=null):void
        {
            var loc1:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc2:*=this._player.data.width;
            var loc3:*=this._player.data.height;
            if (this._data.url != null) 
            {
                if (!(com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().isLoadFailed(this._id) || com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().isLoaded(this._id))) 
                {
                    com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().addEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, this._init);
                    return;
                }
                if (arg1 == null || this._id == arg1.slideId) 
                {
                    com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().removeEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, this._init);
                }
                else 
                {
                    return;
                }
                if (!com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().isLoadFailed(this._id) || !this.data.imageShow) 
                {
                    loc1 = new flash.display.Sprite();
                    if (!this._data.transparent) 
                    {
                        loc1.graphics.beginFill(this._data.bgColor);
                        loc1.graphics.drawRect(0, 0, loc2, loc3);
                        loc1.graphics.endFill();
                    }
                    loc4 = new com.madebyplay.common.view.AlignUtil(new flash.geom.Rectangle(0, 0, loc2, loc3));
                    if (this.data.imageShow) 
                    {
                        (loc5 = new flash.display.Bitmap(com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().loader.getBitmapData(this._id).clone())).smoothing = true;
                        loc5.scaleX = this._data.imageScaleX;
                        loc5.scaleY = this._data.imageScaleY;
                        loc1.addChild(loc5);
                        loc4.addItem(loc5, this._data.imageAlign, this._data.imageX, this._data.imageY, loc5.width, loc5.height);
                    }
                    if (this._data.transparent) 
                    {
                        this._bitmapData = new flash.display.BitmapData(loc2, loc3, true, 0);
                    }
                    else 
                    {
                        this._bitmapData = new flash.display.BitmapData(loc2, loc3, false, this._data.bgColor);
                    }
                    this._bitmapData.draw(loc1, null, null, null, null, true);
                    if (this.data.imageShow) 
                    {
                        loc1.removeChild(loc5);
                        loc5.bitmapData.dispose();
                        loc5 = null;
                    }
                    loc1 = null;
                }
                else 
                {
                    this._bitmapData = this._createEmptyBitmap(loc2, loc3);
                }
            }
            else 
            {
                loc1 = new flash.display.Sprite();
                if (!this._data.transparent) 
                {
                    loc1.graphics.beginFill(this._data.bgColor);
                    loc1.graphics.drawRect(0, 0, loc2, loc3);
                    loc1.graphics.endFill();
                }
                if (this._data.transparent) 
                {
                    this._bitmapData = new flash.display.BitmapData(loc2, loc3, true, 0);
                }
                else 
                {
                    this._bitmapData = new flash.display.BitmapData(loc2, loc3, false, this._data.bgColor);
                }
                this._bitmapData = new flash.display.BitmapData(loc2, loc3, false, this._data.bgColor);
                this._bitmapData.draw(loc1, null, null, null, null, true);
            }
            if (!(this._player.data.descriptionData == null) && this._data.descriptionShow && this._player.data.descriptionData.bakeOnTransition) 
            {
                this._bitmapData_noDesc = this._bitmapData.clone();
                loc6 = this._player.holder.localToGlobal(new flash.geom.Point(0, 0));
                loc7 = this._description.view.localToGlobal(new flash.geom.Point(0, 0));
                if (this._player.data.descriptionData.alignTo == "stage") 
                {
                    loc7 = loc7.subtract(loc6);
                }
                this._bitmapData.copyPixels(this._description.view.bitmapData, new flash.geom.Rectangle(0, 0, this._description.view.bitmapData.width, this._description.view.bitmapData.height), loc7);
            }
            return;
        }

        internal function _createEmptyBitmap(arg1:Number, arg2:Number):flash.display.BitmapData
        {
            var loc1:*=new flash.display.Sprite();
            var loc2:*=new flash.display.Shape();
            loc1.addChild(loc2);
            loc2.graphics.beginFill(0, 1);
            loc2.graphics.drawRect(0, 0, arg1, arg2);
            loc2.graphics.endFill();
            loc2.graphics.lineStyle(1, 4210752);
            loc2.graphics.moveTo(0, 0);
            loc2.graphics.lineTo(arg1, arg2);
            loc2.graphics.moveTo(arg1, 0);
            loc2.graphics.lineTo(0, arg2);
            loc2.graphics.lineStyle(0, 0);
            var loc3:*;
            (loc3 = new flash.display.Bitmap(new no_image_big(0, 0))).x = arg1 / 2 - loc3.width / 2;
            loc3.y = arg2 / 2 - loc3.height / 2;
            loc2.graphics.beginFill(0, 1);
            loc2.graphics.drawRect(arg1 / 2 - loc3.width / 2, arg2 / 2 - loc3.height / 2, loc3.width, loc3.height);
            loc2.graphics.endFill();
            loc1.addChild(loc3);
            var loc4:*;
            (loc4 = new flash.display.BitmapData(arg1, arg2, false)).draw(loc1);
            return loc4;
        }

        public function bringInFront(arg1:flash.display.DisplayObject):void
        {
            if (arg1.parent == this._slideView.parent) 
            {
                if (arg1.parent.getChildIndex(arg1) > this._slideView.parent.getChildIndex(this._slideView)) 
                {
                    this._slideView.parent.setChildIndex(this._slideView, arg1.parent.getChildIndex(arg1));
                }
            }
            return;
        }

        public function addToStage():void
        {
            this._slideView = new flash.display.MovieClip();
            this._slideView.x = this._player.data.x;
            this._slideView.y = this._player.data.y;
            if (!(this._description == null) && !(this._description.view == null)) 
            {
                this._description.view.killTweens();
            }
            if (!(this._player.data.descriptionData == null) && this._data.descriptionShow) 
            {
                this._slideView.addChild(this._description.view);
                if (this._player.data.descriptionData.alignTo != "stage") 
                {
                    this._player.holder.addChild(this._slideView);
                }
                else 
                {
                    com.madebyplay.CU3ER.model.GlobalVars.CU3ER.addChildAt(this._slideView, com.madebyplay.CU3ER.model.GlobalVars.CU3ER.getChildIndex(this._player.holder) + 1);
                }
            }
            this._slideView.visible = false;
            this._slideView.alpha = 0;
            this._slideView.x = 0;
            this._slideView.y = 0;
            return;
        }

        public function showFast():void
        {
            if (this._tweenHide != null) 
            {
                this._tweenHide.kill();
            }
            this._slideView.visible = true;
            this._slideView.alpha = 1;
            if (!(this._description == null) && !this._isDescriptionHidden) 
            {
                this._description.view.hideFast();
            }
            this.showDescriptionFast();
            return;
        }

        public function show():void
        {
            if (this._tweenHide != null) 
            {
                this._tweenHide.kill();
            }
            this._slideView.visible = true;
            this._slideView.alpha = 1;
            if (this._description != null) 
            {
                this._description.view.hideFast();
            }
            this.showDescription();
            return;
        }

        public function hide():void
        {
            if (!(this._player.data.descriptionData == null) && !this._isDescriptionHidden && this._data.descriptionShow) 
            {
                if (com.madebyplay.CU3ER.controller.Slide(this._player.slides[this._player.currSlideNo]).description == null) 
                {
                    this._description.view.hide();
                }
                else 
                {
                    this._description.view.hideFast();
                }
                this._tweenHide = com.greensock.TweenLite.delayedCall(this._description.view.getHideTime(), this._hideSlideView);
            }
            else 
            {
                if (!(this._description == null) && !(this._description.view == null)) 
                {
                    this._description.view.killTweens();
                }
                this._hideSlideView();
            }
            this._isDescriptionHidden = true;
            return;
        }

        internal function _hideSlideView():void
        {
            this._slideView.visible = false;
            return;
        }

        public function set description(arg1:com.madebyplay.CU3ER.controller.Description):void
        {
            this._description = arg1;
            return;
        }

        public function showDescriptionFast():void
        {
            this._isDescriptionHidden = true;
            if (!(this._player.data.descriptionData == null) && this._data.descriptionShow && this._player.data.descriptionData.hideOnTransition && this._player.data.descriptionData.bakeOnTransition) 
            {
                this._description.view.showFast();
                this._isDescriptionHidden = false;
            }
            else if (!(this._player.data.descriptionData == null) && this._data.descriptionShow) 
            {
                this._description.view.showFast();
                this._isDescriptionHidden = false;
            }
            return;
        }

        public function hideDescription(arg1:Boolean=false):void
        {
            this._hideTime = 0;
            this._isDescriptionHidden = false;
            if (!(this._player.data.descriptionData == null) && this._data.descriptionShow && this._player.data.descriptionData.bakeOnTransition && !arg1) 
            {
                this._description.view.hideFast();
                this._hideTime = 0.1;
                this._isDescriptionHidden = true;
            }
            else if (!(this._player.data.descriptionData == null) && this._data.descriptionShow && (this._player.data.descriptionData.hideOnTransition || arg1)) 
            {
                this._description.view.hide();
                this._hideTime = this._description.view.getHideTime();
                this._isDescriptionHidden = true;
            }
            else 
            {
                com.greensock.TweenLite.delayedCall(0.1, this._dispatchFadeOutFinish);
                this._isDescriptionHidden = true;
                this._hideTime = 0.1;
                if (!(this._player.data.descriptionData == null) && this._data.descriptionShow && !this._player.data.descriptionData.hideOnTransition) 
                {
                    this._isDescriptionHidden = false;
                }
            }
            return;
        }

        public function getHideTime():Number
        {
            return this._hideTime;
        }

        internal function _dispatchFadeOutFinish():void
        {
            this.dispatchEvent(new com.madebyplay.CU3ER.events.SlideEvent(com.madebyplay.CU3ER.events.SlideEvent.FADE_OUT_FINISH));
            return;
        }

        public function openLink(arg1:flash.events.MouseEvent=null):void
        {
            net.stevensacks.utils.Web.getURL(this._data.link, this._data.linkTarget);
            return;
        }

        public function destroy():*
        {
            if (this._slideView.parent != null) 
            {
                this._slideView.parent.removeChild(this._slideView);
            }
            if (this._bitmapData != null) 
            {
                this._bitmapData.dispose();
            }
            if (this._bitmapData_noDesc != null) 
            {
                this._bitmapData_noDesc.dispose();
            }
            return;
        }

        public function fadeIn():void
        {
            this._doFadeIn();
            return;
        }

        internal function _doFadeIn(arg1:Number=1):void
        {
            if (!(this._player.data.descriptionData == null) && this._data.descriptionShow) 
            {
                com.greensock.TweenLite.delayedCall(0.2, this._description.view.show);
            }
            this._slideView.visible = true;
            com.greensock.TweenLite.to(this._slideView, arg1, {"alpha":1, "ease":com.greensock.easing.Sine.easeOut, "onComplete":this._onFadeInFinish});
            dispatchEvent(new com.madebyplay.CU3ER.events.SlideEvent(com.madebyplay.CU3ER.events.SlideEvent.FADE_IN_START));
            return;
        }

        internal function _onFadeInFinish():void
        {
            dispatchEvent(new com.madebyplay.CU3ER.events.SlideEvent(com.madebyplay.CU3ER.events.SlideEvent.FADE_IN_FINISH));
            return;
        }

        internal var _player:com.madebyplay.CU3ER.controller.Player;

        internal var _data:com.madebyplay.CU3ER.model.SlideData;

        internal var _bitmapData:flash.display.BitmapData;

        internal var _bitmapData_noDesc:flash.display.BitmapData;

        internal var _bgBmp:flash.display.Bitmap;

        internal var _slideView:flash.display.MovieClip;

        internal var _heading:flash.text.TextField;

        internal var _paragraph:flash.text.TextField;

        internal var _description:com.madebyplay.CU3ER.controller.Description;

        internal var _no:uint;

        internal var _hideTime:Number=0;

        internal var _id:String;

        internal var _isDescriptionHidden:Boolean=true;

        internal var _tweenHide:com.greensock.TweenLite;

        internal var _bg:flash.display.MovieClip;
    }
}
