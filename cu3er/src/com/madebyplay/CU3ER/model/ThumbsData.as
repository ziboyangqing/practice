package com.madebyplay.CU3ER.model 
{
    import flash.text.*;
    
    public class ThumbsData extends Object
    {
        public function ThumbsData(arg1:XML)
        {
            this._scroll = SCROLL_VERTICAL;
            this._scroller = {"align_pos":"TL", "x":0, "y":0, "width":10, "height":30, "rounded_corners":"5,5,5,5", "bar_color":7829367, "bar_alpha":0.9, "slider_thickness":6, "slider_color":12303291, "slider_alpha":1};
            this._background = {"x":0, "y":0, "width":30, "height":30, "rounded_corners":"0,0,0,0"};
            this._titleDefault = {"x":0, "y":0, "width":90, "height":65, "font":"Arial", "embed_fonts":false, "text_bold":false, "text_italic":false, "text_size":12, "text_color":16777215, "text_align":"left", "text_leading":0, "text_letterSpacing":0, "use_numbering":false, "use_numbering_separator":". ", "use_heading":false, "use_caption":false};
            this._imageDefault = {"x":0, "y":0, "width":30, "height":30, "rounded_corners":"0,0,0,0"};
            super();
            this._xml = arg1;
            this.getFromXML();
            return;
        }

        public function get thumbHeight():Number
        {
            return this._thumbHeight;
        }

        public function set thumbHeight(arg1:Number):void
        {
            this._thumbHeight = arg1;
            return;
        }

        public function get scroller():Object
        {
            return this._scroller;
        }

        public function set scroller(arg1:Object):void
        {
            this._scroller = arg1;
            return;
        }

        public function get background():Object
        {
            return this._background;
        }

        public function set background(arg1:Object):void
        {
            this._background = arg1;
            return;
        }

        public function get backgroundTweens():com.madebyplay.CU3ER.model.TweenData
        {
            return this._backgroundTweens;
        }

        public function set backgroundTweens(arg1:com.madebyplay.CU3ER.model.TweenData):void
        {
            this._backgroundTweens = arg1;
            return;
        }

        public function get title():Object
        {
            return this._title;
        }

        public function set title(arg1:Object):void
        {
            this._title = arg1;
            return;
        }

        public function get bgColor():Number
        {
            return this._bgColor;
        }

        public function get titleTweens():com.madebyplay.CU3ER.model.TweenData
        {
            return this._titleTweens;
        }

        public function set titleTweens(arg1:com.madebyplay.CU3ER.model.TweenData):void
        {
            this._titleTweens = arg1;
            return;
        }

        public function get image():Object
        {
            return this._image;
        }

        public function set image(arg1:Object):void
        {
            this._image = arg1;
            return;
        }

        public function get imageMaskTweens():com.madebyplay.CU3ER.model.TweenData
        {
            return this._imageMaskTweens;
        }

        public function set imageMaskTweens(arg1:com.madebyplay.CU3ER.model.TweenData):void
        {
            this._imageMaskTweens = arg1;
            return;
        }

        public function get thumbsPaddingX():Number
        {
            return this._thumbsPaddingX;
        }

        public function set thumbsPaddingX(arg1:Number):void
        {
            this._thumbsPaddingX = arg1;
            return;
        }

        public function get thumbsPaddingY():Number
        {
            return this._thumbsPaddingY;
        }

        public function get thumbSpacingX():Number
        {
            return this._thumbSpacingX;
        }

        public function set thumbSpacingX(arg1:Number):void
        {
            this._thumbSpacingX = arg1;
            return;
        }

        public function get thumbSpacingY():Number
        {
            return this._thumbSpacingY;
        }

        public function set thumbSpacingY(arg1:Number):void
        {
            this._thumbSpacingY = arg1;
            return;
        }

        public function get showScroller():Boolean
        {
            return this._showScroller;
        }

        public function set showScroller(arg1:Boolean):void
        {
            this._showScroller = arg1;
            return;
        }

        public function get imageTweens():com.madebyplay.CU3ER.model.TweenData
        {
            return this._imageTweens;
        }

        public function set imageTweens(arg1:com.madebyplay.CU3ER.model.TweenData):void
        {
            this._imageTweens = arg1;
            return;
        }

        
        {
            SCROLL_VERTICAL = "vertical";
            SCROLL_HORIZONTAL = "horizontal";
        }

        public function refresh(arg1:XML):void
        {
            this._xml = arg1;
            this.getFromXML();
            return;
        }

        public function getFromXML():void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=false;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            if (String(this._xml.@x) != "") 
            {
                this._x = Number(this._xml.@x);
            }
            if (String(this._xml.@y) != "") 
            {
                this._y = Number(this._xml.@y);
            }
            if (String(this._xml.@width) != "") 
            {
                this._width = Number(this._xml.@width);
            }
            if (String(this._xml.@height) != "") 
            {
                this._height = Number(this._xml.@height);
            }
            if (String(this._xml.@scroll) == SCROLL_HORIZONTAL || String(this._xml.@scroll) == SCROLL_VERTICAL) 
            {
                this._scroll = String(this._xml.@scroll);
            }
            if (String(this._xml.auto_hide) == "true") 
            {
                this._autoHide = true;
            }
            if (String(this._xml.auto_hide.@time) != "") 
            {
                this._autoHide_time = Number(this._xml.auto_hide.@time);
            }
            if (String(this._xml.hide_on_transition) == "true") 
            {
                this._hideOnTransition = true;
            }
            if (String(this._xml.background.@color) != "") 
            {
                this._bgColor = parseInt(String(this._xml.background.@color), 16);
            }
            if (String(this._xml.background.@alpha) != "") 
            {
                this._bgAlpha = Number(this._xml.background.@alpha);
            }
            if (String(this._xml.background.@round_corners) != "") 
            {
                this._bgRoundedCorners = String(this._xml.background.@round_corners);
            }
            if (String(this._xml.thumb.@width) != "") 
            {
                this._thumbWidth = Number(this._xml.thumb.@width);
            }
            if (String(this._xml.thumb.@height) != "") 
            {
                this._thumbHeight = Number(this._xml.thumb.@height);
            }
            if (String(this._xml.thumb.@spacing_x) != "") 
            {
                this._thumbSpacingX = Number(this._xml.thumb.@spacing_x);
            }
            if (String(this._xml.thumb.@spacing_y) != "") 
            {
                this._thumbSpacingY = Number(this._xml.thumb.@spacing_y);
            }
            if (String(this._xml.@padding_x) != "") 
            {
                this._thumbsPaddingX = Number(this._xml.@padding_x);
            }
            if (String(this._xml.@padding_y) != "") 
            {
                this._thumbsPaddingY = Number(this._xml.@padding_y);
            }
            if ("scroller" in this._xml) 
            {
                this._showScroller = true;
            }
            else 
            {
                this._showScroller = false;
            }
            if (String(this._xml.scroller.@align_pos) != "") 
            {
                this._scroller.align_pos = String(this._xml.scroller.@align_pos);
            }
            if (String(this._xml.scroller.@x) != "") 
            {
                this._scroller.x = Number(this._xml.scroller.@x);
            }
            if (String(this._xml.scroller.@y) != "") 
            {
                this._scroller.y = Number(this._xml.scroller.@y);
            }
            if (String(this._xml.scroller.@width) != "") 
            {
                this._scroller.width = Number(this._xml.scroller.@width);
            }
            if (String(this._xml.scroller.@height) != "") 
            {
                this._scroller.height = Number(this._xml.scroller.@height);
            }
            if (String(this._xml.scroller.@round_corners) != "") 
            {
                this._scroller.rounded_corners = String(this._xml.scroller.@round_corners);
            }
            if (String(this._xml.scroller.bar.@color) != "") 
            {
                this._scroller.bar_color = parseInt(String(this._xml.scroller.bar.@color), 16);
            }
            if (String(this._xml.scroller.bar.@alpha) != "") 
            {
                this._scroller.bar_alpha = Number(this._xml.scroller.bar.@alpha);
            }
            if (String(this._xml.scroller.slider.@thickness) != "") 
            {
                this._scroller.slider_thickness = Number(this._xml.scroller.slider.@thickness);
            }
            if (String(this._xml.scroller.slider.@color) != "") 
            {
                this._scroller.slider_color = parseInt(String(this._xml.scroller.slider.@color), 16);
            }
            if (String(this._xml.scroller.slider.@alpha) != "") 
            {
                this._scroller.slider_alpha = Number(this._xml.scroller.slider.@alpha);
            }
            if (String(this._xml.thumb.background.@round_corners) != "") 
            {
                this._background.rounded_corners = String(this._xml.thumb.background.@round_corners);
            }
            if (String(this._xml.thumb.@x) != "") 
            {
                this._background.x = Number(this._xml.thumb.@x);
            }
            if (String(this._xml.thumb.@y) != "") 
            {
                this._background.y = Number(this._xml.thumb.@y);
            }
            this._backgroundTweens = new com.madebyplay.CU3ER.model.TweenData(XML(this._xml.thumb.background));
            this._backgroundTweens.tweenShow.x = Number(this._backgroundTweens.tweenShow.x) + this._background.x;
            this._backgroundTweens.tweenShow.y = Number(this._backgroundTweens.tweenShow.y) + this._background.y;
            this._backgroundTweens.tweenHide.x = Number(this._backgroundTweens.tweenHide.x) + this._background.x;
            this._backgroundTweens.tweenHide.y = Number(this._backgroundTweens.tweenHide.y) + this._background.y;
            this._backgroundTweens.tweenOver.x = Number(this._backgroundTweens.tweenOver.x) + this._background.x;
            this._backgroundTweens.tweenOver.y = Number(this._backgroundTweens.tweenOver.y) + this._background.y;
            this._backgroundTweens.tweenSelected.x = Number(this._backgroundTweens.tweenSelected.x) + this._background.x;
            this._backgroundTweens.tweenSelected.y = Number(this._backgroundTweens.tweenSelected.y) + this._background.y;
            if (String(this._xml.thumb.title) != "") 
            {
                this._title = this._titleDefault;
                if (String(this._xml.thumb.title.@x) != "") 
                {
                    this._title.x = Number(this._xml.thumb.title.@x);
                }
                if (String(this._xml.thumb.title.@y) != "") 
                {
                    this._title.y = Number(this._xml.thumb.title.@y);
                }
                if (String(this._xml.thumb.title.@width) != "") 
                {
                    this._title.width = Number(this._xml.thumb.title.@width);
                }
                if (String(this._xml.thumb.title.@height) != "") 
                {
                    this._title.height = Number(this._xml.thumb.title.@height);
                }
                loc2 = decodeURIComponent(String(this._xml.thumb.title.@font));
                loc3 = flash.text.Font.enumerateFonts();
                loc4 = false;
                loc1 = 0;
                while (loc1 < loc3.length) 
                {
                    if (loc2 == flash.text.Font(loc3[loc1]).fontName) 
                    {
                        this._title.font = loc2;
                        this._title.embed_fonts = true;
                        loc4 = true;
                    }
                    ++loc1;
                }
                if (!loc4) 
                {
                    this._title.font = loc2;
                    this._title.embed_fonts = false;
                }
                if (String(this._xml.thumb.title.@text_bold) == "true") 
                {
                    this._title.text_bold = true;
                }
                if (String(this._xml.thumb.title.@text_italic) == "true") 
                {
                    this._title.text_italic = true;
                }
                if (String(this._xml.thumb.title.@text_size) != "") 
                {
                    this._title.text_size = Number(this._xml.thumb.title.@text_size);
                }
                if (String(this._xml.thumb.title.@text_color) == "") 
                {
                    if (String(this._xml.thumb.title.tweenShow.@tint) != "") 
                    {
                        this._title.text_color = parseInt(String(this._xml.thumb.title.tweenShow.@tint), 16);
                    }
                }
                else 
                {
                    this._title.text_color = parseInt(String(this._xml.thumb.title.@text_color), 16);
                }
                if (String(this._xml.thumb.title.@text_align) != "") 
                {
                    this._title.text_align = String(this._xml.thumb.title.@text_align);
                }
                if (String(this._xml.thumb.title.@text_leading) != "") 
                {
                    this._title.text_leading = Number(this._xml.thumb.title.@text_leading);
                }
                if (String(this._xml.thumb.title.@text_letterSpacing) != "") 
                {
                    this._title.text_letterSpacing = Number(this._xml.thumb.title.@text_letterSpacing);
                }
                if (String(this._xml.thumb.title.@use_numbering) != "true") 
                {
                    this._title.use_numbering = false;
                }
                else 
                {
                    this._title.use_numbering = true;
                }
                if ("@use_numbering_separator" in this._xml.thumb.title) 
                {
                    this._title.use_numbering_separator = String(this._xml.thumb.title.@use_numbering_separator);
                }
                if (String(this._xml.thumb.title.@use_heading) != "true") 
                {
                    this._title.use_heading = false;
                }
                else 
                {
                    this._title.use_heading = true;
                }
                if (String(this._xml.thumb.title.@use_caption) != "true") 
                {
                    this._title.use_caption = false;
                }
                else 
                {
                    this._title.use_caption = true;
                }
                this._titleTweens = new com.madebyplay.CU3ER.model.TweenData(XML(this._xml.thumb.title), null, ["visible"]);
                this._titleTweens.tweenShow.x = Number(this._backgroundTweens.tweenShow.x) + this._title.x;
                this._titleTweens.tweenShow.y = Number(this._backgroundTweens.tweenShow.y) + this._title.y;
                this._titleTweens.tweenHide.x = Number(this._titleTweens.tweenHide.x) + this._title.x;
                this._titleTweens.tweenHide.y = Number(this._titleTweens.tweenHide.y) + this._title.y;
                this._titleTweens.tweenOver.x = Number(this._titleTweens.tweenOver.x) + this._title.x;
                this._titleTweens.tweenOver.y = Number(this._titleTweens.tweenOver.y) + this._title.y;
                this._titleTweens.tweenSelected.x = Number(this._titleTweens.tweenSelected.x) + this._title.x;
                this._titleTweens.tweenSelected.y = Number(this._titleTweens.tweenSelected.y) + this._title.y;
            }
            if (!(String(this._xml.thumb.image) == "") || this._xml.thumb.image.attributes().length() > 0) 
            {
                this._image = this._imageDefault;
                if (String(this._xml.thumb.image.@x) != "") 
                {
                    this._image.x = Number(this._xml.thumb.image.@x);
                }
                if (String(this._xml.thumb.image.@y) != "") 
                {
                    this._image.y = Number(this._xml.thumb.image.@y);
                }
                if (String(this._xml.thumb.image.@width) != "") 
                {
                    this._image.width = Number(this._xml.thumb.image.@width);
                }
                if (String(this._xml.thumb.image.@height) != "") 
                {
                    this._image.height = Number(this._xml.thumb.image.@height);
                }
                if (String(this._xml.thumb.image.@round_corners)) 
                {
                    this._image.rounded_corners = String(this._xml.thumb.image.@round_corners);
                }
                this._imageMaskTweens = new com.madebyplay.CU3ER.model.TweenData(XML(this._xml.thumb.image), null, ["tint", "visible"]);
                this._imageMaskTweens.tweenShow.x = Number(this._imageMaskTweens.tweenShow.x) + this._image.x;
                this._imageMaskTweens.tweenShow.y = Number(this._imageMaskTweens.tweenShow.y) + this._image.y;
                this._imageMaskTweens.tweenHide.x = Number(this._imageMaskTweens.tweenHide.x) + this._image.x;
                this._imageMaskTweens.tweenHide.y = Number(this._imageMaskTweens.tweenHide.y) + this._image.y;
                this._imageMaskTweens.tweenOver.x = Number(this._imageMaskTweens.tweenOver.x) + this._image.x;
                this._imageMaskTweens.tweenOver.y = Number(this._imageMaskTweens.tweenOver.y) + this._image.y;
                this._imageMaskTweens.tweenSelected.x = Number(this._imageMaskTweens.tweenSelected.x) + this._image.x;
                this._imageMaskTweens.tweenSelected.y = Number(this._imageMaskTweens.tweenSelected.y) + this._image.y;
                this._imageTweens = new com.madebyplay.CU3ER.model.TweenData(XML(this._xml.thumb.image), null, ["tint", "visible"]);
                loc6 = Math.max(this._imageMaskTweens.tweenShow.scaleX, this._imageMaskTweens.tweenShow.scaleY);
                var loc9:*;
                this._imageTweens.tweenShow.scaleY = loc9 = loc6;
                this._imageTweens.tweenShow.scaleX = loc9;
                loc6 = Math.max(this._imageMaskTweens.tweenHide.scaleX, this._imageMaskTweens.tweenHide.scaleY);
                this._imageTweens.tweenHide.scaleY = loc9 = loc6;
                this._imageTweens.tweenHide.scaleX = loc9;
                loc6 = Math.max(this._imageMaskTweens.tweenOver.scaleX, this._imageMaskTweens.tweenOver.scaleY);
                this._imageTweens.tweenOver.scaleY = loc9 = loc6;
                this._imageTweens.tweenOver.scaleX = loc9;
                loc6 = Math.max(this._imageMaskTweens.tweenSelected.scaleX, this._imageMaskTweens.tweenSelected.scaleY);
                this._imageTweens.tweenSelected.scaleY = loc9 = loc6;
                this._imageTweens.tweenSelected.scaleX = loc9;
                loc7 = (this._imageMaskTweens.tweenShow.scaleX - this._imageTweens.tweenShow.scaleX) * this._image.width / 2;
                loc8 = (this._imageMaskTweens.tweenShow.scaleY - this._imageTweens.tweenShow.scaleY) * this._image.height / 2;
                this._imageTweens.tweenShow.x = Number(this._imageTweens.tweenShow.x) + this._image.x + loc7;
                this._imageTweens.tweenShow.y = Number(this._imageTweens.tweenShow.y) + this._image.y + loc8;
                loc7 = (this._imageMaskTweens.tweenHide.scaleX - this._imageTweens.tweenHide.scaleX) * this._image.width / 2;
                loc8 = (this._imageMaskTweens.tweenHide.scaleY - this._imageTweens.tweenHide.scaleY) * this._image.height / 2;
                this._imageTweens.tweenHide.x = Number(this._imageTweens.tweenHide.x) + this._image.x + loc7;
                this._imageTweens.tweenHide.y = Number(this._imageTweens.tweenHide.y) + this._image.y + loc8;
                loc7 = (this._imageMaskTweens.tweenOver.scaleX - this._imageTweens.tweenOver.scaleX) * this._image.width / 2;
                loc8 = (this._imageMaskTweens.tweenOver.scaleY - this._imageTweens.tweenOver.scaleY) * this._image.height / 2;
                this._imageTweens.tweenOver.x = Number(this._imageTweens.tweenOver.x) + this._image.x + loc7;
                this._imageTweens.tweenOver.y = Number(this._imageTweens.tweenOver.y) + this._image.y + loc8;
                loc7 = (this._imageMaskTweens.tweenSelected.scaleX - this._imageTweens.tweenSelected.scaleX) * this._image.width / 2;
                loc8 = (this._imageMaskTweens.tweenSelected.scaleY - this._imageTweens.tweenSelected.scaleY) * this._image.height / 2;
                this._imageTweens.tweenSelected.x = Number(this._imageTweens.tweenSelected.x) + this._image.x + loc7;
                this._imageTweens.tweenSelected.y = Number(this._imageTweens.tweenSelected.y) + this._image.y + loc8;
            }
            return;
        }

        public function get x():Number
        {
            return this._x;
        }

        public function set x(arg1:Number):void
        {
            this._x = arg1;
            return;
        }

        public function get y():Number
        {
            return this._y;
        }

        public function set y(arg1:Number):void
        {
            this._y = arg1;
            return;
        }

        public function get xml():XML
        {
            return this._xml;
        }

        public function set xml(arg1:XML):void
        {
            this._xml = arg1;
            this.getFromXML();
            return;
        }

        public function get width():Number
        {
            return this._width;
        }

        public function set width(arg1:Number):void
        {
            this._width = arg1;
            return;
        }

        public function get height():Number
        {
            return this._height;
        }

        public function set height(arg1:Number):void
        {
            this._height = arg1;
            return;
        }

        public function get scroll():String
        {
            return this._scroll;
        }

        public function set scroll(arg1:String):void
        {
            this._scroll = arg1;
            return;
        }

        public function set thumbsPaddingY(arg1:Number):void
        {
            this._thumbsPaddingY = arg1;
            return;
        }

        public function set bgColor(arg1:Number):void
        {
            this._bgColor = arg1;
            return;
        }

        public function get bgAlpha():Number
        {
            return this._bgAlpha;
        }

        public function set bgAlpha(arg1:Number):void
        {
            this._bgAlpha = arg1;
            return;
        }

        public function get bgRoundedCorners():String
        {
            return this._bgRoundedCorners;
        }

        public function set bgRoundedCorners(arg1:String):void
        {
            this._bgRoundedCorners = arg1;
            return;
        }

        public function get autoHide():Boolean
        {
            return this._autoHide;
        }

        public function set autoHide(arg1:Boolean):void
        {
            this._autoHide = arg1;
            return;
        }

        public function get autoHide_time():Number
        {
            return this._autoHide_time;
        }

        public function set autoHide_time(arg1:Number):void
        {
            this._autoHide_time = arg1;
            return;
        }

        public function get hideOnTransition():Boolean
        {
            return this._hideOnTransition;
        }

        public function set hideOnTransition(arg1:Boolean):void
        {
            this._hideOnTransition = arg1;
            return;
        }

        public function get thumbWidth():Number
        {
            return this._thumbWidth;
        }

        public function set thumbWidth(arg1:Number):void
        {
            this._thumbWidth = arg1;
            return;
        }

        internal var _xml:XML;

        internal var _x:Number;

        internal var _y:Number;

        internal var _width:Number;

        internal var _height:Number;

        internal var _scroll:String;

        internal var _bgColor:Number=3355443;

        internal var _bgAlpha:Number=1;

        internal var _bgRoundedCorners:String="5,5,5,5";

        internal var _thumbsPaddingX:Number=0;

        internal var _autoHide:Boolean=false;

        internal var _autoHide_time:Number=4;

        internal var _hideOnTransition:Boolean=false;

        internal var _thumbWidth:Number;

        internal var _thumbHeight:Number;

        internal var _thumbSpacingX:Number;

        internal var _thumbSpacingY:Number;

        internal var _showScroller:Boolean=true;

        internal var _scroller:Object;

        internal var _background:Object;

        internal var _backgroundTweens:com.madebyplay.CU3ER.model.TweenData;

        internal var _titleDefault:Object;

        internal var _title:Object=null;

        internal var _titleTweens:com.madebyplay.CU3ER.model.TweenData;

        internal var _imageDefault:Object;

        internal var _image:Object=null;

        internal var _imageMaskTweens:com.madebyplay.CU3ER.model.TweenData;

        internal var _imageTweens:com.madebyplay.CU3ER.model.TweenData;

        public static var SCROLL_VERTICAL:String="vertical";

        public static var SCROLL_HORIZONTAL:String="horizontal";

        internal var _thumbsPaddingY:Number=0;
    }
}
