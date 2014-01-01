/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.SMPEvent;

	import flash.display.DisplayObject;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.external.ExternalInterface;
	import flash.net.LocalConnection;
	import flash.system.Capabilities;
	import com.utils.AppUtil;

	public final class externalInterface extends JsProxy {

		public var lc_back:LocalConnection;
		public var lc_send:LocalConnection;
		public var one:Boolean = true;
		public var str:String;
		public var el:Object;

		public function externalInterface(){
			this.el = {};
			super();
			Config.flash_js = this.check();
			if (Config.flash_js){
				Main.addEventListener(SMPEvent.CONFIG_LOADED, this.init);
			};
			O.o(("flash_js:" + Config.flash_js));
			Main.addEventListener(CS.ERROR, this.c);
		}
		public function api():void{
			if (this.one){
				this.one = false;
				if (Config.api){
					this.eic(Config.api, Config.key);
					this.clc();
				};
			};
		}
		public function clc():void{
			this.lc_back = new LocalConnection();
			this.lc_back.allowDomain("*");
			this.lc_back.client = this;
			this.lc_back.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.eh);
			this.lc_back.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.eh);
			try {
				this.lc_back.connect(("_" + Config.api));
			} catch(e:ArgumentError) {
			};
			this.lc_send = new LocalConnection();
			this.lc_send.addEventListener(StatusEvent.STATUS, this.eh);
		}
		public function eh(_arg1:Event):void{
		}
		public function callback(_arg1:String, ... _args):void{
			var _local3:*;
			if (this.hasOwnProperty(_arg1)){
				_local3 = this[_arg1].apply(this, _args);
				this.lc_send.send((("_" + Config.api) + "_callback"), "callback", _local3);
			};
		}
		public function jsEvent(_arg1:String, _arg2:Object):void{
			var _local4:String;
			if (!Config.flash_js){
				return;
			};
			var _local3:Object = this.el[_arg1];
			if (!_local3){
				return;
			};
			for (_local4 in _local3) {
				this.eic(_local4, _arg2);
			};
		}
		public function sendEvent(... _args):void{
			Main.sendEvent(_args[0], _args[1]);
		}
		public function addEventListener(... _args):void{
			var _local2:String = _args[0];
			var _local3:String = _args[1];
			if (((_local2) && (_local3))){
				if (!this.el[_local2]){
					this.el[_local2] = {};
				};
				this.el[_local2][_local3] = _local3;
			};
		}
		public function removeEventListener(... _args):void{
			var _local2:String = _args[0];
			var _local3:String = _args[1];
			if (this.el[_local2]){
				if (_local3){
					delete this.el[_local2][_local3];
				} else {
					delete this.el[_local2];
				};
			};
		}
		public function ea(_arg1:String, _arg2:Function):void{
			ExternalInterface.addCallback(_arg1, _arg2);
		}
		public function init(_arg1:SMPEvent):void{
			this.ea("cmp_version", this.cmp_version);
			this.ea("cmp_api", this.cmp_api);
			this.ea("config", this.config);
			this.ea("item", this.item);
			this.ea("list_xml", this.list_xml);
			this.ea("list", this.list);
			this.ea("skin_xml", this.skin_xml);
			this.ea("skin", this.skin);
			this.ea("query", this.query);
			this.ea("sendEvent", this.sendEvent);
			this.ea("addEventListener", this.addEventListener);
			this.ea("removeEventListener", this.removeEventListener);
			this.ea("cookie", Main.ca.cookie);
			this.str = this.getStr(tag);
			this.eic(CS.EVAL, this.str);
		}
		public function cmp_version(... _args):String{
			return (Main.VERSION);
		}
		public function cmp_api(... _args):String{
			return (Main.ca.toString());
		}
		public function config(... _args):Object{
			if (_args[0]){
				if (_args.length > 1){
					Config[_args[0]] = AppUtil.parse(_args[1]);
				} else {
					return (Config[_args[0]]);
				};
			};
			return (Config);
		}
		public function item(... _args):Object{
			if (Main.item){
				if (_args[0]){
					if (_args.length > 1){
						Main.item[_args[0]] = AppUtil.parse(_args[1]);
					} else {
						return (Main.item[_args[0]]);
					};
				};
				return (Main.item.clone());
			};
			return ("");
		}
		public function list_xml(... _args):String{
			if (_args[0]){
				if ((((_args.length > 1)) && (!(_args[1])))){
					Main.lst.list_xml = <list/>
						;
					Main.sendEvent(SMPEvent.VIEW_STOP);
				};
				Main.sendEvent(SMPEvent.LIST_LOADED, _args[0]);
			};
			var _local2:String = "";
			if (Main.celh == AppUtil.celh){
				_local2 = Main.lst.list_xml.toXMLString();
			};
			return (_local2);
		}
		public function list(... _args):Object{
			var _local2:String;
			var _local3:TN;
			var _local4:String;
			if (_args[0]){
				if (typeof(_args[0]) == "object"){
					_local2 = _args[0].key;
				} else {
					_local2 = _args[0];
				};
				_local3 = (Main.tr.data.dict[_local2] as TN);
				if (!_local3){
					return ("");
				};
				if (_args.length == 1){
					return (_local3.clone(true));
				};
				_local4 = _args[1];
				if (((_local3.deleted) || (!(_local3.hasOwnProperty(_local4))))){
					return ("");
				};
				if ((_local3[_local4] is Function)){
					var _local5:TN = _local3;
					_local5[_local4]();
				} else {
					if (_args.length > 2){
						_local3[_local4] = AppUtil.parse(_args[2]);
					} else {
						return (_local3[_local4]);
					};
				};
				return ("");
			};
			return (Main.tr.data.root.clone(true).children);
		}
		public function skin_xml(... _args):String{
			return (Main.sk.skin_xml.toXMLString());
		}
		public function skin(... _args):String{
			var _local3:DisplayObject;
			var _local2:String = "";
			if (((_args[0]) && (_args[1]))){
				_local3 = Main.target(_args[0]);
				if (_local3){
					if (_local3.hasOwnProperty(_args[1])){
						if (_args.length > 2){
							try {
								_local3[_args[1]] = AppUtil.parse(_args[2]);
								_local2 = "true";
							} catch(e:Error) {
							};
						} else {
							try {
								_local2 = _local3[_args[1]].toString();
							} catch(e:Error) {
							};
						};
					};
				};
			};
			return (_local2);
		}
		public function query(... _args):String{
			var str:* = null;
			var arr:* = null;
			var obj:* = null;
			var nam:* = null;
			var p:* = null;
			var fn:* = null;
			var rest:* = _args;
			var val:* = "";
			if (rest[0]){
				str = rest[0];
				arr = str.split(".");
				obj = Main;
				while (arr.length) {
					nam = arr.shift();
					if (!obj.hasOwnProperty(nam)){
						break;
					};
					if (arr.length){
						obj = obj[nam];
					} else {
						if (rest[1]){
							p = AppUtil.parse(rest[1]);
							if ((obj[nam] is Function)){
								fn = (obj[nam] as Function);
								try {
									val = String(fn.call(null, p));
								} catch(e:Error) {
									val = "";
								};
							} else {
								val = "ok";
								try {
									obj[nam] = p;
								} catch(e:Error) {
									val = "";
								};
							};
						} else {
							val = String(obj[nam]);
						};
						break;
					};
				};
			};
			return (val);
		}
		public function eic(_arg1:String, _arg2:*=null):*{
			var fn:* = _arg1;
			var v:* = _arg2;
			if (!Config.flash_js){
				return (null);
			};
			try {
				if (v == null){
					return (ExternalInterface.call(fn));
				};
				return (ExternalInterface.call(fn, v));
			} catch(e:Error) {
				O.o(("not allow script access: " + e));
				return (null);
			};
		}
		public function kic(_arg1:String, _arg2:*=null):*{
			return this.eic(Config.key + "." + _arg1, _arg2);
		}
		public function load(_arg1:String):void{
			this.kic("load", _arg1);
		}
		public function play():void{
			this.kic("play");
		}
		public function pause():void{
			this.kic("pause");
		}
		public function stop():void{
			this.kic("stop");
		}
		public function seek(_arg1:Number):void{
			this.kic("seek", _arg1);
		}
		public function volume(_arg1:Number, _arg2:Number):void{
			this.kic("volume", [_arg1, _arg2]);
		}
		public function status():Array{
			return (this.kic("status"));
		}
		public function error():String{
			return (this.kic("error"));
		}
		public function info():Object{
			return (this.kic("info"));
		}
		public function image(_arg1:String):void{
			this.kic("image", _arg1);
		}
		public function execute(_arg1:String):void{
			this.kic("execute", _arg1);
		}
		public function getStr(_arg1:XML):String{
			var _local2:String = "";
			if (_arg1){
				_local2 = _arg1.text();
				_local2 = _local2.replace(/\/\/.*\s/ig, "");
				_local2 = _local2.replace(/\r|\n/ig, "");
				_local2 = _local2.replace(/CMP/ig, Config.key);
			};
			return (_local2);
		}
		public function check():Boolean{
			//return true;
			var arr:* = null;
			if (!ExternalInterface.available){
				return (false);
			};
			if ((((Capabilities.playerType == "ActiveX")) && (!(ExternalInterface.objectID)))){
				return (false);
			};
			try {
				arr = ExternalInterface.call("function(){return [location.href,document.referrer,document.title];}");
			} catch(e:Error) {
				return (false);
			};
			if ((arr is Array)){
				if (arr.length == 3){
					Config.page_url = arr[0];
					Config.page_referrer = arr[1];
					Config.page_title = arr[2];
					return (true);
				};
			};
			return (false);
		}
		//track
		public function c(_arg1:SMPEvent):void{
			W.c(_arg1.data);
		}

	}
}


