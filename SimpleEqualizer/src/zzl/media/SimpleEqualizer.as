package zzl.media {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import zzl.shape.Rect;

	public class SimpleEqualizer extends Sprite {
		private var canvas:Sprite=new Sprite();
		private var bytes:ByteArray=new ByteArray();
		private var n:Number=0;
		private var sizeX:int=100;
		private var barGap:int=0;
		private var barWidth:int=0;
		private var rectHeight:int=0;
		private var barColor:uint=0xff00ff;
		private var rectColor:uint=0xffff00;
		private var barHeight:int=0;
		private var timer:Timer;

		public function SimpleEqualizer(w:int=100,h:int=60,barw:int=3,bargap:int=2,barcolor:uint=0xff0000,rectcolor:uint=0x00ff00) {
			sizeX=w;
			barWidth=barw;
			barHeight=h-barw;
			barGap=bargap;
			barColor=barcolor;
			rectHeight=barw;
			rectColor=rectcolor;
			addChild(canvas);
			timer=new Timer(80);
			timer.addEventListener(TimerEvent.TIMER, ShowBars);
			timer.start();
		}
		private function ShowBars(event:TimerEvent):void {
			canvas.graphics.clear();
			SoundMixer.computeSpectrum(bytes, true, 0);
			for (var i:int=0; i < sizeX/(barWidth+ barGap); i=i +1) {
				var rect:Rect=canvas.getChildByName("rect" + i) as Rect;
				if (!rect) {
					rect=new Rect(barWidth, barWidth, rectColor);
					rect.name="rect" + i;
					canvas.addChild(rect);
					rect.width=barWidth;
					rect.x=(barWidth+ barGap) * i-2;
					rect.y=barHeight-rectHeight;
				}
				n=bytes.readFloat() * barHeight; 
				canvas.graphics.lineStyle(barWidth, barColor,1, true, "noSacle", "none");
				canvas.graphics.moveTo((barWidth+ barGap) * i, barHeight+1);
				
				canvas.graphics.lineTo((barWidth+ barGap) * i, barHeight - n-rectHeight);
				rect.y+=1;
				if (rect.y < 0) {
					rect.y=barHeight - n - rectHeight;
				} else {
					if (barHeight - n - rectHeight < rect.y) {
						rect.y=barHeight - n - rectHeight;
					}
				}
			}
		}
	}
}
