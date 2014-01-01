/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.SMPEvent;
	import com.smp.events.SMPStates;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import com.utils.Base64;
	import com.utils.AppUtil;

	public final class Commander {

		private var keys:Dictionary;

		public function Commander(){
			this.keys = new Dictionary();
			super();
		}
		public function get cmp():Object{
			return (Main.main);
		}
		public function get config():Object{
			return (Config);
		}
		public function get item():Object{
			return (Main.item);
		}
		public function get list_xml():XML{
			return (Main.lst.list_xml);
		}
		public function set list_xml(_arg1:XML):void{
			Main.lst.list_xml = _arg1;
		}
		public function get skin_xml():XMLList{
			return (Main.sk.skin_xml);
		}
		/*public function get tools():Object{
			return ({
					base64:Base64,
					effects:Effects,
					graphics:SGraphics,
					netclient:NC,
					output:O.o,
					states:SMPStates,
					strings:AppUtil,
					types:CS,
					zoom:Z,
					zip:Zip
				});
		}*/
		public function get win_list():Object{
			return (Main.ws.wins);
		}
		public function get models():Object{
			return (Main.mm.models);
		}
		public function showMixer(_arg1:Boolean=true):Sprite{
			return (Main.mv.showMixer(_arg1));
		}
		public function showMedia(_arg1:DisplayObject):Sprite{
			return (Main.mv.showMedia(_arg1));
		}
		public function addModel(_arg1:Object, _arg2:String, _arg3:Array=null):String{
			var _local5:String;
			if (((!(_arg1)) || (!(_arg2)))){
				return ("invalid model or type");
			};
			var _local4:Array = ["load", "play", "pause", "seek", "volume", "stop", "finish"];
			for each (_local5 in _local4) {
				if (!_arg1.hasOwnProperty(_local5)){
					return ((((_arg2 + " model requires method: ") + _local5) + "();"));
				};
			};
			Main.mm.addModel(_arg1, _arg2, _arg3);
			return ((_arg2 + " model is ready"));
		}
		public function setSoundFilter(_arg1:Function):void{
			if (((!((_arg1 is Function))) && (!((_arg1 == null))))){
				_arg1 = EQ.filter;
			};
			Main.mm.sound.sound.filter = _arg1;
		}
		public function addEventListener(_arg1:String, _arg2:String, _arg3:Function, _arg4:Boolean=false, _arg5:int=0, _arg6:Boolean=true):void{
			var _local7:Array;
			var _local8:Array;
			if (this.keys[_arg1]){
				_local7 = [_arg2, _arg3, _arg4];
				for each (_local8 in this.keys[_arg1]) {
					if (AppUtil.same(_local8, _local7)){
						return;
					};
				};
				this.keys[_arg1].push(_local7);
				Main.main.addEventListener(_arg2, _arg3, _arg4, _arg5, _arg6);
			} else {
				O.o("The api key not exist");
			};
		}
		public function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false):void{
			Main.main.removeEventListener(_arg1, _arg2, _arg3);
		}
		public function sendEvent(_arg1:String, _arg2:Object=null):void{
			Main.sendEvent(_arg1, _arg2);
		}
		public function sendState(_arg1:String):void{
			Main.sendState(_arg1);
		}
		public function addProxy(_arg1:String, _arg2:Function):void{
			if (((_arg1) && ((_arg2 is Function)))){
				Main.mm.proxy[_arg1] = _arg2;
			};
		}
		public function setCELH(_arg1:Function):void{
			if ((_arg1 is Function)){
				Main.celh = _arg1;
			} else {
				Main.celh = AppUtil.celh;
			};
		}
		public function cookie(... _args):String{
			var _local2:String = "";
			if (_args[0]){
				if (_args.length > 1){
					if (_args.length > 2){
						Main.setCookie(_args[0], _args[1], _args[2]);
					} else {
						Main.setCookie(_args[0], _args[1]);
					};
				} else {
					_local2 = String(Main.getCookie(_args[0]));
				};
			};
			return (_local2);
		}
		public function addKey(_arg1:String):void{
			this.keys[_arg1] = [];
		}
		public function removeKey(_arg1:String):void{
			var _local2:Array;
			if (!_arg1){
				return;
			};
			if (this.keys[_arg1]){
				for each (_local2 in this.keys[_arg1]) {
					Main.main.removeEventListener(_local2[0], _local2[1], _local2[2]);
				};
				delete this.keys[_arg1];
			};
		}
		public function toString():String{
			var _local5:XML;
			var _local6:Array;
			var _local7:XMLList;
			var _local8:XML;
			var _local9:Array;
			var _local10:XMLList;
			var _local11:XML;
			var _local12:String;
			var _local13:String;
			var _local1:String = "";
			var _local2:XML = describeType(this);
			_local1 = (_local1 + "cmp api attributes{\n");
			var _local3:Array = [];
			var _local4:XMLList = _local2..accessor;
			for each (_local5 in _local4) {
				_local3.push((((_local5.@name + ":") + _local5.@type) + ";\n"));
			};
			_local3.sort();
			_local1 = (_local1 + _local3.join(""));
			_local1 = (_local1 + "}");
			_local1 = (_local1 + "\ncmp api methods{\n");
			_local6 = [];
			_local7 = _local2..method;
			for each (_local8 in _local7) {
				_local12 = _local8.@name;
				if (((!((_local12 == "addKey"))) && (!((_local12 == "removeKey"))))){
					_local6.push((((_local12 + "():") + _local8.@returnType) + ";\n"));
				};
			};
			_local6.sort();
			_local1 = (_local1 + _local6.join(""));
			_local1 = (_local1 + "}");
			_local2 = describeType(SMPEvent);
			_local1 = (_local1 + "\ncmp api events{\n");
			_local9 = [];
			_local10 = _local2..constant;
			for each (_local11 in _local10) {
				_local13 = _local11.@name;
				_local9.push((("\"" + SMPEvent[_local13]) + "\";\n"));
			};
			_local9.sort();
			_local1 = (_local1 + _local9.join(""));
			_local1 = (_local1 + "}");
			return (_local1);
		}

	}
}


