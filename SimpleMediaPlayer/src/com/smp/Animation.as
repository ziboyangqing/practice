/*SimpleMediaPlayer*/
package com.smp {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	public class Animation {

		public var option:Object;
		public var time:int;
		public var timeout:int;
		public var sprite:Sprite;

		public function Animation(_arg1:Object):void{
			var _local2:String;
			this.option = {
					target:null,
					delay:0,
					duration:100,
					easing:EA.linear,
					start:null,
					step:null,
					complete:null,
					from:0,
					data:0,
					till:1
				};
			this.sprite = new Sprite();
			super();
			if (_arg1){
				for (_local2 in _arg1) {
					this.option[_local2] = _arg1[_local2];
				};
			};
			if (isNaN(this.option.delay)){
				this.option.delay = 0;
			};
			if (!(this.option.easing is Function)){
				this.option.easing = EA.linear;
			};
			if (this.option.delay > 0){
				this.timeout = setTimeout(this.start, this.option.delay);
			} else {
				this.start();
			};
		}
		public function start():void{
			if ((this.option.start is Function)){
				this.option.start.call(this);
			};
			this.time = getTimer();
			this.sprite.addEventListener(Event.ENTER_FRAME, this.running, false, 0, true);
		}
		public function running(_arg1:Event):void{
			var _local2:int = getTimer();
			var _local3:Number = (_local2 - this.time);
			var _local4:Number = this.option.duration;
			if (_local3 < _local4){
				this.option.data = this.calculate(_local3, _local4, this.option.from, this.option.till);
				this.step();
			} else {
				this.option.data = this.option.till;
				this.step();
				this.stop();
				this.complete();
			};
		}
		public function calculate(_arg1:Number, _arg2:Number, _arg3:*, _arg4:*):*{
			var _local5:Number;
			var _local6:Number;
			var _local7:Object;
			var _local8:String;
			if ((((typeof(_arg3) === "number")) && ((typeof(_arg4) === "number")))){
				_local5 = Number(_arg3);
				_local6 = (Number(_arg4) - _local5);
				return (this.option.easing.call(this, _arg1, _local5, _local6, _arg2));
			};
			if ((((typeof(_arg3) === "object")) && ((typeof(_arg4) === "object")))){
				_local7 = {};
				for (_local8 in _arg3) {
					if (typeof(_arg4[_local8]) === "undefined"){
						_local7[_local8] = _arg3[_local8];
					} else {
						_local7[_local8] = this.calculate(_arg1, _arg2, _arg3[_local8], _arg4[_local8]);
					};
				};
				return (_local7);
			};
			return (_arg3);
		}
		public function step():void{
			if ((this.option.step is Function)){
				this.option.step.call(this, this.option.data);
			};
		}
		public function complete():void{
			if ((this.option.complete is Function)){
				this.option.complete.call(this);
			};
		}
		public function stop():void{
			clearTimeout(this.timeout);
			this.sprite.removeEventListener(Event.ENTER_FRAME, this.running);
		}

	}
}


