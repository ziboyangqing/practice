/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;
	import flash.media.*;
	import flash.ui.*;
	import flash.system.*;
	import com.utils.AppUtil;

	public final class AudioItem extends SMedia {

		public var sound:SSoundPlayer;
		public var context:SoundLoaderContext;
		public var duration:Number;

		public function AudioItem():void{
			this.context = new SoundLoaderContext((Config.buffer_time * 1000), true);
			this.sound = new SSoundPlayer();
			this.sound.addEventListener(Event.OPEN, this.openHandler, false, 0, true);
			this.sound.addEventListener(Event.COMPLETE, this.loadedHandler, false, 0, true);
			this.sound.addEventListener(Event.ID3, this.id3Handler, false, 0, true);
			this.sound.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler, false, 0, true);
			this.sound.addEventListener(ProgressEvent.PROGRESS, this.progressHandler, false, 0, true);
			this.sound.addEventListener(Event.SOUND_COMPLETE, this.completeHandler, false, 0, true);
		}
		override public function load():void{
			Main.sendState(SMPStates.CONNECTING);
			position = 0;
			this.duration = Main.item.duration;
			loaded = false;
			url = Main.item.url;
			trace("AudioItem:",url);
			this.sound.load(new URLRequest(url), this.context);
		}
		override public function play():void{
			this.sound.play(position);
			interval("add", [this.timeHandler]);
		}
		override public function pause():void{
			interval("del", [this.timeHandler]);
			position = this.sound.position;
			this.sound.pause();
			Main.sendState(SMPStates.PAUSED);
		}
		override public function stop():void{
			interval("del", [this.timeHandler]);
			position = 0;
			this.sound.stop();
		}
		override public function volume():void{
			this.sound.volume();
		}
		override public function seek(_arg1:Number):void{
			var _local2:Number;
			if (!this.sound.length){
				return;
			};
			if ((((_arg1 < 0)) || ((_arg1 > 1)))){
				_local2 = (this.sound.position + (_arg1 * 1000));
			} else {
				if (Main.item.duration){
					_local2 = ((Main.item.duration * _arg1) * 1000);
				} else {
					return;
				};
			};
			position = _local2;
			this.play();
		}
		public function timeHandler(_arg1:Event):void{
			var _local3:Number;
			position = this.sound.position;
			var _local2:Number = (position * 0.001);
			if (((!((_local2 == Main.item.position))) && ((Config.state == SMPStates.PLAYING)))){
				Main.item.position = _local2;
				Main.sendEvent(SMPEvent.MODEL_TIME);
			};
			if (((this.sound.buffering) && (!(loaded)))){
				_local3 = Math.round((((this.sound.length - position) / (Config.buffer_time * 1000)) * 100));
				if (_local3 < 100){
					Config.buffer_percent = _local3;
					Main.sendState(SMPStates.BUFFERING);
				};
			} else {
				if (Config.state != SMPStates.PLAYING){
					Main.sendState(SMPStates.PLAYING);
				};
			};
		}
		public function openHandler(_arg1:Event):void{
			Main.item.data = true;
			Main.sendEvent(SMPEvent.MODEL_START);
			this.play();
		}
		public function progressHandler(_arg1:ProgressEvent):void{
			var _local3:Number;
			bt = _arg1.bytesTotal;
			bl = _arg1.bytesLoaded;
			Main.item.bytes = bt;
			var _local2:Number = 0;
			if (bt > 0){
				_local2 = (bl / bt);
			};
			Main.sendEvent(SMPEvent.MODEL_LOADING, _local2);
			if (((((!(this.duration)) && ((_local2 > 0)))) && (this.sound.length))){
				_local3 = Math.floor(((this.sound.length * 0.001) / _local2));
				if (Math.abs((_local3 - Main.item.duration)) > 2){
					Main.item.duration = _local3;
				};
			};
		}
		public function loadedHandler(_arg1:Event):void{
			if (this.sound.length){
				Main.item.xml.@duration = (Main.item.duration = (this.sound.length * 0.001));
				Main.sendEvent(SMPEvent.MODEL_LOADED);
				loaded = true;
			} else {
				Main.sendEvent(SMPEvent.MODEL_ERROR, "Invalid MP3 Format");
			};
		}
		public function id3Handler(_arg1:Event):void{
			var _local3:Object;
			var _local4:String;
			var _local2:ID3Info = this.sound.id3;
			if (_local2){
				_local3 = {
						comment:"",
						album:"",
						genre:"",
						songName:"",
						artist:"",
						track:"",
						year:""
					};
				for (_local4 in _local3) {
					_local3[_local4] = AppUtil.toUTF(_local2[_local4]);
				};
				_local3.type = "id3";
				Main.sendEvent(SMPEvent.MODEL_META, _local3);
			};
		}
		public function errorHandler(_arg1:Event):void{
			Main.sendEvent(SMPEvent.MODEL_ERROR, _arg1);
		}
		public function completeHandler(_arg1:Event):void{
			finish();
		}

	}
}


