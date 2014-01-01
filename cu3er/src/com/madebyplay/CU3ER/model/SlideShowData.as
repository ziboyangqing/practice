package com.madebyplay.CU3ER.model 
{
    import flash.geom.*;
    
    public class SlideShowData extends Object
    {
        public function SlideShowData(arg1:XML, arg2:Boolean=false)
        {
            this._shadowCornerTL = new flash.geom.Point(100, 100);
            this._shadowCornerTR = new flash.geom.Point(200, 100);
            this._shadowCornerBR = new flash.geom.Point(300, 200);
            this._shadowCornerBL = new flash.geom.Point(0, 200);
            super();
            this._isAdmin = arg2;
            this._xml = arg1;
			//trace("SlideShowData",arg1);
            this.getFromXML();
            return;
        }

        public function set cameraFOV(arg1:Number):void
        {
            this._cameraFOV = arg1;
            return;
        }

        public function get cameraLens():Number
        {
            return this._cameraLens;
        }

        public function set cameraLens(arg1:Number):void
        {
            this._cameraLens = arg1;
            return;
        }

        public function get imageAlign():String
        {
            return this._imageAlign;
        }

        public function set imageAlign(arg1:String):void
        {
            this._imageAlign = arg1;
            return;
        }

        public function get imageX():Number
        {
            return this._imageX;
        }

        public function set imageX(arg1:Number):void
        {
            this._imageX = arg1;
            return;
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

        public function get imageScaleX():Number
        {
            return this._imageScaleX;
        }

        public function set imageScaleX(arg1:Number):void
        {
            this._imageScaleX = arg1;
            return;
        }

        public function get imageScaleY():Number
        {
            return this._imageScaleY;
        }

        public function set imageScaleY(arg1:Number):void
        {
            this._imageScaleY = arg1;
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

        public function set descriptionLinkTarget(arg1:String):void
        {
            this._descriptionLinkTarget = arg1;
            return;
        }

        public function get shadowShow():Boolean
        {
            return this._shadowShow;
        }

        public function get shadowCornerTL():flash.geom.Point
        {
            return this._shadowCornerTL;
        }

        public function set shadowCornerTL(arg1:flash.geom.Point):void
        {
            this._shadowCornerTL = arg1;
            return;
        }

        public function get shadowCornerTR():flash.geom.Point
        {
            return this._shadowCornerTR;
        }

        public function set shadowCornerTR(arg1:flash.geom.Point):void
        {
            this._shadowCornerTR = arg1;
            return;
        }

        public function get shadowCornerBR():flash.geom.Point
        {
            return this._shadowCornerBR;
        }

        public function set shadowCornerBR(arg1:flash.geom.Point):void
        {
            this._shadowCornerBR = arg1;
            return;
        }

        public function get shadowCornerBL():flash.geom.Point
        {
            return this._shadowCornerBL;
        }

        public function set shadowCornerBL(arg1:flash.geom.Point):void
        {
            this._shadowCornerBL = arg1;
            return;
        }

        public function get brandingRemoveLogoLoader():Boolean
        {
            return this._brandingRemoveLogoLoader;
        }

        public function set brandingRemoveLogoLoader(arg1:Boolean):void
        {
            this._brandingRemoveLogoLoader = arg1;
            return;
        }

        public function get brandingRemoveMenuInfo():Boolean
        {
            return this._brandingRemoveMenuInfo;
        }

        public function set brandingRemoveMenuInfo(arg1:Boolean):void
        {
            this._brandingRemoveMenuInfo = arg1;
            return;
        }

        public function get brandingRemoveMenuLicence():Boolean
        {
            return this._brandingRemoveMenuLicence;
        }

        public function set brandingRemoveMenuLicence(arg1:Boolean):void
        {
            this._brandingRemoveMenuLicence = arg1;
            return;
        }

        public function get brandingX():Number
        {
            return this._brandingX;
        }

        public function set brandingX(arg1:Number):void
        {
            this._brandingX = arg1;
            return;
        }

        public function set brandingY(arg1:Number):void
        {
            this._brandingY = arg1;
            return;
        }

        public function get brandingAlignTo():String
        {
            return this._brandingAlignTo;
        }

        public function set brandingAlignTo(arg1:String):void
        {
            this._brandingAlignTo = arg1;
            return;
        }

        public function get brandingAlignPos():String
        {
            return this._brandingAlignPos;
        }

        public function set brandingAlignPos(arg1:String):void
        {
            this._brandingAlignPos = arg1;
            return;
        }

        public function get shadowUseImage():Boolean
        {
            return this._shadowUseImage;
        }

        public function set shadowUseImage(arg1:Boolean):void
        {
            this._shadowUseImage = arg1;
            return;
        }

        public function get loop():uint
        {
            return this._loop;
        }

        public function set loop(arg1:uint):void
        {
            this._loop = arg1;
            return;
        }

        public function get isAdmin():Boolean
        {
            return this._isAdmin;
        }

        public function set isAdmin(arg1:Boolean):void
        {
            this._isAdmin = arg1;
            return;
        }

        public function get shadowImageURL():String
        {
            return this._shadowImageURL;
        }

        public function set shadowImageURL(arg1:String):void
        {
            this._shadowImageURL = arg1;
            return;
        }

        public function get autoPlayIndicator():Boolean
        {
            return this._autoPlayIndicator;
        }

        public function set autoPlayIndicator(arg1:Boolean):void
        {
            this._autoPlayIndicator = arg1;
            return;
        }

        public function get bgTransparent():Boolean
        {
            return this._bgTransparent;
        }

        public function set bgTransparent(arg1:Boolean):void
        {
            this._bgTransparent = arg1;
            return;
        }

        public function get accesibilityKeyboard():Boolean
        {
            return this._accesibilityKeyboard;
        }

        public function set accesibilityKeyboard(arg1:Boolean):void
        {
            this._accesibilityKeyboard = arg1;
            return;
        }

        public function get accesibilityScreenReader():Boolean
        {
            return this._accesibilityScreenReader;
        }

        public function set accesibilityScreenReader(arg1:Boolean):void
        {
            this._accesibilityScreenReader = arg1;
            return;
        }

        public function get pauseOnRollover():Boolean
        {
            return this._pauseOnRollover;
        }

        public function getFromXML():void
        {
            var loc1:*=0;
            var loc3:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            this._accesibilityKeyboard = true;
            this._accesibilityScreenReader = true;
            if (String(this._xml.settings.background.color.@transparent) == "true") 
            {
                this._bgTransparent = true;
            }
            if (String(this._xml.settings.background.color) != "") 
            {
                this._bgColor = parseInt(String(this._xml.settings.background.color), 16);
            }
            if (String(this._xml.settings.branding.remove_logo_loader) != "true") 
            {
                this._brandingRemoveLogoLoader = false;
            }
            else 
            {
                this._brandingRemoveLogoLoader = true;
            }
            if (String(this._xml.settings.branding.remove_right_menu_info) != "true") 
            {
                this._brandingRemoveMenuInfo = false;
            }
            else 
            {
                this._brandingRemoveMenuInfo = true;
            }
            if (String(this._xml.settings.branding.remove_right_menu_licence) != "true") 
            {
                this._brandingRemoveMenuLicence = false;
            }
            else 
            {
                this._brandingRemoveMenuLicence = true;
            }
            if (String(this._xml.settings.branding.@align_to) != "") 
            {
                this._brandingAlignTo = String(this._xml.settings.branding.@align_to);
            }
            if (String(this._xml.settings.branding.@align_pos) != "") 
            {
                this._brandingAlignPos = String(this._xml.settings.branding.@align_pos);
            }
            if (String(this._xml.settings.branding.@x) != "") 
            {
                this._brandingX = Number(this._xml.settings.branding.@x);
            }
            if (String(this._xml.settings.branding.@y) != "") 
            {
                this._brandingY = Number(this._xml.settings.branding.@y);
            }
            if (!(this._brandingAlignPos in com.madebyplay.CU3ER.model.GlobalVars.ALIGN_POS_VALUES)) 
            {
                this._brandingAlignPos = "TR";
                this._brandingX = -20;
                this._brandingY = 20;
            }
            if (String(this._xml.slides.@width) != "") 
            {
                this._width = Number(this._xml.slides.@width);
            }
            if (String(this._xml.slides.@height) != "") 
            {
                this._height = Number(this._xml.slides.@height);
            }
            if (String(this._xml.slides.@x) != "") 
            {
                this._x = Number(this._xml.slides.@x);
            }
            if (String(this._xml.slides.@y) != "") 
            {
                this._y = Number(this._xml.slides.@y);
            }
            if (String(this._xml.slides.@align_pos) != "") 
            {
                this._align = String(this._xml.slides.@align_pos);
            }
            if (String(this._xml.defaults.slide.image.@align_pos) != "") 
            {
                this._imageAlign = String(this._xml.defaults.slide.image.@align_pos);
            }
            if (String(this._xml.defaults.slide.image.@x) != "") 
            {
                this._imageX = Number(this._xml.defaults.slide.image.@x);
            }
            if (String(this._xml.defaults.slide.image.@y) != "") 
            {
                this._imageY = Number(this._xml.defaults.slide.image.@y);
            }
            if (String(this._xml.defaults.slide.image.@scaleX) != "") 
            {
                this._imageScaleX = Number(this._xml.defaults.slide.image.@scaleX);
            }
            if (String(this._xml.defaults.slide.image.@scaleY) != "") 
            {
                this._imageScaleY = Number(this._xml.defaults.slide.image.@scaleY);
            }
            if (String(this._xml.settings.randomize_slides) != "true") 
            {
                this._slideRandomize = false;
            }
            else 
            {
                this._slideRandomize = true;
            }
            if (String(this._xml.defaults.slide.link) != "") 
            {
                this._link = String(this._xml.defaults.slide.link);
            }
            if (String(this._xml.defaults.slide.link.@target) != "") 
            {
                this._linkTarget = String(this._xml.defaults.slide.link.@target);
            }
            if (String(this._xml.defaults.slide.description.link) != "") 
            {
                this._descriptionLink = String(this._xml.defaults.slide.description.link);
            }
            if (String(this._xml.defaults.slide.description.link.@target) != "") 
            {
                this._descriptionLinkTarget = String(this._xml.defaults.slide.description.link.@target);
            }
            if (String(this._xml.description) != "") 
            {
                this._descriptionData = new com.madebyplay.CU3ER.model.DescriptionData(XML(this._xml.description));
            }
            var loc2:*=this._xml.slides.slide;//=====================================================
			
            this._slides = new Array();
            this._totalSlides = loc2.length();
			trace("SlideShowData.getFromXml_slides    \n",this._xml.slides.slide,"\n"+totalSlides);//
            trace("SlideShowData_getFromXML,this._xml.slides.slide.url\n",this._xml.slides.slide.url);
			loc1 = 0;
            while (loc1 < this._totalSlides) 
            {
                loc3 = new com.madebyplay.CU3ER.model.SlideData(loc2[loc1], loc1, this, this.xml);
                this._slides.push(loc3);
                ++loc1;
            }
			//trace("SlideShowData.getFromXml_slides    ",this._slides);
            if (this._slideRandomize && !this._isAdmin) 
            {
                loc7 = this._mixArray(this._slides);
                this._slides = loc7;
                loc1 = 0;
                while (loc1 < this._slides.length) 
                {
                    this._slides[loc1].no = loc1;
                    ++loc1;
                }
            }
            if (String(this._xml.settings.start_slide) != "") 
            {
                this._startSlideNo = (Number(this._xml.settings.start_slide) - 1);
            }
            this._preloader = XML(this._xml.preloader);
            var loc4:*;
            if (!((loc4 = String(this._xml.settings.auto_play)) == "") && loc4 == "false") 
            {
                this._autoPlay = false;
            }
            if (String(this._xml.settings.pause_on_rollover) == "true") 
            {
                this._pauseOnRollover = true;
            }
            if (this._autoPlay && !(String(this._xml.controls.auto_play_indicator) == "")) 
            {
                this._autoPlayIndicator = true;
            }
            if (String(this._xml.settings.loop) != "") 
            {
                this._loop = Number(this._xml.settings.loop);
            }
            this._transitions = new Array();
            var loc5:*=this._xml.slides.transition;//==================================================
            this._totalTransitions = loc5.length();
            loc1 = 0;
            while (loc1 < this._totalTransitions) 
            {
                loc6 = new com.madebyplay.CU3ER.model.TransitionData(loc5[loc1], this.xml);
                this._transitions.push(loc6);
                loc1 = loc1 + 1;
            }
            if (String(this._xml.slides.@reverse) == "true" || com.madebyplay.CU3ER.model.GlobalVars.REVERSE_ORDER) 
            {
                this._slides.reverse();
                this._transitions.reverse();
            }
            if (this._xml.settings.hasOwnProperty("shadow")) 
            {
                loc8 = XML(this._xml.settings.shadow);
                if (String(loc8.@show) != "true") 
                {
                    this._shadowShow = false;
                }
                else 
                {
                    this._shadowShow = true;
                }
                if (String(loc8.url) != "") 
                {
                    this._shadowImageURL = String(loc8.url);
                }
                if (!(this._shadowImageURL == "") && String(loc8.@use_image) == "true") 
                {
                    this._shadowUseImage = true;
                }
                else 
                {
                    this._shadowUseImage = false;
                }
                if (String(loc8.@color) != "") 
                {
                    this._shadowColor = parseInt(String(loc8.@color), 16);
                }
                if (String(loc8.@alpha) != "") 
                {
                    this._shadowStrength = Number(loc8.@alpha);
                }
                if (String(loc8.@blur) != "") 
                {
                    this._shadowBlur = Number(loc8.@blur);
                }
                if (String(loc8.@corner_TL) != "") 
                {
                    loc9 = String(loc8.@corner_TL).split(",");
                    this._shadowCornerTL = new flash.geom.Point(loc9[0], loc9[1]);
                }
                if (String(loc8.@corner_TR) != "") 
                {
                    loc9 = String(loc8.@corner_TR).split(",");
                    this._shadowCornerTR = new flash.geom.Point(loc9[0], loc9[1]);
                }
                if (String(loc8.@corner_BR) != "") 
                {
                    loc9 = String(loc8.@corner_BR).split(",");
                    this._shadowCornerBR = new flash.geom.Point(loc9[0], loc9[1]);
                }
                if (String(loc8.@corner_BL) != "") 
                {
                    loc9 = String(loc8.@corner_BL).split(",");
                    this._shadowCornerBL = new flash.geom.Point(loc9[0], loc9[1]);
                }
                if (String(loc8.@scale) != "") 
                {
                    this._shadowScale = Number(loc8.@scale);
                }
            }
            else 
            {
                this._shadowShow = false;
            }
            if (String(this._xml.settings.camera.@x) != "") 
            {
                this._cameraX = Number(this._xml.settings.camera.@x);
            }
            if (String(this._xml.settings.camera.@y) != "") 
            {
                this._cameraY = Number(this._xml.settings.camera.@y);
            }
            if (String(this._xml.settings.camera.@z) != "") 
            {
                this._cameraZ = Number(this._xml.settings.camera.@z);
            }
            if (String(this._xml.settings.camera.@angleX) != "") 
            {
                this._cameraAngleX = Number(this._xml.settings.camera.@angleX);
            }
            if (String(this._xml.settings.camera.@angleY) != "") 
            {
                this._cameraAngleY = Number(this._xml.settings.camera.@angleY);
            }
            if (String(this._xml.settings.camera.@angleZ) != "") 
            {
                this._cameraAngleZ = Number(this._xml.settings.camera.@angleZ);
            }
            if (String(this._xml.settings.camera.@FOV) != "") 
            {
                this._cameraFOV = Number(this._xml.settings.camera.@FOV);
            }
            if (String(this._xml.settings.camera.@lens) != "") 
            {
                this._cameraLens = Number(this._xml.settings.camera.@lens);
            }
            this._controlsData = new com.madebyplay.CU3ER.model.ControlsData(XML(this._xml.controls));
            if (!(this._descriptionData == null) && (!(this._cameraAngleX == 0) || !(this._cameraAngleY == 0) || !(this._cameraAngleZ == 0) || !(this._cameraZ == 0) || !(this._cameraX == 0) || !(this._cameraY == 0))) 
            {
                this._descriptionData.bakeOnTransition = false;
            }
            if (this._xml.hasOwnProperty("thumbnails")) 
            {
                this._thumbsData = new com.madebyplay.CU3ER.model.ThumbsData(XML(this._xml.thumbnails));
            }
			
			
            return;
        }

        internal function _mixArray(arg1:Array):Array
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=null;
            var loc1:*=arg1.length;
            var loc2:*=arg1.slice();
            loc4 = 0;
            while (loc4 < loc1) 
            {
                loc5 = loc2[loc4];
                var loc6:*;
                loc3 = loc6 = this.random(loc1);
                loc2[loc4] = loc2[loc6];
                loc2[loc3] = loc5;
                ++loc4;
            }
            return loc2;
        }

        internal function random(arg1:Number):Number
        {
            return Math.floor(Math.random() * arg1);
        }

        public function saveToXML():void
        {
            return;
        }

        public function get xml():XML
        {
            return this._xml;
        }

        public function set xml(arg1:XML):void
        {
            this._xml = null;
            this._xml = arg1;
            this.getFromXML();
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

        public function get height():Number
        {
            return this._height;
        }

        public function set height(arg1:Number):void
        {
            this._height = arg1;
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

        public function get slides():Array
        {
            return this._slides;
        }

        public function get transitions():Array
        {
            return this._transitions;
        }

        public function get totalSlides():uint
        {
            return this._totalSlides;
        }

        public function get totalTransitions():uint
        {
            return this._totalTransitions;
        }

        public function get bgColor():uint
        {
            return this._bgColor;
        }

        public function set bgColor(arg1:uint):void
        {
            this._bgColor = arg1;
            return;
        }

        public function get shadowColor():Number
        {
            return this._shadowColor;
        }

        public function set shadowColor(arg1:Number):void
        {
            this._shadowColor = arg1;
            return;
        }

        public function get shadowStrength():Number
        {
            return this._shadowStrength;
        }

        public function set shadowStrength(arg1:Number):void
        {
            this._shadowStrength = arg1;
            return;
        }

        public function get shadowScale():Number
        {
            return this._shadowScale;
        }

        public function set shadowScale(arg1:Number):void
        {
            this._shadowScale = arg1;
            return;
        }

        public function get shadowBlur():Number
        {
            return this._shadowBlur;
        }

        public function set shadowBlur(arg1:Number):void
        {
            this._shadowBlur = arg1;
            return;
        }

        public function get brandingY():Number
        {
            return this._brandingY;
        }

        public function set shadowShow(arg1:Boolean):void
        {
            this._shadowShow = arg1;
            return;
        }

        public function get startSlideNo():Number
        {
            return this._startSlideNo;
        }

        public function set startSlideNo(arg1:Number):void
        {
            this._startSlideNo = arg1;
            return;
        }

        public function get autoPlay():Boolean
        {
            return this._autoPlay;
        }

        public function set autoPlay(arg1:Boolean):void
        {
            this._autoPlay = arg1;
            return;
        }

        public function get cameraX():Number
        {
            return this._cameraX;
        }

        public function set cameraX(arg1:Number):void
        {
            this._cameraX = arg1;
            return;
        }

        public function get cameraY():Number
        {
            return this._cameraY;
        }

        public function set cameraY(arg1:Number):void
        {
            this._cameraY = arg1;
            return;
        }

        public function get cameraZ():Number
        {
            return this._cameraZ;
        }

        public function set cameraZ(arg1:Number):void
        {
            this._cameraZ = arg1;
            return;
        }

        public function get cameraAngleX():Number
        {
            return this._cameraAngleX;
        }

        public function set cameraAngleX(arg1:Number):void
        {
            this._cameraAngleX = arg1;
            return;
        }

        public function get cameraAngleY():Number
        {
            return this._cameraAngleY;
        }

        public function set cameraAngleY(arg1:Number):void
        {
            this._cameraAngleY = arg1;
            return;
        }

        public function get cameraAngleZ():Number
        {
            return this._cameraAngleZ;
        }

        public function set cameraAngleZ(arg1:Number):void
        {
            this._cameraAngleZ = arg1;
            return;
        }

        public function get controlsData():com.madebyplay.CU3ER.model.ControlsData
        {
            return this._controlsData;
        }

        public function set controlsData(arg1:com.madebyplay.CU3ER.model.ControlsData):void
        {
            this._controlsData = arg1;
            return;
        }

        public function get descriptionData():com.madebyplay.CU3ER.model.DescriptionData
        {
            return this._descriptionData;
        }

        public function set descriptionData(arg1:com.madebyplay.CU3ER.model.DescriptionData):void
        {
            this._descriptionData = arg1;
            return;
        }

        public function get thumbsData():com.madebyplay.CU3ER.model.ThumbsData
        {
            return this._thumbsData;
        }

        public function set thumbsData(arg1:com.madebyplay.CU3ER.model.ThumbsData):void
        {
            this._thumbsData = arg1;
            return;
        }

        public function get preloader():XML
        {
            return this._preloader;
        }

        public function set preloader(arg1:XML):void
        {
            this._preloader = arg1;
            return;
        }

        public function get align():String
        {
            return this._align;
        }

        public function set align(arg1:String):void
        {
            this._align = arg1;
            return;
        }

        public function get cameraFOV():Number
        {
            return this._cameraFOV;
        }

        internal var _accesibilityKeyboard:Boolean=false;

        internal var _accesibilityScreenReader:Boolean=false;

        internal var _bgTransparent:Boolean=false;

        internal var _bgColor:uint=16777215;

        internal var _width:Number=600;

        internal var _height:Number=400;

        internal var _x:Number=0;

        internal var _y:Number=0;

        internal var _align:String="TL";

        internal var _imageAlign:String="TL";

        internal var _imageX:Number=0;

        internal var _imageY:Number=0;

        internal var _imageScaleX:Number=1;

        internal var _imageScaleY:Number=1;

        internal var _xml:XML;

        internal var _slides:Array;

        internal var _transitions:Array;

        internal var _slideRandomize:Boolean=false;

        internal var _brandingRemoveLogoLoader:Boolean=false;

        internal var _brandingRemoveMenuInfo:Boolean=false;

        internal var _brandingRemoveMenuLicence:Boolean=false;

        internal var _brandingAlignPos:String="TR";

        internal var _brandingX:Number=-20;

        internal var _brandingY:Number=20;

        internal var _preloader:XML;

        internal var _totalSlides:uint=0;

        internal var _totalTransitions:uint=0;

        internal var _startSlideNo:Number=0;

        internal var _autoPlay:Boolean=true;

        internal var _pauseOnRollover:Boolean=false;

        internal var _autoPlayIndicator:Boolean=false;

        internal var _loop:uint=0;

        internal var _shadowShow:Boolean=false;

        internal var _shadowUseImage:Boolean=false;

        internal var _shadowImageURL:String="";

        internal var _shadowColor:Number=3355443;

        internal var _shadowStrength:Number=1;

        internal var _shadowCornerTL:flash.geom.Point;

        internal var _shadowCornerTR:flash.geom.Point;

        internal var _shadowCornerBR:flash.geom.Point;

        internal var _shadowCornerBL:flash.geom.Point;

        internal var _shadowScale:Number=0.7;

        internal var _shadowBlur:Number=20;

        internal var _cameraX:Number=0;

        internal var _cameraY:Number=0;

        internal var _cameraZ:Number=0;

        internal var _cameraAngleX:Number=0;

        internal var _cameraAngleY:Number=0;

        internal var _cameraAngleZ:Number=0;

        internal var _cameraLens:Number=8;

        internal var _cameraFOV:Number=22.619864948;

        internal var _controlsData:com.madebyplay.CU3ER.model.ControlsData;

        internal var _descriptionData:com.madebyplay.CU3ER.model.DescriptionData;

        internal var _thumbsData:com.madebyplay.CU3ER.model.ThumbsData;

        internal var _link:String="";

        internal var _linkTarget:String="_blank";

        internal var _descriptionLink:String="";

        internal var _descriptionLinkTarget:String="_self";

        internal var _isAdmin:Boolean=false;

        internal var _brandingAlignTo:String="stage";
    }
}
