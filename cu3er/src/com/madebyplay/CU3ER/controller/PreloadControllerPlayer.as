package com.madebyplay.CU3ER.controller 
{
	import br.com.stimuli.loading.*;
	import br.com.stimuli.loading.loadingtypes.*;
	import com.greensock.*;
	import com.madebyplay.CU3ER.events.*;
	import com.madebyplay.CU3ER.model.*;
	import flash.display.*;
	import flash.events.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;

	public class PreloadControllerPlayer extends flash.events.EventDispatcher
	{
		public function PreloadControllerPlayer()
		{
			this._forceLoadedSlides = new Object();
			this._processedSlides = new Object();
			super();
			this._context = new flash.system.LoaderContext();
			this._context.applicationDomain = flash.system.ApplicationDomain.currentDomain;
			this._context.checkPolicyFile = true;
			if (instance) 
			{
				throw new Error("PreloadControllerPlayer is a Singleton and can only be accessed through PreloadControllerPlayer.getInstance()");
			}
			this._loader = new br.com.stimuli.loading.BulkLoader(br.com.stimuli.loading.BulkLoader.getUniqueName(), 4);
			this._loader.logLevel = br.com.stimuli.loading.BulkLoader.LOG_SILENT;
			return;
		}

		internal function _dispatchComplete():void
		{
			this.dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_COMPLETE));
			return;
		}

		internal function _onLoadSlideError(arg1:flash.events.ErrorEvent):void
		{
			var loc1:*=arg1.target as br.com.stimuli.loading.loadingtypes.LoadingItem;
			var loc2:*=loc1.id;
			if (this.isLoadFailed(loc2)) 
			{
				return;
			}
			if (loc1 != null) 
			{
				loc1.removeEventListener(flash.events.Event.COMPLETE, this._onCompleteSlide);
				loc1.removeEventListener(flash.events.ProgressEvent.PROGRESS, this._onProgress);
				loc1.removeEventListener(br.com.stimuli.loading.BulkLoader.ERROR, this._onLoadSlideError);
			}
			this._loader.remove(loc2);
			this._loadedFailSlides = this._loadedFailSlides + (loc2 + "---");
			this._loadedSlides = this._loadedSlides + (loc2 + ",");
			var loc3:*=new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, loc2);
			this.dispatchEvent(loc3);
			this.preloadNextSlide();
			return;
		}

		internal function _onCompleteSlide(arg1:flash.events.Event):void
		{
			var loc1:*=(arg1.currentTarget as br.com.stimuli.loading.loadingtypes.LoadingItem).id;
			var loc2:*=this._loader.get(loc1);
			if (loc2 != null) 
			{
				loc2.removeEventListener(flash.events.Event.COMPLETE, this._onCompleteSlide);
				loc2.removeEventListener(flash.events.ProgressEvent.PROGRESS, this._onProgress);
				loc2.removeEventListener(br.com.stimuli.loading.BulkLoader.ERROR, this._onLoadSlideError);
			}
			this._loadedSlides = this._loadedSlides + (loc1 + ",");
			var loc4:*;
			var loc5:*=((loc4 = this)._totalSlidesLoaded + 1);
			loc4._totalSlidesLoaded = loc5;
			var loc3:*=new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, loc1);
			this.dispatchEvent(loc3);
			this.preloadNextSlide();
			return;
		}

		public function forceLoadSlide(arg1:Number):void
		{
			this._currSlideNo = arg1;
			this.preloadNextSlide();
			return;
		}

		internal function _onCompleteForcedSlide(arg1:flash.events.Event):void
		{
			var loc1:*=arg1.currentTarget as br.com.stimuli.loading.loadingtypes.LoadingItem;
			try 
			{
				loc1.removeEventListener(flash.events.Event.COMPLETE, this._onCompleteForcedSlide);
				loc1.removeEventListener(flash.events.ProgressEvent.PROGRESS, this._onProgress);
			}
			catch (err:Error)
			{
			};
			this._loadedSlides = this._loadedSlides + (loc1.id + ",");
			_totalSlidesLoaded = _totalSlidesLoaded + 1;
			this.dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, loc1.id));
			return;
		}

		public function isSlideLoaded(arg1:String):Boolean
		{
			if (this._loadedSlides.indexOf(arg1 + ",") > -1) 
			{
				return true;
			}
			return false;
		}

		internal function _onProgress(arg1:flash.events.ProgressEvent):void
		{
			var loc1:*=new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_PROGRESS, (arg1.currentTarget as br.com.stimuli.loading.loadingtypes.LoadingItem).id, arg1.bytesLoaded / arg1.bytesTotal);
			this.dispatchEvent(loc1);
			return;
		}

		internal function _onLibraryInfoComplete(arg1:flash.events.Event):void
		{
			this._loader.removeEventListener(flash.events.Event.COMPLETE, this._onLibraryInfoComplete);
			dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_LIBRARY_INFO_COMPLETE));
			return;
		}

		public function isLoaded(arg1:String):Boolean
		{
			try 
			{
				if (this._loader.get(arg1) != null) 
				{
					if (this._loader.get(arg1).isLoaded) 
					{
						return true;
					}
				}
			}
			catch (err:Error)
			{
			};
			return false;
		}

		public function isLoadFailed(arg1:String):Boolean
		{
			if (this._loadedFailSlides.indexOf(arg1 + "---") > -1) 
			{
				return true;
			}
			return false;
		}

		public function get loader():br.com.stimuli.loading.BulkLoader
		{
			return this._loader;
		}

		public function get percentLoaded():Number
		{
			return this._percentLoaded;
		}

		public function set percentLoaded(arg1:Number):void
		{
			this._percentLoaded = arg1;
			return;
		}

		public function get totalSlides():uint
		{
			return this._totalSlides;
		}

		public function get totalSlidesLoaded():uint
		{
			return this._totalSlidesLoaded;
		}

		public function get startSlideId():String
		{
			return this._startSlideId;
		}

		public function get headingFont():String
		{
			return this._headingFont;
		}

		public function get paragraphFont():String
		{
			return this._paragraphFont;
		}

		public function set thumbFont(arg1:String):void
		{
			this._thumbFont = arg1;
			return;
		}

		public function get fileFolder():String
		{
			return this._fileFolder;
		}

		public function get projectFolder():String
		{
			return this._projectFolder;
		}

		public function set projectFolder(arg1:String):void
		{
			this._projectFolder = arg1;
			return;
		}

		public function set fileFolder(arg1:String):void
		{
			this._fileFolder = arg1;
			return;
		}

		public static function getInstance():com.madebyplay.CU3ER.controller.PreloadControllerPlayer
		{
			return instance;
		}


		{
			instance = new PreloadControllerPlayer();
		}

		public function preload(arg1:String="CU3ER-config.xml", arg2:String="", arg3:String="", arg4:Boolean=false):void
		{
			this._isAdmin = arg4;
			this._fileFolder = arg2;
			this._projectFolder = arg3;
			this._urlXML = arg1;
			this._percentLoaded = 0;
			com.greensock.TweenLite.delayedCall(0.1, this._onLoadXML);
			return;
		}

		internal function _onLoadXML(arg1:flash.events.Event=null):void
		{
			var loc1:*=null;
			var loc2:*=NaN;
			var loc3:*=null;
			var loc4:*=null;
			var loc5:*=0;
			var loc6:*=null;
			this.dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_XML_COMPLETE));
			if (com.madebyplay.CU3ER.model.GlobalVars.START_SLIDE != -1) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.start_slide = com.madebyplay.CU3ER.model.GlobalVars.START_SLIDE;
			}
			if (com.madebyplay.CU3ER.model.GlobalVars.FLASHVAR_IMAGES.length != 0) 
			{
				loc1 = com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides;
				loc2 = loc1.length();
				loc3 = com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides[(loc2 - 1)];
				loc4 = new XML("<transition/>");
				loc5 = (com.madebyplay.CU3ER.model.GlobalVars.FLASHVAR_IMAGES.length - 1);
				while (loc5 >= 0) 
				{
					if (loc5 < loc2) 
					{
						loc1[loc5].url = com.madebyplay.CU3ER.model.GlobalVars.FLASHVAR_IMAGES[loc5];
					}
					else 
					{
						com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.insertChildAfter(loc3, loc4);
						(loc6 = new XML("<slide><url></url></slide>")).url = com.madebyplay.CU3ER.model.GlobalVars.FLASHVAR_IMAGES[loc5];
						com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.insertChildAfter(loc3, loc6);
					}
					--loc5;
				}
			}
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.url) == "") 
			{
				this._onLoadBgImage();
			}
			else 
			{
				this._preloadBgImage();
			}
			return;
		}

		internal function _preloadBgImage():void
		{
			this._loader.addEventListener(flash.events.ErrorEvent.ERROR, this._onBgImageError);
			this._loader.addEventListener(flash.events.Event.COMPLETE, this._onLoadBgImage);
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.url).indexOf("http://") == -1 && String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.url).indexOf("https://") == -1) 
			{
				this._loader.add(com.madebyplay.CU3ER.model.GlobalVars.LOAD_PREFIX + String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.folder_images) + "/" + String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.url), {"id":"bg_image", "context":this._context});
			}
			else 
			{
				this._loader.add(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.url), {"id":"bg_image", "context":this._context});
			}
			this._loader.start();
			return;
		}

		internal function _onBgImageError(arg1:flash.events.ErrorEvent):void
		{
			this._loader.remove("bg_image");
			this._onLoadBgImage();
			return;
		}

		internal function _onLoadBgImage(arg1:flash.events.Event=null):void
		{
			this._loader.removeEventListener(flash.events.ErrorEvent.ERROR, this._onBgImageError);
			this._loader.removeEventListener(flash.events.Event.COMPLETE, this._onLoadBgImage);
			this.dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_BG_IMAGE_COMPLETE));
			this._preloadShadowImage();
			return;
		}

		internal function _preloadShadowImage():void
		{
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.shadow.@use_image) == "true" && !(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.shadow.url) == "")) 
			{
				this._loader.addEventListener(flash.events.ErrorEvent.ERROR, this._onShadowError);
				this._loader.addEventListener(flash.events.Event.COMPLETE, this._onLoadShadow);
				if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.shadow.url).indexOf("http://") == -1 && String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.image.url).indexOf("https://") == -1) 
				{
					this._loader.add(com.madebyplay.CU3ER.model.GlobalVars.LOAD_PREFIX + String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.folder_images) + "/" + String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.shadow.url), {"id":"shadow", "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
				}
				else 
				{
					this._loader.add(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.shadow.url), {"id":"shadow", "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
				}
				this._loader.start();
			}
			else 
			{
				this._preloadFonts();
			}
			return;
		}

		internal function _onShadowError(arg1:flash.events.ErrorEvent):void
		{
			this._loader.remove("shadow");
			this._onLoadShadow();
			return;
		}

		internal function _onLoadShadow(arg1:flash.events.Event=null):void
		{
			this._loader.removeEventListener(flash.events.ErrorEvent.ERROR, this._onShadowError);
			this._loader.removeEventListener(flash.events.Event.COMPLETE, this._onLoadShadow);
			this._preloadFonts();
			return;
		}

		public function loadLibraryInfo(arg1:String):void
		{
			if (this._loader.hasItem("library_info")) 
			{
				this._loader.remove("library_info");
			}
			this._loader.add(arg1, {"type":br.com.stimuli.loading.BulkLoader.TYPE_XML, "id":"library_info", "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_XML});
			this._loader.addEventListener(flash.events.Event.COMPLETE, this._onLibraryInfoComplete);
			this._loader.start();
			return;
		}

		public function get thumbFont():String
		{
			return this._thumbFont;
		}

		public function loadMoreFonts(arg1:String):void
		{
			var loc4:*=null;
			var loc1:*=0;
			while (this._loader.get("font_" + loc1) != null) 
			{
				++loc1;
			}
			var loc2:*="font_" + loc1;
			var loc3:*=com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.folder_fonts + "/";
			if (arg1.indexOf("http://") == -1 && arg1.indexOf("https://") == -1) 
			{
				loc4 = this._loader.add(com.madebyplay.CU3ER.model.GlobalVars.LOAD_PREFIX + this._fileFolder + "fonts/" + arg1, {"id":loc2, "context":this._context});
			}
			else 
			{
				loc4 = this._loader.add(arg1, {"id":loc2, "context":this._context});
			}
			this._lastFontId = loc2;
			this._loader.addEventListener(flash.events.Event.COMPLETE, this._onMoreFontComplete);
			this._loader.start();
			return;
		}

		internal function _onMoreFontComplete(arg1:flash.events.Event):void
		{
			var loc2:*=null;
			var loc3:*=null;
			var loc5:*=null;
			var loc1:*=flash.display.MovieClip(this._loader.get(this._lastFontId).content);
			try 
			{
				loc5 = loc1.getFontNames();
			}
			catch (err:Error)
			{
			};
			var loc4:*=0;
			while (loc4 < loc5.length) 
			{
				loc2 = flash.utils.getDefinitionByName(loc5[loc4]) as Class;
				loc3 = new loc2();
				com.madebyplay.CU3ER.model.FontsData.FONT_LIST.push({"name":loc3.fontName, "exportName":loc5[loc4], "swf":this._lastFontId});
				flash.text.Font.registerFont(loc2);
				++loc4;
			}
			dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_ADDITIONAL_FONT_COMPLETE));
			return;
		}

		internal function _preloadFonts():void
		{
			var loc4:*=0;
			var loc1:*=com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG;
			var loc2:*=loc1.settings.folder_fonts + "/";
			var loc3:*=loc1.fonts;
			this._percentLoaded = 0;
			com.madebyplay.CU3ER.model.FontsData.FONT_LIST = new Array();
			if (loc3.length() == 0) 
			{
				dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_FONTS_COMPLETE));
				return;
			}
			loc4 = 0;
			while (loc4 < loc3.length()) 
			{
				if (this._isAdmin) 
				{
					if (String(loc3[loc4].@url).indexOf("http://") == -1 && String(loc3[loc4].@url).indexOf("https://") == -1) 
					{
						this._loader.add(this._fileFolder + "fonts/" + loc3[loc4].@url, {"id":"font_" + loc4, "context":this._context});
					}
					else 
					{
						this._loader.add(loc3[loc4].@url, {"id":"font_" + loc4, "context":this._context});
					}
				}
				else if (String(loc3[loc4].@url).indexOf("http://") == -1 && String(loc3[loc4].@url).indexOf("https://") == -1) 
				{
					this._loader.add(loc2 + loc3[loc4].@url, {"id":"font_" + loc4, "context":this._context});
				}
				else 
				{
					this._loader.add(loc3[loc4].@url, {"id":"font_" + loc4, "context":this._context});
				}
				++loc4;
			}
			this._loader.addEventListener(flash.events.Event.COMPLETE, this._onLoadFonts, false, 0, true);
			this._loader.start();
			return;
		}

		internal function _onLoadFonts(arg1:flash.events.Event):void
		{
			var loc1:*=null;
			var loc2:*=null;
			var loc10:*=null;
			var loc11:*=null;
			var loc12:*=0;
			this._loader.removeEventListener(flash.events.Event.COMPLETE, this._onLoadFonts);
			var loc3:*;
			var loc4:*=(loc3 = com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG).settings.folder_fonts + "/";
			var loc5:*=loc3.fonts;
			var loc6:*=loc3.description.heading.@font_load;
			var loc7:*=loc3.description.paragraph.@font_load;
			var loc8:*=loc3.thumbnails.thumb.title.@font_load;
			var loc9:*=0;
			while (loc9 < loc5.length()) 
			{
				loc10 = flash.display.MovieClip(this._loader.get("font_" + loc9).content);
				loc11 = new Array();
				try 
				{
					loc11 = loc10.getFontNames();
				}
				catch (err:Error)
				{
				};
				loc12 = 0;
				while (loc12 < loc11.length) 
				{
					loc1 = flash.utils.getDefinitionByName(loc11[loc12]) as Class;
					loc2 = new loc1();
					com.madebyplay.CU3ER.model.FontsData.FONT_LIST.push({"name":loc2.fontName, "exportName":loc11[loc12], "swf":loc5[loc9].@url});
					flash.text.Font.registerFont(loc1);
					++loc12;
				}
				++loc9;
			}
			this.dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_FONTS_COMPLETE));
			return;
		}

		public function preloadStartSlide(arg1:Array):void
		{
			this._slideList = arg1;
			this._totalSlides = this._slideList.length;
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.start_slide) != "") 
			{
				this._currSlideNo = (Number(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.start_slide) - 1);
			}
			var loc1:*=this._slideList[this._currSlideNo].url;
			this._startSlideId = loc1;
			this._processedSlides[this._currSlideNo] = 1;
			this._folderImages = com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.folder_images + "/";
			this._loader.addEventListener(br.com.stimuli.loading.BulkLoader.ERROR, this._onLoadError);
			if (this._slideList[this._currSlideNo].url != null) 
			{
				if (this._isAdmin) 
				{
					if (String(this._slideList[this._currSlideNo].url).indexOf("http://") == -1 && String(this._slideList[this._currSlideNo].url).indexOf("https://") == -1) 
					{
						this._loader.add(com.madebyplay.CU3ER.model.GlobalVars.LOAD_PREFIX + this._fileFolder + "images/" + this._slideList[this._currSlideNo].url, {"id":"slide_" + this._currSlideNo, "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
					}
					else 
					{
						this._loader.add(this._slideList[this._currSlideNo].url, {"id":"slide_" + this._currSlideNo, "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
					}
				}
				else if (String(this._slideList[this._currSlideNo].url).indexOf("http://") == -1 && String(this._slideList[this._currSlideNo].url).indexOf("https://") == -1) 
				{
					this._loader.add(com.madebyplay.CU3ER.model.GlobalVars.LOAD_PREFIX + this._fileFolder + this._folderImages + this._slideList[this._currSlideNo].url, {"id":"slide_" + this._currSlideNo, "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
				}
				else 
				{
					this._loader.add(this._slideList[this._currSlideNo].url, {"id":"slide_" + this._currSlideNo, "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
				}
				this._loader.get("slide_" + this._currSlideNo).addEventListener(flash.events.ProgressEvent.PROGRESS, this._onProgress, false, 0, true);
				this._loader.get("slide_" + this._currSlideNo).addEventListener(flash.events.Event.COMPLETE, this._onCompleteFirstSlide, false, 0, true);
				this._loader.get("slide_" + this._currSlideNo).addEventListener(br.com.stimuli.loading.BulkLoader.ERROR, this._onFirstSlideLoadError);
				this._loader.start();
			}
			else 
			{
				this._onCompleteFirstSlide();
			}
			var loc2:*=new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_START);
			loc2.slideId = "slide_" + this._currSlideNo;
			this.dispatchEvent(loc2);
			return;
		}

		internal function _onLoadError(arg1:flash.events.Event):void
		{
			this.preloadNextSlide();
			return;
		}

		internal function _onFirstSlideLoadError(arg1:flash.events.ErrorEvent):void
		{
			var loc1:*=arg1.target as br.com.stimuli.loading.loadingtypes.LoadingItem;
			var loc2:*=loc1.id;
			if (this.isLoadFailed(loc2)) 
			{
				return;
			}
			this._loader.remove(loc2);
			this._loadedFailSlides = this._loadedFailSlides + (loc2 + "---");
			this._onCompleteFirstSlide();
			return;
		}

		internal function _onCompleteFirstSlide(arg1:flash.events.Event=null):void
		{
			var loc1:*=this._loader.get(this._startSlideId);
			if (loc1 != null) 
			{
				loc1.removeEventListener(flash.events.Event.COMPLETE, this._onCompleteFirstSlide);
				loc1.removeEventListener(flash.events.ProgressEvent.PROGRESS, this._onProgress);
				loc1.addEventListener(br.com.stimuli.loading.BulkLoader.ERROR, this._onFirstSlideLoadError);
			}
			this.dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_FIRST_SLIDE_COMPLETE, this._startSlideId));
			this.dispatchEvent(new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, this._startSlideId));
			this._loadedSlides = this._loadedSlides + (this._startSlideId + ",");
			var loc2:*;
			var loc3:*=((loc2 = this)._totalSlidesLoaded + 1);
			loc2._totalSlidesLoaded = loc3;
			this.preloadNextSlide();
			return;
		}

		public function preloadNextSlide():void
		{
			var loc1:*=null;
			var loc3:*=undefined;
			var loc4:*=null;
			var loc2:*=0;
			var loc5:*=0;
			var loc6:*=this._processedSlides;
			for (loc3 in loc6) 
			{
				++loc2;
			}
			if (loc2 < this._totalSlides) 
			{
				while (this._currSlideNo in this._processedSlides) 
				{
					if (this._currDirection == 1) 
					{
						loc6 = ((loc5 = this)._currSlideNo + 1);
						loc5._currSlideNo = loc6;
						if (this._currSlideNo == this._totalSlides) 
						{
							this._currSlideNo = 0;
						}
						continue;
					}
					loc6 = ((loc5 = this)._currSlideNo - 1);
					loc5._currSlideNo = loc6;
					if (!(this._currSlideNo < 0)) 
					{
						continue;
					}
					this._currSlideNo = (this._totalSlides - 1);
				}
				if (this._slideList[this._currSlideNo].url != null) 
				{
					loc1 = this._slideList[this._currSlideNo].url;
					this._processedSlides[this._currSlideNo] = 1;
					if (this._isAdmin) 
					{
						if (String(this._slideList[this._currSlideNo].url).indexOf("http://") == -1 && String(this._slideList[this._currSlideNo].url).indexOf("https://") == -1) 
						{
							this._loader.add(com.madebyplay.CU3ER.model.GlobalVars.LOAD_PREFIX + this._fileFolder + "images/" + this._slideList[this._currSlideNo].url, {"id":"slide_" + this._currSlideNo, "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
						}
						else 
						{
							this._loader.add(this._slideList[this._currSlideNo].url, {"id":"slide_" + this._currSlideNo, "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
						}
					}
					else if (String(this._slideList[this._currSlideNo].url).indexOf("http://") == -1 && String(this._slideList[this._currSlideNo].url).indexOf("https://") == -1) 
					{
						this._loader.add(com.madebyplay.CU3ER.model.GlobalVars.LOAD_PREFIX + this._fileFolder + this._folderImages + this._slideList[this._currSlideNo].url, {"id":"slide_" + this._currSlideNo, "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
					}
					else 
					{
						this._loader.add(this._slideList[this._currSlideNo].url, {"id":"slide_" + this._currSlideNo, "context":this._context, "type":br.com.stimuli.loading.BulkLoader.TYPE_IMAGE});
					}
					this._loader.get("slide_" + this._currSlideNo).addEventListener(flash.events.Event.COMPLETE, this._onCompleteSlide, false, 0, true);
					this._loader.get("slide_" + this._currSlideNo).addEventListener(flash.events.ProgressEvent.PROGRESS, this._onProgress, false, 0, true);
					this._loader.get("slide_" + this._currSlideNo).addEventListener(br.com.stimuli.loading.BulkLoader.ERROR, this._onLoadSlideError);
					this._loader.start();
				}
				else 
				{
					this._processedSlides[this._currSlideNo] = 1;
					this.preloadNextSlide();
				}
				(loc4 = new com.madebyplay.CU3ER.events.PreloadEvent(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_START)).slideNo = this._currSlideNo;
				this.dispatchEvent(loc4);
			}
			else 
			{
				com.greensock.TweenLite.delayedCall(0.1, this._dispatchComplete);
			}
			return;
		}

		internal var _loader:br.com.stimuli.loading.BulkLoader;

		internal var _percentLoaded:Number=0;

		internal var _currSlideNo:Number=0;

		internal var _currDirection:int=1;

		internal var _changeDirection:Boolean=true;

		internal var _slideList:Array;

		internal var _totalSlides:uint;

		internal var _folderImages:String;

		internal var _lastId:String="";

		internal var _startSlideId:String="";

		internal var _headingFont:String;

		internal var _paragraphFont:String;

		internal var _thumbFont:String;

		internal var _loadedSlides:String="";

		internal var _urlXML:String;

		internal var _lastFontId:String="";

		internal var _fileFolder:String="";

		internal var _projectFolder:String="";

		internal var _isAdmin:Boolean=false;

		internal var _loadedFailSlides:String="";

		internal var _forceLoadedSlides:Object;

		internal var _processedSlides:Object;

		internal var _isCompleteDispatched:Boolean=false;

		internal var _context:flash.system.LoaderContext;

		internal var _totalSlidesLoaded:uint=0;

		internal static var instance:com.madebyplay.CU3ER.controller.PreloadControllerPlayer;
	}
}


