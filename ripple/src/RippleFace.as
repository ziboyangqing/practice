package {
	import com.nascom.flash.graphics.Rippler;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class RippleFace extends Sprite {
		private var t:Bitmap;
		private var r:Rippler;

		public function RippleFace() {

		}

		public function init(bmd:BitmapData):void {
			this.t=new Bitmap();
			this.t.bitmapData=bmd;
			addChild(this.t);
			this.r=new Rippler(this.t, 4);
		}

		public function drawRipple():void {
			this.r.drawRipple((this.t.width / 2), (this.t.height / 2), 4, 1);
		}

		public function startRipple():void {
			this.drawRipple();
		}

		public function stopRipple():void {
		}



	}
}


