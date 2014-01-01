package com.madebyplay.CU3ER.controller 
{
	import com.greensock.*;
	//import com.greensock.layout.*;
	import com.madebyplay.CU3ER.events.*;
	import com.madebyplay.CU3ER.model.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	public class Thumb extends flash.events.EventDispatcher
	{
		public function Thumb(arg1:com.madebyplay.CU3ER.controller.Thumbnails, arg2:flash.display.MovieClip, arg3:com.madebyplay.CU3ER.model.ThumbsData, arg4:Number)
		{
			super();
			this._thumbnails = arg1;
			this._holder = arg2;
			this._data = arg3;
			this._slide = this._thumbnails.player.data.slides[arg4];
			this._no = arg4;
			this._id = "slide_" + arg4;
			this._view = new flash.display.MovieClip();
			this._holder.addChild(this._view);
			this._init();
			return;
		}

		internal function _createBackground():void
		{
			this._bg = new flash.display.Shape();
			this._bg.graphics.beginFill(this._data.backgroundTweens.tweenHide.tint, 1);
			var loc1:*=String(this._data.background.rounded_corners).split(",");
			this._bg.graphics.drawRoundRectComplex(0, 0, this._data.thumbWidth, this._data.thumbHeight, loc1[0], loc1[1], loc1[3], loc1[2]);
			this._bg.graphics.endFill();
			this._bg.alpha = this._data.backgroundTweens.alphaHide;
			this._data.backgroundTweens.tweenHide.visible = true;
			this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._data.backgroundTweens.tweenHide);
			this._view.addChild(this._bg);
			return;
		}

		internal function _onLoadSlideComplete(arg1:com.madebyplay.CU3ER.events.PreloadEvent=null):void
		{
			if (arg1 == null) 
			{
			};
			if (arg1 == null || this._id == arg1.slideId) 
			{
				com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().removeEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, this._onLoadSlideComplete);
				if (!(this._data.image == null) && !(this._slide.url == null)) 
				{
					this._createImage();
				}
				if (this._data.title != null) 
				{
					this._createTitle();
				}
				if (this._no != this._thumbnails.player.currSlideNo) 
				{
					this._view.buttonMode = true;
					this._view.mouseEnabled = true;
					this.deselect();
				}
				else 
				{
					com.greensock.TweenLite.delayedCall(0.3, this.select);
				}
			}
			return;
		}

		internal function _createTitle():void
		{
			var loc3:*=undefined;
			this._title = new flash.display.Sprite();
			this._txtTitle = new flash.text.TextField();
			this._title.x = this._data.title.x;
			this._title.y = this._data.title.y;
			this._txtTitle.width = this._data.title.width;
			this._txtTitle.height = this._data.title.height;
			var loc1:*=new flash.text.TextFormat();
			loc1.font = this._data.title.font;
			loc1.size = this._data.title.text_size;
			loc1.bold = this._data.title.text_bold;
			loc1.italic = this._data.title.text_italic;
			loc1.color = this._data.title.text_color;
			loc1.align = this._data.title.text_align;
			loc1.leading = this._data.title.text_leading;
			loc1.letterSpacing = this._data.title.text_letterSpacing;
			this._txtTitle.defaultTextFormat = loc1;
			this._txtTitle.embedFonts = this._data.title.embed_fonts;
			var loc2:*="";
			if (this._data.title.use_numbering) 
			{
				loc2 = loc2 + (String(this._no + 1) + this._data.title.use_numbering_separator);
			}
			if (this._data.title.use_heading) 
			{
				loc2 = loc2 + ((this._thumbnails.player.data.slides[this._no] as com.madebyplay.CU3ER.model.SlideData).descriptionHeading + " ");
			}
			if (this._data.title.use_caption) 
			{
				loc2 = loc2 + (this._thumbnails.player.data.slides[this._no] as com.madebyplay.CU3ER.model.SlideData).caption;
			}
			this._txtTitle.text = loc2;
			this._txtTitle.wordWrap = true;
			this._txtTitle.selectable = false;
			this._title.addChild(this._txtTitle);
			this._tweenTitle = com.greensock.TweenLite.to(this._title, 0, this._data.titleTweens.tweenHide);
			if (this._thumbnails.player.data.bgTransparent && !this._data.title.embed_fonts && "tint" in this._data.titleTweens.tweenShow) 
			{
				this._txtTitle.textColor = this._data.titleTweens.tweenShow.tint;
			}
			var loc4:*=0;
			var loc5:*=this._data.titleTweens.tweenShow;
			for (loc3 in loc5) 
			{
			};
			this._view.addChild(this._title);
			return;
		}

		internal function _createImage():void
		{
			var loc1:*=null;
			var loc7:*;
			this._image = loc7 = new flash.display.Sprite();
			loc7;
			if (com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().isLoadFailed(this._id)) 
			{
				loc1 = loc7 = this._createEmptyBitmap(this._data.image.width, this._data.image.height);
				loc7;
			}
			else 
			{
				loc1 = loc7 = com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().loader.getBitmapData(this._id).clone();
				loc7;
			}
			var loc2:*=new flash.display.Bitmap(loc1, "auto", true);
			loc2.smoothing = loc7 = true;
			loc7;
			this._image.addChild(loc2);
			this._imageMask = loc7 = new flash.display.Shape();
			loc7;
			this._imageMask.x = loc7 = 0;
			loc7;
			this._imageMask.y = loc7 = 0;
			loc7;
			this._imageMask.graphics.beginFill(16777215, 1);
			var loc3:*=this._data.image.rounded_corners.split(",");
			this._imageMask.graphics.drawRoundRectComplex(0, 0, this._data.image.width, this._data.image.height, loc3[0], loc3[1], loc3[3], loc3[2]);
			this._imageMask.graphics.endFill();
			this._view.addChild(this._image);
			this._view.addChild(this._imageMask);
			this._image.mask = loc7 = this._imageMask;
			loc7;
			var loc4:*=this._imageMask.width / loc2.width;
			var loc5:*=this._imageMask.height / loc2.height;
			var loc6:*=Math.max(loc4, loc5);
			loc2.scaleY = loc7 = loc6;
			loc2.scaleX = loc7 = loc7;
			loc7;
			loc2.x = loc7 = (this._imageMask.width - loc2.width) / 2;
			loc7;
			loc2.y = loc7 = (this._imageMask.height - loc2.height) / 2;
			loc7;
			this._tweenImage = loc7 = com.greensock.TweenLite.to(this._image, 0, this._data.imageTweens.tweenHide);
			loc7;
			this._tweenImageMask = loc7 = com.greensock.TweenLite.to(this._imageMask, 0, this._data.imageMaskTweens.tweenHide);
			loc7;
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
			var loc5:*;
			(loc3 = new flash.display.Bitmap(new no_image_small(0, 0), "auto", true)).x = loc5 = arg1 / 2 - loc3.width / 2;
			loc5;
			loc3.y = loc5 = arg2 / 2 - loc3.height / 2;
			loc5;
			loc2.graphics.beginFill(0, 1);
			loc2.graphics.drawRect(arg1 / 2 - loc3.width / 2, arg2 / 2 - loc3.height / 2, loc3.width, loc3.height);
			loc2.graphics.endFill();
			loc1.addChild(loc3);
			var loc4:*;
			(loc4 = new flash.display.BitmapData(arg1, arg2, false)).draw(loc1);
			return loc4;
		}

		internal function _killTweens():void
		{
			if (this._tweenBg != null) 
			{
				this._tweenBg.kill();
			}
			if (this._tweenImage != null) 
			{
				this._tweenImage.kill();
			}
			if (this._tweenImageMask != null) 
			{
				this._tweenImageMask.kill();
			}
			if (this._tweenTitle != null) 
			{
				this._tweenTitle.kill();
			}
			return;
		}

		internal function _onRollOut(arg1:flash.events.MouseEvent=null):void
		{
			this._killTweens();
			var loc1:*;
			this._data.backgroundTweens.tweenShow.alpha = loc1 = this._data.backgroundTweens.alphaShow;
			loc1;
			this._tweenBg = loc1 = com.greensock.TweenLite.to(this._bg, this._data.backgroundTweens.timeShow, this._data.backgroundTweens.tweenShow);
			loc1;
			if (!(this._image == null) && !(this._data.image == null) && !(this._slide.url == null)) 
			{
				this._data.imageTweens.tweenShow.alpha = loc1 = this._data.imageTweens.alphaShow;
				loc1;
				this._tweenImage = loc1 = com.greensock.TweenLite.to(this._image, this._data.imageTweens.timeShow, this._data.imageTweens.tweenShow);
				loc1;
				this._tweenImageMask = loc1 = com.greensock.TweenLite.to(this._imageMask, this._data.imageMaskTweens.timeShow, this._data.imageMaskTweens.tweenShow);
				loc1;
			}
			if (!(this._title == null) && !(this._data.title == null)) 
			{
				this._data.titleTweens.tweenShow.alpha = loc1 = this._data.titleTweens.alphaShow;
				loc1;
				this._tweenTitle = loc1 = com.greensock.TweenLite.to(this._title, this._data.titleTweens.timeShow, this._data.titleTweens.tweenShow);
				loc1;
				if (this._thumbnails.player.data.bgTransparent && !this._data.title.embed_fonts && "tint" in this._data.titleTweens.tweenShow) 
				{
					this._txtTitle.textColor = loc1 = this._data.titleTweens.tweenShow.tint;
					loc1;
				}
			}
			return;
		}

		internal function _onRollOver(arg1:flash.events.MouseEvent=null):void
		{
			this._killTweens();
			this._view.parent.setChildIndex(this._view, this._view.parent.numChildren - 2);
			var loc1:*;
			this._data.backgroundTweens.tweenOver.alpha = loc1 = this._data.backgroundTweens.alphaOver;
			loc1;
			this._tweenBg = loc1 = com.greensock.TweenLite.to(this._bg, this._data.backgroundTweens.timeOver, this._data.backgroundTweens.tweenOver);
			loc1;
			if (!(this._image == null) && !(this._data.image == null) && !(this._slide.url == null)) 
			{
				this._data.imageTweens.tweenOver.alpha = loc1 = this._data.imageTweens.alphaOver;
				loc1;
				this._tweenImage = loc1 = com.greensock.TweenLite.to(this._image, this._data.imageTweens.timeOver, this._data.imageTweens.tweenOver);
				loc1;
				this._tweenImageMask = loc1 = com.greensock.TweenLite.to(this._imageMask, this._data.imageMaskTweens.timeOver, this._data.imageMaskTweens.tweenOver);
				loc1;
			}
			if (!(this._title == null) && !(this._data.title == null)) 
			{
				this._data.titleTweens.tweenOver.alpha = loc1 = this._data.titleTweens.alphaOver;
				loc1;
				this._tweenTitle = loc1 = com.greensock.TweenLite.to(this._title, this._data.titleTweens.timeOver, this._data.titleTweens.tweenOver);
				loc1;
				if (this._thumbnails.player.data.bgTransparent && !this._data.title.embed_fonts && "tint" in this._data.titleTweens.tweenOver) 
				{
					this._txtTitle.textColor = loc1 = this._data.titleTweens.tweenOver.tint;
					loc1;
				}
			}
			return;
		}

		internal function _skipTo(arg1:flash.events.MouseEvent):void
		{
			if (this._thumbnails.player.currState == com.madebyplay.CU3ER.controller.Player.STATE_FREE) 
			{
				this._thumbnails.player.skipTo(this._no);
			}
			return;
		}

		public function select():void
		{
			this._view.parent.setChildIndex(this._view, (this._view.parent.numChildren - 1));
			if (this._view.hasEventListener(flash.events.MouseEvent.ROLL_OVER)) 
			{
				this._view.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this._onRollOver);
			}
			if (this._view.hasEventListener(flash.events.MouseEvent.ROLL_OUT)) 
			{
				this._view.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this._onRollOut);
			}
			this._killTweens();
			var loc1:*;
			this._view.mouseEnabled = loc1 = false;
			loc1;
			this._view.buttonMode = loc1 = false;
			loc1;
			this._data.backgroundTweens.tweenSelected.alpha = loc1 = this._data.backgroundTweens.alphaSelected;
			loc1;
			this._tweenBg = loc1 = com.greensock.TweenLite.to(this._bg, this._data.backgroundTweens.timeSelected, this._data.backgroundTweens.tweenSelected);
			loc1;
			if (!(this._image == null) && !(this._data.image == null) && !(this._slide.url == null)) 
			{
				this._data.imageTweens.tweenSelected.alpha = loc1 = this._data.imageTweens.alphaSelected;
				loc1;
				this._tweenImage = loc1 = com.greensock.TweenLite.to(this._image, this._data.imageTweens.timeSelected, this._data.imageTweens.tweenSelected);
				loc1;
				this._tweenImageMask = loc1 = com.greensock.TweenLite.to(this._imageMask, this._data.imageMaskTweens.timeSelected, this._data.imageMaskTweens.tweenSelected);
				loc1;
			}
			if (!(this._title == null) && !(this._data.title == null)) 
			{
				this._data.titleTweens.tweenSelected.alpha = loc1 = this._data.titleTweens.alphaSelected;
				loc1;
				this._tweenTitle = loc1 = com.greensock.TweenLite.to(this._title, this._data.titleTweens.timeSelected, this._data.titleTweens.tweenSelected);
				loc1;
				if (this._thumbnails.player.data.bgTransparent && !this._data.title.embed_fonts && "tint" in this._data.titleTweens.tweenSelected) 
				{
					this._txtTitle.textColor = loc1 = this._data.titleTweens.tweenSelected.tint;
					loc1;
				}
			}
			return;
		}

		public function deselect():void
		{
			if (!this._view.hasEventListener(flash.events.MouseEvent.ROLL_OVER)) 
			{
				this._view.addEventListener(flash.events.MouseEvent.ROLL_OVER, this._onRollOver, false, 0, true);
			}
			if (!this._view.hasEventListener(flash.events.MouseEvent.ROLL_OUT)) 
			{
				this._view.addEventListener(flash.events.MouseEvent.ROLL_OUT, this._onRollOut, false, 0, true);
			}
			var loc1:*;
			this._view.buttonMode = loc1 = true;
			loc1;
			this._view.mouseEnabled = loc1 = true;
			loc1;
			this._killTweens();
			this._data.backgroundTweens.tweenShow.alpha = loc1 = this._data.backgroundTweens.alphaShow;
			loc1;
			this._tweenBg = loc1 = com.greensock.TweenLite.to(this._bg, this._data.backgroundTweens.timeShow, this._data.backgroundTweens.tweenShow);
			loc1;
			if (!(this._image == null) && !(this._data.image == null) && !(this._slide.url == null)) 
			{
				this._data.imageTweens.tweenShow.alpha = loc1 = this._data.imageTweens.alphaShow;
				loc1;
				this._tweenImage = loc1 = com.greensock.TweenLite.to(this._image, this._data.imageTweens.timeShow, this._data.imageTweens.tweenShow);
				loc1;
				this._tweenImageMask = loc1 = com.greensock.TweenLite.to(this._imageMask, this._data.imageMaskTweens.timeShow, this._data.imageMaskTweens.tweenShow);
				loc1;
			}
			if (!(this._title == null) && !(this._data.title == null)) 
			{
				this._data.titleTweens.tweenShow.alpha = loc1 = this._data.titleTweens.alphaShow;
				loc1;
				this._tweenTitle = loc1 = com.greensock.TweenLite.to(this._title, this._data.titleTweens.timeShow, this._data.titleTweens.tweenShow);
				loc1;
				if (this._thumbnails.player.data.bgTransparent && !this._data.title.embed_fonts && "tint" in this._data.titleTweens.tweenShow) 
				{
					this._txtTitle.textColor = loc1 = this._data.titleTweens.tweenShow.tint;
					loc1;
				}
			}
			return;
		}

		public function disable():void
		{
			this._onRollOut();
			var loc1:*;
			this._view.mouseEnabled = loc1 = false;
			loc1;
			this._view.buttonMode = loc1 = false;
			loc1;
			return;
		}

		public function enable():void
		{
			if (!(this._no == this._thumbnails.player.currSlideNo) || !(this._thumbnails.player.currState == com.madebyplay.CU3ER.controller.Player.STATE_FREE)) 
			{
				var loc1:*;
				this._view.buttonMode = loc1 = true;
				loc1;
				this._view.mouseEnabled = loc1 = true;
				loc1;
				if (this._view.hitTestPoint(this._view.mouseX, this._view.mouseY)) 
				{
					this._onRollOver();
				}
				else 
				{
					this._onRollOut();
				}
			}
			else 
			{
				this._view.buttonMode = loc1 = false;
				loc1;
				this._view.mouseEnabled = loc1 = false;
				loc1;
				this.select();
			}
			return;
		}

		public function get view():flash.display.MovieClip
		{
			return this._view;
		}

		public function get isLoaded():Boolean
		{
			return this._isLoaded;
		}

		public function set isLoaded(arg1:Boolean):void
		{
			var loc1:*;
			this._isLoaded = loc1 = arg1;
			loc1;
			return;
		}

		public function get no():Number
		{
			return this._no;
		}

		public function set no(arg1:Number):void
		{
			var loc1:*;
			this._no = loc1 = arg1;
			loc1;
			return;
		}

		internal function _init():void
		{
			if (this._data.background != null) 
			{
				this._createBackground();
			}
			this._view.addEventListener(flash.events.MouseEvent.ROLL_OVER, this._onRollOver, false, 0, true);
			this._view.addEventListener(flash.events.MouseEvent.ROLL_OUT, this._onRollOut, false, 0, true);
			this._view.buttonMode = false;
			this._view.mouseEnabled = false;
			this._view.mouseChildren = false;
			this._view.addEventListener(flash.events.MouseEvent.MOUSE_UP, this._skipTo, false, 0, true);
			if (this._slide.url == null || com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().isLoaded(this._id) || com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().isLoadFailed(this._id)) 
			{
				this._onLoadSlideComplete();
			}
			else 
			{
				com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().addEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, this._onLoadSlideComplete, false, 0, false);
			}
			return;
		}

		internal var _thumbnails:com.madebyplay.CU3ER.controller.Thumbnails;

		internal var _data:com.madebyplay.CU3ER.model.ThumbsData;

		internal var _slide:com.madebyplay.CU3ER.model.SlideData;

		internal var _holder:flash.display.MovieClip;

		internal var _view:flash.display.MovieClip;

		internal var _bg:flash.display.Shape;

		internal var _image:flash.display.Sprite;

		internal var _imageMask:flash.display.Shape;

		internal var _tweenBg:com.greensock.TweenLite;

		internal var _tweenTitle:com.greensock.TweenLite;

		internal var _tweenImage:com.greensock.TweenLite;

		internal var _tweenImageMask:com.greensock.TweenLite;

		internal var _isLoaded:Boolean=false;

		internal var _loader:flash.display.MovieClip;

		internal var _no:Number;

		internal var _title:flash.display.Sprite;

		internal var _txtTitle:flash.text.TextField;

		internal var _id:String;
	}
}


