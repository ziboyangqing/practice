package zzl.component
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class ZButton extends Sprite
	{
		private var base:ZMovieClip;
		public function ZButton(bmds:Array,start:int=0)
		{
			base=new ZMovieClip(bmds,start);
			addChild(base);
			addEventListener(MouseEvent.MOUSE_OUT,handleMouse);
			addEventListener(MouseEvent.MOUSE_OVER,handleMouse);
			addEventListener(MouseEvent.MOUSE_DOWN,handleMouse);
			addEventListener(MouseEvent.MOUSE_UP,handleMouse);
		}

		protected function handleMouse(event:MouseEvent):void
		{
			switch(event.type)
			{
			case "mouseOver":
			{
				base.goto("over");
				break;
			}
			case "mouseOut":
			{
				base.goto("up");
				break;
			}
			case "mouseDown":
			{
				base.goto("down");
				break;
			}
			case "mouseUp":
			{
				base.goto("over");
				break;
			}
			default:
			{
				base.goto("up");
				break;
			}
			}			
		}
	}
}

