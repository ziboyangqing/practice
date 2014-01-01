package zzl.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * <li>通过传入thumb及trck的位图数据，生成简单ProgressBar
	 * <li>thumb将使用原图，track使用位图填充
	 */	
	public class ZProgressBar extends Sprite {
		protected var callback:Function=null;
		private var thumb:Sprite;
		private var track:Sprite;
		private var load:Sprite;
		private var play:Sprite;
		
		protected var _isMouseDown:Boolean;
		private var realTime:Boolean = false;
		/**
		 * 
		 * @param slideObj:指定thumb、track、load及其width、height
		 * @param backFun:回调函数
		 * @param realtime:是否实时回调
		 */
		public function ZProgressBar( skins:Object,backFun:Function, realtime:Boolean = false) {
			this.callback = backFun;
			var height:Number=skins["track"].height;
			realTime = realtime;
			thumb =new Sprite();
			thumb.addChild(new Bitmap(skins["thumb"]));
			track = new Sprite();
			track.graphics.beginBitmapFill(skins["track"]);
			track.graphics.drawRect(0,0,skins["width"],height);
			track.graphics.endFill();
			addChild(track);
			load = new Sprite();
			load.graphics.beginBitmapFill(skins["load"]);
			load.graphics.drawRect(0,0,skins["width"],height);
			load.graphics.endFill();
			
			addChild(load);
			play = new Sprite();
			play.graphics.beginBitmapFill(skins["play"]);
			play.graphics.drawRect(0,0,skins["width"],height);
			play.graphics.endFill();
			//play.width=load.width=0.1;
			addChild(play);
			addChild(thumb);
			thumb.y = track.height / 2 - thumb.height / 2;
			thumb.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		protected function onEnterFrame(event:Event):void {
			if (!isMouseDown)
				return;
			if (callback!=null)
				callback((thumb.x) / (track.width-thumb.width));
		}
		
		protected function onMouseUp(event:Event):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			if (realTime)stage.removeEventListener(MouseEvent.MOUSE_MOVE, onEnterFrame);
			isMouseDown = false;
			thumb.stopDrag();
			//+++++
			if (realTime)
				return;
			if (callback!=null)
				callback(thumb.x / (track.width-thumb.width));
		}
		
		protected function onMouseDown(event:Event):void {
			if (load.width<=thumb.width)return;
			isMouseDown = true;
			if (realTime)stage.addEventListener(MouseEvent.MOUSE_MOVE, onEnterFrame, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			thumb.startDrag(false, new Rectangle(0, track.height / 2 - thumb.height / 2, load.width-thumb.width, 0));
		}
		
		public function get isMouseDown():Boolean {
			return _isMouseDown;
		}
		
		public function set isMouseDown(value:Boolean):void {
			_isMouseDown = value;
		}
	}
}

