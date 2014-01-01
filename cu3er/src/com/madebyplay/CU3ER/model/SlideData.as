package com.madebyplay.CU3ER.model 
{
    public class SlideData extends Object
    {
        public function SlideData(arg1:XML, arg2:Number, arg3:com.madebyplay.CU3ER.model.SlideShowData, arg4:XML)
        {
            super();
            this._globalXML = arg4;
            this._slideShowData = arg3;
            this._no = arg2;
            this._origNo = arg2;
            this._xml = arg1;
			//trace("SlideData:1-----",this._xml);
            this.getFromXML();
            return;
        }

        public function get link():String
        {
            return this._link;
        }

        public function set link(arg1:String):void
        {
            this._link = arg1;
            return;
        }

        public function get linkTarget():String
        {
            return this._linkTarget;
        }

        public function set linkTarget(arg1:String):void
        {
            this._linkTarget = arg1;
            return;
        }

        public function get descriptionShow():Boolean
        {
            return this._descriptionShow;
        }

        public function set descriptionShow(arg1:Boolean):void
        {
            this._descriptionShow = arg1;
            return;
        }

        public function get imageAlign():String
        {
            return this._imageAlign;
        }

        public function set descriptionLinkTarget(arg1:String):void
        {
            this._descriptionLinkTarget = arg1;
            return;
        }

        public function get imageX():Number
        {
            return this._imageX;
        }

        public function get imageScaleX():Number
        {
            return this._imageScaleX;
        }

        public function get imageScaleY():Number
        {
            return this._imageScaleY;
        }

        public function get imageY():Number
        {
            return this._imageY;
        }

        public function set imageY(arg1:Number):void
        {
            this._imageY = arg1;
            return;
        }

        public function get bgColor():uint
        {
            return this._bgColor;
        }

        public function get caption():String
        {
            return this._caption;
        }

        public function set caption(arg1:String):void
        {
            this._caption = arg1;
            return;
        }

        public function get no():Number
        {
            return this._no;
        }

        public function set no(arg1:Number):void
        {
            this._no = arg1;
            return;
        }

        public function get origNo():Number
        {
            return this._origNo;
        }

        public function set origNo(arg1:Number):void
        {
            this._origNo = arg1;
            return;
        }

        public function get transparent():Boolean
        {
            return this._transparent;
        }

        public function set transparent(arg1:Boolean):void
        {
            this._transparent = arg1;
            return;
        }

        public function get seo_image():Boolean
        {
            return this._seo_image;
        }

        public function get seo_heading():Boolean
        {
            return this._seo_heading;
        }

        public function get seo_paragraph():Boolean
        {
            return this._seo_paragraph;
        }

        public function set url(arg1:String):void
        {
            this._url = arg1;
            return;
        }

        public function get seo_caption():Boolean
        {
            return this._seo_caption;
        }

        public function getFromXML():void
        {
            var loc1:*=null;
            if (String(this._xml.@time) == "") 
            {
                if (String(this._globalXML.defaults.slide.@time) != "") 
                {
                    this._time = Number(this._globalXML.defaults.slide.@time);
                }
            }
            else 
            {
                this._time = Number(this._xml.@time);
            }
            if (String(this._xml.seo.show.@emptyImage) == "true") 
            {
                delete this._xml.seo.show.@emptyImage;
                delete this._xml.seo.show.@image;
            }
            if (String(this._xml.seo.show.@emptyHeading) == "true") 
            {
                delete this._xml.seo.show.@emptyHeading;
                delete this._xml.seo.show.@heading;
            }
            if (String(this._xml.seo.show.@emptyParagraph) == "true") 
            {
                delete this._xml.seo.show.@emptyParagraph;
                delete this._xml.seo.show.@paragraph;
            }
            if (String(this._xml.seo.show.@emptyCaption) == "true") 
            {
                delete this._xml.seo.show.@emptyCaption;
                delete this._xml.seo.show.@caption;
            }
            if ("@image" in this._xml.seo.show) 
            {
                if (String(this._xml.seo.show.@image) != "true") 
                {
                    this._seo_image = false;
                }
                else 
                {
                    this._seo_image = true;
                }
            }
            else if ("@image" in this._globalXML.defaults.slide.seo.show) 
            {
                if (String(this._globalXML.defaults.slide.seo.show.@image) != "true") 
                {
                    this._seo_image = false;
                    this._xml.seo.show.@image = "false";
                }
                else 
                {
                    this._seo_image = true;
                    this._xml.seo.show.@image = "true";
                }
                this._xml.seo.show.@emptyImage = "true";
            }
            else 
            {
                this._xml.seo.show.@emptyImage = "true";
                this._xml.seo.show.@image = "true";
                this._seo_image = true;
            }
            if ("@heading" in this._xml.seo.show) 
            {
                if (String(this._xml.seo.show.@heading) != "true") 
                {
                    this._seo_heading = false;
                }
                else 
                {
                    this._seo_heading = true;
                }
            }
            else if ("@heading" in this._globalXML.defaults.slide.seo.show) 
            {
                if (String(this._globalXML.defaults.slide.seo.show.@heading) != "true") 
                {
                    this._seo_heading = false;
                    this._xml.seo.show.@heading = "false";
                }
                else 
                {
                    this._seo_heading = true;
                    this._xml.seo.show.@heading = "true";
                }
                this._xml.seo.show.@emptyHeading = "true";
            }
            else 
            {
                this._xml.seo.show.@emptyHeading = "true";
                this._xml.seo.show.@heading = "true";
                this._seo_heading = true;
            }
            if ("@paragraph" in this._xml.seo.show) 
            {
                if (String(this._xml.seo.show.@paragraph) != "true") 
                {
                    this._seo_paragraph = false;
                }
                else 
                {
                    this._seo_paragraph = true;
                }
            }
            else if ("@paragraph" in this._globalXML.defaults.slide.seo.show) 
            {
                if (String(this._globalXML.defaults.slide.seo.show.@paragraph) != "true") 
                {
                    this._seo_paragraph = false;
                    this._xml.seo.show.@paragraph = "false";
                }
                else 
                {
                    this._seo_paragraph = true;
                    this._xml.seo.show.@paragraph = "true";
                }
                this._xml.seo.show.@emptyParagraph = "true";
            }
            else 
            {
                this._xml.seo.show.@emptyParagraph = "true";
                this._xml.seo.show.@paragraph = "true";
                this._seo_paragraph = true;
            }
            if ("@caption" in this._xml.seo.show) 
            {
                if (String(this._xml.seo.show.@caption) != "true") 
                {
                    this._seo_caption = false;
                }
                else 
                {
                    this._seo_caption = true;
                }
            }
            else if ("@caption" in this._globalXML.defaults.slide.seo.show) 
            {
                if (String(this._globalXML.defaults.slide.seo.show.@caption) != "true") 
                {
                    this._seo_caption = false;
                    this._xml.seo.show.@caption = "false";
                }
                else 
                {
                    this._seo_caption = true;
                    this._xml.seo.show.@caption = "true";
                }
                this._xml.seo.show.@emptyCaption = "true";
            }
            else 
            {
                this._xml.seo.show.@emptyCaption = "true";
                this._xml.seo.show.@caption = "true";
                this._seo_caption = true;
            }
            if (String(this._xml.url) == "") 
            {
                if (String(this._globalXML.defaults.slide.url) != "") 
                {
                    this._url = String(this._globalXML.defaults.slide.url);
                }
            }
            else 
            {
                this._url = String(this._xml.url);
            }
            if (String(this._xml.description.link.@empty) == "true") 
            {
                delete this._xml.description.link;
            }
            if (String(this._xml.caption) != "") 
            {
                this._caption = String(this._xml.caption);
            }
            if (String(this._xml.description.heading) != "") 
            {
                this._descriptionHeading = String(this._xml.description.heading);
                this._descriptionShow = true;
            }
            if (String(this._xml.description.paragraph) != "") 
            {
                this._descriptionParagraph = String(this._xml.description.paragraph);
                this._descriptionShow = true;
            }
            if (this._descriptionShow) 
            {
                if (String(this._xml.description.link) == "") 
                {
                    this._descriptionLink = this._slideShowData.descriptionLink;
                }
                else 
                {
                    this._descriptionLink = String(this._xml.description.link);
                }
            }
            if (String(this._xml.description.link.@target) == "") 
            {
                this._descriptionLinkTarget = this._slideShowData.descriptionLinkTarget;
            }
            else 
            {
                this._descriptionLinkTarget = String(this._xml.description.link.@target);
            }
            if (String(this._xml.@use_image) == "false") 
            {
                this._imageShow = false;
            }
            if (String(this._xml.image.@empty) == "true") 
            {
                delete this._xml.image;
            }
            if (String(this._xml.image.@align_pos) == "") 
            {
                this._imageAlign = this._slideShowData.imageAlign;
            }
            else 
            {
                this._imageAlign = String(this._xml.image.@align_pos);
            }
            if (String(this._xml.image.@x) == "") 
            {
                this._imageX = this._slideShowData.imageX;
            }
            else 
            {
                this._imageX = Number(this._xml.image.@x);
            }
            if (String(this._xml.image.@y) == "") 
            {
                this._imageY = this._slideShowData.imageY;
            }
            else 
            {
                this._imageY = Number(this._xml.image.@y);
            }
            if (String(this._xml.image.@scaleX) == "") 
            {
                this._imageScaleX = this._slideShowData.imageScaleX;
            }
            else 
            {
                this._imageScaleX = Number(this._xml.image.@scaleX);
            }
            if (String(this._xml.image.@scaleY) == "") 
            {
                this._imageScaleY = this._slideShowData.imageScaleY;
            }
            else 
            {
                this._imageScaleY = Number(this._xml.image.@scaleY);
            }
            if (String(this._xml.@emptyColor) == "true") 
            {
                delete this._xml.@color;
                delete this._xml.@emptyColor;
            }
            if (String(this._xml.@color) == "") 
            {
                if (String(this._slideShowData.xml.defaults.slide.@color) == "") 
                {
                    this._bgColor = 16777215;
                }
                else 
                {
                    this._bgColor = parseInt(String(this._slideShowData.xml.defaults.slide.@color), 16);
                }
            }
            else 
            {
                this._bgColor = parseInt(String(this._xml.@color), 16);
            }
            if (String(this._xml.@emptyTransparent) == "true") 
            {
                delete this._xml.@transparent;
                delete this._xml.@emptyTransparent;
            }
            if (String(this._xml.@transparent) != "true") 
            {
                if (String(this._xml.@transparent) != "false") 
                {
                    if (String(this._globalXML.defaults.slide.@transparent) != "true") 
                    {
                        this._transparent = false;
                    }
                    else 
                    {
                        this._transparent = true;
                    }
                }
                else 
                {
                    this._transparent = false;
                }
            }
            else 
            {
                this._transparent = true;
            }
            if (!this._xml.hasOwnProperty("image")) 
            {
                this._xml.appendChild(new XML("<image/>"));
                this._xml.image.@empty = "true";
                this._xml.image.@x = this._imageX;
                this._xml.image.@y = this._imageY;
                this._xml.image.@scaleX = this._imageScaleX;
                this._xml.image.@scaleY = this._imageScaleY;
                this._xml.image.@align_pos = this._imageAlign;
            }
            if (String(this._xml.link.@empty)) 
            {
                delete this._xml.link;
            }
            if (String(this._xml.link) == "") 
            {
                this._link = this._slideShowData.link;
                this._linkTarget = this._slideShowData.linkTarget;
            }
            else 
            {
                this._link = String(this._xml.link);
                if (String(this._xml.link.@target) == "") 
                {
                    this._linkTarget = this._slideShowData.linkTarget;
                }
                else 
                {
                    this._linkTarget = String(this._xml.link.@target);
                }
            }
            if (!this._xml.hasOwnProperty("link")) 
            {
                this._xml.appendChild(new XML("<link></link>"));
                this._xml.link = this._link;
                this._xml.link.@target = this._linkTarget;
            }
            if (!this._xml.hasOwnProperty("description")) 
            {
                this._xml.appendChild(new XML("<description></description>"));
                this._xml.description.link = this._descriptionLink;
                this._xml.description.link.@target = this._descriptionLinkTarget;
                this._xml.description.link.@empty = "true";
            }
            if (String(this._xml.@color) == "") 
            {
                this._xml.@emptyColor = "true";
                loc1 = this._bgColor.toString(16);
                while (loc1.length < 6) 
                {
                    loc1 = "0" + loc1;
                }
                loc1 = "0x" + loc1;
                this._xml.@color = loc1;
            }
            if (String(this._xml.@transparent) == "") 
            {
                this._xml.@emptyTransparent = "true";
                this._xml.@transparent = "false";
                if (this._transparent) 
                {
                    this._xml.@transparent = "true";
                }
            }
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

        public function get time():Number
        {
            return this._time;
        }

        public function set time(arg1:Number):void
        {
            this._time = arg1;
            return;
        }

        public function get url():String
        {
            return this._url;
        }

        public function get imageShow():Boolean
        {
            return this._imageShow;
        }

        public function get descriptionHeading():String
        {
            return this._descriptionHeading;
        }

        public function set descriptionHeading(arg1:String):void
        {
            this._descriptionHeading = arg1;
            return;
        }

        public function get descriptionParagraph():String
        {
            return this._descriptionParagraph;
        }

        public function set descriptionParagraph(arg1:String):void
        {
            this._descriptionParagraph = arg1;
            return;
        }

        public function get descriptionLink():String
        {
            return this._descriptionLink;
        }

        public function set descriptionLink(arg1:String):void
        {
            this._descriptionLink = arg1;
            return;
        }

        public function get descriptionLinkTarget():String
        {
            return this._descriptionLinkTarget;
        }

        internal var _xml:XML;

        internal var _no:Number;

        internal var _origNo:Number;

        internal var _url:String;

        internal var _time:Number=5;

        internal var _transparent:Boolean=false;

        internal var _link:String="";

        internal var _caption:String="";

        internal var _descriptionHeading:String="";

        internal var _descriptionParagraph:String="";

        internal var _descriptionLink:String="";

        internal var _descriptionLinkTarget:String="_self";

        internal var _descriptionShow:Boolean=false;

        internal var _imageShow:Boolean=true;

        internal var _imageAlign:String;

        internal var _imageX:Number;

        internal var _imageY:Number;

        internal var _imageScaleX:Number;

        internal var _imageScaleY:Number;

        internal var _slideShowData:com.madebyplay.CU3ER.model.SlideShowData;

        internal var _bgColor:uint;

        internal var _globalXML:XML;

        internal var _seo_image:Boolean=true;

        internal var _seo_heading:Boolean=true;

        internal var _seo_caption:Boolean=true;

        internal var _seo_paragraph:Boolean=true;

        internal var _linkTarget:String="_blank";
    }
}
