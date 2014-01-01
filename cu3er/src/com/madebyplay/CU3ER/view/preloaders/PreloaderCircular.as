package com.madebyplay.CU3ER.view.preloaders 
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.madebyplay.CU3ER.interfaces.*;
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.CU3ER.util.*;
    import flash.display.*;
    import flash.events.*;
    
    public class PreloaderCircular extends flash.display.MovieClip implements com.madebyplay.CU3ER.interfaces.IPreloader
    {
        public function PreloaderCircular(arg1:XML)
        {
            this._copyList = new Array("time", "delay", "x", "y", "alpha", "rotation", "tint", "scaleX", "scaleY", "ease");
            this._tweenShow_bg = {"time":0.3, "delay":0, "alpha":1, "x":0, "y":0, "rotation":0, "alpha":0, "tint":16711680, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenOver_bg = {"time":0.3, "delay":0, "alpha":1, "x":0, "y":0, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenHide_bg = {"time":0.3, "delay":0, "alpha":0, "x":0, "y":0, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenShow_loader = {"time":0.3, "delay":0, "alpha":1, "x":0, "y":0, "rotation":0, "alpha":0, "tint":16711680, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenOver_loader = {"time":0.3, "delay":0, "alpha":1, "x":0, "y":0, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenHide_loader = {"time":0.3, "delay":0, "x":0, "y":0, "alpha":0, "ease":com.greensock.easing.Sine.easeOut};
            super();
            this._data = arg1;
            this._bg = new flash.display.Shape();
            this._loader = new flash.display.Shape();
            this.addChild(this._bg);
            this.addChild(this._loader);
            this.mouseEnabled = false;
            this.buttonMode = true;
            this._createFromXML();
            return;
        }

        internal function _createFromXML():void
        {
            this._data.@radius = String(com.madebyplay.CU3ER.model.GlobalVars.getValue(this._data.@radius, 15));
            com.madebyplay.CU3ER.util.AlignXML.align(this, this._data, com.madebyplay.CU3ER.model.GlobalVars.getValue(this._data.@radius) * 2, com.madebyplay.CU3ER.model.GlobalVars.getValue(this._data.@radius) * 2);
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
                        if (this._data.loader.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenShow_loader[this._copyList[loc1]] = Number(this._data.loader.tweenShow.attribute(this._copyList[loc1]));
                        }
                        if (this._data.loader.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenHide_loader[this._copyList[loc1]] = Number(this._data.loader.tweenHide.attribute(this._copyList[loc1]));
                        }
                        if (this._data.loader.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenOver_loader[this._copyList[loc1]] = Number(this._data.loader.tweenOver.attribute(this._copyList[loc1]));
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
                        if (this._data.loader.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenShow_loader[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._data.loader.tweenShow.attribute(this._copyList[loc1])));
                        }
                        if (this._data.loader.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenHide_loader[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._data.loader.tweenHide.attribute(this._copyList[loc1])));
                        }
                        if (this._data.loader.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenOver_loader[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._data.loader.tweenOver.attribute(this._copyList[loc1])));
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
                    if (this._data.loader.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                    {
                        this._tweenShow_loader[this._copyList[loc1]] = parseInt(String(this._data.loader.tweenShow.attribute(this._copyList[loc1])), 16);
                    }
                    if (this._data.loader.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                    {
                        this._tweenHide_loader[this._copyList[loc1]] = parseInt(String(this._data.loader.tweenHide.attribute(this._copyList[loc1])), 16);
                    }
                    if (this._data.loader.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                    {
                        this._tweenOver_loader[this._copyList[loc1]] = parseInt(String(this._data.loader.tweenOver.attribute(this._copyList[loc1])), 16);
                    }
                }
                loc1 = loc1 + 1;
            }
            this._bg.graphics.beginFill(this._tweenHide_bg.tint);
            this._bg.graphics.drawCircle(Number(this._data.@radius), Number(this._data.@radius), Number(this._data.@radius));
            this._bg.graphics.endFill();
            var loc2:*=Number(this._data.background.@padding);
            this._loader.graphics.beginFill(this._tweenShow_bg.tint, 0);
            this._loader.graphics.drawCircle(Number(this._data.@radius) - loc2, Number(this._data.@radius) - loc2, Number(this._data.@radius) - loc2);
            this._loader.graphics.endFill();
            this._tweenShow_bg.scaleX = 1;
            this._tweenShow_bg.scaleY = 1;
            var loc3:*="TL";
            if (String(this._data.@align_pos) != "") 
            {
                loc3 = String(this._data.@align_pos);
            }
            if (loc3.indexOf("C") > -1) 
            {
                this._tweenOver_bg.x = this._tweenOver_bg.x - (this._tweenOver_bg.scaleX - 1) * this._bg.width / 2;
                this._tweenHide_bg.x = this._tweenHide_bg.x - (this._tweenHide_bg.scaleX - 1) * this._bg.width / 2;
            }
            else if (loc3.indexOf("R") > -1) 
            {
                this._tweenOver_bg.x = this._tweenOver_bg.x - (this._tweenOver_bg.scaleX - 1) * this._bg.width;
                this._tweenHide_bg.x = this._tweenHide_bg.x - (this._tweenHide_bg.scaleX - 1) * this._bg.width;
            }
            if (loc3.indexOf("M") > -1) 
            {
                this._tweenOver_bg.y = this._tweenOver_bg.y - (this._tweenOver_bg.scaleY - 1) * this._bg.height / 2;
                this._tweenHide_bg.y = this._tweenHide_bg.y - (this._tweenHide_bg.scaleY - 1) * this._bg.height / 2;
            }
            else if (loc3.indexOf("B") > -1) 
            {
                this._tweenOver_bg.y = this._tweenOver_bg.y - (this._tweenOver_bg.scaleY - 1) * this._bg.height;
                this._tweenHide_bg.y = this._tweenHide_bg.y - (this._tweenHide_bg.scaleY - 1) * this._bg.height;
            }
            this._tweenShow_loader.scaleX = (Number(this._data.@radius) * this._tweenShow_bg.scaleX - loc2) / Number(this._data.@radius);
            this._tweenShow_loader.scaleY = (Number(this._data.@radius) * this._tweenShow_bg.scaleY - loc2) / Number(this._data.@radius);
            this._tweenOver_loader.scaleX = (Number(this._data.@radius) * this._tweenOver_bg.scaleX - loc2) / Number(this._data.@radius);
            this._tweenOver_loader.scaleY = (Number(this._data.@radius) * this._tweenOver_bg.scaleY - loc2) / Number(this._data.@radius);
            this._tweenHide_loader.scaleX = (Number(this._data.@radius) * this._tweenHide_bg.scaleX - loc2) / Number(this._data.@radius);
            this._tweenHide_loader.scaleY = (Number(this._data.@radius) * this._tweenHide_bg.scaleY - loc2) / Number(this._data.@radius);
            this._tweenShow_loader.x = this._tweenShow_bg.x + loc2;
            this._tweenShow_loader.y = this._tweenShow_bg.y + loc2;
            this._tweenOver_loader.x = this._tweenOver_bg.x + loc2;
            this._tweenOver_loader.y = this._tweenOver_bg.y + loc2;
            this._tweenHide_loader.x = this._tweenHide_bg.x + loc2;
            this._tweenHide_loader.y = this._tweenHide_bg.y + loc2;
            this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._tweenHide_bg);
            this._tweenLoader = com.greensock.TweenLite.to(this._loader, 0, this._tweenHide_loader);
            this.mouseEnabled = false;
            return;
        }

        public function isHidden():Boolean
        {
            return this._hidden;
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
            this._loader.visible = true;
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
            if (this._tweenLoader != null) 
            {
                this._tweenLoader.kill();
            }
            this.mouseEnabled = false;
            this.buttonMode = false;
            this._tweenBg = com.greensock.TweenLite.to(this._bg, this._tweenHide_bg.time, this._tweenHide_bg);
            this._tweenLoader = com.greensock.TweenLite.to(this._loader, this._tweenHide_loader.time, this._tweenHide_loader);
            return;
        }

        internal function _onRollOut(arg1:flash.events.MouseEvent=null):void
        {
            if (this._tweenBg != null) 
            {
                this._tweenBg.kill();
            }
            if (this._tweenLoader != null) 
            {
                this._tweenLoader.kill();
            }
            this._bg.visible = true;
            this._loader.visible = true;
            this._tweenBg = com.greensock.TweenLite.to(this._bg, this._tweenShow_bg.time, this._tweenShow_bg);
            this._tweenLoader = com.greensock.TweenLite.to(this._loader, this._tweenShow_loader.time, this._tweenShow_loader);
            return;
        }

        internal function _onRollOver(arg1:flash.events.MouseEvent):void
        {
            if (this._tweenBg != null) 
            {
                this._tweenBg.kill();
            }
            if (this._tweenLoader != null) 
            {
                this._tweenLoader.kill();
            }
            this._bg.visible = true;
            this._loader.visible = true;
            this._tweenBg = com.greensock.TweenLite.to(this._bg, this._tweenOver_bg.time, this._tweenOver_bg);
            this._tweenLoader = com.greensock.TweenLite.to(this._loader, this._tweenOver_loader.time, this._tweenOver_loader);
            return;
        }

        public function updatePercent(arg1:Number):void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=0;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=0;
            if (arg1 > this._percent || arg1 == 0) 
            {
                loc1 = Number(this._data.@radius);
                loc2 = Number(this._data.@rotation);
                loc3 = Number(this._data.background.@padding);
                this._loader.graphics.clear();
                this._loader.graphics.beginFill(this._tweenShow_bg.tint, 0);
                this._loader.graphics.drawCircle(Number(this._data.@radius), Number(this._data.@radius), Number(this._data.@radius));
                this._loader.graphics.endFill();
                this._loader.graphics.beginFill(Number(this._tweenLoader.vars.tint));
                this._loader.graphics.moveTo(loc1, loc1);
                loc4 = arg1 * 2 * Math.PI;
                loc5 = Math.round(loc4 / (Math.PI / 20));
                loc6 = loc4 / loc5;
                loc7 = 0;
                loc8 = 0;
                loc9 = loc4;
                loc6 = -loc6;
                loc10 = 0;
                while (loc10 <= loc5) 
                {
                    loc7 = loc2 + loc6 * loc10 + Math.PI;
                    loc8 = loc2 + loc6 * loc10 + Math.PI;
                    this._loader.graphics.lineTo(loc1 + Math.sin(loc7) * loc1, loc1 + Math.cos(loc8) * loc1);
                    ++loc10;
                }
                this._loader.graphics.lineTo(loc1, loc1);
                this._loader.graphics.endFill();
                this._percent = arg1;
            }
			//trace("PreloaderCircular:",arg1);
            return;
        }

        public function reset():void
        {
            this._loader.graphics.clear();
            return;
        }

        public function destroy():void
        {
            return;
        }

        public function getHideTime():Number
        {
            return this._tweenHide_bg.time;
        }

        public function get bg():flash.display.Shape
        {
            return this._bg;
        }

        public function get loader():flash.display.Shape
        {
            return this._loader;
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
            return this._percent;
        }

        internal var _bg:flash.display.Shape;

        internal var _loader:flash.display.Shape;

        internal var _tween:com.greensock.TweenLite;

        internal var _data:XML;

        internal var _copyList:Array;

        internal var _tweenShow_bg:Object;

        internal var _tweenOver_bg:Object;

        internal var _tweenHide_bg:Object;

        internal var _tweenShow_loader:Object;

        internal var _tweenOver_loader:Object;

        internal var _tweenHide_loader:Object;

        internal var _tweenBg:com.greensock.TweenLite;

        internal var _tweenLoader:com.greensock.TweenLite;

        internal var _hidden:Boolean=true;

        internal var _percent:Number=0;
    }
}
