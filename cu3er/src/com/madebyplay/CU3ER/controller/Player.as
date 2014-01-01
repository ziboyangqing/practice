package com.madebyplay.CU3ER.controller 
{
	import com.greensock.*;
	import com.madebyplay.CU3ER.controller.transitions.*;
	import com.madebyplay.CU3ER.events.*;
	import com.madebyplay.CU3ER.interfaces.*;
	import com.madebyplay.CU3ER.model.*;
	import com.madebyplay.CU3ER.view.preloaders.*;
	import com.madebyplay.common.view.*;
	import flash.display.*;
	import flash.events.*;
	import flash.external.*;
	import flash.geom.*;
	import flash.utils.*;
	import net.stevensacks.utils.*;

	public class Player extends Object
	{
		public function Player(arg1:*, arg2:com.madebyplay.common.view.AlignUtil, arg3:com.madebyplay.CU3ER.model.SlideShowData)
		{
			this._currState = STATE_FREE;
			this._prevSlides = new Array();
			super();
			this._CU3ER = arg1;
			this._data = arg3;
			this._holder = new flash.display.MovieClip();
			this._CU3ER.addChild(this._holder);
			if (com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.debug == 1) 
			{
				this._CU3ER.setChildIndex(this._CU3ER.getChildByName("stats"), (this._CU3ER.numChildren - 1));
			}
			arg2.addItem(this._holder, this._data.align, this._data.x, this._data.y, this._data.width, this._data.height);
			this._holder.x = Math.round(this._holder.x);
			this._holder.y = Math.round(this._holder.y);
			this._currSlideNo = this._data.startSlideNo;
			this._slides = new Array();
			this._srcBmp = new flash.display.BitmapData(this._data.width, this._data.height, true, 0);
			if (this._data.thumbsData != null) 
			{
				this._thumbnails = new com.madebyplay.CU3ER.controller.Thumbnails(this, this._data.thumbsData);
			}
			if (com.madebyplay.CU3ER.model.GlobalVars.KEYBOARD_CONTROLS) 
			{
				this._initKeyboardControls();
			}
			this._checkLoop = false;
			if (this._data.loop > 0) 
			{
				this._checkLoop = true;
				this._loopSlideCount = 0;
				this._loopSlideTotal = this._data.loop * this._data.slides.length;
			}
			//trace("Player.this._data:",this._data.transitions);
			return;
		}

		public function prev():void
		{
			if (this._currState != STATE_FREE) 
			{
				return;
			}
			var loc1:*=(this._currSlideNo - 1);
			if (loc1 == -1) 
			{
				loc1 = (this._data.slides.length - 1);
			}
			this._direction = -1;
			this._nextTransitionNo = loc1;
			this.skipTo(loc1, false);
			return;
		}

		public function getSlidesOrder():String
		{
			var loc1:*=new Array();
			var loc2:*=0;
			while (loc2 < this._data.slides.length) 
			{
				loc1.push(com.madebyplay.CU3ER.model.SlideData(this._data.slides[loc2]).origNo + 1);
				++loc2;
			}
			return loc1.join("|");
		}

		internal function _onSlideFadeOut(arg1:flash.events.Event=null):void
		{
			if (this._currSlide.hasEventListener(com.madebyplay.CU3ER.events.SlideEvent.FADE_OUT_FINISH)) 
			{
				this._currSlide.removeEventListener(com.madebyplay.CU3ER.events.SlideEvent.FADE_OUT_FINISH, this._onSlideFadeOut);
			}
			this._startNextTransition();
			return;
		}

		internal function _onSlideLoadComplete(arg1:com.madebyplay.CU3ER.events.PreloadEvent):void
		{
			if (arg1.slideId == "slide_" + this._nextSlideNo) 
			{
				com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().removeEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_PROGRESS, this._onSlideLoadProgress);
				com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().removeEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, this._onSlideLoadComplete);
				this._preloaderSlide.hide();
				this._controls.paused = false;
				this._CU3ER.stage.addEventListener(flash.events.Event.ENTER_FRAME, this._changeState);
				com.greensock.TweenLite.delayedCall(0.15, this.skipTo, [this._nextSlideNo]);
			}
			return;
		}

		internal function _onSlideLoadProgress(arg1:com.madebyplay.CU3ER.events.PreloadEvent):void
		{
			if (arg1.slideId == "slide" + this._nextSlideNo) 
			{
				this._preloaderSlide.updatePercent(arg1.percent);
			}
			return;
		}

		internal function _createSlidePreloader():void
		{
			var loc1:*=null;
			if (this._data.preloader.@type != "circular") 
			{
				loc1 = new com.madebyplay.CU3ER.view.preloaders.PreloaderLinear(this._data.preloader);
			}
			else 
			{
				loc1 = new com.madebyplay.CU3ER.view.preloaders.PreloaderCircular(this._data.preloader);
			}
			loc1.mouseEnabled = false;
			loc1.mouseChildren = false;
			this._preloaderSlide = com.madebyplay.CU3ER.interfaces.IPreloader(loc1);
			loc1.name = "preloaderSlide";
			if (String(this._data.preloader.@align_to) != "stage") 
			{
				this._holder.addChild(loc1);
			}
			else 
			{
				this._CU3ER.addChild(loc1);
			}
			return;
		}

		internal function _onFirstTransitionComplete(arg1:com.madebyplay.CU3ER.events.TransitionEvent):void
		{
			if (this._checkLoop) 
			{
				var loc1:*;
				var loc2:*=((loc1 = this)._loopSlideCount + 1);
				loc1._loopSlideCount = loc2;
			}
			this._currTransition.removeEventListener(com.madebyplay.CU3ER.events.TransitionEvent.COMPLETE, this._onFirstTransitionComplete);
			this._currSlide.addToStage();
			this._currSlide.show();
			this._currBitmap = new flash.display.Sprite();
			this._currBitmap.addChild(new flash.display.Bitmap(this._currTransition.finalBmp));
			if (this._clickArea == null) 
			{
				this._clickArea = new flash.display.Sprite();
				this._clickArea.graphics.beginFill(16777215, 0);
				this._clickArea.graphics.drawRect(0, 0, this._data.width, this._data.height);
				this._clickArea.graphics.endFill();
				this._clickArea.visible = false;
				this._clickArea.buttonMode = true;
				this._clickArea.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this._onCurrentSlideClick);
				this._holder.addChildAt(this._clickArea, 0);
			}
			if (this._currSlide.data.link == "") 
			{
				this._clickArea.visible = false;
			}
			else 
			{
				this._clickArea.visible = true;
				this._holder.setChildIndex(this._clickArea, 0);
			}
			this._holder.addChildAt(this._currBitmap, 0);
			this._currBitmap.x = -this._holder.x;
			this._currBitmap.y = -this._holder.y;
			this._currBitmap.alpha = 0;
			if (this._tweenBitmap != null) 
			{
				this._tweenBitmap.kill();
			}
			this._tweenBitmap = com.greensock.TweenLite.to(this._currBitmap, 1, {"alpha":1});

			if (this._data.autoPlay && (!this._checkLoop || this._checkLoop && this._loopSlideCount < this._loopSlideTotal)) 
			{
				if (!this._controls.paused) 
				{
					this._startTimerPlayNext();
				}
			}
			else 
			{
				trace("Player:_onFirstTransitionComplete-4");
				this._controls.hideAutoPlay();
			}
			if (this._data.controlsData.hideOnTransition_autoPlayIndicator) 
			{
				this._controls.percent = 0;
			}
			this._controls.showHideOnTransition();
			if (this._thumbnails != null) 
			{
				this._thumbnails.showHideOnTransition();
			}
			if (this._thumbnails != null) 
			{
				this._thumbnails.unblockThumbs(this._currSlideNo);
			}
			try 
			{
				if (flash.external.ExternalInterface.available) 
				{
					flash.external.ExternalInterface.call("CU3ER[\'" + com.madebyplay.CU3ER.model.GlobalVars.FLASH_ID + "\'].onSlideChange", this._currSlideNo + 1);
				}
			}
			catch (err:Error)
			{
			};
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().onSlide(this._currSlideNo + 1);
			this._CU3ER.stage.addEventListener(flash.events.Event.ENTER_FRAME, this._changeState);
			return;
		}

		internal function _startNextTransition():void
		{
			//trace("Player__startNextTransition this._currSlideNo",this._currSlideNo);
			var loc1:*=this._currSlide.bitmapData.clone();
			var loc2:*=this._currSlideNo;
			this._prevSlides.push(this._currSlide);
			this._currSlideNo = this._nextSlideNo;
			if (this._slides[this._currSlideNo] == undefined) 
			{
				this._slides[this._currSlideNo] = new com.madebyplay.CU3ER.controller.Slide(this, this._currSlideNo);//---------------------------------
			}
			this._currSlide = this._slides[this._currSlideNo];
			this._currTransitionNo = this._nextTransitionNo;
			if ((this._data.transitions[this._currTransitionNo] as com.madebyplay.CU3ER.model.TransitionData).type != com.madebyplay.CU3ER.model.TransitionData.TYPE_3D) 
			{
				this._currTransition = new com.madebyplay.CU3ER.controller.transitions.Transition2D(this, loc2, this._currSlideNo, this._data.transitions[this._currTransitionNo], this._direction);
			}
			else 
			{
				this._currTransition = new com.madebyplay.CU3ER.controller.transitions.Transition3D(this, loc2, this._currSlideNo, this._data.transitions[this._currTransitionNo], this._direction);
			}
			//trace("Player__startNextTransition this._currTransitionNo",_currTransitionNo);
			this._currTransition.addEventListener(com.madebyplay.CU3ER.events.TransitionEvent.START, this._onTransitionStart, false, 0, true);
			this._currTransition.addEventListener(com.madebyplay.CU3ER.events.TransitionEvent.COMPLETE, this._onTransitionComplete, false, 0, true);
			this._currTransition.start();
			this._currState = STATE_TRANSITION;
			return;
		}

		internal function _onTransitionStart(arg1:com.madebyplay.CU3ER.events.TransitionEvent):void
		{
			this._currTransition.removeEventListener(com.madebyplay.CU3ER.events.TransitionEvent.START, this._onTransitionStart);
			if (this._clickArea != null) 
			{
				this._clickArea.visible = false;
			}
			this._currBitmap.visible = false;
			this._holder.removeChild(this._currBitmap);
			if (!(this._data.descriptionData == null) && this._data.descriptionData.bakeOnTransition) 
			{
				this._prevSlides[(this._prevSlides.length - 1)].hideDescription();
			}
			try 
			{
				if (flash.external.ExternalInterface.available) 
				{
					flash.external.ExternalInterface.call("CU3ER[\'" + com.madebyplay.CU3ER.model.GlobalVars.FLASH_ID + "\'].onSlideChangeStart", this._currSlideNo + 1);
				}
			}
			catch (err:Error)
			{
			};
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().onTransition(this._currSlideNo + 1);
			return;
		}

		internal function _onTransitionComplete(arg1:com.madebyplay.CU3ER.events.TransitionEvent):void
		{
			var loc1:*=false;
			var loc2:*=0;
			while (loc2 < this._prevSlides.length) 
			{
				if (this._prevSlides[loc2].no != this._currSlide.no) 
				{
					loc1 = loc1 || !com.madebyplay.CU3ER.controller.Slide(this._prevSlides[loc2]).isDescriptionHidden;
					com.madebyplay.CU3ER.controller.Slide(this._prevSlides[loc2]).hide();
				}
				++loc2;
			}
			this._prevSlides = new Array();
			if (this._checkLoop) 
			{
				var loc3:*;
				var loc4:*=((loc3 = this)._loopSlideCount + 1);
				loc3._loopSlideCount = loc4;
			}
			this._currTransition.removeEventListener(com.madebyplay.CU3ER.events.TransitionEvent.COMPLETE, this._onTransitionComplete);
			this._currSlide.addToStage();
			if (loc1 || !(this._data.descriptionData == null) && this._data.descriptionData.bakeOnTransition) 
			{
				this._currSlide.showFast();
			}
			else 
			{
				this._currSlide.show();
			}
			if (!(this._currBitmap == null) && !(this._currBitmap.parent == null)) 
			{
				this._currBitmap.parent.removeChild(this._currBitmap);
			}
			this._currBitmap = new flash.display.Sprite();
			this._currBitmap.addChild(new flash.display.Bitmap(this._currTransition.finalBmp));
			if (this._clickArea == null) 
			{
				this._clickArea = new flash.display.Sprite();
				this._clickArea.graphics.beginFill(16777215, 0);
				this._clickArea.graphics.drawRect(0, 0, this._data.width, this._data.height);
				this._clickArea.graphics.endFill();
				this._clickArea.visible = false;
				this._clickArea.buttonMode = true;
				this._clickArea.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, this._onCurrentSlideClick);
				this._holder.addChildAt(this._clickArea, 0);
			}
			if (this._currSlide.data.link == "") 
			{
				this._clickArea.visible = false;
			}
			else 
			{
				this._clickArea.visible = true;
				this._holder.setChildIndex(this._clickArea, 0);
			}
			this._holder.addChildAt(this._currBitmap, 0);
			this._currBitmap.x = -this._holder.x;
			this._currBitmap.y = -this._holder.y;
			if (this._data.autoPlay && (!this._checkLoop || this._checkLoop && this._loopSlideCount < this._loopSlideTotal)) 
			{
				if (!this._controls.paused) 
				{
					this._startTimerPlayNext();
				}
			}
			else 
			{
				this._controls.hideAutoPlay();
			}
			if (!this._controls.paused && this._data.controlsData.hideOnTransition_autoPlayIndicator) 
			{
				this._controls.percent = 0;
			}
			this._controls.showHideOnTransition();
			if (this._thumbnails != null) 
			{
				this._thumbnails.showHideOnTransition();
			}
			if (this._thumbnails != null) 
			{
				this._thumbnails.unblockThumbs(this._currSlideNo);
			}
			try 
			{
				if (flash.external.ExternalInterface.available) 
				{
					flash.external.ExternalInterface.call("CU3ER[\'" + com.madebyplay.CU3ER.model.GlobalVars.FLASH_ID + "\'].onSlideChange", this._currSlideNo + 1);
				}
			}
			catch (err:Error)
			{
			};
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().onSlide(this._currSlideNo + 1);
			this._CU3ER.stage.addEventListener(flash.events.Event.ENTER_FRAME, this._changeState);
			return;
		}

		internal function _startFirstTransition():void
		{
			if (this._clickArea != null) 
			{
				this._clickArea.visible = false;
			}
			this._currTransitionNo = this._currSlideNo;
			if ((this._data.transitions[this._currTransitionNo] as com.madebyplay.CU3ER.model.TransitionData).type != com.madebyplay.CU3ER.model.TransitionData.TYPE_3D) 
			{
				this._currTransition = new com.madebyplay.CU3ER.controller.transitions.Transition2D(this, -1, this._currSlideNo, this._data.transitions[this._currTransitionNo], this._direction);
			}
			else 
			{
				this._currTransition = new com.madebyplay.CU3ER.controller.transitions.Transition3D(this, -1, this._currSlideNo, this._data.transitions[this._currTransitionNo], this._direction);
			}
			this._currTransition.addEventListener(com.madebyplay.CU3ER.events.TransitionEvent.COMPLETE, this._onFirstTransitionComplete, false, 0, true);
			this._currTransition.start();
			this._currState = STATE_TRANSITION;
			try 
			{
				if (flash.external.ExternalInterface.available) 
				{
					flash.external.ExternalInterface.call("CU3ER[\'" + com.madebyplay.CU3ER.model.GlobalVars.FLASH_ID + "\'].onSlideChangeStart", this._currSlideNo + 1);
				}
			}
			catch (err:Error)
			{
			};
			com.madebyplay.CU3ER.controller.FunctionsBridge.getInstance().onTransition(this._currSlideNo + 1);
			return;
		}

		internal function _onCurrentSlideClick(arg1:flash.events.MouseEvent):void
		{
			this._currSlide.openLink();
			return;
		}

		internal function _onSlideFadeIn(arg1:com.madebyplay.CU3ER.events.SlideEvent):void
		{
			this._currSlide.removeEventListener(com.madebyplay.CU3ER.events.SlideEvent.FADE_IN_FINISH, this._onSlideFadeIn);
			return;
		}

		public function pauseAutoPlay():void
		{
			if (this._controls.paused) 
			{
				if (this._tweenAutoPlay != null) 
				{
					this._tweenAutoPlay.kill();
				}
				if (!(this._timerPlayNext == null) && this._timerPlayNext.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
				{
					this._timerPlayNext.stop();
					this._timerPlayNext.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onPlayNextSlide);
				}
			}
			else 
			{
				if (!(this._timerPlayNext == null) && this._timerPlayNext.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
				{
					this._timerPlayNext.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onPlayNextSlide);
				}
				this._timerPlayNext = new flash.utils.Timer(this._currSlide.data.time * 1000 * (1 - this._controls.percent), 1);
				this._timerPlayNext.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onPlayNextSlide, false, 0, true);
				if (this._tweenAutoPlay != null) 
				{
					this._tweenAutoPlay.kill();
				}
				this._timerPlayNext.start();
				this._tweenAutoPlay = com.greensock.TweenLite.to(this._controls, this._currSlide.data.time * (1 - this._controls.percent), {"percent":1});
			}
			return;
		}

		internal function _startTimerPlayNext():void
		{
			if (!(this._timerPlayNext == null) && this._timerPlayNext.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
			{
				this._timerPlayNext.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onPlayNextSlide);
			}
			this._timerPlayNext = new flash.utils.Timer(this._currSlide.data.time * 1000, 1);
			this._timerPlayNext.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onPlayNextSlide, false, 0, true);
			this._timerPlayNext.start();
			this._controls.percent = 0;
			if (this._tweenAutoPlay != null) 
			{
				this._tweenAutoPlay.kill();
			}
			this._tweenAutoPlay = com.greensock.TweenLite.to(this._controls, this._currSlide.data.time, {"percent":1});
			return;
		}

		internal function _onPlayNextSlide(arg1:flash.events.TimerEvent):void
		{
			this._timerPlayNext.reset();
			if (this._tweenAutoPlay != null) 
			{
				this._tweenAutoPlay.kill();
			}
			this.next();
			return;
		}

		public function destroy():void
		{
			this._clearAutoHide();
			return;
		}

		public function get data():com.madebyplay.CU3ER.model.SlideShowData
		{
			return this._data;
		}

		public function set data(arg1:com.madebyplay.CU3ER.model.SlideShowData):void
		{
			this._data = arg1;
			return;
		}

		public function get currState():String
		{
			return this._currState;
		}

		public function get timerPlayNext():flash.utils.Timer
		{
			return this._timerPlayNext;
		}

		public function get currSlideNo():uint
		{
			return this._currSlideNo;
		}

		public function set currSlideNo(arg1:uint):void
		{
			this._currSlideNo = arg1;
			return;
		}

		public function get currSlide():com.madebyplay.CU3ER.controller.Slide
		{
			return this._currSlide;
		}

		public function set currSlide(arg1:com.madebyplay.CU3ER.controller.Slide):void
		{
			this._currSlide = arg1;
			return;
		}

		public function get holder():flash.display.MovieClip
		{
			return this._holder;
		}

		public function get CU3ER():flash.display.DisplayObjectContainer
		{
			return this._CU3ER;
		}

		public function get slides():Array
		{
			return this._slides;
		}

		public function get sceneHolder():flash.display.MovieClip
		{
			return this._sceneHolder;
		}

		public function set sceneHolder(arg1:flash.display.MovieClip):void
		{
			this._sceneHolder = arg1;
			return;
		}

		public function get pausedOnRollover():int
		{
			return this._pausedOnRollover;
		}

		public function set pausedOnRollover(arg1:int):void
		{
			this._pausedOnRollover = arg1;
			return;
		}

		public function play():void
		{
			if (this._currState != STATE_FREE) 
			{
				return;
			}
			this._controls.play();
			return;
		}


		{
			STATE_TRANSITION = "stateTransition";
			STATE_SLIDE = "stateSlide";
			STATE_START = "stateStart";
			STATE_LOADING_SLIDE = "stateLoadingSlide";
			STATE_FREE = "stateFree";
		}

		internal function _changeState(arg1:flash.events.Event=null):void
		{
			this._CU3ER.stage.removeEventListener(flash.events.Event.ENTER_FRAME, this._changeState);
			var loc1:*=this._currState;
			this._currState = STATE_FREE;
			if (loc1 == STATE_TRANSITION) 
			{
				this._startAutoHide();
			}
			return;
		}

		internal function _initKeyboardControls():void
		{
			this._CU3ER.stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this._onKeyDown);
			return;
		}

		internal function _onKeyDown(arg1:flash.events.KeyboardEvent):void
		{
			if (this._currState != STATE_FREE) 
			{
				return;
			}
			if (arg1.keyCode != 37) 
			{
				if (arg1.keyCode == 39) 
				{
					this.next();
				}
			}
			else 
			{
				this.prev();
			}
			return;
		}

		internal function _onStageMouseOver(arg1:flash.events.MouseEvent):void
		{
			if (!this._isMouseOnStage && this._currState == STATE_FREE) 
			{
				this._isMouseOnStage = true;
				if (this._currState == STATE_FREE) 
				{
					this._controls.showAutoHide();
					if (this._thumbnails != null) 
					{
						this._thumbnails.showAutoHide();
					}
				}
				if (this._CU3ER.stage.hasEventListener(flash.events.MouseEvent.MOUSE_MOVE)) 
				{
					this._CU3ER.stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this._onStageMouseOver);
				}
				this._startAutoHide();
				if (this._data.pauseOnRollover && this._pausedOnRollover == 0) 
				{
					this._pausedOnRollover = 1;
					if (!this._controls.paused) 
					{
						this._controls.pause();
					}
				}
			}
			return;
		}

		internal function _onStageMouseLeave(arg1:flash.events.Event):void
		{
			this._isMouseOnStage = false;
			if (!this._CU3ER.stage.hasEventListener(flash.events.MouseEvent.MOUSE_MOVE)) 
			{
				this._CU3ER.stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this._onStageMouseOver, false, 0, true);
			}
			this._startAutoHide();
			if (this._data.pauseOnRollover && this._pausedOnRollover == 1 && this._controls.paused) 
			{
				this._pausedOnRollover = 0;
				this._controls.play();
			}
			return;
		}

		internal function _clearAutoHide():void
		{
			if (this._CU3ER.stage.hasEventListener(flash.events.Event.MOUSE_LEAVE)) 
			{
				this._CU3ER.stage.removeEventListener(flash.events.Event.MOUSE_LEAVE, this._onStageMouseLeave);
			}
			if (this._CU3ER.stage.hasEventListener(flash.events.MouseEvent.MOUSE_MOVE)) 
			{
				this._CU3ER.stage.removeEventListener(flash.events.MouseEvent.MOUSE_MOVE, this._onStageMouseOver);
			}
			this._controls.clearAutoHide();
			if (this._thumbnails != null) 
			{
				this._thumbnails.clearAutoHide();
			}
			return;
		}

		internal function _resetAutoHide(arg1:flash.events.MouseEvent=null):void
		{
			if (this._currState == STATE_FREE) 
			{
				this._controls.showAutoHide();
			}
			this._controls.resetHideTimers();
			if (this._thumbnails != null) 
			{
				this._thumbnails.resetHideTimers();
			}
			return;
		}

		internal function _startAutoHide(arg1:flash.events.Event=null):void
		{
			if (this._currState != STATE_FREE) 
			{
				return;
			}
			this._controls.initAutoHide();
			if (this._thumbnails != null) 
			{
				this._thumbnails.initAutoHide();
			}
			this._controls.resetHideTimers();
			if (this._thumbnails != null) 
			{
				this._thumbnails.resetHideTimers();
			}
			if (!this._isMouseOnStage) 
			{
				this._controls.startHideTimers();
				if (this._thumbnails != null) 
				{
					this._thumbnails.startHideTimers();
				}
			}
			return;
		}

		public function start():void
		{
			if (this._currState != STATE_FREE) 
			{
				return;
			}
			this.skipTo(this._currSlideNo);
			return;
		}

		public function set CU3ER(arg1:flash.display.DisplayObjectContainer):void
		{
			this._CU3ER = arg1;
			return;
		}

		public function pause():void
		{
			if (this._currState != STATE_FREE) 
			{
				return;
			}
			this._controls.pause();
			return;
		}

		public function skipToMinus(arg1:Number):*
		{
			this.skipTo((arg1 - 1));
			return;
		}

		public function skipTo(arg1:Number, arg2:Boolean=true):void
		{
			var slideNo:Number;
			var calculateTransition:Boolean=true;
			var licenses:*;
			var l:int;
			var brandingPos:flash.geom.Point;
			var stageRect:flash.geom.Rectangle;
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
			var maxWaiting:Number;

			var loc1:*;
			l = 0;
			brandingPos = null;
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
			maxWaiting = NaN;
			slideNo = arg1;
			calculateTransition = arg2;
			if (this._currState != STATE_FREE) 
			{
				return;
			}
			licenses = com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG;


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
			stageRect = new flash.geom.Rectangle(-0.01, -0.01, com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH - com.madebyplay.CU3ER.model.GlobalVars.BRANDING.width + 0.02, com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT - com.madebyplay.CU3ER.model.GlobalVars.BRANDING.height + 0.02);
			if (this._data.brandingAlignTo != "stage") 
			{
				com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.addItem(com.madebyplay.CU3ER.model.GlobalVars.BRANDING, this._data.brandingAlignPos, this._data.brandingX, this._data.brandingY);
				brandingPos = new flash.geom.Point(com.madebyplay.CU3ER.model.GlobalVars.BRANDING.x + com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.area.x, com.madebyplay.CU3ER.model.GlobalVars.BRANDING.y + com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.area.y);
				if (!stageRect.containsPoint(brandingPos)) 
				{
					com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.addItem(com.madebyplay.CU3ER.model.GlobalVars.BRANDING, "TR", -20, 20);
				}
			}
			else 
			{
				com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.addItem(com.madebyplay.CU3ER.model.GlobalVars.BRANDING, this._data.brandingAlignPos, this._data.brandingX, this._data.brandingY);
				brandingPos = new flash.geom.Point(com.madebyplay.CU3ER.model.GlobalVars.BRANDING.x, com.madebyplay.CU3ER.model.GlobalVars.BRANDING.y);
				if (!stageRect.containsPoint(brandingPos)) 
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
				if (com.madebyplay.CU3ER.model.GlobalVars.BRANDING.alpha != 1) 
				{
					com.greensock.TweenLite.to(com.madebyplay.CU3ER.model.GlobalVars.BRANDING, 0.5, {"alpha":1});
				}
			}
			com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER.visible = true;
			if (!com.madebyplay.CU3ER.model.GlobalVars.BRANDING.hasEventListener(flash.events.MouseEvent.CLICK)) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.BRANDING.addEventListener(flash.events.MouseEvent.CLICK, function ():*
				{
					net.stevensacks.utils.Web.getURL("http://getcu3er.com" + com.madebyplay.CU3ER.model.GlobalVars.REFERRAL, "_blank");
					return;
				})
			}
			com.madebyplay.CU3ER.model.GlobalVars.BRANDING.mouseChildren = false;
			com.madebyplay.CU3ER.model.GlobalVars.BRANDING.buttonMode = true;
			com.madebyplay.CU3ER.model.GlobalVars.TOP_LAYER.buttonMode = true;
			if (slideNo >= this._data.slides.length || slideNo < 0) 
			{
				return;
			}
			if (this._currSlide != null) 
			{
				if (this._thumbnails != null) 
				{
					this._thumbnails.blockThumbs(slideNo);
				}
			}
			if (!(this._data.slides[slideNo].url == null) && !com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().isLoadFailed("slide_" + slideNo) && !com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().isLoaded("slide_" + slideNo)) 
			{
				this._currState = STATE_LOADING_SLIDE;
				this._nextSlideNo = slideNo;
				this._controls.paused = true;
				this.pauseAutoPlay();
				com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().addEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_PROGRESS, this._onSlideLoadProgress, false, 0, true);
				com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().addEventListener(com.madebyplay.CU3ER.events.PreloadEvent.LOAD_SLIDE_COMPLETE, this._onSlideLoadComplete, false, 0, true);
				com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().forceLoadSlide(slideNo);
				if (this._preloaderSlide == null) 
				{
					this._createSlidePreloader();
				}
				this._preloaderSlide.show();
				return;
			}
			if (this._preloaderSlide != null) 
			{
				this._preloaderSlide.hide();
			}
			if (calculateTransition) 
			{
				if (this._currSlideNo == (this._data.slides.length - 1) && slideNo == 0) 
				{
					this._direction = 1;
					this._nextTransitionNo = this._currSlideNo;
				}
				else if (this._currSlideNo == 0 && slideNo == (this._data.slides.length - 1)) 
				{
					this._direction = -1;
					this._nextTransitionNo = (this._data.slides.length - 1);
				}
				else if (this._currSlideNo > slideNo) 
				{
					this._nextTransitionNo = slideNo;
					this._direction = -1;
				}
				else if (this._currSlideNo < slideNo) 
				{
					this._nextTransitionNo = this._currSlideNo;
					this._direction = 1;
				}
			}
			if (this._currState != STATE_TRANSITION) 
			{
				this._currState = STATE_TRANSITION;
				if (this._data.autoPlay && !(this._timerPlayNext == null)) 
				{
					this._timerPlayNext.reset();
					if (this._tweenAutoPlay != null) 
					{
						this._tweenAutoPlay.kill();
					}
				}
				//trace("Player.this._currSlide  ",this._currSlide,"----------------------------slideNo:  ",slideNo,"--------------------------------url:",this._data.slides[slideNo].url);
				if (this._currSlide != null) //+++++++++++++++++++++++++++++++++++++++++
				{
					this._currState = STATE_TRANSITION;
					this._nextSlideNo = slideNo;
					this._controls.hideOnTransition();
					maxWaiting = this._controls.getMaxHideTime();
					if (this._thumbnails != null) 
					{
						this._thumbnails.blockThumbs(this._nextSlideNo);
						this._thumbnails.hideOnTransition();
					}
					com.greensock.TweenLite.delayedCall(maxWaiting + 0.05, this._onSlideFadeOut);
				}
				else 
				{
					this._currSlideNo = slideNo;
					if (this._slides[this._currSlideNo] == undefined) 
					{
						this._slides[this._currSlideNo] = new com.madebyplay.CU3ER.controller.Slide(this, this._currSlideNo);
					}
					this._currSlide = this._slides[this._currSlideNo];
					this._startFirstTransition();//++++++++++++++++
					if (this._controls == null) 
					{
						this._controls = new com.madebyplay.CU3ER.controller.Controls(this, this._data.controlsData);
					}
					this._controls.show();
					//this._startFirstTransition();

					if (this._data.autoPlay && (!this._checkLoop || this._checkLoop && this._loopSlideCount < this._loopSlideTotal)) 
					{
						if (!this._controls.paused) 
						{
							this._startTimerPlayNext();
						}
					}
					else 
					{
						this._controls.hideAutoPlay();
					}
					if (this._thumbnails != null) 
					{
						this._thumbnails.blockThumbs(this._currSlideNo);
					}
					this._CU3ER.stage.addEventListener(flash.events.Event.MOUSE_LEAVE, this._onStageMouseLeave, false, 0, true);
					this._CU3ER.stage.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, this._onStageMouseOver, false, 0, true);
				}
			}
			return;
		}

		public function next():void
		{
			if (this._currState != STATE_FREE) 
			{
				return;
			}
			var loc1:*=this._currSlideNo + 1;
			//trace("Player.next()     ",this._data,this._data.slides);
			if (loc1 == this._data.slides.length) 
			{
				loc1 = 0;
			}
			this._direction = 1;
			this._nextTransitionNo = this._currSlideNo;
			this.skipTo(loc1, false);
			return;
		}

		internal var _data:com.madebyplay.CU3ER.model.SlideShowData;

		internal var _hasStarted:Boolean=false;

		internal var _pausedOnRollover:int=0;

		internal var _srcBmp:flash.display.BitmapData;

		internal var _destBmp:flash.display.BitmapData;

		internal var _currSlide:com.madebyplay.CU3ER.controller.Slide;

		internal var _currSlideNo:uint=0;

		internal var _currTransition:com.madebyplay.CU3ER.controller.Transition;

		internal var _currTransitionNo:uint=0;

		internal var _currState:String;

		internal var _direction:int=1;

		internal var _nextSlideNo:uint=0;

		internal var _slides:Array;

		internal var _timerPlayNext:flash.utils.Timer;

		internal var _timerAutoHide:flash.utils.Timer;

		internal var _hidden:Boolean=false;

		internal var _prevSlides:Array;

		internal var _controls:com.madebyplay.CU3ER.controller.Controls;

		internal var _tweenAutoPlay:com.greensock.TweenLite;

		internal var _thumbnails:com.madebyplay.CU3ER.controller.Thumbnails;

		internal var _preloaderSlide:com.madebyplay.CU3ER.interfaces.IPreloader;

		internal var _tweenPreloader:com.greensock.TweenLite;

		internal var _currBitmap:flash.display.Sprite;

		internal var _clickArea:flash.display.Sprite;

		internal var _tweenBitmap:com.greensock.TweenLite;

		internal var _holder:flash.display.MovieClip;

		internal var _sceneHolder:flash.display.MovieClip;

		internal var _isMouseOnStage:Boolean=false;

		internal var _firstTime:Boolean=true;

		internal var _loopSlideCount:uint=0;

		internal var _checkLoop:Boolean=false;

		internal var _CU3ER:flash.display.DisplayObjectContainer;

		internal var _loopSlideTotal:uint=0;

		public static var STATE_TRANSITION:String="stateTransition";

		public static var STATE_SLIDE:String="stateSlide";

		public static var STATE_START:String="stateStart";

		public static var STATE_LOADING_SLIDE:String="stateLoadingSlide";

		public static var STATE_FREE:String="stateFree";

		internal var _nextTransitionNo:uint;
	}
}


