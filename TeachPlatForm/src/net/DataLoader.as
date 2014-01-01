package net {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import conf.Config;

	public class DataLoader {

		private var callBack:Function;
		private var bit:String;
		private var request:URLRequest;
		private var methodKind:String;
		private var variables:URLVariables;
		private var loader:URLLoader;
		private var _result:String;
		private var callBackPara:String;
		private var _data:Object;

		public function DataLoader(data:Object=null,callback:Function=null, dataformat:String="BINARY", callbackPara:String="", charcode:String="gb2312", method:String="POST", autostart:Boolean=true){
			this.variables = new URLVariables();
			this.loader = new URLLoader();
			super();
			this.callBack = callback;
			this.callBackPara = callbackPara;
			this.bit = charcode;
			this._data=data;
			this.request = new URLRequest(Config.SERVER);
			this.methodKind = ((method)=="POST") ? "POST" : "GET";
			if (dataformat == "BINARY"){
				this.loader.dataFormat = URLLoaderDataFormat.BINARY;
				this.loader.addEventListener(Event.COMPLETE, this.loaded_BINARY);
			} else {
				if (dataformat == "VARIABLES"){
					this.loader.dataFormat = URLLoaderDataFormat.VARIABLES;
					this.loader.addEventListener(Event.COMPLETE, this.loaded_TEXT);
				} else {
					if (dataformat == "TEXT"){
						this.loader.dataFormat = URLLoaderDataFormat.TEXT;
						this.loader.addEventListener(Event.COMPLETE, this.loaded_TEXT);
					};
				};
			};
			this.request.method = (method=="POST") ? URLRequestMethod.POST : URLRequestMethod.GET;
			if (autostart){
				this.start();
			};
		}
		
		private function getUnique():String
		{
			var date:Date=new Date();
			return date.getTime().toString();
		}
		public function start():void{
			var errFun:Function= function (e:IOErrorEvent):void{
				trace("DataLoader Error...");
			};
			var num:Number = Math.random() ;
			this.upData({
				"pid":getUnique()
			});
			this.upData(_data);
			this.request.data = this.variables;
			trace("DataLoader:",variables);
			this.loader.load(this.request);
			this.loader.addEventListener(IOErrorEvent.IO_ERROR, errFun);
			this.loader.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
		}
		private function loaded_BINARY(e:Event):void{
			this.loader.removeEventListener(Event.COMPLETE,loaded_BINARY);
			var byte:ByteArray = ByteArray(this.loader.data);
			var muilty:String = byte.readMultiByte(byte.length, this.bit);
			this._result = muilty;
			this.callBack(this._result, this.callBackPara);
		}
		private function loaded_TEXT(_arg1:Event):void{
			this.loader.removeEventListener(Event.COMPLETE,loaded_TEXT);
			this._result = this.loader.data;
			this.callBack(this._result,this.callBackPara);
		}
		public function upData(obj:Object):void{
			for( var o:* in obj){
				this.variables.decode(o + "=" + obj[o]);
			}
		}
		public function get result():String{
			return (this._result);
		}
		public function onProgress(_arg1:ProgressEvent):void {
			trace("loading...");
		}
	}
} 


