package zzl.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/**
	 * <li>通过传入thumb及trck的位图数据，生成简单slider
	 * <li>thumb将使用原图，track使用位图填充
	 */	
	public class ZSlider extends Sprite {
		protected var callback:Function=null;
		public var thumb:Sprite;
		public var track:Sprite;
		protected var _isMouseDown:Boolean;
		private var realTime:Boolean = false;
		/**
		 * 
		 * @param slideObj:指定thumb、track及其width，heigth取track高度
		 * @param backFun:回调函数
		 * @param realtime:是否实时回调
		 */
		public function ZSlider( skins:Object,backFun:Function, realtime:Boolean = false) {
			this.callback = backFun;
			realTime = realtime;
			thumb =new Sprite();
			thumb.addChild(new Bitmap(skins["thumb"]));
			track = new Sprite();
			track.graphics.beginBitmapFill(skins["track"]);
			track.graphics.drawRect(0,0,skins["width"],skins["track"].height);
			track.graphics.endFill();
			//track.x = thumb.width / 2;
			addChild(track);
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
			isMouseDown = true;
			if (realTime)stage.addEventListener(MouseEvent.MOUSE_MOVE, onEnterFrame, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			thumb.startDrag(false, new Rectangle(0, track.height / 2 - thumb.height / 2, track.width-thumb.width, 0));
		}

		public function get isMouseDown():Boolean {
			return _isMouseDown;
		}

		public function set isMouseDown(value:Boolean):void {
			_isMouseDown = value;
		}
	}
}

