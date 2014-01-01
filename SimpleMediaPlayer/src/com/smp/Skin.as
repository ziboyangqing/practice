/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.*;
	import com.utils.AppUtil;
	import com.zip.*;

	import flash.utils.*;

	//import flash.net.*;

	public final class Skin {

		public var skin_url:String;
		public var skin_bin:ByteArray;
		public var skin_zip:ZipFile;
		public var skin_xml:XMLList;
		public var mask_color:Number;
		public var show_tips:Number;
		public var skin_list:Array;

		public function Skin():void{
			Main.addEventListener(SMPEvent.SKIN_CHANGE, this.skinChange);
			Main.addEventListener(SMPEvent.SKIN_LOAD, this.init, false, 1);
			Main.addEventListener(SMPEvent.SKIN_COMPLETE, this.skinComplete);
		}
		private function skinComplete(_arg1:SMPEvent):void{
			Main.removeEventListener(SMPEvent.SKIN_COMPLETE, this.skinComplete);
			Main.api(Main.main.root.loaderInfo);
			Main.sendEvent(SMPEvent.PLUGINS_LOAD);
		}
		private function init(_arg1:SMPEvent):void{
			if (_arg1.data != null){
				Config.skins = _arg1.data.toString();
			};
			this.skin_list = [];
			var _local2:String = Config.skins;
			if (_local2){
				this.skin_list = AppUtil.array(_local2);
			};
			Main.sendEvent(SMPEvent.SKIN_CHANGE);
		}
		private function skinChange(e:SMPEvent):void{
			if (this.skin_bin && (Config.video_max || Config.lrc_max)){
				return;
			};
			this.skin_bin = null;
			this.skin_zip = null;
			this.skin_xml = null;
			if (e.data != null){
				Config.skin_id = e.data.toString();
			};
			var _local2:int = int(Number(Config.skin_id));
			var _local3:Number = this.skin_list.length;
			if (_local3){
				if (_local2 < 0 || _local2 > _local3){
					_local2 = Math.round(_local3 * Math.random());
				};
			} else {
				_local2 = 1;
			};
			if (_local2){
				this.skinLoad(_local2);
			} else {
				trace("skinChange no skin id.");
				this.skinBack();
			};
			Config.skin_id = _local2;
			Main.setCookie("skin_id", _local2, true);
		}
		private function skinLoad(_arg1:int):void{
			this.skin_url = this.skin_list[(_arg1 - 1)];
			this.skin_url = AppUtil.auto(this.skin_url, Config);
			this.skin_url = Main.fU(this.skin_url, true);
			Main.ld.init();
			new SURLLodader(this.skin_url, this.skinError, this.skinProgress, this.skinDone, false);
		}
		private function skinProgress(_arg1:uint, _arg2:uint):void{
			Main.ld.show(_arg1, _arg2);
		}
		private function skinError(_arg1:String):void{
			O.o(_arg1);
			Main.ld.hide();
			this.skinBack();
			trace("skin Error!");
		}
		private function skinDone(_arg1:ByteArray):void{
			//trace("SK:skinDone1");
			Main.ld.hide();
			this.skin_bin = AppUtil.csf(_arg1);
			this.skinParse();
			//trace("SK:skinDone2");
		}
		private function skinParse():void{
			try {
				this.skin_zip = new ZipFile(this.skin_bin);
			} catch(e:Error) {
				trace("skinParseError.");
				skinBack();
				return;
			};
			var zipEntry:* = this.skin_zip.getEntry("skin.xml");
			if (!zipEntry){
				trace("no skin.xml");
				this.skinBack();
				return;
			};
			var fileData:* = zipEntry.data;
			fileData = AppUtil.bom(fileData);
			var str:* = fileData.toString();

			this.skin_xml = AppUtil.XL(str);
			if (!this.skin_xml.children().length()){
				trace("skinParseError skin.xml has no child.");
				this.skinBack();
				return;
			};
			this.skinConfig();
		}
		private function skinBack():void{
			trace("skinBack.");
			this.skin_zip = Main.ds.skin_zip;
			this.skin_xml = Main.ds.skin_xml;
			this.skinConfig();
		}
		private function skinConfig():void{
			var _local1:String = this.skin_xml.@mask_color;
			if (_local1){
				_local1 = _local1.replace(/#/g, "0xff");
				this.mask_color = parseInt(_local1);
			} else {
				this.mask_color = NaN;
			};
			var _local2:String = this.skin_xml.@show_tips;
			if (_local2){
				this.show_tips = Number(_local2);
			} else {
				this.show_tips = 0.5;
			};
			if (((!(this.show_tips)) || ((this.show_tips < 0)))){
				this.show_tips = 0;
			};
			Main.sendEvent(SMPEvent.SKIN_LOADED);
			//trace("skinConfig ok.");
		}

	}
}


