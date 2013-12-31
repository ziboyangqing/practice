
package com.tencent.mode {
	import flash.events.*;
	import com.tencent.event.*;
	import com.sun.media.video.*;
	import com.sun.utils.*;
	import com.tencent.video.media.*;
	import flash.utils.*;

	public class M4aPlayMode extends BaseSoundPlayMode {

		private var _statObj:Object;
		private var _stream:FlvStream;
		private var _volume:Number = 50;
		private var _tmpStat:int;
		private var _isMute:Boolean = false;
		private var _timeoutCount:uint = 0;
		private var _timeoutMax:Number = 30000;
		protected var playMetaData:Object;
		private var _timer:Timer;
		private var _preTime:int = 0;

		public function M4aPlayMode(){
			this.init();
		}
		override public function play(_arg1:String="", _arg2:int=5000):void{
			this.destory();
			if (!this._stream){
				this._stream = new FlvStream();
			};
			this.addEventListeners();
			this._stream.load(_arg1, (_arg2 * 0.001));
		}
		override public function pause():void{
			try {
				if (currStat == STAT_PLAYING){
					currStat = STAT_PAUSE;
					this.updateStat();
					if (this._stream){
						this._stream.pause();
					};
				};
			} catch(e:Error) {
				AS3Debugger.Trace(("M4aPlayMode::pause>>error:" + e.toString()));
			};
		}
		override public function resume():void{
			try {
				if (currStat == STAT_PAUSE){
					currStat = STAT_PLAYING;
					this.updateStat();
					if (this._stream){
						this._stream.resume();
					};
				};
			} catch(e:Error) {
				AS3Debugger.Trace(("M4aPlayMode::resume>>error:" + e.toString()));
			};
		}
		override public function stop():void{
			this.close();
		}
		override public function close():void{
			currStat = STAT_STOP;
			this.updateStat();
			if (this._stream){
				this._stream.closeStream();
			};
			currStat = STAT_PLAY_COMPLETE;
			if (((this._timer) && (this._timer.running))){
				this._timer.stop();
			};
			this.removeEventListeners();
		}
		override public function seek(_arg1:int):void{
			if (((((this._stream) && ((_arg1 <= this.totalTime)))) && ((_arg1 > 0)))){
				this._stream.seek(_arg1);
				currStat = STAT_PLAYING;
				this.updateStat();
			};
		}
		override public function get volume():Number{
			return (this._volume);
		}
		override public function set volume(_arg1:Number):void{
			if (this._stream){
				this._stream.volume = _arg1;
			};
			this._isMute = false;
		}
		override public function get mute():Boolean{
			return (this._isMute);
		}
		override public function set mute(_arg1:Boolean):void{
			this._isMute = _arg1;
			if (this._stream){
				if (this._isMute){
					this._stream.volume = 0;
				} else {
					this._stream.volume = this._volume;
				};
			};
		}
		override public function get position():Number{
			if (this._stream){
				return (this._stream.playTime);
			};
			return (0);
		}
		override public function get totalTime():Number{
			if (((this.playMetaData) && (this.playMetaData.duration))){
				return (this.playMetaData.duration);
			};
			return (0);
		}
		override public function get playStat():int{
			return (currStat);
		}
		override public function get bytesLoaded():Number{
			if (this._stream){
				return (this._stream.bytesLoaded);
			};
			return (0);
		}
		override public function get bytesTotal():Number{
			if (this._stream){
				return (this._stream.bytesTotal);
			};
			return (0);
		}
		override public function destory():void{
			this.removeEventListeners();
			if (this._stream){
				this._stream.closeStream();
			};
			this._stream = null;
			ForceGC.gc();
		}
		private function init():void{
			this._statObj = {};
			this._isMute = false;
		}
		private function addEventListeners():void{
			if (!this._stream){
				return;
			};
			this._stream.addEventListener(StreamEvent.STREAM_READY, this.readyHandler);
			this._stream.addEventListener(StreamEvent.STREAM_START_PLAY, this.startToPlayHandler);
			this._stream.addEventListener(StreamEvent.STREAM_MD, this.mdHandler);
			this._stream.addEventListener(StreamEvent.STREAM_NC_ERROR, this.errorHandler);
			this._stream.addEventListener(StreamEvent.STREAM_ERROR, this.errorHandler);
			this._stream.addEventListener(StreamEvent.STREAM_404, this.error404Handler);
			this._stream.addEventListener(StreamEvent.STREAM_STOP, this.playComplete);
			this._stream.addEventListener(StreamEvent.STREAM_EMPTY, this.emptyHandler);
			this._stream.addEventListener(StreamEvent.STREAM_FULL, this.fullHandler);
			if (!hasEventListener(Event.ENTER_FRAME)){
				this.addEventListener(Event.ENTER_FRAME, this.onSoundEnterFrame);
			};
		}
		private function removeEventListeners():void{
			if (!this._stream){
				return;
			};
			this._stream.removeEventListener(StreamEvent.STREAM_READY, this.readyHandler);
			this._stream.removeEventListener(StreamEvent.STREAM_START_PLAY, this.startToPlayHandler);
			this._stream.removeEventListener(StreamEvent.STREAM_MD, this.mdHandler);
			this._stream.removeEventListener(StreamEvent.STREAM_NC_ERROR, this.errorHandler);
			this._stream.removeEventListener(StreamEvent.STREAM_ERROR, this.errorHandler);
			this._stream.removeEventListener(StreamEvent.STREAM_404, this.error404Handler);
			this._stream.removeEventListener(StreamEvent.STREAM_STOP, this.playComplete);
			this._stream.removeEventListener(StreamEvent.STREAM_EMPTY, this.emptyHandler);
			this._stream.removeEventListener(StreamEvent.STREAM_FULL, this.fullHandler);
			if (this.hasEventListener(Event.ENTER_FRAME)){
				removeEventListener(Event.ENTER_FRAME, this.onSoundEnterFrame);
			};
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
				if (this.bytesTotal != 0){
					this._statObj.position = this.position;
					this._statObj.progress = Number(((this.bytesLoaded / this.bytesTotal) * 100)).toFixed(1);
					this._statObj.progress = ((this._statObj.progress > 100)) ? 100 : this._statObj.progress;
					this._statObj.progress = ((this._statObj.progress < 0)) ? 0 : this._statObj.progress;
				} else {
					this._statObj.position = 0;
					this._statObj.progress = 0;
				};
			};
		}
		private function readyHandler(_arg1:StreamEvent):void{
		}
		private function startToPlayHandler(_arg1:StreamEvent):void{
			if (this._timeoutCount != 0){
				clearTimeout(this._timeoutCount);
				this._timeoutCount = 0;
			};
			this._stream.removeEventListener(StreamEvent.STREAM_START_PLAY, this.startToPlayHandler);
			if (!this._stream.hasEventListener(StreamEvent.STREAM_EMPTY)){
				this._stream.addEventListener(StreamEvent.STREAM_EMPTY, this.emptyHandler);
				this._stream.addEventListener(StreamEvent.STREAM_FULL, this.fullHandler);
			};
			currStat = STAT_START_TO_PLAY;
			this.updateStat();
			currStat = STAT_PLAYING;
		}
		private function mdHandler(_arg1:StreamEvent):void{
			var _local2:*;
			this.metadataFormat(_arg1.value);
			AS3Debugger.Trace("M4aPlayMode::获取playMateData");
			for (_local2 in _arg1.value) {
				AS3Debugger.Trace(((_local2 + ":") + _arg1.value[_local2]));
			};
		}
		private function metadataFormat(_arg1:Object):void{
			if (!this.playMetaData){
				this.playMetaData = new Object();
			};
			if (((isNaN((_arg1.width * 1))) || (((_arg1.width * 1) <= 0)))){
				this.playMetaData.width = 320;
			} else {
				this.playMetaData.width = _arg1.width;
			};
			if (((isNaN((_arg1.height * 1))) || (((_arg1.height * 1) <= 0)))){
				this.playMetaData.height = 240;
			} else {
				this.playMetaData.height = _arg1.height;
			};
			if (((isNaN((_arg1.duration * 1))) || (((_arg1.duration * 1) <= 0)))){
				this.playMetaData.duration = 0;
			} else {
				this.playMetaData.duration = _arg1.duration;
			};
			_arg1 = null;
		}
		private function errorHandler(_arg1:StreamEvent):void{
			var _local2:*;
			if (this._timeoutCount != 0){
				clearTimeout(this._timeoutCount);
				this._timeoutCount = 0;
			};
			if (_arg1 != null){
				_local2 = _arg1.value;
			} else {
				_local2 = "requesttimeout";
			};
			switch (_local2){
			case "requesttimeout":
				break;
			case "NetConnection.Connect.Failed":
				break;
			case "NetConnection.Connect.Rejected":
				break;
			case "NetConnection.Connect.AppShutdown":
				break;
			case "NetConnection.Connect.InvalidApp":
				break;
			case "securityError":
				break;
			};
			AS3Debugger.Trace(("M4aPlayMode::errorHandler=" + _local2));
			this.removeEventListeners();
			this._stream.closeStream();
			currStat = STAT_STOP;
			dispatchEvent(new SoundPlayModeEvent(SoundPlayModeEvent.SOUND_ERROR, {code:_local2}));
		}
		private function error404Handler(_arg1:StreamEvent):void{
			if (this._timeoutCount != 0){
				clearTimeout(this._timeoutCount);
				this._timeoutCount = 0;
			};
			AS3Debugger.Trace("M4aPlayMode::error404Handler-NotFound or Can't be read.");
			this.removeEventListeners();
			this._stream.closeStream();
			currStat = STAT_STOP;
			dispatchEvent(new SoundPlayModeEvent(SoundPlayModeEvent.SOUND_ERROR, {code:"streamNotFound"}));
		}
		private function playComplete(_arg1:StreamEvent):void{
			if (this._stream.hasEventListener(StreamEvent.STREAM_EMPTY)){
				this._stream.removeEventListener(StreamEvent.STREAM_EMPTY, this.emptyHandler);
				this._stream.removeEventListener(StreamEvent.STREAM_FULL, this.fullHandler);
			};
			this.stop();
			currStat = STAT_PLAY_COMPLETE;
			this.updateStat();
			if (((this._timer) && (this._timer.running))){
				this._timer.stop();
			};
			AS3Debugger.Trace("M4aPlayMode::playComplete");
		}
		private function emptyHandler(_arg1:StreamEvent):void{
			this._tmpStat = currStat;
			currStat = STAT_BUFFER_START;
			this.updateStat();
			AS3Debugger.Trace("M4aPlayMode::emptyHandler");
		}
		private function fullHandler(_arg1:StreamEvent):void{
			currStat = this._tmpStat;
			AS3Debugger.Trace("M4aPlayMode::fullHandler");
		}
		private function onSoundEnterFrame(_arg1:Event):void{
			var _local2:int = getTimer();
			if ((_local2 - this._preTime) >= 1000){
				this._preTime = _local2;
				this.updateDataObj();
				dispatchEvent(new SoundPlayModeEvent(SoundPlayModeEvent.SOUND_DATA, this._statObj));
			};
		}

	}
}


