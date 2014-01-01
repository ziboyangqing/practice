package zzl.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import zzl.utils.Tool;

	/**
	 * 用于播放暂停控制的自定义按钮
	 * @author zzlasp
	 * 
	 */	
	public class SwitchButton extends Sprite
	{
		
		private var playBtn:ZButton;
		private var pauseBtn:ZButton;
		/**
		 * 
		 * @param playIco 
		 * @param pauseIco
		 * 
		 */		
		public function SwitchButton(playBmp:BitmapData,pauseBmp:BitmapData)
		{
			playBtn=new ZButton(Tool.SplitBMD(playBmp,4,1));
			pauseBtn=new ZButton(Tool.SplitBMD(pauseBmp,4,1));
			addChild(pauseBtn);
			pauseBtn.visible=false;
			addChild(playBtn);
			addEventListener(MouseEvent.CLICK,toggleBtn);
		}
		
		protected function toggleBtn(event:MouseEvent):void
		{
			if(playBtn.visible){
				playBtn.visible=false
			}else{
				playBtn.visible=true;
			}
			pauseBtn.visible=!playBtn.visible;
		}
	}
}