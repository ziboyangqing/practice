package com.sun.utils {
	import flash.events.*;
	import flash.net.*;

	public class AS3Debugger {

		private static var conn:LocalConnection;
		public static var identity:String = "^-^无名氏^-^";
		public static var OmitTrace:Boolean = true;

		public function AS3Debugger(){
			throw (new Error("AS3Debugger 为静态类，不允许实例化"));
		}
		public static function Trace(msg:*, prefix:String=""):void{
			if (!AS3Debugger.OmitTrace){
				return;
			};
			trace(msg,prefix);
			if (prefix == ""){
				prefix = AS3Debugger.identity;
			};
			prefix="<font color='#ffffff' size='14' face='微软雅黑'>"+prefix+"</font>";
			if (conn == null){
				conn = new LocalConnection();
				conn.addEventListener(StatusEvent.STATUS, onStatus);
			};
			if (msg.toString() == "[object Object]"){
				msg = objectToString(msg);
			} else {
				if ((msg is Array)){
					msg = arrayToString(msg);
				} else {
					if ((msg is XML)){
						msg = msg.toXMLString();
					} else {
						msg = msg.toString();
					};
				};
			};
			msg = htmlFormat(msg);
			msg = "<font color='#ff0000'>[" + getTime() + "]</font>" + "<font size='12' color='#00ff00' face='宋体'>" + msg + "</font>";
			try {
				conn.send("_debugConnectionStr", "transMsg", msg, prefix);
			} catch(e:Error) {
			};
		}
		private static function htmlFormat(str:String):String{
			str = str.replace(/\&/g, "&amp;");
			str = str.replace(/\</g, "&lt;");
			str = str.replace(/\>/g, "&gt;");
			str = str.replace(/\"/g, "&quot;");
			str = str.replace(/\'/g, "&apos;");
			return (str);
		}
		private static function getTime():String{
			var date:Date = new Date();
			return getFormatTime(date.getHours() )+ ":" + getFormatTime(date.getMinutes()) + ":" + getFormatTime(date.getSeconds()) + "." + date.getMilliseconds();
		}
		private static function getFormatTime(number:uint):String{
			return (((number < 10)) ? ("0" + number) : ("" + number));
		}
		private static function onStatus(e:StatusEvent):void{
			switch (e.level){
			case "status":
				break;
			case "error":
				break;
			};
		}
		private static function objectToString(o:Object):String{
			var str:String;
			var result:String = "{";
			for (str in o) {
				if (o[str].toString() == "[object Object]"){
					result = (result + (((str + ":") + objectToString(o[str])) + ","));
				} else {
					if ((o[str] is Array)){
						result = (result + (((str + ":") + arrayToString(o[str])) + ","));
					} else {
						result = (result + (((str + ":") + o[str]) + ","));
					};
				};
			};
			result = result.substr(0, (result.length - 1));
			result = (result + "}");
			return (result);
		}
		private static function arrayToString(array:Array):String{
			var l:uint = array.length;
			var str:String = "[";
			var n:uint;
			while (n < l) {
				if (array[n].toString() == "[object Object]"){
					str = (str + (objectToString(array[n]) + ","));
				} else {
					if ((array[n] is Array)){
						str = (str + (arrayToString(array[n]) + ","));
					} else {
						str = (str + (array[n] + ","));
					};
				};
				n++;
			};
			str = str.substr(0, (str.length - 1));
			str = (str + "]");
			return (str);
		}

	}
}


