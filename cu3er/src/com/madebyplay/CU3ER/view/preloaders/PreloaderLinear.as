package com.madebyplay.CU3ER.view.preloaders 
{
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.madebyplay.CU3ER.interfaces.*;
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.CU3ER.util.*;
    import flash.display.*;
    import flash.events.*;
    
    public class PreloaderLinear extends flash.display.MovieClip implements com.madebyplay.CU3ER.interfaces.IPreloader
    {
        public function PreloaderLinear(arg1:XML)
        {
            this._copyList = new Array("time", "delay", "x", "y", "alpha", "rotation", "tint", "visible", "scaleX", "scaleY", "width", "height", "ease");
            this._tweenShow_bg = {"time":0.3, "delay":0, "alpha":0.85, "x":0, "y":0, "rotation":0, "alpha":0, "scaleX":1, "scaleY":1, "tint":16711680, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenOver_bg = {"time":0.3, "delay":0, "alpha":1, "x":0, "y":0, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenHide_bg = {"time":0.3, "delay":0, "alpha":0, "x":0, "y":0, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenShow_loader = {"time":0.3, "delay":0, "alpha":0.85, "x":0, "y":0, "rotation":0, "alpha":0, "tint":16711680, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenOver_loader = {"time":0.3, "delay":0, "alpha":1, "x":0, "y":0, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenHide_loader = {"time":0.3, "delay":0, "x":0, "y":0, "alpha":0, "ease":com.greensock.easing.Sine.easeOut};
            super();
            this._data = arg1;
            this.x = arg1.x;
            this.y = arg1.y;
            this._bg = new flash.display.Shape();
            this._loader = new flash.display.Sprite();
            this.addChild(this._bg);
            this.addChild(this._loader);
            this.mouseEnabled = false;
            this.buttonMode = true;
            this._createFromXML();
            return;
        }

        public function getPercent():Number
        {
            return this._loaderBar.scaleX;
        }

        internal function _createFromXML():void
        {
            this._data.@width = com.madebyplay.CU3ER.model.GlobalVars.getValue(this._data.@width, 100);
            this._data.@height = com.madebyplay.CU3ER.model.GlobalVars.getValue(this._data.@height, 10);
            com.madebyplay.CU3ER.util.AlignXML.align(this, this._data, com.madebyplay.CU3ER.model.GlobalVars.getValue(this._data.@width, 100), com.madebyplay.CU3ER.model.GlobalVars.getValue(this._data.@height, 10));
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
                        if (!(this._copyList[loc1] == "x") && !(this._copyList[loc1] == "y")) 
                        {
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
            this._bg.graphics.drawRect(0, 0, Number(this._data.@width), Number(this._data.@height));
            this._bg.graphics.endFill();
            this._loaderBar = new flash.display.Shape();
            this._loaderBar.graphics.beginFill(this._tweenHide_loader.tint);
            this._loaderBar.graphics.drawRect(0, 0, Number(this._data.@width) - 2 * Number(this._data.background.@padding), Number(this._data.@height) - 2 * Number(this._data.background.@padding));
            this._loaderBar.graphics.endFill();
            this._loader.addChild(this._loaderBar);
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
            this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._tweenHide_bg);
            this._tweenShow_loader.scaleX = 1;
            this._tweenShow_loader.scaleY = 1;
            this._tweenShow_loader.x = this._tweenShow_bg.x + Number(this._data.background.@padding);
            this._tweenShow_loader.y = this._tweenShow_bg.y + Number(this._data.background.@padding);
            this._tweenOver_loader.x = this._tweenOver_bg.x + Number(this._data.background.@padding);
            this._tweenOver_loader.y = this._tweenOver_bg.y + Number(this._data.background.@padding);
            this._tweenHide_loader.x = this._tweenHide_bg.x + Number(this._data.background.@padding);
            this._tweenHide_loader.y = this._tweenHide_bg.y + Number(this._data.background.@padding);
            this._loader.width = 0;
            var loc3:*=Number(this._data.background.@padding);
            this._tweenShow_loader.scaleX = 1;
            this._tweenShow_loader.scaleY = 1;
            this._tweenOver_loader.scaleX = ((Number(this._data.@width) + 2 * loc3) * this._tweenOver_bg.scaleX - 2 * loc3) / Number(this._data.@width);
            this._tweenOver_loader.scaleY = ((Number(this._data.@height) + 2 * loc3) * this._tweenOver_bg.scaleY - 2 * loc3) / Number(this._data.@height);
            this._tweenHide_loader.scaleX = ((Number(this._data.@width) + 2 * loc3) * this._tweenHide_bg.scaleX - 2 * loc3) / Number(this._data.@width);
            this._tweenHide_loader.scaleY = ((Number(this._data.@height) + 2 * loc3) * this._tweenHide_bg.scaleY - 2 * loc3) / Number(this._data.@height);
            this._loaderBar.scaleX = 0;
            this._tweenLoader = com.greensock.TweenLite.to(this._loader, 0, this._tweenHide_loader);
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
            this._tweenBg = com.greensock.TweenLite.to(this._bg, this._tweenOver_bg.time, this._tweenOver_bg);
            this._tweenLoader = com.greensock.TweenLite.to(this._loader, this._tweenOver_loader.time, this._tweenOver_loader);
            return;
        }

        public function updatePercent(arg1:Number):void
        {
            if (arg1 > this._percent || arg1 == 0) 
            {
                if (this._tweenPerc != null) 
                {
                    this._tweenPerc.kill();
                }
                this._percent = arg1;
                this._loaderBar.scaleX = arg1;
            }
            return;
        }

        public function reset():void
        {
            this._loader.width = 0;
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

        public function get bar():flash.display.Sprite
        {
            return this._loader;
        }

        public function get bg():flash.display.Shape
        {
            return this._bg;
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

        internal var _bg:flash.display.Shape;

        internal var _loader:flash.display.Sprite;

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

        internal var _percent:Number=0;

        internal var _currLoaderScale:Number=1;

        internal var _loaderBar:flash.display.Shape;

        internal var _tweenPerc:com.greensock.TweenLite;

        internal var _hidden:Boolean=true;
    }
}
