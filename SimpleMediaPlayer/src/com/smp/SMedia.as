/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.*;
	import flash.events.*;
	import flash.display.*;

	public class SMedia {

		public var url:String;
		public var position:Number = 0;
		public var loaded:Boolean;
		public var bl:int;
		public var bt:int;
		private var timer:Sprite;

		public function SMedia(){
			this.timer = new Sprite();
			super();
		}
		public function interval(_arg1:String, _arg2:Array):void{
			var _local3:Function;
			var _local4:int;
			while (_local4 < _arg2.length) {
				_local3 = _arg2[_local4];
				if ((_local3 is Function)){
					this.timer.removeEventListener(Event.ENTER_FRAME, _local3);
					if (_arg1 == "add"){
						this.timer.addEventListener(Event.ENTER_FRAME, _local3);
					};
				};
				_local4++;
			};
		}
		public function load():void{
		}
		public function play():void{
		}
		public function pause():void{
		}
		public function stop():void{
		}
		public function seek(_arg1:Number):void{
		}
		public function finish():void{
			this.stop();
			Main.sendState(SMPStates.COMPLETED);
			Main.sendEvent(SMPEvent.MODEL_COMPLETE);
		}
		public function volume():void{
		}

	}
}


