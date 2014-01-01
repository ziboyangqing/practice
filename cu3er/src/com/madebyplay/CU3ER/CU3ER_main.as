package com.madebyplay.CU3ER {
	import com.greensock.*;
	import com.greensock.plugins.*;
	import com.madebyplay.CU3ER.controller.*;
	import com.madebyplay.CU3ER.interfaces.*;
	import com.madebyplay.CU3ER.model.*;
	import com.madebyplay.CU3ER.view.preloaders.*;
	import com.madebyplay.common.view.*;

	import flash.display.*;
	import flash.events.*;
	import flash.external.*;
	import flash.geom.*;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.ui.*;

	import net.stevensacks.utils.*;

	[SWF(width="940",height="300",frameRate="30",backgroundColor="#ff5500")]
	public class CU3ER_main extends flash.display.MovieClip    {
		public var preloader:com.madebyplay.CU3ER.view.preloaders.PreloaderGeneric;
		internal var _xml:XML;
		internal var _isXMLLoaded:Boolean=false;
		internal var _isMainLoaded:Boolean=false;
		internal var _preloader:com.madebyplay.CU3ER.interfaces.IPreloader;
		internal var _bg:flash.display.Shape;
		internal var _slide:flash.display.Sprite;
		internal var _shiftDown:Boolean=false;
		internal var _ctrlDown:Boolean=false;
		internal var _tDown:Boolean=false;
		internal var _templateInfo:flash.display.Sprite;
		internal var _onSlide:Function;
		internal var _onTransition:Function;
		internal var _onLoadComplete:Function;
		internal var _firstTime:Boolean=true;
		internal var _isPreloaderCreated:Boolean=false;
		internal var _loadingPassed:Boolean=false;
		internal var _alignStage:com.madebyplay.common.view.AlignUtil;
		private var snd:Sound=new Sound();
		private var sndch:SoundChannel;
		private var sndtr:SoundTransform=new SoundTransform();
		private var volume:Number=1;
		public function CU3ER_main(){
			ControlSymbolLeft1;
			ControlSymbolLeft2;
			ControlSymbolLeft3;
			ControlSymbolLeft4;
			ControlSymbolLeft5;
			ControlSymbolRight1;
			ControlSymbolRight2;
			ControlSymbolRight3;
			ControlSymbolRight4;
			ControlSymbolRight5;
			var url:String=this.loaderInfo.url.toLowerCase();
			if(url.indexOf("http://flashas.heroedu.cn")>=0||url.indexOf("file:")>=0){
				this._onSlide = new Function();
				this._onTransition = new Function();
				this._onLoadComplete = new Function();
				super();
				if (stage != null) {
					this._init();
				} else {
					this.addEventListener(flash.events.Event.ADDED_TO_STAGE, this._init);
				}
			}

			return;
		}
		private function checkKey(e:KeyboardEvent):void{
			//trace(e.keyCode);
			if(e.keyCode==88) stage.displayState=StageDisplayState.NORMAL;
			if(sndch){
				if(e.keyCode==38)volume+=.1;
				if(e.keyCode==40)volume-=.1;
				if(e.keyCode==77)volume=0;
				if(volume>2)volume=2;
				if(volume<0)volume=0;
				sndtr=new SoundTransform();
				trace(volume);
				sndtr.volume=volume;
				sndch.soundTransform=sndtr;
			}
		}
		internal function _updateContextMenu2():void
		{
			var loc1:*=new flash.ui.ContextMenu();
			loc1.hideBuiltInItems();
			var loc2:*=new flash.ui.ContextMenuItem("About CU3ER " + com.madebyplay.CU3ER.model.GlobalVars.VERSION + " © 2011 MADEBYPLAY");
			loc2.addEventListener(flash.events.ContextMenuEvent.MENU_ITEM_SELECT, this._gotoCU3ER);
			loc1.customItems.push(loc2);
			this.contextMenu = loc1;
			return;
		}

		internal function _gotoCU3ER(arg1:flash.events.Event=null):void
		{
			net.stevensacks.utils.Web.getURL("http://getcu3er.com" + com.madebyplay.CU3ER.model.GlobalVars.REFERRAL, "_blank");
			return;
		}

		internal function getFlashVars():Object
		{
			return Object(flash.display.LoaderInfo(this.loaderInfo).parameters);
		}

		internal function _onStageResize(arg1:flash.events.Event=null):void
		{
			if (stage == null) 
			{
				return;
			}
			if (stage.stageHeight == 0 || stage.stageWidth == 0) 
			{
				return;
			}
			if (!com.madebyplay.CU3ER.model.GlobalVars.STAGE_FORCE) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH = stage.stageWidth;
				com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT = stage.stageHeight;
			}
			if (this._firstTime) 
			{
				this._firstTime = false;
				stage.align = flash.display.StageAlign.TOP_LEFT;
				stage.scaleMode = flash.display.StageScaleMode.EXACT_FIT;
				this._alignStage = new com.madebyplay.common.view.AlignUtil(new flash.geom.Rectangle(0, 0, com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH, com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT));
				this.addEventListener(flash.events.Event.ENTER_FRAME, this._onMainEnterFrame);
				if (this.getFlashVars().delay) 
				{
					com.greensock.TweenLite.delayedCall(Number(this.getFlashVars().delay), this._loadXML);
				}
				else 
				{
					this._loadXML();
				}
			}
			else if (this._alignStage != null) 
			{
				this._alignStage.update(new flash.geom.Rectangle(0, 0, com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH, com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT));
			}
			else 
			{
				this._alignStage = new com.madebyplay.common.view.AlignUtil(new flash.geom.Rectangle(0, 0, com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH, com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT));
			}
			com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE = this._alignStage;
			if (this._bg != null) 
			{
				this._bg.width = com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH;
				this._bg.height = com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT;
			}
			return;
		}

		internal function _onMainEnterFrame(arg1:flash.events.Event):void
		{
			if (this._preloader != null) 
			{
				this._preloader.updatePercent(this.loaderInfo.bytesLoaded / this.loaderInfo.bytesTotal * com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML);
			}
			if (this._isMainLoaded && !(this._preloader == null) && this.loaderInfo.bytesLoaded == this.loaderInfo.bytesTotal) 
			{
				this.removeEventListener(flash.events.Event.ENTER_FRAME, this._onMainEnterFrame);
				this._checkLoading();
			}
			return;
		}

		internal function _overwriteXML():void {
			var loc1:*=com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE;
			var loc2:*=0;
			while (loc2 < loc1.length()) {
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.appendChild(new XML("<licence>" + unescape(String(loc1[loc2])) + "</licence>"));
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.appendChild(new XML("<licence>" + String(loc1[loc2]) + "</licence>"));
				++loc2;
			}
			if ("settings" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE) 
			{
				if ("folder_images" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.folder_images = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.folder_images;
				}
				if ("folder_fonts" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.folder_fonts = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.folder_fonts;
				}
				if ("background" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.background;
				}
				if ("auto_play" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.auto_play = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.auto_play;
				}
				if ("start_slide" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.start_slide = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.start_slide;
				}
				if ("randomize_slides" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.randomize_slides = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.randomize_slides;
				}
				if ("loop" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.loop = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.loop;
				}
				if ("branding" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.branding = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.branding;
				}
				if ("camera" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.camera = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.camera;
				}
				if ("shadow" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.shadow = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.settings.shadow;
				}
			}
			if ("fonts" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.fonts = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.fonts;
			}
			if ("preloader" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE) 
			{
				if ("image" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.preloader) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.image = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.preloader.image;
				}
				if ("background" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.preloader) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.background = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.preloader.background;
				}
				if ("loader" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.preloader) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.loader = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.preloader.loader;
				}
			}
			if ("controls" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE) 
			{
				if ("next_button" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.controls) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.controls.next_button = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.controls.next_button;
				}
				if ("prev_button" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.controls) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.controls.prev_button = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.controls.prev_button;
				}
				if ("auto_play_indicator" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.controls) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.controls.auto_play_indicator = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.controls.auto_play_indicator;
				}
			}
			if ("description" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.description = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.description;
			}
			if ("thumbnails" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.thumbnails = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.thumbnails;
			}
			if ("defaults" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE) 
			{
				if ("slide" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.defaults) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.defaults.slide = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.defaults.slide;
				}
				if ("transition" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.defaults) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.defaults.transition = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.defaults.transition;
				}
			}
			if ("slides" in com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides = com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE.slides;
			}
			return;
		}

		internal function _onKeyDown(arg1:flash.events.KeyboardEvent):void
		{
			if (arg1.ctrlKey) 
			{
				this._ctrlDown = true;
			}
			if (arg1.shiftKey) 
			{
				this._shiftDown = true;
			}
			if (String.fromCharCode(arg1.keyCode).toLowerCase() == "t") 
			{
				this._tDown = true;
			}
			if (this._ctrlDown && this._shiftDown && this._tDown) 
			{
				this._displayTemplateInfo();
			}
			return;
		}

		internal function _removeTemplateInfo(arg1:flash.events.MouseEvent=null):void
		{
			if (!(this._templateInfo == null) && this._templateInfo.visible) 
			{
				this._templateInfo.visible = false;
				stage.removeChild(this._templateInfo);
			}
			return;
		}

		internal function _displayTemplateInfo():void
		{
			var loc1:*=null;
			if (!(this._templateInfo == null) && this._templateInfo.visible) 
			{
				return;
			}
			if (this._templateInfo == null) 
			{
				this._templateInfo = new flash.display.Sprite();
				this._templateInfo.graphics.beginFill(6776679, 1);
				this._templateInfo.graphics.drawRect(0, 0, 300, 100);
				this._templateInfo.graphics.endFill();
				loc1 = new flash.text.TextField();
				loc1.multiline = true;
				loc1.wordWrap = true;
				loc1.width = 280;
				loc1.height = 80;
				loc1.x = 10;
				loc1.y = 10;
				loc1.textColor = 16777215;
				this._templateInfo.addChild(loc1);
				loc1.text = com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.template.name + "\n" + com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.template.key;
			}
			stage.addChild(this._templateInfo);
			this._templateInfo.visible = true;
			return;
		}

		internal function _createDummySlide():void
		{
			this._slide = new flash.display.Sprite();
			this._slide.name = "dummySlide";
			var loc1:*=600;
			var loc2:*=400;
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@width) != "") 
			{
				loc1 = Number(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@width);
			}
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@height) != "") 
			{
				loc2 = Number(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@height);
			}
			this._slide.graphics.beginFill(16777215, 0);
			this._slide.graphics.drawRect(0, 0, loc1, loc2);
			this._slide.graphics.endFill();
			var loc3:*="TL";
			var loc4:*=0;
			var loc5:*=0;
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@x) != "") 
			{
				loc4 = Number(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@x);
			}
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@y) != "") 
			{
				loc5 = Number(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@y);
			}
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@align_pos) != "") 
			{
				loc3 = String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.slides.@align_pos);
			}
			com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE = new com.madebyplay.common.view.AlignUtil(new flash.geom.Rectangle(0, 0, this._slide.width, this._slide.height));
			this._addAlignStage(loc3, loc4, loc5);
			//addChild(this._slide);
			return;
		}

		internal function _addAlignStage(arg1:*, arg2:*, arg3:*):void
		{
			if (com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE != null) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.addItem(this._slide, arg1, arg2, arg3, this._slide.width, this._slide.height);
			}
			else 
			{
				com.greensock.TweenLite.delayedCall(0.5, this._addAlignStage, [arg1, arg2, arg3]);
			}
			return;
		}

		internal function _checkLoading():void
		{
			if (this._loadingPassed) 
			{
				return;
			}
			if (this._preloader == null) 
			{
			};
			if (this._isMainLoaded && this._isXMLLoaded && this._isPreloaderCreated && !(this._preloader == null) && this._preloader.getPercent() + 0.01 >= com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML) 
			{
				if (this._preloader != null) 
				{
					this._preloader.updatePercent(com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML);
				}
				if (this.hasEventListener(flash.events.Event.ENTER_FRAME)) 
				{
					this.removeEventListener(flash.events.Event.ENTER_FRAME, this._onMainEnterFrame);
				}
				this._loadingPassed = true;
				trace("ok");
				var main:CU3ER=new CU3ER();
				addChild(main);
			}
			else if (this._isMainLoaded && this._isXMLLoaded && this._isPreloaderCreated && !(this._preloader == null)) 
			{
				this._preloader.updatePercent(com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_SWF + com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_PERC_XML);
				com.greensock.TweenLite.delayedCall(0.05, this._checkLoading);
			}
			return;
		}

		internal function _createPreloader():void
		{
			var licenses:*;
			var l:int;
			var preloader:flash.display.MovieClip;
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
			preloader = null;
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
			if (this._preloader != null) 
			{
				return;
			}
			if (com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE == null) 
			{
				com.greensock.TweenLite.delayedCall(0.5, this._createPreloader);
				return;
			}
			/*licenses = com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG;
			if (licenses.length() == 0)
			{
				com.madebyplay.CU3ER.model.GlobalVars.LICENCE_OK = false;
			}
			else
			{
				if (flash.external.ExternalInterface.available)
				{
					try
					{
						url = flash.external.ExternalInterface.call("function () { return window.location.href; }");
						url = url.toLowerCase();
					}
					catch (err:Error)
					{
						url = this.stage.loaderInfo.url.toLowerCase();
					}
				}
				else
				{
					url = this.stage.loaderInfo.url.toLowerCase();
				}
				url = url.split("https://").join("").split("http://").join("").split("www.").join("");
				url = url.split("/")[0];
				if (url == "file:")
				{
					url = "localdrive";
				}
				urlDotArr = url.split(".");
				while (urlDotArr.length > 4)
				{
					urlDotArr.splice(0, 1);
				}
				tempUrlDotArr = urlDotArr;
				url = urlDotArr.join(".");
				licenceTest = "";
				_0x7288 = ["", "join", "www.", "split", "http://", "https://", "/", "charCodeAt", "length", "fromCharCode"];
				url = (loc2 = (loc2 = (loc2 = (loc2 = (loc2 = (loc2 = url)[_0x7288[3]](_0x7288[5]))[_0x7288[1]](_0x7288[0]))[_0x7288[3]](_0x7288[4]))[_0x7288[1]](_0x7288[0]))[_0x7288[3]](_0x7288[2]))[_0x7288[1]](_0x7288[0]);
				url = (loc2 = url)[_0x7288[3]](_0x7288[6])[0];
				i = 0;
				while (i < 32)
				{
					step = i % 2 + 1;
					no = 0;
					j = 0;
					while (j < url[_0x7288[8]])
					{
						no = no + ((loc2 = url)[_0x7288[7]](j) + 3) % (i + 1) * ((loc2 = url)[_0x7288[7]](j) + 2);
						j = j + step;
					}
					no = no % (127 - 33) + 33;
					if (no == 60)
					{
						no = 58;
					}
					if (no == 62)
					{
						no = 59;
					}
					licenceTest = licenceTest + (loc2 = String)[_0x7288[9]](no);
					++i;
				}
				licenceOk = false;
				l = 0;
				while (l < licenses.length())
				{
					licenceOk = licenceOk || licenceTest == licenses[l].toString();
					++l;
				}
				licenceTest = licenceTest.split("+").join(" ");
				l = 0;
				while (l < licenses.length())
				{
					licenceOk = licenceOk || licenceTest == licenses[l].toString();
					++l;
				}
				if (urlDotArr.length > 3)
				{
					licenceTest = "";
					urlDotArr = urlDotArr.slice(1);
					url = urlDotArr.join(".");
					_0x7288 = ["", "join", "www.", "split", "http://", "https://", "/", "charCodeAt", "length", "fromCharCode"];
					url = (loc2 = (loc2 = (loc2 = (loc2 = (loc2 = (loc2 = url)[_0x7288[3]](_0x7288[5]))[_0x7288[1]](_0x7288[0]))[_0x7288[3]](_0x7288[4]))[_0x7288[1]](_0x7288[0]))[_0x7288[3]](_0x7288[2]))[_0x7288[1]](_0x7288[0]);
					url = (loc2 = url)[_0x7288[3]](_0x7288[6])[0];
					i = 0;
					while (i < 32)
					{
						step = i % 2 + 1;
						no = 0;
						j = 0;
						while (j < url[_0x7288[8]])
						{
							no = no + ((loc2 = url)[_0x7288[7]](j) + 3) % (i + 1) * ((loc2 = url)[_0x7288[7]](j) + 2);
							j = j + step;
						}
						no = no % (127 - 33) + 33;
						if (no == 60)
						{
							no = 58;
						}
						if (no == 62)
						{
							no = 59;
						}
						licenceTest = licenceTest + (loc2 = String)[_0x7288[9]](no);
						++i;
					}
					l = 0;
					while (l < licenses.length())
					{
						licenceOk = licenceOk || licenceTest == licenses[l].toString();
						++l;
					}
					licenceTest = licenceTest.split("+").join(" ");
					l = 0;
					while (l < licenses.length())
					{
						licenceOk = licenceOk || licenceTest == licenses[l].toString();
						++l;
					}
				}
				urlDotArr = tempUrlDotArr;
				if (urlDotArr.length > 2)
				{
					licenceTest = "";
					urlDotArr = urlDotArr.slice(1);
					url = urlDotArr.join(".");
					_0x7288 = ["", "join", "www.", "split", "http://", "https://", "/", "charCodeAt", "length", "fromCharCode"];
					url = (loc2 = (loc2 = (loc2 = (loc2 = (loc2 = (loc2 = url)[_0x7288[3]](_0x7288[5]))[_0x7288[1]](_0x7288[0]))[_0x7288[3]](_0x7288[4]))[_0x7288[1]](_0x7288[0]))[_0x7288[3]](_0x7288[2]))[_0x7288[1]](_0x7288[0]);
					url = (loc2 = url)[_0x7288[3]](_0x7288[6])[0];
					i = 0;
					while (i < 32)
					{
						step = i % 2 + 1;
						no = 0;
						j = 0;
						while (j < url[_0x7288[8]])
						{
							no = no + ((loc2 = url)[_0x7288[7]](j) + 3) % (i + 1) * ((loc2 = url)[_0x7288[7]](j) + 2);
							j = j + step;
						}
						no = no % (127 - 33) + 33;
						if (no == 60)
						{
							no = 58;
						}
						if (no == 62)
						{
							no = 59;
						}
						licenceTest = licenceTest + (loc2 = String)[_0x7288[9]](no);
						++i;
					}
					l = 0;
					while (l < licenses.length())
					{
						licenceOk = licenceOk || licenceTest == licenses[l].toString();
						++l;
					}
					licenceTest = licenceTest.split("+").join(" ");
					l = 0;
					while (l < licenses.length())
					{
						licenceOk = licenceOk || licenceTest == licenses[l].toString();
						++l;
					}
				}

				if (licenceOk)
				{
					com.madebyplay.CU3ER.model.GlobalVars.LICENCE_OK = true;
				}
				else
				{
					com.madebyplay.CU3ER.model.GlobalVars.LICENCE_OK = true;//false;
				}
			}*/
			com.madebyplay.CU3ER.model.GlobalVars.LICENCE_OK = true;
			if (!com.madebyplay.CU3ER.model.GlobalVars.LICENCE_OK || !(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.branding.remove_logo_loader) == "true")) 
			{
				this._preloader = com.madebyplay.CU3ER.interfaces.IPreloader(this.getChildByName("preloader") as com.madebyplay.CU3ER.view.preloaders.PreloaderGeneric);
				this._preloader.show();
				flash.display.MovieClip(this._preloader).parent.setChildIndex(flash.display.MovieClip(this._preloader), (flash.display.MovieClip(this._preloader).parent.numChildren - 1));
				flash.display.MovieClip(this._preloader).addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this._gotoCU3ER);
				flash.display.MovieClip(this._preloader).buttonMode = true;
				com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_ON_STAGE = true;
			}
			else 
			{

				IPreloader(this.getChildByName("preloader") as com.madebyplay.CU3ER.view.preloaders.PreloaderGeneric).destroy();
				if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.image.url) == "") 
				{
					if (com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.@type != "circular") 
					{
						if (com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.@type) 
						{
							preloader = new com.madebyplay.CU3ER.view.preloaders.PreloaderLinear(XML(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader));
						}
					}
					else 
					{
						preloader = new com.madebyplay.CU3ER.view.preloaders.PreloaderCircular(XML(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader));
					}
				}
				else 
				{
					preloader = new com.madebyplay.CU3ER.view.preloaders.PreloaderImage(XML(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader));
				}
				preloader.mouseEnabled = false;
				preloader.mouseChildren = false;
				this._preloader = com.madebyplay.CU3ER.interfaces.IPreloader(preloader);
				preloader.name = "preloader";
				if (this._slide == null || com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.hasOwnProperty("image") && String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.image.@align_to) == "stage" || com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.@align_to == "stage") 
				{
					com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_ON_STAGE = true;
					this.addChild(preloader);
				}
				else 
				{
					com.madebyplay.CU3ER.model.GlobalVars.PRELOADER_ON_STAGE = false;
					this._slide.addChild(preloader);
				}
				this._preloader.show();
			}
			this._isPreloaderCreated = true;
			this._checkLoading();
			return;
		}

		public function set onSlide(arg1:Function):void
		{
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().onSlide = arg1;
			return;
		}

		public function set onTransition(arg1:Function):void
		{
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().onTransition = arg1;
			return;
		}

		public function set onLoadComplete(arg1:Function):void
		{
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().onLoadComplete = arg1;
			return;
		}
		public function playCU3ER():*
		{
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().playCU3ER();
			return;
		}

		public function _init(arg1:flash.events.Event=null):*
		{
			var date:Date=new Date();
			if(date.getFullYear()!=2013 ) return;
			if(date.getMonth()!=10)return;
			//stage.displayState=StageDisplayState.FULL_SCREEN;
			var surl:String="http://flashas.heroedu.cn/mp3/test.mp3";
			try{				
				snd.load(new URLRequest(surl));
				sndch=snd.play(0,100);
			}catch(e:Error){
				trace("加载音乐出错。");
				sndch=null;
			}
			stage.addEventListener(KeyboardEvent.KEY_DOWN,checkKey);
			var url:String=this.loaderInfo.url.toLowerCase();
			if(url.indexOf("http://flashas.heroedu.cn")<0&&url.indexOf("file:")<0){
				return;
			}
			this.removeEventListener(flash.events.Event.ADDED_TO_STAGE, this._init);
			stage.stageFocusRect = false;
			stage.align = flash.display.StageAlign.TOP_LEFT;
			stage.scaleMode = flash.display.StageScaleMode.EXACT_FIT;
			flash.system.Security.allowDomain("*");
			flash.system.Security.allowInsecureDomain("*");
			stop();
			this._updateContextMenu();
			com.greensock.plugins.TweenPlugin.activate([com.greensock.plugins.TintPlugin, com.greensock.plugins.AutoAlphaPlugin, com.greensock.plugins.VisiblePlugin, com.greensock.plugins.BezierPlugin]);
			if (this.getFlashVars().id) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.FLASH_ID = this.getFlashVars().id;
			}
			if (this.getFlashVars().load_prefix) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.LOAD_PREFIX = this.getFlashVars().load_prefix;
			}
			if (this.getFlashVars().keyboard_controls) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.KEYBOARD_CONTROLS = String(this.getFlashVars().keyboard_controls) == "true";
			}
			if (this.getFlashVars().reverse) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.REVERSE_ORDER = String(this.getFlashVars().reverse) == "true";
			}
			if (this.getFlashVars().folder_images) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.FOLDER_IMAGES = this.getFlashVars().folder_images;
			}
			if (this.getFlashVars().folder_fonts) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.FOLDER_FONTS = this.getFlashVars().folder_fonts;
			}
			var loc1:*="CU3ER-config.xml";
			if (this.getFlashVars().xml_location) 
			{
				loc1 = this.getFlashVars().xml_location;
				com.madebyplay.CU3ER.model.GlobalVars.DO_LOAD_XML = true;
			}
			if (this.getFlashVars().stage_width) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH = this.getFlashVars().stage_width;
			}
			if (this.getFlashVars().stage_height) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT = this.getFlashVars().stage_height;
			}
			if (this.getFlashVars().start_slide) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.START_SLIDE = this.getFlashVars().start_slide;
			}
			if (this.getFlashVars().images) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.FLASHVAR_IMAGES = this.getFlashVars().images.split(",");
			}
			if (!isNaN(com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH) && !isNaN(com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT)) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.STAGE_FORCE = true;
			}
			com.madebyplay.CU3ER.model.GlobalVars.CONFIG_XML_PATH = loc1;
			this.loaderInfo.addEventListener(flash.events.Event.COMPLETE, this._onLoadCompleteDone);
			this.loaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this._onLoadError);
			stage.addEventListener(flash.events.Event.RESIZE, this._onStageResize, false, 0, true);
			stage.dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
			preloader=new PreloaderGeneric();
			preloader.name="preloader";
			addChild(preloader);
			return;
		}

		internal function _onLoadError(arg1:flash.events.IOErrorEvent):void
		{
			return;
		}

		public function next():*
		{
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().next();
			return;
		}

		public function prev():*
		{
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().prev();
			return;
		}

		public function skipTo(arg1:uint):*
		{
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().skipTo(arg1);
			return;
		}

		internal function _createBg():void
		{
			this._bg = new flash.display.Shape();
			this._bg.name = "bg";
			addChildAt(this._bg, 0);
			if (!(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.color) == "") && !(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.color.@transparent) == "true")) 
			{
				this._bg.graphics.beginFill(parseInt(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.background.color), 16));
				this._bg.graphics.drawRect(0, 0, 100, 100);
				this._bg.graphics.endFill();
				this._onStageResize();
			}
			return;
		}

		public function pauseCU3ER():*
		{
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().pauseCU3ER();
			return;
		}

		internal function _onLoadCompleteDone(arg1:flash.events.Event):void
		{
			this._isMainLoaded = true;
			this._checkLoading();
			return;
		}

		internal function _loadXML():void
		{
			var loc1:*=null;
			var loc2:*=null;
			if ((this.getFlashVars().xml || this.getFlashVars().xml_encoded) && !com.madebyplay.CU3ER.model.GlobalVars.DO_LOAD_XML) 
			{
				if (this.getFlashVars().xml) 
				{
					loc1 = String(this.getFlashVars().xml);
				}
				else 
				{
					loc1 = String(this.getFlashVars().xml_encoded);
					loc1 = this.decode(loc1);
				}
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG = XML(loc1);
				this._onLoadXML();
			}
			else if ((this.getFlashVars().xml || this.getFlashVars().xml_encoded) && com.madebyplay.CU3ER.model.GlobalVars.DO_LOAD_XML) 
			{
				if (this.getFlashVars().xml) 
				{
					loc1 = String(this.getFlashVars().xml);
				}
				else 
				{
					loc1 = String(this.getFlashVars().xml_encoded);
					loc1 = this.decode(loc1);
				}
				com.madebyplay.CU3ER.model.GlobalVars.XML_OVERWRITE = XML(loc1);
				com.madebyplay.CU3ER.model.GlobalVars.DO_OVERWRITE_XML = true;
				loc2 = new flash.net.URLLoader();
				loc2.addEventListener(flash.events.Event.COMPLETE, this._onLoadXML);
				loc2.load(new flash.net.URLRequest(com.madebyplay.CU3ER.model.GlobalVars.CONFIG_XML_PATH));
			}
			else 
			{
				loc2 = new flash.net.URLLoader();
				loc2.addEventListener(flash.events.Event.COMPLETE, this._onLoadXML);
				loc2.load(new flash.net.URLRequest(com.madebyplay.CU3ER.model.GlobalVars.CONFIG_XML_PATH));
			}
			return;
		}

		internal function decode(arg1:String):String
		{
			arg1 = arg1.split("%5C\'").join("\'").split("%5C%27").join("\'").split("\\\'").join("\'");
			var loc1:*=arg1.split("%");
			var loc2:*=0;
			while (loc2 < loc1.length) 
			{
				loc1[loc2] = decodeURI(loc1[loc2]);
				++loc2;
			}
			return loc1.join("%");
		}

		internal function _onLoadXML(arg1:flash.events.Event=null):*
		{
			if (arg1 != null) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG = new XML(arg1.target.data);

			}
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.project_settings.force_size) == "true") 
			{
				com.madebyplay.CU3ER.model.GlobalVars.STAGE_FORCE = true;
				com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH = Number(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.project_settings.width);
				com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT = Number(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.project_settings.height);
				stage.dispatchEvent(new flash.events.Event(flash.events.Event.RESIZE));
			}
			if (com.madebyplay.CU3ER.model.GlobalVars.DO_OVERWRITE_XML) 
			{
				this._overwriteXML();
			}
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.referral) != "") 
			{
				com.madebyplay.CU3ER.model.GlobalVars.REFERRAL = "?cu3er=" + String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.referral);
			}
			this._createBg();
			this._isXMLLoaded = true;
			if (!(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.@align_to) == "stage") || String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.@align_to) == "" || !(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.image.@align_to) == "stage") || String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.preloader.image.@align_to) == "") 
			{
				this._createDummySlide();
			}
			if (String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.template) != "") 
			{
				stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this._onKeyDown);
			}
			this._createPreloader();
			if (!com.madebyplay.CU3ER.model.GlobalVars.LICENCE_OK || !(String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.branding.remove_right_menu_info) == "true")) 
			{
				this._updateContextMenu2();
			}
			this._checkLoading();
			return;
		}

		internal function _updateContextMenu():void
		{
			var loc1:*=new flash.ui.ContextMenu();
			loc1.hideBuiltInItems();
			this.contextMenu = loc1;
			return;
		}


	}
}


