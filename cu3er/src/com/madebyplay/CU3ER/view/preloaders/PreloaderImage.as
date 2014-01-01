package com.madebyplay.CU3ER.view.preloaders 
{
    import com.greensock.*;
    import com.madebyplay.CU3ER.interfaces.*;
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.CU3ER.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    
    public class PreloaderImage extends flash.display.MovieClip implements com.madebyplay.CU3ER.interfaces.IPreloader
    {
        public function PreloaderImage(arg1:XML)
        {
            this._directions = {"left":1, "right":1, "up":1, "down":1};
            super();
            this._data = arg1;
            this._percLoop = 0;
            this._loadImage();
            this.addEventListener(flash.events.Event.ADDED_TO_STAGE, this._onAddedToStage);
            return;
        }

        internal function _onAddedToStage(arg1:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, this._onAddedToStage);
            if (this.parent != null) 
            {
                this.parent.setChildIndex(this, (this.parent.numChildren - 1));
            }
            return;
        }

        internal function _loadImage():void
        {
            var loc1:*=new flash.system.LoaderContext();
            loc1.applicationDomain = flash.system.ApplicationDomain.currentDomain;
            loc1.checkPolicyFile = true;
            this._loader = new flash.display.Loader();
            if (String(this._data.image.url).indexOf("http://") != -1) 
            {
                this._loader.load(new flash.net.URLRequest(String(this._data.image.url)), loc1);
            }
            else 
            {
                this._loader.load(new flash.net.URLRequest(com.madebyplay.CU3ER.model.GlobalVars.LOAD_PREFIX + String(com.madebyplay.CU3ER.model.GlobalVars.XML_CONFIG.settings.folder_images) + "/" + String(this._data.image.url)), loc1);
            }
            this._loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this._initGraphics);
            this._loader.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this._onError);
            return;
        }

        internal function _onError(arg1:flash.events.IOErrorEvent):void
        {
            return;
        }

        internal function _initGraphics(arg1:flash.events.Event):void
        {
            var loc1:*=this._loader.content;
            var loc2:*=new flash.display.BitmapData(loc1.width, loc1.height, true, 0);
            loc2.draw(loc1, null, null, null, null, true);
            this._main = new flash.display.Bitmap(loc2.clone());
            this._bg = new flash.display.Bitmap(loc2.clone());
            this._main.smoothing = true;
            this._bg.smoothing = true;
            loc2.dispose();
            this._bg.alpha = 0.2;
            if (String(this._data.image.@alpha_bg) != "") 
            {
                this._bg.alpha = Number(this._data.image.@alpha_bg);
            }
            this._main.alpha = 1;
            if (String(this._data.image.@alpha_loader) != "") 
            {
                this._main.alpha = Number(this._data.image.@alpha_loader);
            }
            if (String(this._data.image.@scaleX) != "") 
            {
                this._bg.scaleX = Number(this._data.image.@scaleX);
                this._main.scaleX = Number(this._data.image.@scaleX);
            }
            if (String(this._data.image.@scaleY) != "") 
            {
                this._bg.scaleY = Number(this._data.image.@scaleY);
                this._main.scaleY = Number(this._data.image.@scaleY);
            }
            if (!(String(this._data.image.@loader_direction) == "") && String(this._data.image.@loader_direction) in this._directions) 
            {
                this._loaderDirection = String(this._data.image.@loader_direction);
            }
            this._maskMain = new flash.display.Sprite();
            this._maskMain.graphics.beginFill(0, 1);
            this._maskMain.graphics.drawRect(0, 0, this._bg.width, this._bg.height);
            this._maskMain.graphics.endFill();
            if (String(this._data.image.@tint_bg) != "") 
            {
                com.greensock.TweenLite.to(this._bg, 0, {"tint":parseInt(String(this._data.image.@tint_bg), 16)});
            }
            if (String(this._data.image.@tint_loader) != "") 
            {
                com.greensock.TweenLite.to(this._main, 0, {"tint":parseInt(String(this._data.image.@tint_loader), 16)});
            }
            addChild(this._bg);
            addChild(this._maskMain);
            addChild(this._main);
            this._main.mask = this._maskMain;
            this._maskMain.alpha = 0;
            var loc3:*=this._loaderDirection;
            switch (loc3) 
            {
                case "left":
                {
                    this._maskMain.x = this._bg.width;
                    this._maskMain.scaleX = 0;
                    break;
                }
                case "right":
                {
                    this._maskMain.x = this._bg.x;
                    this._maskMain.scaleX = 0;
                    break;
                }
                case "up":
                {
                    this._maskMain.y = this._bg.height;
                    this._maskMain.scaleY = 0;
                    break;
                }
                case "down":
                {
                    this._maskMain.y = 0;
                    this._maskMain.scaleY = 0;
                    break;
                }
                default:
                {
                    this._maskMain.x = 0;
                    this._maskMain.scaleX = 0;
                    break;
                }
            }
            com.madebyplay.CU3ER.util.AlignXML.align(this, XML(this._data.image), this._bg.width, this._bg.height);
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
            arg1 = Math.round(arg1 * 100) / 100;
            if (!(this._maskMain == null) && (arg1 >= this._percent || arg1 == 0 || this._percLoop >= 10)) 
            {
                if (this._tweenMask != null) 
                {
                    this._tweenMask.kill();
                }
                var loc1:*=this._loaderDirection;
                switch (loc1) 
                {
                    case "left":
                    {
                        this._tweenMask = com.greensock.TweenLite.to(this._maskMain, 0.05, {"scaleX":-arg1});
                        break;
                    }
                    case "right":
                    {
                        this._tweenMask = com.greensock.TweenLite.to(this._maskMain, 0.05, {"scaleX":arg1});
                        break;
                    }
                    case "up":
                    {
                        this._tweenMask = com.greensock.TweenLite.to(this._maskMain, 0.05, {"scaleY":-arg1});
                        break;
                    }
                    case "down":
                    {
                        this._tweenMask = com.greensock.TweenLite.to(this._maskMain, 0.05, {"scaleY":arg1});
                        break;
                    }
                    default:
                    {
                        this._tweenMask = com.greensock.TweenLite.to(this._maskMain, 0.05, {"scaleX":arg1});
                        break;
                    }
                }
            }
            else if (this._maskMain == null && (arg1 >= this._percent || arg1 == 0)) 
            {
                com.greensock.TweenLite.delayedCall(0.05, this.updatePercent, [arg1]);
                if (arg1 == 1) 
                {
                    var loc2:*=((loc1 = this)._percLoop + 1);
                    loc1._percLoop = loc2;
                }
            }
            this._percent = arg1;
            return;
        }

        public function destroy():void
        {
            com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.removeItem(this);
            if (this.parent != null) 
            {
                this.parent.removeChild(this);
            }
            return;
        }

        public function getHideTime():Number
        {
            return 0.3;
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
            return this._percent;
        }

        internal var _percent:Number=0;

        internal var _percLoop:uint=0;

        internal var _tween:com.greensock.TweenLite;

        internal var _firstTime:Boolean=true;

        internal var _hidden:Boolean=true;

        internal var _data:XML;

        internal var _main:flash.display.Bitmap;

        internal var _maskMain:flash.display.Sprite;

        internal var _bg:flash.display.Bitmap;

        internal var _loader:flash.display.Loader;

        internal var _tweenMask:com.greensock.TweenLite;

        internal var _directions:Object;

        internal var _loaderDirection:String="right";
    }
}
