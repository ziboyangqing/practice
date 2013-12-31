package com.tencent.video.media {
	import com.sun.media.video.*;

	import flash.events.*;
	import flash.media.*;
	import flash.net.*;

	public class FlvStream extends EventDispatcher {

		private var _bufferTime:int = 2;
		private var _flvPath:String = "";
		private var _server:String = "";
		private var _stream:NetStream;
		private var _connection:NetConnection;
		private var _readyToPlay:Boolean = false;
		private var _fullForTheFirstTime:Boolean;
		private var empty:Boolean;

		public function get readyToPlay():Boolean{
			return (this._readyToPlay);
		}
		public function load(url:String, buffertime:int=2):void{
			if (url == ""){
				throw (new Error("不能提供空的路径"));
			};
			this._bufferTime = buffertime;
			this._flvPath = url;
			this._server = null;
			this._readyToPlay = false;
			this.netObjDestroy();
			this.connectionInit();
		}
		private function netObjDestroy():void{
			if (this._stream){
				this._stream.close();
				this._stream.removeEventListener(NetStatusEvent.NET_STATUS, this.nsStatusHandler);
				this._stream.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
				this._stream.removeEventListener(IOErrorEvent.IO_ERROR, this.ioError);
				this._stream = null;
			};
			if (this._connection != null){
				this._connection.close();
				this._connection.removeEventListener(NetStatusEvent.NET_STATUS, this.ncStatusHandler);
				this._connection.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
				this._connection.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
				this._connection = null;
			};
		}
		private function asyncErrorHandler(_arg1:AsyncErrorEvent):void{
		}
		private function securityErrorHandler(_arg1:SecurityErrorEvent):void{
			dispatchEvent(new StreamEvent(StreamEvent.STREAM_ERROR, "securityError"));
		}
		private function ioError(_arg1:IOErrorEvent):void{
		}
		private function connectionInit():void{
			var _local1:Object;
			this._connection = new NetConnection();
			this._connection.addEventListener(NetStatusEvent.NET_STATUS, this.ncStatusHandler);
			this._connection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
			this._connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.securityErrorHandler);
			if (this._flvPath.indexOf("rtmp://") >= 0){
				_local1 = this.splitRMPTURL(this._flvPath);
				this._server = _local1.server;
				this._flvPath = _local1.flvname;
			};
			this._connection.connect(this._server);
		}
		private function splitRMPTURL(_arg1:String):Object{
			var _local8:String;
			var _local2:Object = new Object();
			var _local3:Array = _arg1.split("/");
			var _local4:uint = _local3.length;
			var _local5:String = "";
			var _local6:String = "";
			var _local7:uint;
			while (_local7 < _local4) {
				if (_local7 < 4){
					_local5 = (_local5 + (_local3[_local7] + "/"));
				} else {
					if (_local7 == (_local4 - 1)){
						_local8 = _local3[_local7];
						if (_local8.lastIndexOf(".mp4") >= 0){
							if (_local8.indexOf("mp4:") != 0){
								_local8 = ("mp4:" + _local8);
							};
						};
						_local6 = (_local6 + _local8);
					} else {
						_local6 = (_local6 + (_local3[_local7] + "/"));
					};
				};
				_local7++;
			};
			_local6 = _local6.substr(0, (_local6.length - 4));
			_local2.server = _local5;
			_local2.flvname = _local6;
			return (_local2);
		}
		private function ncStatusHandler(_arg1:NetStatusEvent):void{
			switch (_arg1.info.code){
			case "NetConnection.Connect.Success":
				this.streamInit();
				break;
			case "NetConnection.Connect.Closed":
				dispatchEvent(new StreamEvent(StreamEvent.STREAM_NC_CLOSED, "NetConnection.Connect.Closed"));
				break;
			case "NetConnection.Connect.Failed":
				dispatchEvent(new StreamEvent(StreamEvent.STREAM_NC_ERROR, "NetConnection.Connect.Failed"));
				break;
			case "NetConnection.Connect.Rejected":
				dispatchEvent(new StreamEvent(StreamEvent.STREAM_NC_ERROR, "NetConnection.Connect.Rejected"));
				break;
			case "NetConnection.Connect.AppShutdown":
				dispatchEvent(new StreamEvent(StreamEvent.STREAM_NC_ERROR, "NetConnection.Connect.AppShutdown"));
				break;
			case "NetConnection.Connect.InvalidApp":
				dispatchEvent(new StreamEvent(StreamEvent.STREAM_NC_ERROR, "NetConnection.Connect.InvalidApp"));
			default:
				dispatchEvent(new StreamEvent(StreamEvent.STREAM_NC_ERROR, "other error"));
			};
		}
		private function streamInit():void{
			this._stream = new NetStream(this._connection);
			this._stream.addEventListener(NetStatusEvent.NET_STATUS, this.nsStatusHandler);
			this._stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.asyncErrorHandler);
			this._stream.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
			this._stream.client = this;
			this._stream.bufferTime = this._bufferTime;
			this._fullForTheFirstTime = false;
			try {
				this._stream.play(this._flvPath);
			} catch(e:Error) {
			};
		}
		private function nsStatusHandler(_arg1:NetStatusEvent):void{
			switch (_arg1.info.code){
			case "NetStream.Play.Start":
				if (!this._readyToPlay){
					this._readyToPlay = true;
					this.empty = false;
					if (this._server != null){
						this._stream.pause();
					};
					this._fullForTheFirstTime = false;
					dispatchEvent(new StreamEvent(StreamEvent.STREAM_READY));
				};
				break;
			case "NetStream.Play.StreamNotFound":
				dispatchEvent(new StreamEvent(StreamEvent.STREAM_404, "StreamNotFound"));
				break;
			case "NetStream.Buffer.Empty":
				if ((((this._stream.bytesLoaded > 0)) && ((this._stream.bytesLoaded == this._stream.bytesTotal)))){
					return;
				};
				if (this._fullForTheFirstTime){
					this.empty = true;
					dispatchEvent(new StreamEvent(StreamEvent.STREAM_EMPTY));
				};
				break;
			case "NetStream.Buffer.Full":
				if (!this._fullForTheFirstTime){
					this._fullForTheFirstTime = true;
					this._stream.bufferTime = this._bufferTime;
					dispatchEvent(new StreamEvent(StreamEvent.STREAM_START_PLAY));
				} else {
					if (this.empty){
						this.empty = false;
						dispatchEvent(new StreamEvent(StreamEvent.STREAM_FULL));
					};
				};
				break;
			case "NetStream.Buffer.Flush":
				break;
			case "NetStream.Seek.Notify":
				break;
			case "NetStream.Seek.InvalidTime":
				if (_arg1.info.details != 0){
					this._stream.seek(_arg1.info.details);
					dispatchEvent(new StreamEvent(StreamEvent.STREAM_INVALIDTIME, _arg1.info.details));
				};
				break;
			case "NetStream.Play.Stop":
				if ((((((this._server == null)) && ((this._stream.bytesLoaded > 0)))) && ((this._stream.bytesLoaded == this._stream.bytesTotal)))){
					dispatchEvent(new StreamEvent(StreamEvent.STREAM_STOP));
				};
				break;
			};
			dispatchEvent(new StreamEvent(StreamEvent.STREAM_STATUS, _arg1.info));
		}
		public function onMetaData(_arg1:Object):void{
			dispatchEvent(new StreamEvent(StreamEvent.STREAM_MD, _arg1));
		}
		public function onPlayStatus(_arg1:Object):void{
			dispatchEvent(new StreamEvent(StreamEvent.STREAM_STOP));
		}
		public function get bytesLoaded():Number{
			if (!this._stream){
				return (0);
			};
			return (this._stream.bytesLoaded);
		}
		public function get bytesTotal():Number{
			if (!this._stream){
				return (0);
			};
			return (this._stream.bytesTotal);
		}
		public function getLoadedPercent():Number{
			if (!this._stream){
				return (0);
			};
			if (this._stream.bytesTotal == 0){
				return (0);
			};
			return ((this._stream.bytesLoaded / this._stream.bytesTotal));
		}
		public function get playTime():Number{
			if (!this._stream){
				return (0);
			};
			return (this._stream.time);
		}
		public function get bufferPercent():Number{
			if (!this._stream){
				return (0);
			};
			if (this.empty){
				return ((this._stream.bufferLength / this._stream.bufferTime));
			};
			return (1);
		}
		public function get bufferPerToPlay():Number{
			if (!this._stream){
				return (0);
			};
			return ((this._stream.bufferLength / this._stream.bufferTime));
		}
		public function get bufferLength():Number{
			if (!this._stream){
				return (0);
			};
			return (this._stream.bufferLength);
		}
		public function closeStream():void{
			this.netObjDestroy();
		}
		public function get volume():Number{
			var _local1:SoundTransform;
			if (this._stream){
				_local1 = this._stream.soundTransform;
				return ((_local1.volume * 100));
			};
			return (0);
		}
		public function set volume(_arg1:Number):void{
			var _local2:SoundTransform;
			if (this._stream){
				if (_arg1 > 500){
					_arg1 = 500;
				} else {
					if (_arg1 < 0){
						_arg1 = 0;
					};
				};
				_local2 = this._stream.soundTransform;
				_local2.volume = (_arg1 / 100);
				this._stream.soundTransform = _local2;
			};
		}
		public function set bufferTime(_arg1:int):void{
			this._bufferTime = _arg1;
			if (_arg1 > 10){
				_arg1 = 10;
			} else {
				if (_arg1 < 2){
					_arg1 = 2;
				};
			};
			if (((this._fullForTheFirstTime) && (this._stream))){
				this._stream.bufferTime = _arg1;
			};
		}
		public function get bufferTime():int{
			return (this._bufferTime);
		}
		public function get isLive():Boolean{
			if (this._server == null){
				return (false);
			};
			return (true);
		}
		public function pause():Boolean{
			if (this._stream){
				this._stream.pause();
				return (true);
			};
			return (false);
		}
		public function resume():Boolean{
			if (this._stream){
				this._stream.resume();
				return (true);
			};
			return (false);
		}
		public function seek(_arg1:Number):Boolean{
			if (this._stream){
				_arg1 = (Math.floor((_arg1 * 100)) / 100);
				if (_arg1 < -1){
				};
				this._stream.seek(_arg1);
				return (true);
			};
			return (false);
		}
		public function attachVideo(_arg1:Video):void{
			if (((_arg1) && (this._stream))){
				_arg1.attachNetStream(this._stream);
			};
		}
		public function startToChange():void{
			if (this._stream){
				this._stream.pause();
				this._stream.resume();
				this._stream.seek(0);
			};
		}
		public function get stream():NetStream{
			return (this._stream);
		}

	}
}

