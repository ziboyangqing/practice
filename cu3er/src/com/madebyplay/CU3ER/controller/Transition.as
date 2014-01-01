package com.madebyplay.CU3ER.controller 
{
    import com.greensock.*;
    import com.madebyplay.CU3ER.events.*;
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.CU3ER.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    public class Transition extends flash.events.EventDispatcher
    {
        public function Transition(arg1:com.madebyplay.CU3ER.controller.Player, arg2:int, arg3:int, arg4:com.madebyplay.CU3ER.model.TransitionData, arg5:int)
        {
            super();
            this._srcNo = arg2;
            this._destNo = arg3;
            if (this._srcNo == -1) 
            {
                if ((arg1.slides[this._destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc == null) 
                {
                    this._destBmp = (arg1.slides[this._destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData.clone();
                }
                else 
                {
                    this._destBmp = (arg1.slides[this._destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc.clone();
                }
            }
            else 
            {
                if (!(arg1.data.descriptionData == null) && (arg1.data.slides[this._srcNo] as com.madebyplay.CU3ER.model.SlideData).descriptionShow && arg1.data.descriptionData.bakeOnTransition && !(arg1.slides[this._srcNo] as com.madebyplay.CU3ER.controller.Slide).isDescriptionHidden) 
                {
                    this._srcBmp = (arg1.slides[this._srcNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData.clone();
                }
                else if ((arg1.slides[this._srcNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc == null) 
                {
                    this._srcBmp = (arg1.slides[this._srcNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData.clone();
                }
                else 
                {
                    this._srcBmp = (arg1.slides[this._srcNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc.clone();
                }
                if (!(arg1.data.descriptionData == null) && (arg1.data.slides[this._destNo] as com.madebyplay.CU3ER.model.SlideData).descriptionShow && arg1.data.descriptionData.bakeOnTransition) 
                {
                    this._destBmp = (arg1.slides[this._destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData.clone();
                }
                else if ((arg1.slides[this._destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc == null) 
                {
                    this._destBmp = (arg1.slides[this._destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData.clone();
                }
                else 
                {
                    this._destBmp = (arg1.slides[this._destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc.clone();
                }
            }
            this._direction = arg5;
            this._data = arg4;
            this._player = arg1;
            return;
        }

        public function get player():com.madebyplay.CU3ER.controller.Player
        {
            return this._player;
        }

        public function get data():com.madebyplay.CU3ER.model.TransitionData
        {
            return this._data;
        }

        public function get destBmp():flash.display.BitmapData
        {
            return this._destBmp;
        }

        public function set destBmp(arg1:flash.display.BitmapData):void
        {
            this._destBmp = arg1;
            return;
        }

        public function get srcBmp():flash.display.BitmapData
        {
            return this._srcBmp;
        }

        public function set srcBmp(arg1:flash.display.BitmapData):void
        {
            this._srcBmp = arg1;
            return;
        }

        public function get finalBmp():flash.display.BitmapData
        {
            return this._finalBmp;
        }

        public function set finalBmp(arg1:flash.display.BitmapData):void
        {
            this._finalBmp = arg1;
            return;
        }

        public function get rectangles():Array
        {
            return this._rectangles;
        }

        public function set rectangles(arg1:Array):void
        {
            this._rectangles = arg1;
            return;
        }

        public function get arrBmpSrc():Array
        {
            return this._arrBmpSrc;
        }

        public function set arrBmpSrc(arg1:Array):void
        {
            this._arrBmpSrc = arg1;
            return;
        }

        public function get arrBmpDest():Array
        {
            return this._arrBmpDest;
        }

        public function set arrBmpDest(arg1:Array):void
        {
            this._arrBmpDest = arg1;
            return;
        }

        public function start():void
        {
            return;
        }

        public function destroy():void
        {
            if (this._srcBmp != null) 
            {
                this._srcBmp.dispose();
            }
            this._destBmp.dispose();
            if (this._destBmpFinal != null) 
            {
                this._destBmpFinal.dispose();
            }
            return;
        }

        protected function dispatchStart():void
        {
            this.dispatchEvent(new com.madebyplay.CU3ER.events.TransitionEvent(com.madebyplay.CU3ER.events.TransitionEvent.START));
            this.onTransitionStart();
            return;
        }

        protected function onTransitionStart():void
        {
            return;
        }

        protected function createRectangles():void
        {
            var loc6:*=0;
            this.rectangles = new Array();
            var loc1:*=this.player.data.width / this.data.columns;
            var loc2:*=this.player.data.height / this.data.rows;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            while (loc5 < this.data.rows) 
            {
                loc6 = 0;
                while (loc6 < this.data.columns) 
                {
                    if (loc5 == (this.data.rows - 1) && loc6 == (this.data.columns - 1)) 
                    {
                        this.rectangles.push(new flash.geom.Rectangle(loc3, loc4, this.player.data.width - loc3, this.player.data.height - loc4));
                    }
                    else if (loc6 != (this.data.columns - 1)) 
                    {
                        if (loc5 != (this.data.rows - 1)) 
                        {
                            this.rectangles.push(new flash.geom.Rectangle(loc3, loc4, Math.round(loc3 + loc1) - loc3, Math.round(loc4 + loc2) - loc4));
                        }
                        else 
                        {
                            this.rectangles.push(new flash.geom.Rectangle(loc3, loc4, Math.round(loc3 + loc1) - loc3, this.player.data.height - loc4));
                        }
                    }
                    else 
                    {
                        this.rectangles.push(new flash.geom.Rectangle(loc3, loc4, this.player.data.width - loc3, Math.round(loc4 + loc2) - loc4));
                    }
                    loc3 = Math.round(loc3 + loc1);
                    loc6 = loc6 + 1;
                }
                loc3 = 0;
                loc4 = Math.round(loc4 + loc2);
                loc5 = loc5 + 1;
            }
            return;
        }

        protected function createBitmaps():void
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc6:*=0;
            this._arrBmpSrc = new Array();
            this._arrBmpDest = new Array();
            var loc1:*=this.player.data.width;
            var loc2:*=this.player.data.height;
            var loc5:*=0;
            while (loc5 < this.data.rows) 
            {
                loc6 = 0;
                while (loc6 < this.data.columns) 
                {
                    loc4 = this._rectangles[loc6 + loc5 * this.data.columns];
                    loc3 = new flash.display.BitmapData(loc4.width, loc4.height, true, 0);
                    loc3.copyPixels(this.srcBmp, loc4, new flash.geom.Point(0, 0));
                    this._arrBmpSrc.push(loc3);
                    loc3 = new flash.display.BitmapData(loc4.width, loc4.height, true, 0);
                    loc3.copyPixels(this.destBmp, loc4, new flash.geom.Point(0, 0));
                    this._arrBmpDest.push(loc3);
                    loc6 = loc6 + 1;
                }
                loc5 = loc5 + 1;
            }
            return;
        }

        protected var _player:com.madebyplay.CU3ER.controller.Player;

        protected var _data:com.madebyplay.CU3ER.model.TransitionData;

        protected var _srcBmp:flash.display.BitmapData;

        protected var _destBmp:flash.display.BitmapData;

        protected var _destBmpFinal:flash.display.BitmapData;

        protected var _finalBmp:flash.display.BitmapData;

        protected var _rectangles:Array;

        protected var _arrBmpSrc:Array;

        protected var _arrBmpDest:Array;

        protected var _srcNo:int;

        protected var _destNo:int;

        internal var _scene:com.madebyplay.CU3ER.view.Scene;

        protected var _direction:int;

        protected var _hasDesc:Boolean=false;
    }
}
