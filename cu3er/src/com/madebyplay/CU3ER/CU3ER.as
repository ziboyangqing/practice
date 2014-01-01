package com.madebyplay.CU3ER 
{
	import br.com.stimuli.loading.*;

	import com.greensock.*;
	import com.greensock.plugins.*;
	import com.madebyplay.CU3ER.controller.*;
	import com.madebyplay.CU3ER.events.*;
	import com.madebyplay.CU3ER.interfaces.*;
	import com.madebyplay.CU3ER.model.*;
	import com.madebyplay.CU3ER.util.*;
	import com.madebyplay.CU3ER.view.*;
	import com.madebyplay.CU3ER.view.controls.*;
	import com.madebyplay.CU3ER.view.preloaders.*;
	import com.madebyplay.common.view.*;

	import flash.display.*;
	import flash.events.*;
	import flash.external.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;

	import net.hires.debug.*;
	import net.stevensacks.utils.*;

	public class CU3ER extends flash.display.MovieClip
	{
		public function CU3ER()
		{
			trace("CU3ER_CONSTRUCTED");
			var licenses:*;
			var l:int;
			var url:String;
			var urlDotArr:Array;
			var tempUrlDotArr:Array;
			var i:int;
			var step:Number;
			var no:Number;
			var j:uint;
			var licenceTest:String;
			var _0x7288:*;
			var licenceOk:Boolean;

			var loc1:*;
			l = 0;
			url = null;
			urlDotArr = null;
			tempUrlDotArr = null;
			i = 0;
			step = NaN;
			no = NaN;
			j = 0;
			licenceTest = null;
			_0x7288 = undefined;
			licenceOk = false;
			this._preloadController = com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance();
			super();
			com.madebyplay.CU3ER.model.GlobalVars.CU3ER = this;
			licenses = com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG;

			com.madebyplay.CU3ER.model.GlobalVars.LICENCE_OK = true;
			com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.TintPlugin, com.greensock.plugins.AutoAlphaPlugin, com.greensock.plugins.VisiblePlugin, com.greensock.plugins.BezierPlugin]);
			com.madebyplay.CU3ER.model.GlobalVars.SCENE_WIDTH = com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH;
			com.madebyplay.CU3ER.model.GlobalVars.SCENE_HEIGHT = com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT;
			if (stage){
				init(null);
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE,init);
			}

			return;
		}
		private function init(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			stage.align = flash.display.StageAlign.TOP_LEFT;
			stage.addEventListener(flash.events.Event.RESIZE, this._onStageResize, false, 0, true);
			if (com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_ON_STAGE) 
			{
				this._preloader = com.madebyplay.CU3ER.interfaces.IPreloader(this.parent.getChildByName("preloader"));
			}
			else 
			{
				this._preloader = com.madebyplay.CU3ER.interfaces.IPreloader(flash.display.Sprite(this.parent.getChildByName("dummySlide")).getChildByName("preloader"));
			}
			this._preloadSlideShow();
		}
		internal function _callBackListenner():void
		{
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().next = this._player.next;
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().prev = this._player.prev;
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().playCU3ER = this._player.play;
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().pauseCU3ER = this._player.pause;
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().skipTo = this._player.skipToMinus;
			try 
			{
				if (flash.external.ExternalInterface.available) 
				{
					flash.external.ExternalInterface.addCallback("playCU3ER", this._player.play);
					flash.external.ExternalInterface.addCallback("pauseCU3ER", this._player.pause);
					flash.external.ExternalInterface.addCallback("next", this._player.next);
					flash.external.ExternalInterface.addCallback("prev", this._player.prev);
					flash.external.ExternalInterface.addCallback("skipTo", this._player.skipTo);
				}
			}
			catch (err:Error)
			{
			};
			return;
		}

		internal function _fadePreloader():void
		{
			if (this._preloader.getPercent() < 1) 
			{
				com.greensock.TweenLite.delayedCall(0.05, this._fadePreloader);
				return;
			}
			this._preloader.hide();
			com.greensock.TweenLite.delayedCall(0.05, this._startPlayer);
			return;
		}

		internal function _startPlayer():void
		{
			var loc3:*=0;
			var loc4:*=null;
			var loc6:*=null;
			var loc7:*=null;
			var loc8:*=null;
			var loc9:*=0;
			var loc10:*=NaN;
			var loc11:*=NaN;
			var loc12:*=0;
			var loc13:*=null;
			var loc14:*=undefined;
			var loc15:*=false;
			com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE = new com.madebyplay.common.view.AlignUtil(new flash.geom.Rectangle(0, 0, this._data.width, this._data.height));
			if (this._bgImage != null) 
			{
				com.greensock.TweenLite.to(this._bgImage, 0.3, {"alpha":1});
			}
			this._player = new com.madebyplay.CU3ER.controller.Player(this, com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE, this._data);
			var loc1:*=this._player.getSlidesOrder();
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().onLoadComplete(loc1);
			try 
			{
				if (flash.external.ExternalInterface.available) 
				{
					flash.external.ExternalInterface.call("CU3ER[\'" + com.madebyplay.CU3ER.model.GlobalVars.FLASH_ID + "\'].onLoadCompleteFlash", loc1);
				}
			}
			catch (err:Error)
			{
			};
			com.greensock.TweenLite.delayedCall(0.2, this._player.start);

			com.madebyplay.CU3ER.model.GlobalVars.LICENCE_OK = true;
			if (com.madebyplay.CU3ER.model.GlobalVars.BRANDING == null || com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER == null) 
			{
				if (com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER == null) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER = new flash.display.Sprite();
					com.madebyplay.CU3ER.model.GlobalVars.CU3ER.addChild(com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER);
				}
				com.madebyplay.CU3ER.model.GlobalVars.BRANDING = new Branding();
				com.madebyplay.CU3ER.model.GlobalVars.BRANDING.buttonMode = true;
				com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER.addChild(com.madebyplay.CU3ER.model.GlobalVars.BRANDING);
				com.madebyplay.CU3ER.model.GlobalVars.BRANDING.alpha = 0;
			}
			var loc5:*=new flash.geom.Rectangle(-0.01, -0.01, com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH - com.madebyplay.CU3ER.model.GlobalVars.BRANDING.width + 0.02, com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT - com.madebyplay.CU3ER.model.GlobalVars.BRANDING.height + 0.02);
			if (this._data.brandingAlignTo != "stage") 
			{
				com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.addItem(com.madebyplay.CU3ER.model.GlobalVars.BRANDING, this._data.brandingAlignPos, this._data.brandingX, this._data.brandingY);
				loc4 = new flash.geom.Point(com.madebyplay.CU3ER.model.GlobalVars.BRANDING.x + com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.area.x, com.madebyplay.CU3ER.model.GlobalVars.BRANDING.y + com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.area.y);
				if (!loc5.containsPoint(loc4)) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.addItem(com.madebyplay.CU3ER.model.GlobalVars.BRANDING, "TR", -20, 20);
				}
			}
			else 
			{
				com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.addItem(com.madebyplay.CU3ER.model.GlobalVars.BRANDING, this._data.brandingAlignPos, this._data.brandingX, this._data.brandingY);
				loc4 = new flash.geom.Point(com.madebyplay.CU3ER.model.GlobalVars.BRANDING.x, com.madebyplay.CU3ER.model.GlobalVars.BRANDING.y);
				if (!loc5.containsPoint(loc4)) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.addItem(com.madebyplay.CU3ER.model.GlobalVars.BRANDING, "TR", -20, 20);
				}
			}
			if (com.madebyplay.CU3ER.model.GlobalVars.LICENCE_OK) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.BRANDING.visible = false;
			}
			else 
			{
				com.madebyplay.CU3ER.model.GlobalVars.BRANDING.visible = true;
				com.greensock.TweenLite.to(com.madebyplay.CU3ER.model.GlobalVars.BRANDING, 0.5, {"alpha":1});
			}
			com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER.visible = true;
			if (!com.madebyplay.CU3ER.model.GlobalVars.BRANDING.hasEventListener(flash.events.MouseEvent.CLICK)) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.BRANDING.addEventListener(flash.events.MouseEvent.CLICK, this._openBranding);
			}
			com.madebyplay.CU3ER.model.GlobalVars.BRANDING.mouseChildren = false;
			com.madebyplay.CU3ER.model.GlobalVars.BRANDING.buttonMode = true;
			com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER.buttonMode = true;
			this._callBackListenner();
			this._destroyPreloader();
			return;
		}

		internal function _destroyPreloader():void
		{
			var loc1:*=null;
			loc1 = this.parent.getChildByName("dummySlide") as flash.display.Sprite;
			if (loc1 != null) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.removeItem(loc1);
				loc1.parent.removeChild(loc1);
				loc1 = null;
			}
			this._preloader.destroy();
			return;
		}

		internal function _openBranding(arg1:flash.events.MouseEvent):void
		{
			net.stevensacks.utils.Web.getURL("http://www.getcu3er.com" + com.madebyplay.CU3ER.model.GlobalVars.REFERRAL, "_blank");
			return;
		}

		public function get testPerc():Number
		{
			return this._testPerc;
		}

		public function set testPerc(arg1:Number):void
		{
			this._testPerc = arg1;
			return;
		}

		public function get player():com.madebyplay.CU3ER.controller.Player
		{
			return this._player;
		}

		public function get preloader():com.madebyplay.CU3ER.interfaces.IPreloader
		{
			return this._preloader;
		}

		public function get stats():net.hires.debug.Stats
		{
			return this._stats;
		}

		public override function addChild(arg1:flash.display.DisplayObject):flash.display.DisplayObject
		{
			var loc1:*=super.addChild(arg1);
			if (com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER != null) 
			{
				setChildIndex(com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER, (numChildren - 1));
			}
			return loc1;
		}

		public override function addChildAt(arg1:flash.display.DisplayObject, arg2:int):flash.display.DisplayObject
		{
			var loc1:*=super.addChildAt(arg1, arg2);
			if (com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER != null) 
			{
				setChildIndex(com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER, (numChildren - 1));
			}
			if (this._bgImage != null) 
			{
				setChildIndex(this._bgImage, 0);
			}
			return loc1;
		}

		internal function _onStageResize(arg1:flash.events.Event):void
		{
			dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
			return;
		}

		internal function _preloadSlideShow():void
		{
			this._preloadController.preload(com.madebyplay.CU3ER.model.GlobalVars.CONFIG_XML_PATH);
			this._preloadController.addEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_XML_COMPLETE, this._onXMLLoadComplete, false, 0, true);
			this._preloadController.addEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_BG_IMAGE_COMPLETE, this._onLoadBgImageComplete, false, 0, true);
			this._preloadController.addEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_FONTS_COMPLETE, this._onFontsLoadComplete, false, 0, true);
			this._preloadController.addEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_PROGRESS, this._onPreloadUpdate, false, 0, true);
			this._preloadController.addEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_FIRST_SLIDE_COMPLETE, this._onPreloadComplete, false, 0, true);
			return;
		}

		internal function _onXMLLoadComplete(arg1:com.madebyplay.CU3ER.events.PreloadEvent):void
		{
			if (com.madebyplay.CU3ER.model.GlobalVars.FOLDER_FONTS != null) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.folder_fonts = com.madebyplay.CU3ER.model.GlobalVars.FOLDER_FONTS;
			}
			if (com.madebyplay.CU3ER.model.GlobalVars.FOLDER_IMAGES != null) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.folder_images = com.madebyplay.CU3ER.model.GlobalVars.FOLDER_IMAGES;
			}
			this._preloadController.removeEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_XML_COMPLETE, this._onXMLLoadComplete);
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.url) == "") 
			{
				com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_FONT = com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_FONT + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_BG_IMAGE;
				this._preloadController.loader.addEventListener(br.com.stimuli.loading.BulkProgressEvent.PROGRESS, this._onFontLoadProgress);
			}
			else 
			{
				this._preloadController.loader.addEventListener(br.com.stimuli.loading.BulkProgressEvent.PROGRESS, this._onBgImageLoadProgress);
			}
			return;
		}

		internal function _onBgImageLoadProgress(arg1:br.com.stimuli.loading.BulkProgressEvent):void
		{
			var loc1:*=com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML + arg1.percentLoaded * com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_BG_IMAGE;
			if (this._preloader != null) 
			{
				this._preloader.updatePercent(loc1);
			}
			return;
		}

		internal function _onLoadBgImageComplete(arg1:com.madebyplay.CU3ER.events.PreloadEvent):void
		{
			if (!(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.url) == "") && String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.@use_image) == "true" && this._preloadController.loader.hasItem("bg_image")) 
			{
				this._bgImage = new flash.display.Sprite();
				this._bgImage.addChild(this._preloadController.loader.getBitmap("bg_image"));
				this.addChildAt(this._bgImage, 0);
				this._bgImage.alpha = 0;
				this._bgImage.cacheAsBitmap = true;
				this._bgImage.scaleX = com.madebyplay.CU3ER.model.GlobalVars.getValue(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.@scaleX, 1);
				this._bgImage.scaleY = com.madebyplay.CU3ER.model.GlobalVars.getValue(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.@scaleY, 1);
				com.madebyplay.CU3ER.util.AlignXML.align(this._bgImage, XML(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image), this._bgImage.width, this._bgImage.height);
			}
			this._preloadController.loader.removeEventListener(br.com.stimuli.loading.BulkProgressEvent.PROGRESS, this._onBgImageLoadProgress);
			this._preloadController.loader.addEventListener(br.com.stimuli.loading.BulkProgressEvent.PROGRESS, this._onFontLoadProgress);
			return;
		}

		internal function _onFontLoadProgress(arg1:br.com.stimuli.loading.BulkProgressEvent):void
		{
			var loc1:*=NaN;
			if (this._bgImage == null) 
			{
				loc1 = com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML + arg1.percentLoaded * com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_FONT;
			}
			else 
			{
				loc1 = com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_BG_IMAGE + arg1.percentLoaded * com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_FONT;
			}
			this._preloader.updatePercent(loc1);
			return;
		}

		internal function _onFontsLoadComplete(arg1:com.madebyplay.CU3ER.events.PreloadEvent=null):void
		{
			var loc1:*=NaN;
			this._preloadController.loader.removeEventListener(br.com.stimuli.loading.BulkProgressEvent.PROGRESS, this._onFontLoadProgress);
			this._preloadController.removeEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_FONTS_COMPLETE, this._onFontsLoadComplete);
			if (this._bgImage == null) 
			{
				loc1 = com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_FONT;
			}
			else 
			{
				loc1 = com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_BG_IMAGE + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_FONT;
			}
			this._preloader.updatePercent(loc1);

			this._data = new com.madebyplay.CU3ER.model.SlideShowData(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG);//+++++++++++++++++++
			//trace("CU3ER-651",GlobalVars.XML_CONFIG);
			this._preloadController.preloadStartSlide(this._data.slides);
			return;
		}

		internal function _onPreloadUpdate(arg1:com.madebyplay.CU3ER.events.PreloadEvent):void
		{
			var loc1:*=NaN;
			if (arg1.slideId == "slide_" + this._data.startSlideNo) 
			{
				if (this._bgImage == null) 
				{
					loc1 = com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SLIDESHOW * arg1.percent + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_FONT + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML;
				}
				else 
				{
					loc1 = com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SLIDESHOW * arg1.percent + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_FONT + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_BG_IMAGE;
				}
				this._preloader.updatePercent(loc1);
			}
			return;
		}

		internal function _onPreloadComplete(arg1:flash.events.Event):void
		{
			this._preloadController.removeEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_PROGRESS, this._onPreloadUpdate);
			this._preloadController.removeEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_FIRST_SLIDE_COMPLETE, this._onPreloadComplete);
			if (com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.debug == 1) 
			{
				this._stats = new net.hires.debug.Stats();
				this._stats.name = "stats";
				this.addChild(this._stats);
			}
			this._preloader.updatePercent(1);
			this.gotoAndStop(3);
			com.greensock.TweenLite.delayedCall(0.1, this._start);
			return;
		}

		internal function _testDesc():void
		{
			var loc1:*=new com.madebyplay.CU3ER.view.DescriptionView(null, this._data.descriptionData);
			this.addChild(new flash.display.Bitmap(loc1.bitmapData));
			var loc2:*=new com.madebyplay.CU3ER.view.DescriptionView(null, this._data.descriptionData);
			this.addChild(loc2);
			loc2.show();
			return;
		}

		internal function _test():void
		{
			var loc1:*=new flash.text.TextField();
			var loc2:*=new flash.text.TextFormat();
			var loc3:*=com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.description.heading.@fontFile;
			var loc4:*=com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.description.paragraph.@fontFile;
			loc2.font = "Neo Sans Std";
			loc2.size = 14;
			loc2.bold = true;
			loc1.width = 150;
			loc1.height = 100;
			loc1.embedFonts = true;
			loc1.defaultTextFormat = loc2;
			loc1.htmlText = "TEST TEXT";
			loc1.x = 150;
			loc1.y = 300;
			this.addChild(loc1);
			return;
		}

		internal function _testPercent():void
		{
			this._testPercView = new com.madebyplay.CU3ER.view.preloaders.PreloaderCircular(XML(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.controls.auto_play_indicator));
			this.addChild(this._testPercView);
			this._testPercView.show();
			this._testPercView.updatePercent(0.5);
			return;
		}

		internal function _updateTestPerc():void
		{
			this._testPercView.updatePercent(this._testPerc);
			return;
		}

		internal function _start():void
		{
			if (flash.utils.getQualifiedClassName(this._preloader).indexOf("PreloaderGeneric") > -1 && flash.display.MovieClip(this._preloader).currentFrame == 100 || flash.utils.getQualifiedClassName(this._preloader).indexOf("PreloaderGeneric") == -1) 
			{
				com.greensock.TweenLite.delayedCall(0.05, this._fadePreloader);
			}
			else 
			{
				com.greensock.TweenLite.delayedCall(0.05, this._start);
			}
			return;
		}

		internal var _stats:net.hires.debug.Stats;

		internal var _preloader:com.madebyplay.CU3ER.interfaces.IPreloader;

		internal var _mcPreloader:flash.display.MovieClip;

		internal var _player:com.madebyplay.CU3ER.controller.Player;

		internal var _data:com.madebyplay.CU3ER.model.SlideShowData;

		internal var _preloadController:com.madebyplay.CU3ER.controller.PreloadControllerPlayer;

		internal var _testPerc:Number=0;

		internal var _testPercView:com.madebyplay.CU3ER.view.preloaders.PreloaderCircular;

		internal var _testBtn:com.madebyplay.CU3ER.view.controls.BtnControl;

		internal var _bgImage:flash.display.Sprite;
	}
}


