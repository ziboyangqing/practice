/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.SMPEvent;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.KeyboardEvent;
	import flash.media.Video;
	import flash.net.FileReference;
	import flash.net.SharedObject;
	import flash.system.Capabilities;
	import flash.system.Security;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	import com.utils.AppUtil;

	public final class Main extends Sprite {

		public static const VERSION:String = "S.M.P. 2012.12.12";
		public static const NAME:String = "Simple Media Player";
		//public static const cenfun_music_player_email:String = "smp@mail.com";
		public static const LINK:String = "http://www.smp.com";
		//public static const cenfun_music_player_author:String = "S.M.P.";
		//public static const cenfun_music_player_copyright:String = "SMP 2.0 Copyright 2012 - 2020 SMP.Com";
		//public static const cenfun_music_player_license:String = "许可协议license: CC BY-ND (http://creativecommons.org/licenses/by-nd/3.0/deed.zh)";
		//public static const cenfun_music_player_readme:String = "版权声明：CMP程序受中国著作权法的保护，任何非法破解或反编译修改CMP程序的行为，或其他非法使用的行为，都将对著作权人合法权益造成侵害，著作权人有权依法追究其法律责任。请尊重他人劳动成果！谢谢！";

		public static var ds:DefaultSkin;
		public static var info:Info;
		public static var ca:Commander;
		public static var ei:externalInterface;
		public static var cc:SMPCore;
		public static var mm:MediaManager;
		public static var cf:SConfiger;
		public static var sk:Skin;
		public static var menue:SMenue;
		public static var lst:SList;
		public static var vv:Video;
		public static var bg:BackGround;
		public static var ws:WS;
		public static var wc:MediaControl;
		public static var wm:WM;
		public static var mv:MediaView;
		public static var mx:MX;
		public static var vc:ViewControl;
		public static var wl:WL;
		public static var tr:TR;
		public static var wr:WR;
		public static var lc:SLrc;
		public static var wo:WO;
		public static var fp:FP;
		public static var wf:WF;
		public static var tp:TP;
		public static var ld:LD;
		public static var group:Object;
		public static var cps:Object;
		public static var cookie:SharedObject;
		public static var local:Boolean;
		public static var item:TN;
		public static var main:Main;
		public static var celh:Function = AppUtil.celh;

		public function Main():void{
			if (main){
				addChild(main);
				return;
			};
			System.useCodePage = false;//true;
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			main = this;
			if (stage){
				this.init();
			} else {
				addEventListener(Event.ADDED_TO_STAGE, this.iewh);
			};
		}
		public static function write(_arg1:Object):void{
			var _local2:String;
			for (_local2 in _arg1) {
				Config[_local2] = AppUtil.parse(_arg1[_local2]);
			};
		}
		public static function setCookie(_arg1:String, _arg2:Object, _arg3:Boolean=false):void{
			if (cookie){
				cookie.data[_arg1] = _arg2.toString();
				if (_arg3){
					cookie.flush();
				};
			};
		}
		public static function getCookie(_arg1:String):Object{
			if (cookie){
				return (cookie.data[_arg1]);
			};
			return (null);
		}
		public static function clear(_arg1:DisplayObjectContainer):void{
			if (!_arg1){
				return;
			};
			while (_arg1.numChildren) {
				_arg1.removeChildAt(0);
			};
		}
		public static function rm(_arg1:DisplayObjectContainer):void{
			var _local2:DisplayObject;
			var _local3:RemovableSP;
			if (!_arg1){
				return;
			};
			while (_arg1.numChildren) {
				_local2 = _arg1.getChildAt(0);
				if ((_local2 is RemovableSP)){
					_local3 = (_local2 as RemovableSP);
					_local3.rm();
				} else {
					_arg1.removeChild(_local2);
				};
			};
		}
		public static function input(_arg1:Object):Boolean{
			if (_arg1){
				if ((_arg1 is TextField)){
					if (_arg1.type == TextFieldType.INPUT){
						return (true);
					};
				};
			};
			return (false);
		}
		public static function fU(_arg1:String, _arg2:Boolean=false):String{
			var _local3:String;
			if (_arg1){
				if (((_arg2) && (local))){
					_arg1 = _arg1.replace(":", "");
				};
				if (Config.cmp_host){
					_local3 = _arg1.split("?")[0];
					if (_local3.indexOf(":") != -1){
						return (_arg1);
					};
					if (_local3.substr(0, 1) == "/"){
						return ((Config.cmp_host + _arg1));
					};
					return ((Config.cmp_path + _arg1));
				};
			};
			//trace(_arg1,"................");
			return (_arg1);
		}
		public static function scalemode(_arg1:TN=null):Number{
			_arg1 = ((_arg1) || (item));
			var _local2:Number = Config.video_scalemode;
			if (_arg1){
				if (!isNaN(_arg1.scalemode)){
					_local2 = _arg1.scalemode;
				};
			};
			if (isNaN(_local2)){
				_local2 = 1;
			};
			return (_local2);
		}
		public static function api(_arg1:LoaderInfo):String{
			var _local3:Boolean;
			var _local4:Object;
			var _local5:SMPEvent;
			var _local2:String;
			if (_arg1){
				_local3 = _arg1.sharedEvents.hasEventListener(SMPEvent.API);
				if (_local3){
					_local2 = AppUtil.key("KEY_");
					ca.addKey(_local2);
					_local4 = {
							api:ca,
							key:_local2
						};
					_local5 = new SMPEvent(SMPEvent.API, _local4);
					_arg1.sharedEvents.dispatchEvent(_local5);
				};
			};
			return (_local2);
		}
		public static function apirm(_arg1:LoaderInfo):void{
			var _local2:Boolean;
			var _local3:SMPEvent;
			if (_arg1){
				_local2 = _arg1.sharedEvents.hasEventListener(SMPEvent.API_REMOVE);
				if (_local2){
					_local3 = new SMPEvent(SMPEvent.API_REMOVE);
					_arg1.sharedEvents.dispatchEvent(_local3);
				};
			};
		}
		public static function target(_arg1:String):DisplayObject{
			var _local2:DisplayObject;
			var _local3:Array;
			var _local4:W;
			if (_arg1){
				_local3 = _arg1.split(".");
				_local4 = ws.wins[_local3[0]];
				if (_local4){
					if (_local3[1]){
						if (_local4.hasOwnProperty(_local3[1])){
							_local2 = _local4[_local3[1]];
						};
					} else {
						_local2 = _local4;
					};
				};
			};
			return (_local2);
		}
		public static function addEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false, _arg4:int=0, _arg5:Boolean=true):void{
			main.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
		}
		public static function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false):void{
			main.removeEventListener(_arg1, _arg2, _arg3);
		}
		public static function sendEvent(_arg1:String, _arg2:Object=null):void{
			main.dispatchEvent(new SMPEvent(_arg1, _arg2));
			ei.jsEvent(_arg1, _arg2);
		}
		public static function sendState(_arg1:String):void{
			Config.state = _arg1;
			sendEvent(SMPEvent.MODEL_STATE, _arg1);
		}
		public static function toString():String{
			var _local1:String = getQualifiedClassName(Main);
			_local1 = _local1.substr((_local1.length - 3));
			return (_local1);
		}

		private function iewh(_arg1:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, this.iewh);
			this.init();
		}
		public function init():void{
			var _local6:String;
			var _local7:String;
			var _local8:String;
			var _local11:String;
			var _local12:String;
			var _local13:TextFormat;
			var _local14:TextField;
			var _local15:String;
			var _local16:Array;
			var _local17:String;
			var _local18:String;
			SGraphics.c();
			Config.flash_serverstring = Capabilities.serverString;
			Config.name = (Config.version = (Config.page_title = VERSION));
			Config.link = LINK;
			O.o(Config.version);
			Config.key = AppUtil.key("SMP_");
			Config.flash_version = Capabilities.version;
			var _local1:String = Config.flash_version.split(" ")[1];
			var _local2:Array = AppUtil.array(_local1);
			var _local3:Number = parseFloat(((_local2[0] + ".") + _local2[1]));
			var _local4:Number = 10.1;
			if (_local3 < _local4){
				_local12 = "<a href=\"http://get.adobe.com/flashplayer/\" target=\"_blank\">";
				_local12 = (_local12 + (((Config.version + " requires Flash Player ") + _local4) + " or higher\n"));
				_local12 = (_local12 + (((Config.version + " 需要安装 Flash Player ") + _local4) + " 或以上版本"));
				_local12 = (_local12 + "</a>");
				_local13 = new TextFormat(null, null, 0xFF0000);
				_local14 = AppUtil.text(_local12, _local13, 0);
				addChild(_local14);
				return;
			};
			Config.flash_gpu = stage.wmodeGPU;
			try {
				cookie = SharedObject.getLocal("cenfun_cmp_local_data");
			} catch(e:Error) {
			};
			if (cookie){
				write(cookie.data);
			};
			cps = LoaderInfo(main.root.parent.root.loaderInfo).parameters;
			var _local5:* = ["config", "id", "url", "api", "bgcolor", "asp", "aspx", "php", "jsp", "cgi"];
			for each (_local6 in _local5) {
				if (cps.hasOwnProperty(_local6)){
					Config[_local6] = cps[_local6];
				};
			};
			_local7 = main.root.loaderInfo.loaderURL;
			Config.page_url = _local7;
			Config.cmp_url = _local7.split("?")[0];
			Config.cmp_path = Config.cmp_url.substring(0, (Config.cmp_url.lastIndexOf("/") + 1));
			Config.cmp_file = Config.cmp_url.replace(Config.cmp_path, "");
			_local8 = Config.cmp_file.toLowerCase();
			if (_local8.indexOf(CS.LOCAL) != -1){
				local = true;
			};
			if (Security.sandboxType == Security.REMOTE){
				_local15 = Config.cmp_path;
				_local16 = _local15.split("//");
				_local17 = ((_local16[1]) || (_local16[0]));
				_local17 = _local17.substring(0, _local17.indexOf("/"));
				Config.cmp_host = _local15.substring(0, (_local15.indexOf(_local17) + _local17.length));
			};
			ca = new Commander();
			ei = new externalInterface();
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			stage.addEventListener(Event.RESIZE, this.resize);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, this.fsHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, this.keyboard);
			this.resize();
			Config.share_url = Config.cmp_url;
			var _local9:String ="<object type=\"application/x-shockwave-flash\" data=\"" + Config.cmp_url + "\" width=\"" + Config.width + "\" height=\"" + Config.height + "\" id=\"" + Config.key + "\">";
			_local9 = _local9 + "<param name=\"movie\" value=\"" + Config.cmp_url + "\" />";
			_local9 = _local9 + "<param name=\"allowfullscreen\" value=\"true\" />";
			_local9 = _local9 + "<param name=\"allowscriptaccess\" value=\"always\" />";
			var _local10:Array = [];
			for (_local11 in cps) {
				_local10.push(_local11 + "=" + encodeURIComponent(cps[_local11]));
			};
			if (_local10.length){
				_local10.sort();
				_local18 = _local10.join("&");
				Config.share_url = (Config.share_url + (("?" + _local18) + "&.swf"));
				_local9 = _local9 + "<param name=\"flashvars\" value=\"" + _local18 + "\" />";
			};
			_local9 = _local9 + "</object>";
			Config.share_html = _local9;
			ds = new DefaultSkin();
			ds.addEventListener(Event.COMPLETE, this.mvc, false, 0, true);
			ds.load();
		}
		public function mvc(_arg1:Event):void{
			ds.removeEventListener(Event.COMPLETE, this.mvc);
			info = new Info();
			cc = new SMPCore();
			mm = new MediaManager();
			var _local2:Sprite = new Sprite();
			bg = new BackGround();
			_local2.addChild(bg);
			ws = new WS();
			_local2.addChild(ws);
			fp = new FP();
			_local2.addChild(fp);
			wf = new WF();
			_local2.addChild(wf);
			tp = new TP();
			_local2.addChild(tp);
			ld = new LD();
			_local2.addChild(ld);
			addChild(_local2);
			cf = new SConfiger();
			sk = new Skin();
			//右键菜单
			menue = new SMenue();
			lst = new SList();
			sendEvent(SMPEvent.READY);
		}
		public function resize(_arg1:Event=null):void{
			Config.width = stage.stageWidth;
			Config.height = stage.stageHeight;
			sendEvent(SMPEvent.RESIZE);
		}
		public function fsHandler(_arg1:FullScreenEvent):void{
			Config.fullscreen = _arg1.fullScreen;
			sendEvent(SMPEvent.CONTROL_FULLSCREEN);
			var _local2:String = AppUtil.gOP(Main.sk.skin_xml.console.bt_fullscreen, "fullscreen_max", Config.fullscreen_max);
			if ((((_local2 == CS.VIDEO)) && (!((Config.fullscreen == Config.video_max))))){
				sendEvent(SMPEvent.VIDEO_MAX);
			} else {
				if ((((_local2 == CS.LRC)) && (!((Config.fullscreen == Config.lrc_max))))){
					sendEvent(SMPEvent.LRC_MAX);
				};
			};
		}
		public function printScreen():void{
			var bd:* = null;
			var file:* = null;
			var ba:* = null;
			bd = new BitmapData(Config.width, Config.height);
			try {
				bd.draw(main);
			} catch(e:Error) {
				sendEvent(SMPEvent.VIEW_STOP);
				try {
					bd.draw(main);
				} catch(e:Error) {
				};
			};
			if (bd){
				file = new FileReference();
				ba = PNG.encode(bd);
				file.save(ba, ((Config.name + AppUtil.key("_", 5)) + ".png"));
			};
		}
		public function keyboard(_arg1:KeyboardEvent):void{
			var _local2:uint;
			var _local3:int;
			_local2 = _arg1.keyCode;
			trace(_local2);
			/*if ((((((_local2 == 44)) && (_arg1.ctrlKey))) && (_arg1.altKey))){
				this.printScreen();
				return;
			};
			if (input(_arg1.target)){
				return;
			};
			if ((((((_local2 == 67)) && (_arg1.ctrlKey))) && (!(_arg1.altKey)))){
				SS.copy(C.share_url);
				return;
			};
			if (!C.shortcuts){
				return;
			};
			if (((((!((_local2 == 13))) && (!((_local2 == 27))))) && (!((_local2 == 32))))){
				if (((!(_arg1.ctrlKey)) || (!(_arg1.altKey)))){
					return;
				};
			};*/
			switch (_local2){
			case 13:
				sendEvent(SMPEvent.VIEW_ITEM, true);
				break;
			case 27:
				if (!Config.fullscreen){
					if (Config.video_max){
						sendEvent(SMPEvent.VIDEO_MAX);
					} else {
						if (Config.lrc_max){
							sendEvent(SMPEvent.LRC_MAX);
						};
					};
				};
				break;
			case 32:
				sendEvent(SMPEvent.VIEW_PLAY);
				break;
			case 37:
				sendEvent(SMPEvent.VIEW_REWIND);
				break;
			case 39:
				sendEvent(SMPEvent.VIEW_FORWARD);
				break;
			case 38:
				sendEvent(SMPEvent.VIEW_VOLUME, (Config.volume + 0.1));
				trace("up");
				break;
			case 40:
				sendEvent(SMPEvent.VIEW_VOLUME, (Config.volume - 0.1));
				trace("down");
				break;
			case 48:
			case 49:
			case 50:
			case 51:
			case 52:
			case 53:
			case 54:
			case 55:
			case 56:
			case 57:
				_local3 = parseInt(String.fromCharCode(_local2));
				if (_local3 <= sk.skin_list.length){
					Config.skin_id = _local3;
					sendEvent(SMPEvent.SKIN_CHANGE);
				};
				break;
			case 67:
				sendEvent(SMPEvent.VIEW_CONSOLE);
				break;
			case 68:
				Config.skin_id = 0;
				sendEvent(SMPEvent.SKIN_CHANGE);
				break;
			case 70:
				sendEvent(SMPEvent.VIEW_FULLSCREEN);
				break;
			case 76:
				sendEvent(SMPEvent.VIEW_LIST);
				break;
			case 77:
				if (Config.lrc_max){
					sendEvent(SMPEvent.LRC_MAX);
				} else {
					sendEvent(SMPEvent.VIDEO_MAX);
				};
				break;
			case 79:
				sendEvent(SMPEvent.VIEW_OPTION);
				break;
			case 80:
				if (Config.plugins_disabled){
					Config.plugins_disabled = false;
					sendEvent(SMPEvent.PLUGINS_LOAD);
				} else {
					Config.plugins_disabled = true;
					sendEvent(SMPEvent.PLUGINS_REMOVE);
				};
				break;
			case 82:
				sendEvent(SMPEvent.VIEW_LRC);
				break;
			case 83:
				sendEvent(SMPEvent.VIEW_STOP);
				break;
			case 86:
				sendEvent(SMPEvent.VIEW_VIDEO);
				break;
			};
		}

	}
}


