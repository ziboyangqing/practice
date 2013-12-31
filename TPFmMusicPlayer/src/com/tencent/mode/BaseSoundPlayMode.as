
package com.tencent.mode {
	import flash.display.*;

	public class BaseSoundPlayMode extends Sprite {

		public static const STAT_STOP:int = 0;
		public static const STAT_START_TO_PLAY:int = 1;
		public static const STAT_PLAYING:int = 2;
		public static const STAT_PAUSE:int = 3;
		public static const STAT_BUFFER_START:int = 4;
		public static const STAT_PLAY_COMPLETE:int = 5;
		public static const STAT_LOAD_COMPLETE:int = 6;
		public static const TYPE_MP3:String = "mp3";
		public static const TYPE_M4A:String = "m4a";

		protected var currStat:int = 0;

		public function play(_arg1:String="", _arg2:int=5000):void{
		}
		public function pause():void{
		}
		public function resume():void{
		}
		public function stop():void{
		}
		public function close():void{
		}
		public function seek(_arg1:int):void{
		}
		public function get volume():Number{
			return (0);
		}
		public function set volume(_arg1:Number):void{
		}
		public function get mute():Boolean{
			return (false);
		}
		public function set mute(_arg1:Boolean):void{
		}
		public function get position():Number{
			return (0);
		}
		public function get totalTime():Number{
			return (0);
		}
		public function get playStat():int{
			return (0);
		}
		public function get bytesLoaded():Number{
			return (0);
		}
		public function get bytesTotal():Number{
			return (0);
		}
		public function destory():void{
		}

	}
}


