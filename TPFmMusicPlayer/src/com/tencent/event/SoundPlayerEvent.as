
package com.tencent.event {
	import flash.events.*;

	public class SoundPlayerEvent extends Event {

		public static const SOUND_IOERROR:String = "soundIOError";
		public static const SOUND_STAT_CHANGE:String = "soundStatChange";
		public static const SOUND_DATA:String = "soundData";

		public var data:*;

		public function SoundPlayerEvent(_arg1:String, _arg2:*=-1, _arg3:Boolean=false, _arg4:Boolean=false){
			super(_arg1, _arg3, _arg4);
			this.data = _arg2;
		}
	}
} 


