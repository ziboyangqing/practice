/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.*;

	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;

	public final class Info {

		public var lang:XMLList;
		public var lang_default:XMLList;

		public function Info():void{
			this.lang_default = Main.ds.skin_xml.languages;
			Main.addEventListener(SMPEvent.SKIN_LOADED, this.init, false, 1000);
		}
		public function init(_arg1:SMPEvent):void{
			//取得外部资源中配置
			if(Config.allow_config)this.lang = Main.sk.skin_xml.languages;
			if (!this.lang){
				//使用内置默认值
				this.lang = this.lang_default;
			};
		}
		public function queryMessage(_arg1:String):String{
			var str:* = null;
			var msgid:* = _arg1;
			str = this.lang.msg.(@id == msgid).text();
			if (!str){
				str = this.lang_default.msg.(@id == msgid).text();
			};
			return (str);
		}

	}
}


