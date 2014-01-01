package shapes
{
	import ascb.display.DraggableSprite;
	import flash.display.Sprite;

	public class Ball extends Sprite
	{
		public function Ball(radius:Number=10,color:uint=0xff0000,edge:Boolean=false){
			graphics.lineStyle(0,0,0);
			graphics.beginFill(color);
			graphics.drawCircle(0,0,radius);
		}
	}
}

