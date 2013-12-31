package com.tencent.core {
	import com.tencent.event.*;
	import com.sun.utils.*;
	import flash.display.*;
	import com.tencent.mode.*;
	import flash.utils.*;
	import flash.errors.*;

	public class SoundPlayer extends Sprite {

		public static const STAT_STOP:int = 0;
		public static const STAT_START_TO_PLAY:int = 1;
		public static const STAT_PLAYING:int = 2;
		public static const STAT_PAUSE:int = 3;
		public static const STAT_BUFFER_START:int = 4;
		public static const STAT_PLAY_COMPLETE:int = 5;

		private static var _instance:SoundPlayer = null;

		private var _sound:BaseSoundPlayMode;
		private var _volume:Number = 50;
		private var _statObj:Object;
		private var _tmpStat:int;
		private var _firstPlay:Boolean;
		private var _preTime:int = 0;
		private var _isMute:Boolean = false;
		private var _preFileType:String = "";

		public function SoundPlayer(){
			if (_instance != null){
				throw (new IllegalOperationError((getQualifiedClassName(this) + " :Please use getInstance() method to get its instance!")));
			};
		}
		public static function getInstance():SoundPlayer{
			if (_instance == null){
				_instance = new (SoundPlayer)();
			};
			return (_instance);
		}

		public function destory():void{
			if (this._sound){
				this.removeEventListeners();
				this._sound.destory();
				this._sound = null;
			};
		}
		public function play(url:String="", buffertime:int=5000, audiotype:String="mp3"):void{
			AS3Debugger.Trace("play url===[" + audiotype + "]");
			if (url == ""){
				if (this._sound){
					this._sound.resume();
				};
			} else {
				this.destory();
				switch (audiotype){
				case BaseSoundPlayMode.TYPE_MP3:
					this._sound = new Mp3PlayMode();
					break;
				case BaseSoundPlayMode.TYPE_M4A:
					this._sound = new M4aPlayMode();
					break;
				default:
					AS3Debugger.Trace("不支持的播放格式：" + audiotype + "！");
					return;
				};
				this.addEventListeners();
				this._sound.play(url, buffertime);
				this._sound.volume = this._volume;
				this._preFileType = audiotype;
			};
		}
		public function pause():void{
			if (this._sound){
				this._sound.pause();
			};
		}
		public function stop():void{
			if (this._sound){
				this._sound.stop();
			};
		}
		public function close():void{
			if (this._sound){
				this._sound.close();
			};
		}
		public function seek(_arg1:int):void{
			if (this._sound){
				this._sound.seek(_arg1);
			};
		}
		public function get volume():Number{
			return (this._volume);
		}
		public function set volume(_arg1:Number):void{
			this._volume = _arg1;
			if (this._sound){
				this._sound.volume = _arg1;
			};
		}
		public function get mute():Boolean{
			return (this._isMute);
		}
		public function set mute(_arg1:Boolean):void{
			this._isMute = _arg1;
			if (this._sound){
				this._sound.mute = this._isMute;
			};
		}
		public function get position():Number{
			if (this._sound){
				return (this._sound.position);
			};
			return (0);
		}
		public function get totalTime():Number{
			if (this._sound){
				return (this._sound.totalTime);
			};
			return (0);
		}
		public function get playStat():int{
			if (this._sound){
				return (this._sound.playStat);
			};
			return (BaseSoundPlayMode.STAT_STOP);
		}
		public function init():void{
		}
		private function soundIOErrorHandler(_arg1:SoundPlayModeEvent):void{
			dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.SOUND_IOERROR, _arg1.data));
		}
		private function soundErrorHandler(_arg1:SoundPlayModeEvent):void{
			dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.SOUND_IOERROR, _arg1.data));
		}
		private function soundStatChangeHandler(_arg1:SoundPlayModeEvent):void{
			dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.SOUND_STAT_CHANGE, _arg1.data));
		}
		private function soundDataHandler(_arg1:SoundPlayModeEvent):void{
			dispatchEvent(new SoundPlayerEvent(SoundPlayerEvent.SOUND_DATA, _arg1.data));
		}
		private function addEventListeners():void{
			if (!this._sound){
				return;
			};
			if (!this._sound.hasEventListener(SoundPlayModeEvent.SOUND_ERROR)){
				this._sound.addEventListener(SoundPlayModeEvent.SOUND_ERROR, this.soundErrorHandler);
			};
			if (!this._sound.hasEventListener(SoundPlayModeEvent.SOUND_IOERROR)){
				this._sound.addEventListener(SoundPlayModeEvent.SOUND_IOERROR, this.soundIOErrorHandler);
			};
			if (!this._sound.hasEventListener(SoundPlayModeEvent.SOUND_STAT_CHANGE)){
				this._sound.addEventListener(SoundPlayModeEvent.SOUND_STAT_CHANGE, this.soundStatChangeHandler);
			};
			if (!this._sound.hasEventListener(SoundPlayModeEvent.SOUND_DATA)){
				this._sound.addEventListener(SoundPlayModeEvent.SOUND_DATA, this.soundDataHandler);
			};
		}
		private function removeEventListeners():void{
			if (!this._sound){
				return;
			};
			if (this._sound.hasEventListener(SoundPlayModeEvent.SOUND_ERROR)){
				this._sound.removeEventListener(SoundPlayModeEvent.SOUND_ERROR, this.soundErrorHandler);
			};
			if (this._sound.hasEventListener(SoundPlayModeEvent.SOUND_IOERROR)){
				this._sound.removeEventListener(SoundPlayModeEvent.SOUND_IOERROR, this.soundIOErrorHandler);
			};
			if (this._sound.hasEventListener(SoundPlayModeEvent.SOUND_STAT_CHANGE)){
				this._sound.removeEventListener(SoundPlayModeEvent.SOUND_STAT_CHANGE, this.soundStatChangeHandler);
			};
			if (this._sound.hasEventListener(SoundPlayModeEvent.SOUND_DATA)){
				this._sound.removeEventListener(SoundPlayModeEvent.SOUND_DATA, this.soundDataHandler);
			};
		}

	}
}


