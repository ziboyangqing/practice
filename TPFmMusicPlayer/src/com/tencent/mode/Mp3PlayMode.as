
package com.tencent.mode {
	import com.sun.utils.*;
	import com.tencent.event.*;

	import flash.errors.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import flash.utils.*;

	public class Mp3PlayMode extends BaseSoundPlayMode {

		private var _currUrl:String;
		private var _sound:Sound;
		private var _channel:SoundChannel;
		private var _pausePosition:Number;
		private var _volume:Number = 50;
		private var _statObj:Object;
		private var _tmpStat:int;
		private var _firstPlay:Boolean;
		private var _preTime:int = 0;
		private var _isMute:Boolean;

		public function Mp3PlayMode(){
			this.init();
		}
		override public function destory():void{
			if (this._sound){
				this._sound.removeEventListener(IOErrorEvent.IO_ERROR, this.onSoundIOError);
			};
			this._channel.removeEventListener(Event.SOUND_COMPLETE, this.onSoundPlayComplete);
			if (this.hasEventListener(Event.ENTER_FRAME)){
				removeEventListener(Event.ENTER_FRAME, this.onSoundEnterFrame);
			};
			this.close();
			this._channel = null;
			this._sound = null;
			ForceGC.gc();
		}
		override public function play(_arg1:String="", _arg2:int=5000):void{
			var t_buffer:* = null;
			var $url:String = _arg1;
			var $bufferTime:int = _arg2;
			if (!$url){
				return;
			};
			this._currUrl = $url;
			try {
				this._firstPlay = true;
				this.close();
				this._sound = null;
				this._sound = new Sound();
				this._sound.addEventListener(IOErrorEvent.IO_ERROR, this.onSoundIOError);
				t_buffer = new SoundLoaderContext($bufferTime);
				this._sound.load(new URLRequest(this._currUrl), t_buffer);
				this._channel = this._sound.play();
				this._channel.addEventListener(Event.SOUND_COMPLETE, this.onSoundPlayComplete);
				if (this._volume){
					this.volume = this._volume;
				};
				if (!hasEventListener(Event.ENTER_FRAME)){
					addEventListener(Event.ENTER_FRAME, this.onSoundEnterFrame);
				};
			} catch(e:Error) {
				AS3Debugger.Trace(("SoundPlayer::play>>error:" + e.toString()));
			};
		}
		override public function resume():void{
			try {
				if (currStat == STAT_PAUSE){
					currStat = STAT_PLAYING;
					this.updateStat();
					this._channel = null;
					this._channel = this._sound.play(this._pausePosition);
					this._channel.addEventListener(Event.SOUND_COMPLETE, this.onSoundPlayComplete);
					if (!hasEventListener(Event.ENTER_FRAME)){
						addEventListener(Event.ENTER_FRAME, this.onSoundEnterFrame);
					};
				};
			} catch(e:Error) {
				AS3Debugger.Trace(("SoundPlayer::resume>>error:" + e.toString()));
			};
		}
		override public function pause():void{
			if (this._channel){
				if (currStat == STAT_PLAYING){
					currStat = STAT_PAUSE;
					this.updateStat();
					this._pausePosition = this._channel.position;
					this._channel.stop();
					if (hasEventListener(Event.ENTER_FRAME)){
						removeEventListener(Event.ENTER_FRAME, this.onSoundEnterFrame);
					};
				};
			};
		}
		override public function stop():void{
			this.close();
		}
		override public function close():void{
			if (this._sound){
				currStat = STAT_STOP;
				if (this._channel){
					this._channel.stop();
				};
				this.updateStat();
				this._pausePosition = 0;
				try {
					this._sound.close();
				} catch(e:IOError) {
					AS3Debugger.Trace(("Couldn't close stream :" + e.message));
				};
				removeEventListener(Event.ENTER_FRAME, this.onSoundEnterFrame);
			};
		}
		override public function seek(_arg1:int):void{
			if (this._sound){
				if ((((_arg1 <= (this._sound.length * 0.001))) && ((_arg1 > 0)))){
					if (this._channel){
						this._channel.stop();
					};
					this._channel = null;
					this._channel = this._sound.play((_arg1 * 1000));
					this._channel.addEventListener(Event.SOUND_COMPLETE, this.onSoundPlayComplete);
					currStat = STAT_PLAYING;
					this.updateStat();
				};
			};
		}
		override public function get volume():Number{
			if (this._channel){
				return ((this._channel.soundTransform.volume * 100));
			};
			return (0);
		}
		override public function set volume(_arg1:Number):void{
			if (_arg1 > 100){
				_arg1 = 100;
			} else {
				if (_arg1 < 0){
					_arg1 = 0;
				};
			};
			this._volume = _arg1;
			this._isMute = false;
			var _local2:SoundTransform = this._channel.soundTransform;
			_local2.volume = (_arg1 * 0.01);
			this._channel.soundTransform = _local2;
		}
		override public function get mute():Boolean{
			return (this._isMute);
		}
		override public function set mute(_arg1:Boolean):void{
			this._isMute = _arg1;
			var _local2:SoundTransform = this._channel.soundTransform;
			if (this._isMute){
				_local2.volume = 0;
			} else {
				_local2.volume = (this._volume * 0.01);
			};
			this._channel.soundTransform = _local2;
		}
		override public function get position():Number{
			if (this._channel){
				return ((this._channel.position * 0.001));
			};
			return (0);
		}
		override public function get totalTime():Number{
			if (this._sound){
				return Math.round(this._sound.length / (this._sound.bytesLoaded / this._sound.bytesTotal) * 0.001);
			};
			return (0);
		}
		override public function get playStat():int{
			return (currStat);
		}
		private function init():void{
			this._sound = new Sound();
			this._channel = new SoundChannel();
			this._statObj = {};
			this._isMute = false;
		}
		private function onSoundIOError(_arg1:IOErrorEvent):void{
			var _local2:String = ("打开文件" + this._currUrl + "出错！");
			dispatchEvent(new SoundPlayModeEvent(SoundPlayModeEvent.SOUND_IOERROR, _local2));
		}
		private function onSoundPlayComplete(_arg1:Event):void{
			this._statObj.playStat = (currStat = STAT_PLAY_COMPLETE);
			removeEventListener(Event.ENTER_FRAME, this.onSoundEnterFrame);
			this.updateStat();
		}
		private function onSoundProgress(_arg1:ProgressEvent):void{
		}
		private function onSoundEnterFrame(_arg1:Event):void{
			var _local2:int = getTimer();
			if (this._sound.isBuffering){
				if (currStat != STAT_BUFFER_START){
					this._tmpStat = currStat;
					this._statObj.playStat = (currStat = STAT_BUFFER_START);
					if (!this._firstPlay){
						this.updateStat();
					};
				};
			} else {
				if (currStat == STAT_BUFFER_START){
					if (this._firstPlay){
						this._firstPlay = false;
						this._statObj.playStat = (currStat = STAT_START_TO_PLAY);
						this.updateStat();
						this._statObj.playStat = (currStat = STAT_PLAYING);
					} else {
						this._statObj.playStat = (currStat = this._tmpStat);
					};
					this.updateStat();
				};
			};
			if ((_local2 - this._preTime) >= 1000){
				this._preTime = _local2;
				this.updateData();
			};
			//this.updateStat();
		}
		private function updateStat():void{
			this.updateDataObj();
			dispatchEvent(new SoundPlayModeEvent(SoundPlayModeEvent.SOUND_STAT_CHANGE, this._statObj));
		}
		private function updateDataObj():void{
			this._statObj.playStat = currStat;
			if (currStat == STAT_STOP){
				this._statObj.position = 0;
				this._statObj.progress = 0;
			} else {
				this._statObj.position = this.position;
				this._statObj.progress = Number(((this._sound.bytesLoaded / this._sound.bytesTotal) * 100)).toFixed(1);
				this._statObj.progress = ((this._statObj.progress > 100)) ? 100 : this._statObj.progress;
				this._statObj.progress = ((this._statObj.progress < 0)) ? 0 : this._statObj.progress;
			};
		}
		private function updateData():void{
			this.updateDataObj();
			dispatchEvent(new SoundPlayModeEvent(SoundPlayModeEvent.SOUND_DATA, this._statObj));
		}

	}
}


