/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.*;
	import flash.events.*;
	import flash.display.*;
	import flash.filters.*;
	import flash.net.*;
	import flash.media.*;
	import flash.geom.*;
	import flash.ui.*;
	import com.utils.AppUtil;

	public final class VideoItem extends SMedia {

		public var transform:SoundTransform;
		public var nc:NetConnection;
		public var ns:NetStream;
		public var isBuffering:Boolean = false;
		public var isFlush:Boolean = false;
		public var streaming:Boolean = false;
		public var keyframes:Object;
		public var meta:Boolean;
		public var mp4:Boolean;
		public var mp4_start:Number = 0;
		public var isRTMP:Boolean;
		public var edRTMP:Boolean;

		public function VideoItem():void{
			this.transform = new SoundTransform();
			this.nc = new NetConnection();
			this.nc.addEventListener(NetStatusEvent.NET_STATUS, this.statusHandler);
			this.nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.errorHandler);
			this.nc.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
			this.nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.errorHandler);
			this.nc.client = new NC(this);
			Main.addEventListener(SMPEvent.VIDEO_EFFECT, this.effectHandler);
			Main.addEventListener(SMPEvent.VIDEO_SMOOTHING, this.smoothingHandler);
		}
		override public function load():void{
			var _local1:String;
			Main.sendState(SMPStates.CONNECTING);
			loaded = false;
			if (Main.item.rtmp){
				this.isRTMP = true;
				this.edRTMP = false;
				if (Main.item.reload){
					this.nsError("RTMP Connect Failed");
				} else {
					url = this.getID(Main.item.src);
					trace("VideoItem RTMP:",url,Main.item.rtmp);

					this.nc.connect(Main.item.rtmp);
				};
			} else {
				this.isRTMP = false;
				url = Main.item.url;
				trace("VideoItem Normal:",url);
				if (!Main.item.stream){
					_local1 = Main.item.src;
					if (((!((_local1.indexOf("{start_seconds}") == -1))) || (!((_local1.indexOf("{start_bytes}") == -1))))){
						Main.item.stream = true;
					};
				};
				this.nc.connect(null);
			};
		}
		public function connect():void{
			this.ns = new NetStream(this.nc);
			this.ns.bufferTime = Config.buffer_time;
			this.ns.client = new NC(this);
			this.ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.errorHandler);
			this.ns.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
			this.ns.addEventListener(NetStatusEvent.NET_STATUS, this.statusHandler);
			Main.vv = new Video();
			Main.vv.attachNetStream(this.ns);
			trace("M2,connect:",url);
			this.ns.play(url);
			interval("add", [this.progressHandler]);
		}
		override public function play():void{
			this.ns.resume();
			this.volume();
			interval("add", [this.timeHandler]);
		}
		override public function pause():void{
			interval("del", [this.timeHandler]);
			this.ns.pause();
			Main.sendState(SMPStates.PAUSED);
		}
		override public function stop():void{
			interval("del", [this.timeHandler, this.progressHandler, this.whHandler]);
			this.mp4_start = 0;
			Main.item.start_seconds = 0;
			Main.item.start_bytes = 0;
			this.streaming = false;
			this.keyframes = null;
			this.meta = false;
			this.isRTMP = false;
			if (Main.vv){
				Main.vv.clear();
				Main.vv.visible = false;
				Main.vv = null;
			};
			if (this.ns){
				this.ns.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.errorHandler);
				this.ns.removeEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
				this.ns.removeEventListener(NetStatusEvent.NET_STATUS, this.statusHandler);
				try {
					this.ns.close();
				} catch(e:Error) {
				};
				this.ns = null;
			};
			if (this.nc.connected){
				this.nc.close();
			};
		}
		override public function volume():void{
			this.transform.volume = Config.volume;
			this.transform.pan = Config.panning;
			this.ns.soundTransform = this.transform;
			trace("M2:volume",this.ns.soundTransform.volume);
		}
		override public function seek(_arg1:Number):void{
			var _local2:Number;
			if ((((_arg1 < 0)) || ((_arg1 > 1)))){
				_local2 = (this.ns.time + _arg1);
			} else {
				if (Main.item.duration){
					_local2 = (Main.item.duration * _arg1);
				} else {
					return;
				};
			};
			var _local3:Object = this.getStart(_local2);
			var _local4:Number = _local3.seconds;
			var _local5:Number = _local3.bytes;
			if (Main.item.stream){
				if ((((_local5 < Main.item.start_bytes)) || ((_local5 >= (Main.item.start_bytes + this.ns.bytesLoaded))))){
					Main.sendState(SMPStates.CONNECTING);
					loaded = false;
					interval("del", [this.timeHandler, this.progressHandler, this.whHandler]);
					this.mp4_start = _local4;
					Main.item.start_seconds = _local4;
					Main.item.start_bytes = _local5;
					Main.item.position = _local4;
					url = AppUtil.auto(Main.item.src, Main.item);
					url = AppUtil.auto(url, Config);
					trace("M2,seek:",url);
					Main.item.url = url;
					this.streaming = true;
					this.ns.play(url);
					interval("add", [this.progressHandler]);
					return;
				};
			};
			if (this.isRTMP){
				this.isBuffering = true;
			};
			_local2 = _local4;
			if (this.mp4){
				_local2 = (_local2 - this.mp4_start);
			};
			if (_local2 < 0){
				_local2 = 0;
			};
			this.ns.seek(_local2);
			if (Config.state == SMPStates.PAUSED){
				this.play();
			};
		}
		public function statusHandler(_arg1:NetStatusEvent):void{
			var _local2:String = _arg1.info.code;
			switch (_local2){
			case "NetConnection.Connect.Success":
				this.connect();
				break;
			case "NetStream.Play.Start":
				this.start();
				break;
			case "NetStream.Buffer.Empty":
				if (!this.isFlush){
					this.isBuffering = true;
				};
				break;
			case "NetStream.Buffer.Full":
				this.isBuffering = false;
				break;
			case "NetStream.Buffer.Flush":
				this.isFlush = true;
				this.isBuffering = false;
				break;
			case "NetStream.Seek.InvalidTime":
				this.isBuffering = true;
				break;
			case "NetStream.Seek.Notify":
				this.isBuffering = false;
				break;
			case "NetStream.Play.Stop":
				if (((this.isRTMP) && ((Main.item.duration > 0)))){
					this.edRTMP = true;
				} else {
					this.completeHandler();
				};
				break;
			case "NetConnection.Connect.Rejected":
			case "NetConnection.Connect.Failed":
			case "NetStream.Play.StreamNotFound":
			case "NetStream.Play.Failed":
			case "NetStream.Failed":
			case "NetStream.Play.FileStructureInvalid":
			case "NetStream.Play.NoSupportedTrackFound":
				this.nsError(_local2);
				break;
			};
		}
		public function start():void{
			this.isBuffering = true;
			this.isFlush = false;
			Main.item.data = true;
			if (!this.streaming){
				Main.sendEvent(SMPEvent.MODEL_START);
			};
			this.volume();
			interval("add", [this.timeHandler, this.whHandler]);
		}
		public function whHandler(_arg1:Event):void{
			var _local4:String;
			var _local5:Array;
			var _local6:String;
			var _local2:Number = parseInt(Main.item.width);
			var _local3:Number = parseInt(Main.item.height);
			if (((_local2) && (_local3))){
				this.size(_local2, _local3);
			} else {
				if (((Main.vv.videoWidth) && (Main.vv.videoHeight))){
					this.size(Main.vv.videoWidth, Main.vv.videoHeight);
				} else {
					_local4 = Main.item.src;
					if (_local4){
						_local5 = _local4.split(".");
						_local6 = _local4.split(".")[(_local5.length - 1)].toLowerCase();
						if ((((((_local6 == "m4a")) || ((_local6 == "aac")))) || ((CS.EXTS[_local6] == CS.SOUND)))){
							interval("del", [this.whHandler]);
							Main.mv.showMixer(true);
						};
					};
				};
			};
		}
		public function size(_arg1:Number, _arg2:Number):void{
			interval("del", [this.whHandler]);
			Main.vv.width = _arg1;
			Main.vv.height = _arg2;
			Main.mv.showMedia(Main.vv);
			this.effectHandler();
			this.smoothingHandler();
		}
		public function timeHandler(_arg1:Event):void{
			var _local2:Object;
			var _local3:Number;
			if (this.isRTMP){
				if (Math.abs((this.ns.time - position)) > 0.2){
					position = this.ns.time;
				};
			} else {
				position = this.ns.time;
			};
			if (this.mp4){
				position = (position + this.mp4_start);
			};
			if (((!((position == Main.item.position))) && ((Config.state == SMPStates.PLAYING)))){
				Main.item.position = position;
				_local2 = this.getStart(position);
				Main.item.start_seconds = _local2.seconds;
				Main.item.start_bytes = _local2.bytes;
				Main.sendEvent(SMPEvent.MODEL_TIME);
			};
			if (((this.isBuffering) && (((((!(loaded)) || (!(Main.item.duration)))) || (this.isRTMP))))){
				_local3 = Math.floor(((this.ns.bufferLength * 100) / Config.buffer_time));
				if (_local3 < 100){
					Config.buffer_percent = _local3;
					Main.sendState(SMPStates.BUFFERING);
				};
			} else {
				if (Config.state != SMPStates.PLAYING){
					Main.sendState(SMPStates.PLAYING);
				};
			};
			if (((this.edRTMP) && ((Main.item.position >= Main.item.duration)))){
				this.edRTMP = false;
				this.completeHandler();
			};
		}
		public function progressHandler(_arg1:Event):void{
			var _local2:int;
			var _local3:Number;
			Main.item.bytes = this.ns.bytesTotal;
			if ((((this.ns.bytesTotal > 0)) && ((this.ns.bytesLoaded < this.ns.bytesTotal)))){
				_local2 = this.ns.bytesLoaded;
				if (this.streaming){
					if (this.ns.bytesTotal < bt){
						_local2 = ((bt - this.ns.bytesTotal) + this.ns.bytesLoaded);
					};
				} else {
					bt = this.ns.bytesTotal;
				};
				if (_local2 == bl){
					return;
				};
				bl = _local2;
				_local3 = 0;
				if (bt > 0){
					_local3 = (bl / bt);
				};
				Main.sendEvent(SMPEvent.MODEL_LOADING, _local3);
			} else {
				interval("del", [this.progressHandler]);
				Main.sendEvent(SMPEvent.MODEL_LOADED);
				loaded = true;
			};
		}
		public function smoothingHandler(_arg1:SMPEvent=null):void{
			if (!Main.vv){
				return;
			};
			if (_arg1){
				if (_arg1.data != null){
					Config.video_smoothing = AppUtil.tof(_arg1.data.toString());
				} else {
					Config.video_smoothing = !(Config.video_smoothing);
				};
			};
			Main.vv.smoothing = Config.video_smoothing;
		}
		public function effectHandler(_arg1:SMPEvent=null):void{
			var _local2:BitmapFilter;
			var _local3:Array;
			if (!Main.vv){
				return;
			};
			if (((_arg1) && (!((_arg1.data == null))))){
				_local3 = AppUtil.array(_arg1.data.toString());
				_local2 = new ColorMatrixFilter(_local3);
			} else {
				if (((Config.video_blackwhite) && (Config.video_highlight))){
					_local2 = new ColorMatrixFilter([1.5, 0, 0, 0, 0, 1.5, 0, 0, 0, 0, 1.5, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
				} else {
					if (Config.video_blackwhite){
						_local2 = new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0]);
					} else {
						if (Config.video_highlight){
							_local2 = new ColorMatrixFilter([1.5, 0, 0, 0, 0, 0, 1.5, 0, 0, 0, 0, 0, 1.5, 0, 0, 0, 0, 0, 1, 0]);
						};
					};
				};
			};
			if (_local2){
				Main.vv.filters = [_local2];
			} else {
				Main.vv.filters = null;
			};
		}
		public function errorHandler(_arg1:Event):void{
			this.nsError(_arg1);
		}
		public function nsError(_arg1:Object):void{
			Main.sendEvent(SMPEvent.MODEL_ERROR, _arg1);
		}
		public function completeHandler():void{
			finish();
		}
		public function metaHandler(_arg1:Object):void{
			Main.item.data = true;
			if (this.isRTMP){
				if (_arg1.type == "complete"){
					this.edRTMP = false;
					this.completeHandler();
				};
				if (_arg1.type == "close"){
					this.stop();
				};
			};
			if (((_arg1.duration) && (!(this.streaming)))){
				Main.item.xml.@duration = (Main.item.duration = _arg1.duration);
			};
			if (((_arg1.width) && (_arg1.height))){
				this.size(_arg1.width, _arg1.height);
			};
			if ((((_arg1["type"] == "metadata")) && (!(this.meta)))){
				this.meta = true;
				if (_arg1.seekpoints){
					this.mp4 = true;
					this.keyframes = this.skf(_arg1.seekpoints);
				} else {
					if (_arg1.keyframes){
						this.mp4 = false;
						this.keyframes = _arg1.keyframes;
					};
				};
			};
			Main.sendEvent(SMPEvent.MODEL_META, _arg1);
		}
		public function getStart(_arg1:Number):Object{
			var _local4:int;
			var _local2:Number = 0;
			var _local3:Number = 0;
			if (this.keyframes){
				_local4 = 0;
				while (_local4 < (this.keyframes.times.length - 1)) {
					if ((((this.keyframes.times[_local4] <= _arg1)) && ((this.keyframes.times[(_local4 + 1)] >= _arg1)))){
						break;
					};
					_local4++;
				};
				_local2 = this.keyframes.times[_local4];
				_local3 = this.keyframes.filepositions[_local4];
			} else {
				_local2 = Math.floor(_arg1);
				if (Main.item.bytes){
					_local3 = Math.floor(((Main.item.bytes * _arg1) / Main.item.duration));
				};
			};
			return ({
					seconds:_local2,
					bytes:_local3
				});
		}
		public function skf(_arg1:Object):Object{
			var _local3:String;
			var _local2:Object = {};
			_local2.times = [];
			_local2.filepositions = [];
			for (_local3 in _arg1) {
				_local2.times[_local3] = Number(_arg1[_local3]["time"]);
				_local2.filepositions[_local3] = Number(_arg1[_local3]["offset"]);
			};
			return (_local2);
		}
		public function getID(_arg1:String):String{
			var _local2:Array = _arg1.split("?");
			var _local3:String = _local2[0].substr(-4);
			_local2[0] = _local2[0].substr(0, (_local2[0].length - 4));
			if (_arg1.indexOf(":") > -1){
				return (_arg1);
			};
			if (_local3 == ".mp3"){
				return (("mp3:" + _local2.join("?")));
			};
			if ((((((((((((_local3 == ".mp4")) || ((_local3 == ".mov")))) || ((_local3 == ".m4v")))) || ((_local3 == ".aac")))) || ((_local3 == ".m4a")))) || ((_local3 == ".f4v")))){
				return (("mp4:" + _arg1));
			};
			if (_local3 == ".flv"){
				return (_local2.join("?"));
			};
			return (_arg1);
		}

	}
}


