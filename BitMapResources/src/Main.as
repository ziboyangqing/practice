package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import zzl.vo.SlideVO;
	
	import zzl.component.SwitchButton;
	import zzl.component.ZButton;
	import zzl.component.ZProgressBar;
	import zzl.component.ZSlider;
	import zzl.utils.Tool;

	[SWF(width="550",height="400",backgroundColor="#0099ff")]
	public class Main extends Sprite
	{
		/**Button*/
		[Embed(source="../assets/btn.png",mimeType="image/png")]
		private var closeBtn:Class;
		/**Slider*/
		[Embed(source="../assets/thumb.png",mimeType="image/png")]
		private var thumbIco:Class;
		[Embed(source="../assets/track.png",mimeType="image/png")]
		private var trackIco:Class;
		/**SwitchButton*/
		[Embed(source="../assets/play.png",mimeType="image/png")]
		private var playIco:Class;
		[Embed(source="../assets/pause.png",mimeType="image/png")]
		private var pauseIco:Class;
		/**ProgressBar*/
		[Embed(source="../assets/playtrack.png")]
		private var playtrack:Class;
		[Embed(source="../assets/loadtrack.png")]
		private var loadtrack:Class;
		private var progress:ZProgressBar;
		public function Main()
		{
			var btn:Bitmap=new closeBtn();
			var bmds:Array=Tool.SplitBMD(btn.bitmapData,4,1);
			var close:ZButton=new ZButton(bmds,0);
			addChild(close);
			close.addEventListener(MouseEvent.CLICK,handleClick);
			
			var thumb:Bitmap=new thumbIco();
			var track:Bitmap=new trackIco();
			var slideObj:SlideVO=new SlideVO(thumb,track,500);
			
			var slide:ZSlider=new ZSlider(slideObj,slideFun,true);
			slide.x=50;
			slide.y=20;
			addChild(slide);
			
			var play:Bitmap=new playIco();
			var pause:Bitmap=new pauseIco();
			var playpause:SwitchButton=new SwitchButton(play.bitmapData,pause.bitmapData);
			addChild(playpause);
			playpause.x=playpause.y=200;
			
			var load:Bitmap=new loadtrack();
			var playb:Bitmap=new playtrack();
			var progObj:SlideVO=new SlideVO(thumb,track,300,load,playb);
			progress=new ZProgressBar(progObj,progFun);
			addChild(progress);
			progress.y=300;
		}

		private function slideFun(value:Number):void
		{
			trace(value);
			progress.showPlay(value);
		}
		private function progFun(value:Number):void{
			trace(value);
		}
		protected function handleClick(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			trace("close Button clicked");
		}
	}
}

