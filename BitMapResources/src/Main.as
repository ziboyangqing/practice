package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import zzl.component.SwitchButton;
	import zzl.component.ZButton;
	import zzl.component.ZSlider;
	import zzl.utils.Tool;

	[SWF(width="550",height="400",backgroundColor="#0099ff")]
	public class Main extends Sprite
	{
		[Embed(source="../assets/btn.png",mimeType="image/png")]
		private var closeBtn:Class;
		[Embed(source="../assets/thumb.png",mimeType="image/png")]
		private var thumbIco:Class;
		[Embed(source="../assets/track.png",mimeType="image/png")]
		private var trackIco:Class;
		[Embed(source="../assets/play.png",mimeType="image/png")]
		private var playIco:Class;
		[Embed(source="../assets/pause.png",mimeType="image/png")]
		private var pauseIco:Class;
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
					"width":300
			}
			var slide:ZSlider=new ZSlider(slideObj,slideFun);
			slide.x=50;
			slide.y=20;
			addChild(slide);
			var play:Bitmap=new playIco();
			var pause:Bitmap=new pauseIco();
			var playpause:SwitchButton=new SwitchButton(play.bitmapData,pause.bitmapData);
			addChild(playpause);
			playpause.x=playpause.y=200;
		}

		private function slideFun(value:Number):void
		{
			trace(value);
		}

		protected function handleClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			trace("zb clicked");
		}
	}
}

