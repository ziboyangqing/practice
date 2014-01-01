package com.madebyplay.CU3ER.view.controls 
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import com.madebyplay.CU3ER.interfaces.*;
	import com.madebyplay.CU3ER.model.*;
	import com.madebyplay.CU3ER.util.*;
	import com.madebyplay.common.view.*;

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;

	public class BtnControl extends flash.display.MovieClip implements com.madebyplay.CU3ER.interfaces.IDisplayObject
	{
		public function BtnControl(arg1:XML, arg2:String)
		{
			this._tweenShow_bg = {time:0.3, delay:0, alpha:0.85, rotation:0, alpha:0, tint:16777215, x:0, y:0, scaleX:1, scaleY:1, ease:Sine.easeOut};
			this._tweenOver_bg = {time:0.3, delay:0, alpha:1, x:0, y:0, scaleX:1, scaleY:1, ease:Sine.easeOut};
			this._tweenHide_bg = {time:0.3, delay:0, alpha:0, x:0, y:0, scaleX:1, scaleY:1, ease:Sine.easeOut};
			this._tweenShow_symbol = {time:0.3, delay:0, alpha:0.85, rotation:0, tint:16777215, scaleX:1, scaleY:1, x:0, y:0, ease:Sine.easeOut};
			this._tweenOver_symbol = {time:0.3, delay:0, alpha:1, x:0, y:0, scaleX:1, scaleY:1, ease:Sine.easeOut};
			this._tweenHide_symbol = {time:0.3, delay:0, alpha:0, x:0, y:0, scaleX:1, scaleY:1, ease:Sine.easeOut};
			this._copyList = new Array("time", "delay", "x", "y", "alpha", "rotation", "tint", "scaleX", "scaleY", "ease");
			super();
			this._type = arg2;
			this._data = arg1;
			this._bg = new flash.display.Shape();
			this.addChild(this._bg);
			this.mouseChildren = false;
			this.buttonMode = true;
			this._createFromXML();
			return;
		}

		internal function _onRollOut(arg1:flash.events.MouseEvent=null):void
		{
			if (this._tweenBg != null) 
			{
				this._tweenBg.kill();
			}
			if (this._tweenSymbol != null) 
			{
				this._tweenSymbol.kill();
			}
			this._tweenShow_bg.alpha = this._tweenShow_bg_alpha;
			this._tweenBg = com.greensock.TweenLite.to(this._bg, this._tweenShow_bg.time, this._tweenShow_bg);
			if (this._symbol != null) 
			{
				this._tweenShow_symbol.alpha = this._tweenShow_symbol_alpha;
				this._tweenSymbol = com.greensock.TweenLite.to(this._symbol, this._tweenShow_symbol.time, this._tweenShow_symbol);
			}
			return;
		}

		internal function _onRollOver(arg1:flash.events.MouseEvent):void
		{
			if (this._tweenBg != null) 
			{
				this._tweenBg.kill();
			}
			if (this._tweenSymbol != null) 
			{
				this._tweenSymbol.kill();
			}
			this._tweenOver_bg.alpha = this._tweenOver_bg_alpha;
			this._tweenBg = com.greensock.TweenLite.to(this._bg, this._tweenOver_bg.time, this._tweenOver_bg);
			if (this._symbol != null) 
			{
				this._tweenOver_symbol.alpha = this._tweenOver_symbol_alpha;
				this._tweenSymbol = com.greensock.TweenLite.to(this._symbol, this._tweenOver_symbol.time, this._tweenOver_symbol);
			}
			return;
		}

		public function getHideTime():Number
		{
			return this._tweenHide_bg.time;
		}

		public function destroy():void
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

		internal function _createFromXML():void
		{	
			var loc3:*=null;
			var loc4:*=null;
			com.madebyplay.CU3ER.util.AlignXML.align(this, this._data);
			this._data.background.@round_corners = com.madebyplay.CU3ER.model.GlobalVars.getStringValue(this._data.background.@round_corners, "0,0,0,0");
			this._roundedCorners = String(this._data.background.@round_corners).split(",");
			var loc1:*=0;
			while (loc1 < this._copyList.length) 
			{
				if (this._copyList[loc1] != "tint") 
				{
					if (this._copyList[loc1] != "ease") 
					{
						if (this._data.background.tweenShow.attribute(this._copyList[loc1]) != undefined) 
						{
							this._tweenShow_bg[this._copyList[loc1]] = Number(this._data.background.tweenShow.attribute(this._copyList[loc1]));
						}
						if (this._data.background.tweenHide.attribute(this._copyList[loc1]) != undefined) 
						{
							this._tweenHide_bg[this._copyList[loc1]] = Number(this._data.background.tweenHide.attribute(this._copyList[loc1]));
						}
						if (this._data.background.tweenOver.attribute(this._copyList[loc1]) != undefined) 
						{
							this._tweenOver_bg[this._copyList[loc1]] = Number(this._data.background.tweenOver.attribute(this._copyList[loc1]));
						}
						if ("symbol" in this._data != "") 
						{
							if (this._data.symbol.tweenShow.attribute(this._copyList[loc1]) != undefined) 
							{
								this._tweenShow_symbol[this._copyList[loc1]] = Number(this._data.symbol.tweenShow.attribute(this._copyList[loc1]));
							}
							if (this._data.symbol.tweenHide.attribute(this._copyList[loc1]) != undefined) 
							{
								this._tweenHide_symbol[this._copyList[loc1]] = Number(this._data.symbol.tweenHide.attribute(this._copyList[loc1]));
							}
							if (this._data.symbol.tweenOver.attribute(this._copyList[loc1]) != undefined) 
							{
								this._tweenOver_symbol[this._copyList[loc1]] = Number(this._data.symbol.tweenOver.attribute(this._copyList[loc1]));
							}
						}
					}
					else 
					{
						if (this._data.background.tweenShow.attribute(this._copyList[loc1]) != undefined) 
						{
							this._tweenShow_bg[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._data.background.tweenShow.attribute(this._copyList[loc1])));
						}
						if (this._data.background.tweenHide.attribute(this._copyList[loc1]) != undefined) 
						{
							this._tweenHide_bg[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._data.background.tweenHide.attribute(this._copyList[loc1])));
						}
						if (this._data.background.tweenOver.attribute(this._copyList[loc1]) != undefined) 
						{
							this._tweenOver_bg[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._data.background.tweenOver.attribute(this._copyList[loc1])));
						}
						if ("symbol" in this._data != "") 
						{
							if (this._data.symbol.tweenShow.attribute(this._copyList[loc1]) != undefined) 
							{
								this._tweenShow_symbol[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._data.symbol.tweenShow.attribute(this._copyList[loc1])));
							}
							if (this._data.symbol.tweenHide.attribute(this._copyList[loc1]) != undefined) 
							{
								this._tweenHide_symbol[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._data.symbol.tweenHide.attribute(this._copyList[loc1])));
							}
							if (this._data.symbol.tweenOver.attribute(this._copyList[loc1]) != undefined) 
							{
								this._tweenOver_symbol[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._data.symbol.tweenOver.attribute(this._copyList[loc1])));
							}
						}
					}
				}
				else 
				{
					if (this._data.background.tweenShow.attribute(this._copyList[loc1]) != undefined) 
					{
						this._tweenShow_bg[this._copyList[loc1]] = parseInt(String(this._data.background.tweenShow.attribute(this._copyList[loc1])), 16);
					}
					if (this._data.background.tweenHide.attribute(this._copyList[loc1]) != undefined) 
					{
						this._tweenHide_bg[this._copyList[loc1]] = parseInt(String(this._data.background.tweenHide.attribute(this._copyList[loc1])), 16);
					}
					if (this._data.background.tweenOver.attribute(this._copyList[loc1]) != undefined) 
					{
						this._tweenOver_bg[this._copyList[loc1]] = parseInt(String(this._data.background.tweenOver.attribute(this._copyList[loc1])), 16);
					}
					if (String(this._data.symbol) != "") 
					{
						if (this._data.symbol.tweenShow.attribute(this._copyList[loc1]) != undefined) 
						{
							this._tweenShow_symbol[this._copyList[loc1]] = parseInt(String(this._data.symbol.tweenShow.attribute(this._copyList[loc1])), 16);
						}
						if (this._data.symbol.tweenHide.attribute(this._copyList[loc1]) != undefined) 
						{
							this._tweenHide_symbol[this._copyList[loc1]] = parseInt(String(this._data.symbol.tweenHide.attribute(this._copyList[loc1])), 16);
						}
						if (this._data.symbol.tweenOver.attribute(this._copyList[loc1]) != undefined) 
						{
							this._tweenOver_symbol[this._copyList[loc1]] = parseInt(String(this._data.symbol.tweenOver.attribute(this._copyList[loc1])), 16);
						}
					}
				}
				loc1 = loc1 + 1;
			}
			if (String(this._data.background.@color) != "") 
			{
				this._tweenShow_bg.tint = parseInt(String(this._data.background.@color), 16);
			}
			if (String(this._data.background.@alpha) != "") 
			{
				this._tweenShow_bg.alpha = Number(this._data.background.@alpha);
			}
			this._tweenShow_bg_alpha = this._tweenShow_bg.alpha;
			this._tweenHide_bg_alpha = this._tweenHide_bg.alpha;
			this._tweenOver_bg_alpha = this._tweenOver_bg.alpha;
			if (String(this._data.@width) == "") 
			{
				this._data.@width = "40";
			}
			if (String(this._data.@height) == "") 
			{
				this._data.@height = "40";
			}
			this._bg.graphics.beginFill(this._tweenHide_bg.tint);
			this._bg.graphics.drawRoundRectComplex(0, 0, Number(this._data.@width), Number(this._data.@height), this._roundedCorners[0], this._roundedCorners[1], this._roundedCorners[3], this._roundedCorners[2]);
			this._bg.graphics.endFill();
			this._tweenShow_bg.scaleX = 1;
			this._tweenShow_bg.scaleY = 1;
			var loc2:*="TL";
			if (String(this._data.@align_pos) != "") 
			{
				loc2 = String(this._data.@align_pos);
			}
			if (loc2.indexOf("C") > -1) 
			{
				this._tweenOver_bg.x = this._tweenOver_bg.x - (this._tweenOver_bg.scaleX - 1) * this._bg.width / 2;
				this._tweenHide_bg.x = this._tweenHide_bg.x - (this._tweenHide_bg.scaleX - 1) * this._bg.width / 2;
			}
			else if (loc2.indexOf("R") > -1) 
			{
				this._tweenOver_bg.x = this._tweenOver_bg.x - (this._tweenOver_bg.scaleX - 1) * this._bg.width;
				this._tweenHide_bg.x = this._tweenHide_bg.x - (this._tweenHide_bg.scaleX - 1) * this._bg.width;
			}
			if (loc2.indexOf("M") > -1) 
			{
				this._tweenOver_bg.y = this._tweenOver_bg.y - (this._tweenOver_bg.scaleY - 1) * this._bg.height / 2;
				this._tweenHide_bg.y = this._tweenHide_bg.y - (this._tweenHide_bg.scaleY - 1) * this._bg.height / 2;
			}
			else if (loc2.indexOf("B") > -1) 
			{
				this._tweenOver_bg.y = this._tweenOver_bg.y - (this._tweenOver_bg.scaleY - 1) * this._bg.height;
				this._tweenHide_bg.y = this._tweenHide_bg.y - (this._tweenHide_bg.scaleY - 1) * this._bg.height;
			}
			if (String(this._data.symbol) != "") 
			{
				this._tweenShow_symbol_alpha = this._tweenShow_symbol.alpha;
				this._tweenHide_symbol_alpha = this._tweenHide_symbol.alpha;
				this._tweenOver_symbol_alpha = this._tweenOver_symbol.alpha;
				loc3 = "ControlSymbolLeft";
				if (this._type == "next") 
				{
					loc3 = "ControlSymbolRight";
				}
				loc4 = flash.utils.getDefinitionByName(loc3 + String(this._data.symbol.@type)) as Class;
				this._symbol = new loc4() as flash.display.MovieClip;
			}
			this._precalculatePositions();
			this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._tweenHide_bg);//+++++++++++++++++++++++++++++++++++++++
			if (this._symbol != null) 
			{
				this._tweenSymbol = com.greensock.TweenLite.to(this._symbol, 0, this._tweenHide_symbol);
				this.addChild(this._symbol);
			}
			this.mouseEnabled = false;
			return;
		}

		internal function _precalculatePositions():void
		{
			var loc1:*=null;
			var loc2:*=NaN;
			var loc3:*=NaN;
			var loc6:*=null;
			var loc4:*=0;
			var loc5:*=0;
			if (this._symbol != null) 
			{
				if (String(this._data.symbol.@align_pos) == "") 
				{
					this._data.symbol.@align_pos = "MC";
				}
				if (String(this._data.symbol.@x) != "") 
				{
					loc4 = Number(this._data.symbol.@x);
				}
				if (String(this._data.symbol.@y) != "") 
				{
					loc5 = Number(this._data.symbol.@y);
				}
			}
			loc2 = this._bg.width;
			loc3 = this._bg.height;
			loc1 = new com.madebyplay.common.view.AlignUtil(new flash.geom.Rectangle(this._bg.x, this._bg.y, loc2, loc3));
			if (this._symbol != null) 
			{
				loc1.addItem(this._symbol, this._data.symbol.@align_pos, loc4, loc5, this._symbol.width * this._tweenShow_symbol.scaleX, this._symbol.height * this._tweenShow_symbol.scaleY);
				this._tweenShow_symbol.x = this._symbol.x + this._tweenShow_symbol.x;
				this._tweenShow_symbol.y = this._symbol.y + this._tweenShow_symbol.y;
				loc1.removeItem(this._symbol);
			}
			loc2 = this._bg.width * this._tweenHide_bg.scaleX;
			loc3 = this._bg.height * this._tweenHide_bg.scaleY;
			loc1 = new com.madebyplay.common.view.AlignUtil(new flash.geom.Rectangle(this._tweenHide_bg.x, this._tweenHide_bg.y, loc2, loc3));
			if (this._symbol != null) 
			{
				loc1.addItem(this._symbol, this._data.symbol.@align_pos, loc4, loc5, this._symbol.width * this._tweenHide_symbol.scaleX, this._symbol.height * this._tweenHide_symbol.scaleY);
				this._tweenHide_symbol.x = this._symbol.x + this._tweenHide_symbol.x;
				this._tweenHide_symbol.y = this._symbol.y + this._tweenHide_symbol.y;
				loc1.removeItem(this._symbol);
			}
			loc2 = this._bg.width * this._tweenOver_bg.scaleX;
			loc3 = this._bg.height * this._tweenOver_bg.scaleY;
			loc1 = new com.madebyplay.common.view.AlignUtil(new flash.geom.Rectangle(this._tweenOver_bg.x, this._tweenOver_bg.y, loc2, loc3));
			if (this._symbol != null) 
			{
				loc1.addItem(this._symbol, this._data.symbol.@align_pos, loc4, loc5, this._symbol.width * this._tweenOver_symbol.scaleX, this._symbol.height * this._tweenOver_symbol.scaleY);
				this._tweenOver_symbol.x = this._symbol.x + this._tweenOver_symbol.x;
				this._tweenOver_symbol.y = this._symbol.y + this._tweenOver_symbol.y;
				loc1.removeItem(this._symbol);
			}
			return;
		}

		public function show():void
		{
			this._hidden = false;
			if (!this.hasEventListener(flash.events.MouseEvent.ROLL_OVER)) 
			{
				this.addEventListener(flash.events.MouseEvent.ROLL_OVER, this._onRollOver, false, 0, true);
			}
			if (!this.hasEventListener(flash.events.MouseEvent.ROLL_OUT)) 
			{
				this.addEventListener(flash.events.MouseEvent.ROLL_OUT, this._onRollOut, false, 0, true);
			}
			this._bg.visible = true;
			if (this._symbol != null) 
			{
				this._symbol.visible = true;
				this._symbol.alpha = this._tweenHide_symbol_alpha;
			}
			this._bg.alpha = this._tweenHide_bg_alpha;
			this.mouseEnabled = true;
			this.buttonMode = true;
			this._onRollOut();
			return;
		}

		public function hide():void
		{
			this._hidden = true;
			if (this.hasEventListener(flash.events.MouseEvent.ROLL_OVER)) 
			{
				this.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this._onRollOver);
			}
			if (this.hasEventListener(flash.events.MouseEvent.ROLL_OUT)) 
			{
				this.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this._onRollOut);
			}
			if (this._tweenBg != null) 
			{
				this._tweenBg.kill();
			}
			if (this._tweenSymbol != null) 
			{
				this._tweenSymbol.kill();
			}
			this.mouseEnabled = false;
			this.buttonMode = false;
			this._tweenHide_bg.alpha = this._tweenHide_bg_alpha;
			this._tweenBg = com.greensock.TweenLite.to(this._bg, this._tweenHide_bg.time, this._tweenHide_bg);//-------------------------
			if (this._symbol != null) 
			{
				this._tweenHide_symbol.alpha = this._tweenHide_symbol_alpha;
				this._tweenSymbol = com.greensock.TweenLite.to(this._symbol, this._tweenHide_symbol.time, this._tweenHide_symbol);
			}
			return;
		}

		internal var _bg:flash.display.Shape;

		internal var _symbol:flash.display.MovieClip;

		internal var _symbolHolder:flash.display.MovieClip;

		internal var _data:XML;

		internal var _roundedCorners:Array;

		internal var _tweenShow_bg_alpha:Number=0.85;

		internal var _tweenShow_symbol_alpha:Number=0.85;

		internal var _tweenHide_bg_alpha:Number=0;

		internal var _tweenHide_symbol_alpha:Number=0;

		internal var _tweenOver_bg_alpha:Number=1;

		internal var _tweenOver_symbol_alpha:Number=1;

		internal var _tweenShow_bg:Object;

		internal var _tweenOver_bg:Object;

		internal var _tweenHide_bg:Object;

		internal var _tweenShow_symbol:Object;

		internal var _hidden:Boolean=true;

		internal var _copyList:Array;

		internal var _type:String;

		internal var _tweenHide_symbol:Object;

		internal var _tweenBg:com.greensock.TweenLite;

		internal var _tweenSymbol:com.greensock.TweenLite;

		internal var _tweenOver_symbol:Object;
	}
}


