package com.madebyplay.CU3ER.view.preloaders 
{
	import com.greensock.*;
	import com.madebyplay.CU3ER.interfaces.*;
	import com.madebyplay.CU3ER.model.*;
	import flash.display.*;
	import flash.events.*;

	public class PreloaderGeneric extends flash.display.MovieClip implements com.madebyplay.CU3ER.interfaces.IPreloader
	{
		public function PreloaderGeneric()
		{
			super();
			addFrameScript(99, this.frame100);
			this.addEventListener(flash.events.Event.ENTER_FRAME, this._onEnterFrame, false, 0, true);
			return;
		}

		internal function _onEnterFrame(arg1:flash.events.Event):void
		{
			if (this._percent == 100 && this.currentFrame == 100) 
			{
				this.removeEventListener(flash.events.Event.ENTER_FRAME, this._onEnterFrame);
			}
			else if (this.currentFrame < this._percent) 
			{
				this.nextFrame();
			}
			return;
		}

		public function isHidden():Boolean
		{
			return this._hidden;
		}

		public function show():void
		{
			this._hidden = false;
			if (this._tween != null) 
			{
				this._tween.kill();
			}
			this.visible = true;
			this._tween = com.greensock.TweenLite.to(this, 0.5, {"alpha":1});
			if (this._firstTime) 
			{
				com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.addItem(this, "MC");
				this._firstTime = false;
			}
			return;
		}

		public function hide():void
		{
			this._hidden = true;
			if (this._tween != null) 
			{
				this._tween.kill();
			}
			this._tween = com.greensock.TweenLite.to(this, 0.3, {"alpha":0, "visible":false});
			return;
		}

		public function updatePercent(arg1:Number):void
		{
			var loc1:*=NaN;
			arg1 = arg1 * 100;
			if (arg1 > this.currentFrame || arg1 == 0) 
			{
				loc1 = Math.min(Math.round(arg1), 100);
				this._percent = Math.max(100, loc1);
			}
			return;
		}

		public function getHideTime():Number
		{
			return 0.3;
		}

		public function destroy():void
		{
			com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.removeItem(this);
			if (this.parent != null) 
			{
				this.parent.removeChild(this);
			}
			if (this.hasEventListener(flash.events.Event.ENTER_FRAME)) 
			{
				this.removeEventListener(flash.events.Event.ENTER_FRAME, this._onEnterFrame);
			}
			return;
		}

		public function reset():void
		{
			return;
		}

		public function get hidden():Boolean
		{
			return this._hidden;
		}

		public function set hidden(arg1:Boolean):void
		{
			this._hidden = arg1;
			return;
		}

		public function getPercent():Number
		{
			return this.currentFrame / 100;
		}

		private function frame100():*
		{
			stop();
			return;
		}

		internal var _percent:Number=0;

		internal var _tween:com.greensock.TweenLite;

		internal var _firstTime:Boolean=true;

		internal var _hidden:Boolean=true;
	}
}


