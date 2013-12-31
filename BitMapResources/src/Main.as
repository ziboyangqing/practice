package
{
	import component.controls.ZButton;
	import component.controls.ZSlider;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import util.Tool;

	[SWF(width="550",height="400",backgroundColor="#cecece")]
	public class Main extends Sprite
	{
		[Embed(source="../assets/btn.png",mimeType="image/png")]
		private var closeBtn:Class;
		[Embed(source="../assets/thumb.png",mimeType="image/png")]
		private var thumbIco:Class;
		[Embed(source="../assets/track.png",mimeType="image/png")]
		private var trackIco:Class;
		public function Main()
		{
			var btn:Bitmap=new closeBtn();
			var bmds:Array=Tool.SplitBMD(btn.bitmapData,4,1);
			var zb:ZButton=new ZButton(bmds,0);
			addChild(zb);
			zb.addEventListener(MouseEvent.CLICK,handleClick);
			var thumb:Bitmap=new thumbIco();
			var track:Bitmap=new trackIco();
			var slideObj:Object={
					"thumb":thumb.bitmapData,
					"track":track.bitmapData,
					"width":300,
					"height":8
			}
			var slide:ZSlider=new ZSlider(slideObj,slideFun);
			slide.x=50;
			slide.y=20;
			addChild(slide);
		}

		private function slideFun(value:Number):void
		{
			// TODO Auto Generated method stub
			trace(value);
		}

		protected function handleClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			trace("zb clicked");
		}
	}
}

