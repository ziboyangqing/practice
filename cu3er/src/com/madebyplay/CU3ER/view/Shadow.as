package com.madebyplay.CU3ER.view 
{
    import flash.display.*;
    import flash.filters.*;
    import flash.geom.*;
    import org.papervision3d.objects.*;
    
    public class Shadow extends flash.display.MovieClip
    {
        public function Shadow(arg1:org.papervision3d.objects.DisplayObject3D, arg2:flash.geom.Rectangle, arg3:Number, arg4:Number=1, arg5:Number=1)
        {
            super();
            this._color = arg3;
            this._scale = arg5;
            this._intensity = arg4;
            alpha = arg4;
            this._displayObject = arg1;
            var loc1:*=new flash.display.BitmapData(Math.round(Math.abs(arg2.width) * this._scale), Math.round(Math.abs(arg2.height) * this._scale), false, 4278190080 + this._color);
            this._bmp = new flash.display.Bitmap(loc1);
            this._bmp.x = (-arg2.width) * this._scale / 2;
            this._bmp.y = (-arg2.height) * this._scale / 2;
            this.addChild(this._bmp);
            rotation = this._displayObject.rotationY;
            x = this._displayObject.x * this._scale;
            y = this._displayObject.z * this._scale;
            return;
        }

        public function destroy():void
        {
            this._bmp.bitmapData.dispose();
            return;
        }

        internal function _addBlur():void
        {
            var loc1:*=this._blur / 2;
            var loc2:*=this._blur / 2;
            var loc3:*=new flash.filters.DropShadowFilter(0, 0, 6710886, 1, loc1, loc2, 1, 2, false, false, true);
            var loc4:*;
            (loc4 = new Array()).push(loc3);
            filters = loc4;
            return;
        }

        internal function getBitmapFilter():flash.filters.BitmapFilter
        {
            var loc1:*=this._blur / 2;
            var loc2:*=this._blur / 2;
            return new flash.filters.DropShadowFilter(0, 0, 6710886, 1, loc1, loc2, 1, 2, false, false, true);
        }

        public function get scale():Number
        {
            return this._scale;
        }

        public function set scale(arg1:Number):void
        {
            this._scale = arg1;
            return;
        }

        internal var _intensity:Number;

        internal var _displayObject:org.papervision3d.objects.DisplayObject3D;

        internal var _bmp:flash.display.Bitmap;

        internal var _blur:Number;

        internal var _scale:Number=1;

        internal var _color:Number;
    }
}
