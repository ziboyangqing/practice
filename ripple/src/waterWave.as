package {
	import com.nascom.flash.graphics.*;

	import flash.display.*;
	import flash.events.*;
	import flash.net.drm.*;

	[SWF(width="800", height="600")]
	public class waterWave extends MovieClip {

		private var t:Bitmap;
		private var r:Rippler;
		[Embed(source="3.jpg")]
		private var img:Class;
		[Embed(source="2.jpg")]
		private var bimg:Class;
		private var bmp:Bitmap;
		private var face:RippleFace;
		public function waterWave() {
			bmp=new img();
			face=new RippleFace();
			face.init(bmp.bitmapData);
			face.addEventListener(MouseEvent.ROLL_OVER, this.mouseEvent);
			face.addEventListener(MouseEvent.ROLL_OUT, this.mouseEvent);
			addChild(face);
			var big:Bitmap=new bimg();
			r=new Rippler(big,4);

			var sp:Sprite=new Sprite();
			sp.addChild(big);
			sp.addEventListener(MouseEvent.MOUSE_MOVE,rr);
			addChild(sp);
			sp.x=200;
		}
		private function rr(e:MouseEvent):void{
			r.drawRipple(e.localX,e.localY,4,1);
		}
		private function mouseEvent(event:MouseEvent):void {
			switch (event.type) {
			case "rollOver":  {
				face.startRipple();
				break;
			}
			case "rollOut":  {
				break;
			}
			default:  {
				break;
			}
			}
			return;
		}
	}
}

