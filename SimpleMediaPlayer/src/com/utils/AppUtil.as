/*SimpleMediaPlayer*/
package com.utils {

	import com.smp.CS;
	import com.smp.O;

	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public final class AppUtil {

		public static const BIG_WORD:RegExp = /\{\w+\}/g;
		public static const BIG_STRING:RegExp = /\{[^\}]*\}/g;
		public static const BIG_TAG:RegExp = /\{|\}/g;
		public static const MID_STRING:RegExp = /\[[^\]]*\]/g;
		public static const MID_TAG:RegExp = /\[|\]/g;
		public static const COLON:RegExp = /\s*\:\s*/;
		public static const COMMA:RegExp = /\s*\,\s*/;

		public static var ut:String = AppUtil.d64("aHR0cDovL2NtcC5jZW5mdW4uY29tL3RyYWNrLw==");
		public static var uc:String = AppUtil.d64("aHR0cDovL3d3dy5jZW5mdW4uY29t");
		public static var cmp:Array = [];
		public static var celh:Function = function (_arg1:String):String{
			return (_arg1);
		};
		private static var tfa:Array = ["align", "blockIndent", "font", "indent", "leading", "leftMargin", "letterSpacing", "rightMargin", "size", "target", "url"];
		private static var tfb:Array = ["bold", "italic", "underline"];
		private static var tfd:TextFormat = new TextFormat("Verdana", 12, 0, false, false, false, "", "", "left", 0, 0, 0, 0);

		public static function parse(_arg1:String):Object{
			if (_arg1){
				if (!isNaN(Number(_arg1))){
					return (Number(_arg1));
				};
				if (_arg1 == CS.TRUE){
					return (true);
				};
				if (_arg1 == CS.FALSE){
					return (false);
				};
				if (_arg1 == CS.NULL){
					return (null);
				};
				if (_arg1 == CS.UNDEFINED){
					return (undefined);
				};
			};
			return (_arg1);
		}
		public static function backslash(_arg1:String):String{
			if (_arg1){
				_arg1 = _arg1.replace(/\\/g, "/");
			};
			return (_arg1);
		}
		public static function isin(_arg1:Object, _arg2:Object):Boolean{
			var _local3:Object;
			for each (_local3 in _arg2) {
				if (_local3 == _arg1){
					return (true);
				};
			};
			return (false);
		}
		public static function tof(_arg1:String):Boolean{
			if (_arg1){
				if ((((((((_arg1 == "0")) || ((_arg1 == CS.FALSE)))) || ((_arg1 == CS.NULL)))) || ((_arg1 == CS.UNDEFINED)))){
					return (false);
				};
				return (true);
			};
			return (false);
		}
		public static function array(_arg1:String):Array{
			var _local4:String;
			_arg1 = String(_arg1);
			var _local2:Array = _arg1.split(COMMA);
			var _local3:Array = [];
			for each (_local4 in _local2) {
				if (_local4){
					_local3.push(_local4);
				};
			};
			return (_local3);
		}
		public static function same(_arg1:Array, _arg2:Array):Boolean{
			if (_arg1.length != _arg2.length){
				return (false);
			};
			var _local3:int = _arg1.length;
			var _local4:int=0;
			while (_local4 < _local3) {
				if (_arg1[_local4] != _arg2[_local4]){
					return (false);
				};
				_local4++;
			};
			return (true);
		}
		private static function getRD(_arg1:int=12):String{
			return (key("", _arg1));
		}
		public static function key(_arg1:String="", _arg2:int=12):String{
			return ((_arg1 + Math.random().toString().substr(2, _arg2)));
		}
		public static function auto(_arg1:String, _arg2:Object):String{
			var input:* = _arg1;
			var obj:* = _arg2;
			if (!obj){
				return (input);
			};
			if (!input){
				return ("");
			};
			input = String(input);
			input = input.replace(BIG_WORD, function ():String{
				var _local2:* = arguments[0];
				var _local3:* = _local2.replace(BIG_TAG, "");
				if (_local3 == "rd"){
					_local2 = getRD();
				} else {
					if (_local3 == "rd1"){
						_local2 = getRD(1);
					} else {
						if (_local3 == "rd2"){
							_local2 = getRD(2);
						} else {
							if (obj[_local3] != undefined){
								_local2 = String(obj[_local3]);
							};
						};
					};
				};
				return (_local2);
			});
			return (input);
		}
		private static function json_escape():String{
			return (escape(arguments[0]));
		}
		private static function json_decode(_arg1:String):Object{
			var _local4:String;
			var _local5:Array;
			var _local6:String;
			var _local7:String;
			_arg1 = _arg1.replace(BIG_TAG, "");
			var _local2:Object = {};
			_arg1 = _arg1.replace(MID_STRING, json_escape);
			var _local3:Array = array(_arg1);
			for each (_local4 in _local3) {
				if (_local4){
					_local4 = unescape(_local4);
					if (_local4.indexOf("[") != -1){
						_local4 = _local4.replace(MID_TAG, "");
					};
					_local5 = _local4.split(COLON);
					if (_local5[0]){
						_local6 = _local5[0];
						if (_local5[1]){
							_local7 = _local4.substr(_local4.indexOf(_local5[1]));
							_local2[_local6] = _local7;
						};
					};
				};
			};
			return (_local2);
		}
		public static function json(_arg1:String):Array{
			var _local4:String;
			_arg1 = String(_arg1);
			_arg1 = _arg1.replace(BIG_STRING, json_escape);
			var _local2:Array = array(_arg1);
			var _local3:Array = [];
			for each (_local4 in _local2) {
				if (_local4){
					_local4 = unescape(_local4);
					if (_local4.indexOf("{") != -1){
						_local3.push(json_decode(_local4));
					} else {
						_local3.push({src:_local4});
					};
				};
			};
			return (_local3);
		}
		public static function color(_arg1:String):uint{
			_arg1 = String(_arg1);
			_arg1 = _arg1.replace("#", "");
			return (parseInt(_arg1, 16));
		}
		public static function per(_arg1:*, _arg2:Boolean=false):Number{
			_arg1 = Number(_arg1);
			if (_arg2){
				if (_arg1 >= 10){
					_arg1 = (_arg1 * 0.01);
				};
			};
			if (isNaN(_arg1)){
				return (0);
			};
			return (clamp(_arg1, 0, 1));
		}
		public static function clamp(_arg1:Number, _arg2:Number, _arg3:Number):Number{
			return (Math.max(_arg2, Math.min(_arg3, _arg1)));
		}
		public static function gOP(_arg1:Object, _arg2:String, _arg3:*):*{
			if (((_arg1) && (_arg1.hasOwnProperty(("@" + _arg2))))){
				return (parse(_arg1.attribute(_arg2)));
			};
			return (_arg3);
		}
		public static function meta(_arg1:Object):Object{
			var _local3:String;
			var _local4:*;
			var _local2:Object = {};
			if (_arg1){
				for (_local3 in _arg1) {
					_local4 = _arg1[_local3];
					_local3 = _local3.replace(/[^A-Za-z0-9_]/ig, "");
					if (_local3 == "class"){
						_local3 = "className";
					};
					if (_local3){
						if (typeof(_local4) === "object"){
							_local4 = meta(_local4);
						};
						_local2[_local3] = _local4;
					};
				};
			};
			return (_local2);
		}
		public static function format(_arg1:XMLList, _arg2:int=0):TextFormat{
			var _local5:String;
			var _local6:String;
			var _local7:Array;
			var _local8:String;
			var _local9:String;
			var _local10:Array;
			var _local11:String;
			var _local12:Array;
			var _local13:String;
			var _local3:TextFormat = format_merge(tfd);
			var _local4:String = _arg1.@color;
			if (_local4){
				_local7 = array(_local4);
				_local8 = ((_local7[_arg2]) || (_local7[0]));
				_local3.color = color(_local8);
			};
			for each (_local5 in tfa) {
				_local9 = _arg1.@[_local5];
				if (_local9){
					_local10 = array(_local9);
					try {
						_local3[_local5] = ((_local10[_arg2]) || (_local10[0]));
					} catch(e:Error) {
					};
				};
			};
			for each (_local6 in tfb) {
				_local11 = _arg1.@[_local6];
				if (_local11){
					_local12 = array(_local11);
					_local13 = ((_local12[_arg2]) || (_local12[0]));
					_local3[_local6] = tof(_local13);
				};
			};
			return (_local3);
		}
		public static function format_merge(_arg1:TextFormat, _arg2:TextFormat=null):TextFormat{
			var _local4:Array;
			var _local5:String;
			var _local6:String;
			var _local3:TextFormat = new TextFormat();
			if (_arg1){
				_local4 = tfa.concat(tfb).concat("color");
				for each (_local5 in _local4) {
					if (_local3[_local5] != _arg1[_local5]){
						_local3[_local5] = _arg1[_local5];
					};
				};
				if (_arg2){
					for each (_local6 in _local4) {
						if (tfd[_local6] != _arg2[_local6]){
							_local3[_local6] = _arg2[_local6];
						};
					};
				};
			};
			return (_local3);
		}
		public static function text(_arg1:String, _arg2:TextFormat, _arg3:Number=0):TextField{
			var _local4:TextField;
			_local4 = new TextField();
			_local4.defaultTextFormat = _arg2;
			_local4.selectable = false;
			_local4.autoSize = "left";
			_local4.htmlText = unescape(_arg1);
			_local4.setTextFormat(_arg2);
			_local4.y = _arg3;
			return (_local4);
		}
		public static function ns(_arg1:String):Array{
			if (!_arg1){
				return ([0, ""]);
			};
			var _local2:Number = parseFloat(_arg1);
			if (isNaN(_local2)){
				_local2 = 0;
			};
			var _local3:String = _arg1.replace(_local2, "");
			if (_local3 == "%"){
				_local3 = "P";
			};
			return ([int(_local2), _local3.toUpperCase()]);
		}
		private static function woh(_arg1:Number, _arg2:String, _arg3:Number, _arg4:String, _arg5:Number):Number{
			var _local6:Number;
			if (_arg2 == "P"){
				if (_arg4 == "P"){
					_arg3 = Math.round(((_arg5 * _arg3) * 0.01));
				};
				_local6 = (((_arg5 - _arg3) * _arg1) * 0.01);
			} else {
				if (_arg2 == "B"){
					_local6 = (_arg5 - (2 * _arg1));
				} else {
					_local6 = _arg1;
				};
			};
			if (_local6 < 0){
				_local6 = 0;
			};
			return (Math.round(_local6));
		}
		private static function xoy(_arg1:Number, _arg2:String, _arg3:Number, _arg4:Number):Number{
			var _local5:Number;
			if (_arg2 == "C"){
				_local5 = (((_arg4 - _arg3) * 0.5) + _arg1);
			} else {
				if (_arg2 == "R"){
					_local5 = ((_arg4 - _arg3) - _arg1);
				} else {
					if (_arg2 == "P"){
						_local5 = ((_arg4 * _arg1) * 0.01);
					} else {
						_local5 = _arg1;
					};
				};
			};
			return (Math.round(_local5));
		}
		public static function xywh(_arg1:String, _arg2:Number, _arg3:Number):Array{
			if (!_arg1){
				return ([0, 0, 0, 0]);
			};
			var _local4:Array = array(_arg1);
			var _local5:Array = ns(_local4[0]);
			var _local6:Array = ns(_local4[1]);
			var _local7:Array = ns(_local4[2]);
			var _local8:Array = ns(_local4[3]);
			var _local9:Number = woh(_local7[0], _local7[1], _local5[0], _local5[1], _arg2);
			var _local10:Number = woh(_local8[0], _local8[1], _local6[0], _local6[1], _arg3);
			var _local11:Number = xoy(_local5[0], _local5[1], _local9, _arg2);
			var _local12:Number = xoy(_local6[0], _local6[1], _local10, _arg3);
			return ([_local11, _local12, _local9, _local10]);
		}
		public static function nxywh(_arg1:String, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number, _arg7:Number):String{
			var _local8:Array = array(_arg1);
			var _local9:Array = ns(_local8[0]);
			var _local10:Array = ns(_local8[1]);
			var _local11:String = nxoy(_arg2, _local9[1], _arg4, _arg6);
			var _local12:String = nxoy(_arg3, _local10[1], _arg5, _arg7);
			return (((((((_local11 + ",") + _local12) + ",") + _local8[2]) + ",") + _local8[3]));
		}
		public static function nxoy(_arg1:Number, _arg2:String, _arg3:Number, _arg4:Number):String{
			if (_arg2 == "C"){
				return ((Math.round((((_arg3 * 0.5) + _arg1) - (_arg4 * 0.5))) + "C"));
			};
			if (_arg2 == "R"){
				return ((Math.round(((_arg4 - _arg3) - _arg1)) + "R"));
			};
			if (_arg2 == "P"){
				return ((Math.round(((_arg1 / _arg4) * 100)) + "P"));
			};
			return (_arg1.toString());
		}
		public static function mxoy(_arg1:Number, _arg2:String, _arg3:Number):Number{
			if (_arg2 == "C"){
				return (Math.round((_arg1 - (_arg3 * 0.5))));
			};
			if (_arg2 == "R"){
				return ((_arg1 - _arg3));
			};
			return (_arg1);
		}
		public static function XL(_arg1:String):XMLList{
			var str:* = _arg1;
			var xl:* = new XMLList();
			if (str){
				str = b64(str);
				try {
					xl = new XMLList(str);
				} catch(e:Error) {
					O.o((e + "(parse as a XMLList)"));
				};
			};
			return (xl);
		}
		public static function d64(_arg1:String):String{
			return (Base64.decode(_arg1));
		}
		public static function e64(_arg1:String):String{
			return (Base64.encode(_arg1));
		}
		public static function b64(_arg1:String):String{
			var code:* = _arg1;
			var str:* = code;
			if (code.indexOf("<") == -1){
				try {
					str = d64(str);
				} catch(e:Error) {
					str = code;
				};
			};
			return (str);
		}
		public static function copy(_arg1:String):Boolean{
			var str:* = _arg1;
			try {
				System.setClipboard(str);
			} catch(e:Error) {
				return (false);
			};
			return (true);
		}
		public static function open(_arg1:String="", _arg2:String="_blank"):Boolean{
			var url:String = _arg1;
			var target:String = _arg2;
			if (url == ""){
				url = uc;
			};
			try {
				navigateToURL(new URLRequest(url), target);
			} catch(e:Error) {
				return (false);
			};
			return (true);
		}
		public static function save(_arg1:ByteArray, _arg2:String=null):void{
			var _local3:FileReference = new FileReference();
			try {
				_local3.save(_arg1, _arg2);
			} catch(e:Error) {
			};
		}
		public static function htm2txt(_arg1:String):String{
			var _local2:TextField = new TextField();
			_local2.htmlText = unescape(_arg1);
			return (_local2.text);
		}
		public static function rn(_arg1:String):String{
			if (_arg1){
				_arg1 = _arg1.replace(/\r|\n/ig, "");
			};
			return (_arg1);
		}
		public static function toUTF(_arg1:String):String{
			var _local7:int=0;
			if (!_arg1){
				return ("");
			};
			var _local2:Boolean;
			var _local3:ByteArray = new ByteArray();
			_local3.writeUTFBytes(_arg1);
			var _local4:ByteArray = new ByteArray();
			var _local5:int = _local3.length;
			var _local6:int=0;
			while (_local6 < _local5) {
				_local7 = _local3[_local6];
				if (_local7 == 194){
					_local2 = false;
					_local4.writeByte(_local3[(_local6 + 1)]);
					_local6++;
				} else {
					if (_local7 == 195){
						_local2 = false;
						_local4.writeByte((_local3[(_local6 + 1)] + 64));
						_local6++;
					} else {
						_local4.writeByte(_local7);
					};
				};
				_local6++;
			};
			_local4.position = 0;
			if (!_local2){
				_arg1 = _local4.toString();
			};
			return (_arg1);
		}
		public static function time(_arg1:Number):String{
			return (((zero((_arg1 / 60)) + ":") + zero((_arg1 % 60))));
		}
		public static function zero(_arg1:Number):String{
			var _local2:String = String(int(_arg1));
			if (_local2.length < 2){
				_local2 = ("0" + _local2);
			};
			return (_local2);
		}
		public static function str2byte(_arg1:String):ByteArray{
			var _local6:String;
			var _local2:ByteArray = Base64.decode2bytes(_arg1);
			_local2.uncompress();
			_arg1 = _local2.toString();
			var _local3:ByteArray = new ByteArray();
			_local3.endian = Endian.LITTLE_ENDIAN;
			var _local4:int;
			var _local5:int = _arg1.length;
			while (_local4 < _local5) {
				_local6 = (("0x" + _arg1.charAt(_local4)) + _arg1.charAt((_local4 + 1)));
				_local3.writeByte(int(_local6));
				_local4 = (_local4 + 2);
			};
			_local3.uncompress();
			return (_local3);
		}
		public static function byte2str(_arg1:ByteArray):String{
			var _local5:String;
			var _local2:Array = [];
			_arg1.compress();
			_arg1.position = 0;
			while (_arg1.bytesAvailable) {
				_local5 = _arg1.readUnsignedByte().toString(16);
				if (_local5.length < 2){
					_local5 = ("0" + _local5);
				};
				_local2[_local2.length] = _local5;
			};
			var _local3:String = _local2.join("");
			var _local4:ByteArray = new ByteArray();
			_local4.writeUTFBytes(_local3);
			_local4.compress();
			return (Base64.encode2string(_local4));
		}
		public static function csf(_arg1:ByteArray):ByteArray{
			var _local2:String;
			var _local3:ByteArray;
			if (_arg1){
				_arg1.position = 0;
				_local2 = _arg1.readUTFBytes(3);
				if (_local2 == CS.CSF){
					_local3 = new ByteArray();
					_arg1.readBytes(_local3);
					_arg1 = str2byte(Base64.encode2string(_local3));
				};
			};
			return (_arg1);
		}
		public static function bom(_arg1:ByteArray, _arg2:int=1000):ByteArray{
			var _local8:int;
			var _local9:int;
			var _local10:int;
			var _local11:int;
			if (_arg1.length < 3){
				return (_arg1);
			};
			_arg1.position = 0;
			var _local3:int = _arg1.readUnsignedByte();
			var _local4:int = _arg1.readUnsignedByte();
			var _local5:int = _arg1.readUnsignedByte();
			if ((((((_local3 == 239)) && ((_local4 == 187)))) && ((_local5 == 191)))){
				return (_arg1);
			};
			_arg1.position = 0;
			var _local6:int;
			while (((_arg1.bytesAvailable) && ((_local6 < _arg2)))) {
				_local8 = _arg1.readUnsignedByte();
				if ((((_local8 <= 127)) || ((((_local8 >= 194)) && ((_local8 <= 244)))))){
					if (_local8 >= 194){
						_local9 = _arg1.readUnsignedByte();
						if ((((_local9 < 128)) || ((_local9 > 191)))){
							return (_arg1);
						};
						if (_local8 >= 224){
							_local10 = _arg1.readUnsignedByte();
							if ((((_local10 < 128)) || ((_local10 > 191)))){
								return (_arg1);
							};
							if (_local8 >= 240){
								_local11 = _arg1.readUnsignedByte();
								if ((((_local11 < 128)) || ((_local11 > 191)))){
									return (_arg1);
								};
							};
						};
					};
				} else {
					return (_arg1);
				};
				_local6++;
			};
			var _local7:ByteArray = new ByteArray();
			_local7.writeByte(239);
			_local7.writeByte(187);
			_local7.writeByte(191);
			_local7.writeBytes(_arg1);
			return (_local7);
		}
		public static function rotate(_arg1:DisplayObject, _arg2:Number=0):void{
			var _local3:Number;
			var _local4:Number;
			var _local5:Point;
			var _local6:Point;
			var _local7:Point;
			var _local8:Point;
			var _local9:Number;
			var _local10:Point;
			var _local11:*;
			var _local12:Number;
			var _local13:Point;
			var _local14:*;
			var _local15:Point;
			var _local16:Array;
			var _local17:Array;
			_arg1.x = 0;
			_arg1.y = 0;
			_arg1.rotation = 0;
			if (_arg2 != 0){
				_local3 = _arg1.width;
				_local4 = _arg1.height;
				_local5 = new Point(0, 0);
				_local6 = new Point(_local3, 0);
				_local7 = new Point(_local3, -(_local4));
				_local8 = new Point(0, -(_local4));
				_local9 = ((_arg2 * Math.PI) / 180);
				_local10 = new Point((_local3 * Math.cos(_local9)), (_local3 * Math.sin(_local9)));
				_local11 = (_arg2 + ((Math.atan((_local4 / _local3)) * 180) / Math.PI));
				_local11 = ((_local11 * Math.PI) / 180);
				_local12 = Point.distance(_local5, _local7);
				_local13 = new Point((_local12 * Math.cos(_local11)), (_local12 * Math.sin(_local11)));
				_local14 = (_arg2 + 90);
				_local14 = ((_local14 * Math.PI) / 180);
				_local15 = new Point((_local4 * Math.cos(_local14)), (_local4 * Math.sin(_local14)));
				_local16 = [0, Math.round(_local10.x), Math.round(_local13.x), Math.round(_local15.x)];
				_local17 = [0, Math.round(_local10.y), Math.round(_local13.y), Math.round(_local15.y)];
				_local16.sort(Array.NUMERIC);
				_local17.sort(Array.NUMERIC);
				_arg1.x = -(_local16[0]);
				_arg1.y = -(_local17[0]);
				_arg1.rotation = _arg2;
			};
		}
		public static function fit(_arg1:DisplayObject, _arg2:Number, _arg3:Number, _arg4:Number):void{
			_arg1.scaleX = 1;
			_arg1.scaleY = 1;
			var _local5:Number = _arg1.width;
			var _local6:Number = _arg1.height;
			var _local7:Number = (_local5 / _local6);
			var _local8:Number = (_arg2 / _arg3);
			switch (_arg4){
			case 1:
				if (_local7 > _local8){
					_local5 = _arg2;
					_local6 = (_local5 / _local7);
				} else {
					_local6 = _arg3;
					_local5 = (_local6 * _local7);
				};
				break;
			case 2:
				_local5 = _arg2;
				_local6 = _arg3;
				break;
			case 3:
				if (_local7 > _local8){
					_local6 = _arg3;
					_local5 = (_local6 * _local7);
				} else {
					_local5 = _arg2;
					_local6 = (_local5 / _local7);
				};
				break;
			};
			var _local9:Number = (_arg2 - _local5);
			var _local10:Number = (_arg3 - _local6);
			_arg1.x = Math.round((_local9 * 0.5));
			_arg1.y = Math.round((_local10 * 0.5));
			_arg1.width = Math.round(_local5);
			_arg1.height = Math.round(_local6);
		}

	}
}


