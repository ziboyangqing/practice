package zzl.shape {
	import flash.display.Sprite;

	public class Rect extends Sprite {
		public function Rect(w:int=3, h:int=3, color:uint=0xff00ff) {
			graphics.clear();
			graphics.lineStyle(1,color);
			graphics.beginFill(color);
			graphics.drawRect(0, 0, w, h);
			graphics.endFill();
		}
	}
}
