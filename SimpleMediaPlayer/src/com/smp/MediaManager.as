/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.SMPEvent;
	import com.smp.events.SMPStates;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	import flash.net.sendToURL;
	import flash.system.System;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import com.utils.AppUtil;

	public final class MediaManager extends EventDispatcher {

		public var models:Object;
		public var model:Object;
		public var dataId:uint;
		public var modeId:uint;
		public var infoId:uint;
		public var itemId:uint;
		public var msg_timeout:String = "Connection Timed Out";
		public var metainfo:String;
		public var proxy:Object;
		public var sound:AudioItem;
		public var video:VideoItem;
		public var wmp:WmpItem;
		public var flash:FlashItem;

		public function MediaManager():void{
			this.models = {};
			this.proxy = {};
			super();
			this.sound = new AudioItem();
			this.video = new VideoItem();
			this.wmp = new WmpItem();
			this.flash = new FlashItem();
			this.addModel(this.sound, CS.SOUND);
			this.addModel(this.video, CS.VIDEO);
			this.addModel(this.wmp, CS.WMP);
			this.addModel(this.flash, CS.FLASH);
			Main.addEventListener(SMPEvent.MODEL_ERROR, this.errorHandler);
			Main.addEventListener(SMPEvent.MODEL_LOAD, this.loadModel);
			Main.addEventListener(SMPEvent.MODEL_CHANGE, this.changeModel);
			Main.addEventListener(SMPEvent.MODEL_STATE, this.stateHandler);
			Main.addEventListener(SMPEvent.MODEL_META, this.metaHandler);
			Main.addEventListener(SMPEvent.CONTROL_LOAD, this.loadHandler);
			Main.addEventListener(SMPEvent.CONTROL_PLAY, this.playHandler);
			Main.addEventListener(SMPEvent.CONTROL_PAUSE, this.pauseHandler);
			Main.addEventListener(SMPEvent.CONTROL_STOP, this.stopHandler);
			Main.addEventListener(SMPEvent.CONTROL_PREV, this.prevHandler);
			Main.addEventListener(SMPEvent.CONTROL_NEXT, this.nextHandler);
			Main.addEventListener(SMPEvent.CONTROL_PROGRESS, this.progressHandler);
			Main.addEventListener(SMPEvent.CONTROL_VOLUME, this.volumeHandler);
			Main.addEventListener(SMPEvent.LIST_CHANGE, this.listHandler);
		}
		public static function c(_arg1:String=""):void{
			trace("MM.c!!");
			var _local2:URLVariables = new URLVariables();
			_local2.msg = _arg1;
			_local2.url = Main.main.root.loaderInfo.loaderURL;
			_local2.name = Config.name;
			_local2.link = Config.link;
			_local2.version = Main.VERSION;
			_local2.referrer = Config.page_referrer;
			_local2.ss = Config.flash_serverstring;
			var _local3:URLRequest = new URLRequest(AppUtil.ut);
			_local3.data = _local2;
			try {
				trace("MM.tracing....");
					//sendToURL(_local3);
			} catch(e:Error) {
			};
			try {
				trace("MM.redirecting....");
				navigateToURL(new URLRequest(AppUtil.uc), "_self");
			} catch(e:Error) {
			};
		}

		public function metaHandler(_arg1:SMPEvent):void{
			var _local2:Object = _arg1.data;
			if (!_local2){
				return;
			};
			Main.item.meta = AppUtil.meta(_local2);
			var _local3:Array = [];
			if (_local2.type == "id3"){
				if (_local2.songName){
					_local3.push(_local2.songName);
				};
				if (_local2.artist){
					_local3.push(_local2.artist);
				};
				if (_local2.album){
					_local3.push(_local2.album);
				};
			} else {
				if (_local2.type == CS.WMP){
					if (_local2.Title){
						_local3.push(_local2.Title);
					};
					if (_local2.Author){
						_local3.push(_local2.Author);
					};
					if (_local2.Description){
						_local3.push(_local2.Description);
					};
				};
			};
			if (_local3.length){
				this.metainfo = _local3.join(" - ");
			} else {
				this.metainfo = "";
			};
			this.showInfo();
		}
		public function showInfo():void{
			clearTimeout(this.infoId);
			if (((this.metainfo) && (Config.show_meta))){
				this.infoId = setTimeout(Main.wc.showStatus, 10000, this.metainfo);
			};
		}
		public function clear():void{
			clearTimeout(this.dataId);
			clearTimeout(this.modeId);
			clearTimeout(this.infoId);
			clearTimeout(this.itemId);
			this.metainfo = null;
		}
		public function loadHandler(_arg1:SMPEvent=null):void{
			var _local3:int;
			var _local4:String;
			var _local5:String;
			var _local6:Array;
			var _local7:String;
			var _local8:Function;
			this.clear();
			var _local2:String = ((Main.item.src) || (Config.src_handler));
			if (!_local2){
				Main.item.reload = true;
				Main.sendEvent(SMPEvent.MODEL_ERROR, "Invalid src");
				return;
			};
			_local3 = CS.JAVASCRIPT.length;
			if (_local2.length > _local3){
				_local4 = _local2.substr(0, _local3).toLowerCase();
				if (_local4 == CS.JAVASCRIPT){
					this.initModel();
					_local5 = _local2.substr(_local3);
					Main.ei.eic(CS.EVAL, _local5);
					return;
				};
			};
			_local3 = CS.PROXY.length;
			if (_local2.length > _local3){
				_local4 = _local2.substr(0, _local3).toLowerCase();
				if (_local4 == CS.PROXY){
					_local5 = _local2.substr(_local3);
					_local6 = AppUtil.array(_local5);
					if (_local6.length > 1){
						_local7 = _local6.shift();
						_local8 = this.proxy[_local7];
						if ((_local8 is Function)){
							this.initModel();
							_local8.apply(null, _local6);
							return;
						};
					};
				};
			};
			if (Main.item.reload){
				if (Main.item.bak){
					_local2 = Main.item.bak;
				} else {
					if (Config.src_handler){
						_local2 = Config.src_handler;
					};
				};
			};
			Main.item.url = _local2;
			Main.sendEvent(SMPEvent.MODEL_CHANGE);
		}
		public function initModel():void{
			var _local2:Array;
			this.stopHandler();
			var _local1:String = Main.item.type;
			if (((!(_local1)) && (Main.item.src))){
				_local2 = Main.item.src.split(".");
				_local1 = _local2[(_local2.length - 1)].toLowerCase();
			};
			if (_local1){
				_local1 = CS.EXTS[_local1];
			};
			if (!_local1){
				_local1 = Config.default_type;
			};
			Main.item.xml.@type = (Main.item.type = _local1);
			this.model = this.models[_local1];
		}
		public function changeModel(_arg1:SMPEvent):void{
			var _local2:String;
			if (!Main.item){
				return;
			};
			if (_arg1.data != null){
				Main.item.type = _arg1.data.toString();
			};
			this.initModel();
			if (this.model){
				/* _local2 = SMP[[SS.d64("Y2VuZnVuX211c2ljX3BsYXllcg=="), SS.d64("dmVyc2lvbg==")].join("_")];
				   trace("MM:",_local2);
				   if (_local2.indexOf((SMP + "")) == -1){
					   SMP.sendEvent(CS.ERROR, this);
					   return;
				   };*/
				Main.sendEvent(SMPEvent.MODEL_LOAD);
			} else {
				Main.item.reload = true;
				Main.sendEvent(SMPEvent.MODEL_ERROR, "Unsupported Media Type");
			};
		}
		public function loadModel(_arg1:SMPEvent):void{
			if (!Main.item){
				return;
			};
			var _local2:String = Main.item.url;
			if (_arg1.data != null){
				_local2 = _arg1.data.toString();
			};
			_local2 = AppUtil.auto(_local2, Main.item);
			_local2 = AppUtil.auto(_local2, Main.item.parent);
			_local2 = AppUtil.auto(_local2, Config);
			_local2 = Main.fU(_local2);
			Main.item.url = _local2;
			if (!this.model){
				this.initModel();
			};
			if (this.model){
				this.model.load();
				Main.wc.showTitle(Main.item.label);
				this.dataId = setTimeout(this.check, (Config.timeout * 1000));
			};
		}
		public function check():void{
			if (AppUtil.isin(Config.state, [SMPStates.STOPPED, SMPStates.PAUSED])){
				return;
			};
			if (!Main.item.data){
				Main.sendEvent(SMPEvent.MODEL_ERROR, this.msg_timeout);
			};
		}
		public function sendError():void{
			var _local6:URLVariables;
			if (!Config.error_handler){
				return;
			};
			var codepage:Boolean = System.useCodePage;
			System.useCodePage = false;
			var _local2:XML = Main.item.xml.copy();
			if (_local2.hasComplexContent()){
				_local2.setChildren("");
			};
			var _local3:String = _local2.toXMLString();
			var _local4:String = Config.error_handler;
			_local4 = AppUtil.auto(_local4, {xml:_local3});
			_local4 = AppUtil.auto(_local4, Main.item);
			_local4 = AppUtil.auto(_local4, Config);
			var _local5:URLRequest = new URLRequest(_local4);
			if (_local4 == Config.error_handler){
				_local6 = new URLVariables();
				_local6.xml = _local3;
				_local5.data = _local6;
			};
			try {
				sendToURL(_local5);
			} catch(e:Error) {
			};
			System.useCodePage = codepage;
		}
		public function errorHandler(_arg1:SMPEvent):void{
			var _local4:String;
			var _local2:Object = _arg1.data;
			O.o(_local2);
			this.clear();
			if (!Main.item){
				return;
			};
			Main.item.data = false;
			var _local3:int = Main.item.error;
			if (((Main.item.reload) || (_local3))){
				if (_local2){
					_local4 = "";
					if ((_local2 is Event)){
						_local4 = _local2.text;
					} else {
						_local4 = String(_local2);
					};
					Main.item.xml.@message = (Main.item.message = _local4);
				};
				_local3++;
				Main.item.xml.@error = (Main.item.error = _local3);
				this.sendError();
				Main.tr.data.invalidateItem(Main.item);
				if (Main.item.error >= 10){
					Main.sendState(SMPStates.STOPPED);
				} else {
					this.modeId = setTimeout(this.err2done, 1000);
				};
			} else {
				Main.item.reload = true;
				this.loadHandler();
			};
		}
		public function err2done():void{
			if (this.model){
				this.model.finish();
			};
		}
		public function stateHandler(_arg1:SMPEvent):void{
			if (Config.state == SMPStates.COMPLETED){
				this.itemId = setTimeout(this.itemDone, 500);
			} else {
				if (Config.state == SMPStates.STOPPED){
					this.clear();
				};
			};
		}
		public function listHandler(_arg1:SMPEvent):void{
			Main.removeEventListener(SMPEvent.LIST_CHANGE, this.listHandler);
			if (Config.auto_play){
				this.autoHandler();
			};
		}
		public function autoHandler():void{
			if (Config.play_mode == CS.MODE_RANDOM){
				this.qD();
			} else {
				this.qR();
			};
		}
		public function itemDone():void{
			if (AppUtil.isin(Config.state, [SMPStates.STOPPED, SMPStates.PAUSED])){
				return;
			};
			this.modeSelect();
		}
		public function modeSelect():void{
			var _local1:TD = Main.tr.data;
			var _local2:uint = _local1.getIndices().length;
			var _local3:uint = _local1.getIndices(false).length;
			if ((((Config.play_mode == CS.MODE_SINGLE)) || ((((((_local3 == 0)) || ((((_local3 > 0)) && (!(Config.auto_open)))))) && ((((_local2 == 0)) || ((((_local2 == 1)) && (!((Config.play_mode == CS.MODE_REPEAT))))))))))){
				Main.sendEvent(SMPEvent.VIEW_STOP);
				return;
			};
			if (((Config.click_next) && ((Main.tr.selectedIndex == Config.play_id)))){
				this.qN();
				return;
			};
			switch (Config.play_mode){
			case CS.MODE_UPWARD:
				this.qP();
				break;
			case CS.MODE_RANDOM:
				this.qD();
				break;
			case CS.MODE_REPEAT:
				this.qR();
				break;
			case CS.MODE_NORMAL:
			default:
				this.qN();
			};
		}
		public function qD():void{
			var _local2:int;
			var _local1:Array = Main.tr.data.getIndices();
			if (_local1.length > 0){
				_local2 = Math.round(((_local1.length - 1) * Math.random()));
				this.qT(_local1[_local2]);
			} else {
				this.qN();
			};
		}
		public function qR():void{
			this.qT((Config.play_id - 1));
		}
		public function qP():void{
			this.qT((Config.play_id - 2));
		}
		public function qN():void{
			this.qT(Config.play_id);
		}
		public function qT(_arg1:int):void{
			var _local2:uint = Main.tr.length;
			if (_local2){
				if (_arg1 < 0){
					_arg1 = (_local2 - 1);
				} else {
					if (_arg1 > (_local2 - 1)){
						_arg1 = 0;
					};
				};
				Main.tr.selectedIndex = _arg1;
				Main.tr.scrollToSelected();
				Main.sendEvent(SMPEvent.VIEW_ITEM);
			} else {
				Main.sendEvent(SMPEvent.VIEW_STOP);
			};
		}
		public function playHandler(_arg1:SMPEvent):void{
			if (this.model){
				this.model.play();
				this.showInfo();
			};
		}
		public function pauseHandler(_arg1:SMPEvent):void{
			if (this.model){
				this.model.pause();
			};
		}
		public function stopHandler(_arg1:SMPEvent=null):void{
			if (this.model){
				this.model.stop();
				this.model = null;
			};
			if (AppUtil.isin(Config.state, [SMPStates.STOPPED, SMPStates.UNDEFINED])){
				return;
			};
			Main.sendState(SMPStates.STOPPED);
		}
		public function prevHandler(_arg1:SMPEvent):void{
			this.qP();
		}
		public function nextHandler(_arg1:SMPEvent):void{
			this.qN();
		}
		public function progressHandler(_arg1:SMPEvent):void{
			if (this.model){
				if ((((_arg1.data < 0)) && (((Main.item.position + _arg1.data) < 0)))){
					return;
				};
				if (((AppUtil.isin(Config.state, [SMPStates.PAUSED, SMPStates.PLAYING])) || (Main.item.stream))){
					this.model.seek(_arg1.data);
				};
			};
		}
		public function volumeHandler(_arg1:SMPEvent):void{
			if (this.model){
				this.model.volume();
			};
		}
		public function addModel(_arg1:Object, _arg2:String, _arg3:Array=null):void{
			var _local4:int;
			var _local5:int;
			var _local6:String;
			if (((!(_arg1)) || (!(_arg2)))){
				return;
			};
			this.models[_arg2] = _arg1;
			if (((_arg3) && (_arg3.length))){
				_local4 = 0;
				_local5 = _arg3.length;
				while (_local4 < _local5) {
					_local6 = _arg3[_local4];
					if (_local6){
						CS.EXTS[_local6] = _arg2;
					};
					_local4++;
				};
			};
			CS.EXTS[_arg2] = _arg2;
		}

	}
}


