/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.SMPEvent;

	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import com.utils.AppUtil;

	public final class SList {

		public static var vars:Array = [];

		public var listing:String;
		public var list_url:String;
		public var list_arr:Array;
		public var list_xml:XML;

		public function SList():void{
			var _local3:XML;
			var _local4:String;
			this.list_xml = <list/>;
			super();
			var _local1:XML = describeType(TN);
			var _local2:XMLList = _local1..variable;
			for each (_local3 in _local2) {
				_local4 = _local3.@name;
				if (!AppUtil.isin(_local4, ["children", "parent", "tc", "td", "url", "xml"])){
					vars.push(_local4);
				};
			};
			vars.sort();
			Main.addEventListener(SMPEvent.LIST_LOAD, this.start);
		}
		public static function celh(_arg1:Object):XMLList{
			var _local2:String = String(_arg1);
			_local2 = Main.celh(_local2);
			var _local3:XMLList = AppUtil.XL(_local2);
			return (_local3.children());
		}

		public function start(_arg1:SMPEvent):void{
			if (_arg1.data != null){
				Config.lists = _arg1.data.toString();
			};
			this.list_arr = AppUtil.array(Config.lists);
			if (((this.list_xml.children().length()) || (!(this.list_arr.length)))){
				Main.sendEvent(SMPEvent.LIST_LOADED);
			};
			this.load();
		}
		public function load():void{
			if (!this.list_arr.length){
				return;
			};
			this.listing = Main.info.queryMessage("view_listing");
			Main.tr.showMsg(this.listing);
			this.list_url = this.list_arr.shift();
			this.list_url = AppUtil.auto(this.list_url, Config);
			this.list_url = Main.fU(this.list_url, true);
			new SURLLodader(this.list_url, this.lsE, this.lsP, this.lsL);
		}
		public function lsP(_arg1:uint, _arg2:uint):void{
			var _local3:String = "";
			if (_arg2){
				_local3 = (Math.round(((100 * _arg1) / _arg2)) + "%");
			};
			_local3 = ((this.listing + " ") + _local3);
			Main.tr.showMsg(_local3);
		}
		public function lsE(_arg1:String):void{
			O.o(_arg1);
			this.next();
		}
		public function lsL(_arg1:ByteArray):void{
			var _local3:int;
			var _local2:Array = Zip.extract(_arg1);
			if (_arg1 == _local2[0]){
				Main.sendEvent(SMPEvent.LIST_LOADED, _arg1);
			} else {
				_local3 = 0;
				while (_local3 < _local2.length) {
					Main.sendEvent(SMPEvent.LIST_LOADED, AppUtil.bom(_local2[_local3]));
					_local3++;
				};
			};
			this.next();
		}
		public function next():void{
			Main.tr.showMsg("");
			this.load();
		}

	}
}


