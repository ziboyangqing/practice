/*SimpleMediaPlayer*/
package com.smp {
	import flash.utils.*;
	import flash.events.*;
	import flash.net.*;
	import com.utils.AppUtil;

	public final class SURLLodader extends URLLoader {

		public var url:String;
		public var onerr:Function;
		public var oning:Function;
		public var onled:Function;
		public var checkbom:Boolean;

		public function SURLLodader(url:String, errFun:Function, progressFun:Function, completeFun:Function, checkBom:Boolean=true):void{
			var vars:* = null;
			var _url:* = url;
			var _onerr:* = errFun;
			var _oning:* = progressFun;
			var _onled:* = completeFun;
			var _checkbom:Boolean = checkBom;
			super();
			this.url = _url;
			this.onerr = _onerr;
			this.oning = _oning;
			this.onled = _onled;
			this.checkbom = _checkbom;
			dataFormat = URLLoaderDataFormat.BINARY;
			addEventListener(IOErrorEvent.IO_ERROR, this.onError);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
			addEventListener(ProgressEvent.PROGRESS, this.onProgress);
			addEventListener(Event.COMPLETE, this.onLoaded);
			var req:* = new URLRequest(this.url);
			if (Config.post_key){
				vars = new URLVariables();
				vars.cmp_key = Config.key;
				vars.cmp_url = Config.cmp_url;
				req.data = vars;
				req.method = URLRequestMethod.POST;
			};
			try {
				load(req);
			} catch(e:Error) {
				onError();
			};
		}
		public function stop():void{
			try {
				close();
			} catch(e:Error) {
			};
		}
		public function onError(_arg1:Event=null):void{
			this.onerr.call(null, ("Error load:" + this.url));
		}
		public function onProgress(_arg1:ProgressEvent):void{
			this.oning.call(null, _arg1.bytesLoaded, _arg1.bytesTotal);
		}
		public function onLoaded(_arg1:Event):void{
			var _local2:ByteArray = data;
			if (((this.checkbom) && (_local2))){
				_local2 = AppUtil.bom(_local2);
			};
			this.onled.call(null, _local2);
		}

	}
}


