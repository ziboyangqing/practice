package {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import zzl.shapes.Ball;

[SWF(width="800", height="600", frameRate="24")]
public class TwoBall extends Sprite {
	private var a:Ball             =new Ball();
	private var b:Ball             =new Ball(15, 0x00ff00);
	private var hitTarget:Sprite;
	private var dist:Number        =100;
	private var angle:Number       =0;
	private var step:Number        =0.03;
	private var rotateTarget:Sprite;
	private var switcher:Number    =1;
	private var firstswicth:Boolean=true;

	public function TwoBall() {

		addChild(a);
		addChild(b);
		a.x=b.x=400;
		a.y=b.y=300;

		a.addEventListener(MouseEvent.CLICK, clickAB);
		b.addEventListener(MouseEvent.CLICK, clickAB);
		addEventListener(Event.ENTER_FRAME, monitorBall);
		hitTarget=a;
		rotateTarget=b;

	}

	public function swfHost():String {
		var url:String=this.loaderInfo.url;
		url=url.split("?")[0];
		var pos:int   =url.lastIndexOf("/");
		return url.substr(0, (pos + 1));

	}

	protected function clickAB(event:MouseEvent):void {
		hitTarget=event.currentTarget as Sprite;
		if (hitTarget != rotateTarget)
			return;
		if (hitTarget == a) {
			rotateTarget=b;
		} else {
			rotateTarget=a;
		}
		//处理首次角度变换
		if (firstswicth) {
			firstswicth=false;
			angle+=Math.PI;
		} else {
			angle-=Math.PI;
		}
		//改变角度变化方向
		switcher*=-1;
		//trace(switcher,angle);
	}

	protected function monitorBall(event:Event):void {
		var cx:Number=hitTarget.x;
		var cy:Number=hitTarget.y;

		rotateTarget.x=cx + dist * Math.cos(angle);
		rotateTarget.y=cy + dist * Math.sin(angle);
		angle+=step * switcher;
		graphics.clear();
		graphics.lineStyle(2, 0x0000ff);
		graphics.moveTo(cx, cy);
		graphics.lineTo(rotateTarget.x, rotateTarget.y);
		//trace("URL:",swfHost());
	}
}
}

