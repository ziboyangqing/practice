package {
	import ascb.drawing.Pen;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import shapes.Ball;
	[SWF(width="800",height="400",frameRate="20")]
	public class ASCBTest extends Sprite {
		private var ball:Ball;
		private var pen:Pen;
		public function ASCBTest() {
			ball=new Ball();
			addChild(ball);
			ball.x=ball.y=100;
			
			ball.addEventListener(MouseEvent.MOUSE_DOWN,function(){ball.startDrag(true);});
			ball.addEventListener(MouseEvent.MOUSE_UP,function(){ball.stopDrag();});
			//创建画笔
			pen=new Pen(this.graphics);
			//画椭圆
			pen.drawEllipse(100,200,30,50);
			//画圆弧
			pen.drawArc(200,200,100,60,240);

		}
	}
}


