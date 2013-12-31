package zzl.shapes
{
	import flash.display.Sprite;
	
	public class Ball extends Sprite
	{
		public function Ball(radius:Number=15,color:uint=0xff0000,alpha:Number=1)
		{
			graphics.lineStyle(0,0,0);
			graphics.beginFill(color,alpha);
			graphics.drawCircle(0,0,radius);
			graphics.endFill();
		}
	}
}