/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.*;
	import com.utils.AppUtil;

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;


	public final class SConfiger extends Data {

		private var config_xml:XMLList;
		private var config_url:String;

		public function SConfiger():void{
			Main.addEventListener(SMPEvent.READY, this.load);
			Main.addEventListener(SMPEvent.CONFIG_LOADED, this.loaded);
		}
		private function loaded(e:SMPEvent):void{
			Main.sendEvent(SMPEvent.SKIN_LOAD);
		}
		private function load(e:SMPEvent):void{
			var _local2:String;
			var _local3:String;
			var _local4:Array;
			var _local5:Array;
			var _local6:String;
			this.config_xml = new XMLList();
			if (Config.config){
				this.config_xml = AppUtil.XL(Config.config);
				this.configParse();
			} else {
				_local2 = Config.url;
				if (_local2 == "config.xml"){
					_local3 = Config.cmp_file.substring(0, Config.cmp_file.lastIndexOf("."));
					_local4 = _local3.match(/^([0-9A-Z]{6})$/g);
					if (_local4.length == 1){
						Config.id = _local3;
					};
				};
				if (Config.id){
					_local2 = (Config.id + ".xml");
				} else {
					_local5 = ["asp", "aspx", "php", "jsp", "cgi"];
					for each (_local6 in _local5) {
						if (Config[_local6]){
							_local2 = ((("cmp." + _local6) + "?id=") + encodeURIComponent(Config[_local6]));
							break;
						};
					};
				};
				if (_local2){
					this.config_url = Main.fU(_local2, true);
					Main.ld.init();
					new SURLLodader(this.config_url, this.configError, this.configProgress, this.configLoaded);
				} else {
					this.configParse();
				};
			};
		}
		private function configProgress(_arg1:uint, _arg2:uint):void{
			Main.ld.show(_arg1, _arg2);
		}
		private function configError(_arg1:String):void{
			O.o(_arg1);
			this.configParse();
		}
		private function configLoaded(_arg1:ByteArray):void{
			var _local2:Array = Zip.extract(_arg1);
			if (_arg1 != _local2[0]){
				_arg1 = AppUtil.bom(_local2[0]);
			};
			this.config_xml = AppUtil.XL(_arg1.toString());
			trace("Config.xml:",_local2);
			this.configParse();
		}
		private function configParse():void{
			var _local2:XML;
			var _local10:String;
			var _local11:String;
			var _local12:String;
			var _local13:XML;
			var _local14:String;
			var _local15:String;
			var _local16:XMLList;
			var _local1:XMLList = this.config_xml.attributes();
			for each (_local2 in _local1) {
				_local11 = _local2.toString();
				if (_local11){
					Config[_local2.localName()] = AppUtil.parse(AppUtil.backslash(_local11));
				};
			};
			if (_local1.length() == 0){
				Config.video_max = (Config.lrc_max = (Config.mute = false));
			};
			Main.write(Main.cps);
			var _local3:Number = Number(Config.timeout);
			if (((!(_local3)) || ((_local3 < 1)))){
				_local3 = 1;
			};
			Config.timeout = _local3;
			var _local4:Number = AppUtil.per(Config.volume, true);
			if (Config.mute){
				Config.mute_volume = _local4;
				Config.volume = 0;
			} else {
				Config.volume = _local4;
			};
			Config.logo_alpha = AppUtil.per(Config.logo_alpha, true);
			var _local5:Number = Number(Config.buffer_time);
			if (((!(_local5)) || ((_local5 < 1)))){
				_local5 = 1;
			};
			Config.buffer_time = _local5;
			var _local6:int = Number(Config.video_scalemode);
			if (!_local6){
				Config.video_scalemode = 1;
			};
			var _local7:int = Number(Config.play_id);
			if (((!(_local7)) || ((_local7 < 0)))){
				_local7 = 1;
			};
			Config.play_id = int(_local7);
			var _local8:String = CS.MODES[String(Config.play_mode).toLowerCase()];
			if (!_local8){
				_local8 = CS.MODE_NORMAL;
			};
			Config.play_mode = _local8;
			if (Config.skin){
				Config.skin_id = 1;
			};
			var _local9:Array = ["skin", "plugin", "background"];
			for each (_local10 in _local9) {
				_local12 = (_local10 + "s");
				if (Config[_local10]){
					if (Config[_local12]){
						Config[_local12] = ((Config[_local10] + ",") + Config[_local12]);
					} else {
						Config[_local12] = Config[_local10];
					};
				};
			};
			if (Config.models){
				if (Config.plugins){
					Config.plugins = ((Config.models + ",") + Config.plugins);
				} else {
					Config.plugins = Config.models;
				};
			};
			if (Config.version == Config.page_title){
				Config.page_title = Config.name;
			};
			if (((Config.src) || (Config.label))){
				_local13 = <m/>
					;
				for each (_local14 in SList.vars) {
					if (Config[_local14] != undefined){
						_local13.@[_local14] = Config[_local14];
					};
				};
				Main.lst.list_xml.appendChild(_local13);
				Config.play_id = 1;
			};
			if (Config.list){
				_local15 = decodeURIComponent(Config.list);
				_local16 = AppUtil.XL(_local15);
				Main.lst.list_xml.appendChild(_local16.children());
			};
			Main.ld.hide();
			Main.sendEvent(SMPEvent.CONFIG_LOADED);
		}
		//统计Anlytics
		private function cj():void{
			var _local3:URLRequest;
			var _local1:String = Config.counter;
			if (_local1){
				_local1 = AppUtil.auto(_local1, Config);
				if (Config.flash_js){
					Main.ei.image(_local1);
				} else {
					_local3 = new URLRequest(_local1);
					try {
						//trace("req:",_local1);
						sendToURL(_local3);
							//new URLLoader().load(_local3);

					} catch(e:Error) {
						trace("request error.");
					};
				};
			};
			var _local2:String = Config.javascript;
			if (((_local2) && (Config.flash_js))){
				//trace("CMP.ei");
				_local2 = unescape(_local2);
				_local2 = AppUtil.auto(_local2, Config);
				Main.ei.execute(_local2);
			};
		}

	}
}


