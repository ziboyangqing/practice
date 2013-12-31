
package com.tencent.utils {
	import flash.external.*;

	public class ParamsVerify {

		public static const DEFAULT_ALLOWDOMAIN_LIST:Array = ["qq.com", "soso.com", "paipai.com", "gtimg.cn", "gtimg.com", "pengyou.com", "app100620792.imgcache.qzoneapp.com", "app100620792.qzone.qzoneapp.com", "app347.qzone.qzoneapp.com", "app347-1.qzone.qzoneapp.com", "app347-2.qzone.qzoneapp.com", "app347.imgcache.qzoneapp.com", "app383.imgcache.qzoneapp.com", "app383.qzone.qzoneapp.com", "app383-1.qzone.qzoneapp.com", "app383-2.qzone.qzoneapp.com", "app383-3.qzone.qzoneapp.com", "app383-4.qzone.qzoneapp.com", "app383-5.qzone.qzoneapp.com"];

		public static var objIdAllowed:Boolean = true;

		public static function checkObjectID():Boolean{
			var _local1:String;
			try {
				if (ExternalInterface.available){
					_local1 = ExternalInterface.objectID;
					if (((!(_local1)) || ((_local1 == _local1.replace(getDisNormalRegexp(), ""))))){
						return (true);
					};
					return (false);
				};
			} catch(e:Error) {
			};
			return (true);
		}
		public static function getDisNormalRegexp():RegExp{
			var _local1:RegExp = /[^0-9a-zA-Z_]/g;
			return (_local1);
		}
		public static function getAllowDomainName(_arg1:Array=null):String{
			var patterns:* = null;
			var whiteListDomainArr:Array = _arg1;
			var domainName:* = "";
			try {
				if (((ExternalInterface.available) && (checkObjectID()))){
					patterns = getUrlPattern(String(ExternalInterface.call("eval", "location.href")));
				};
				if (patterns){
					if (whiteListDomainArr == null){
						whiteListDomainArr = DEFAULT_ALLOWDOMAIN_LIST;
					};
					if (isWhiteListDomain(patterns.host, whiteListDomainArr, false)){
						domainName = patterns.host;
					};
				};
			} catch(e:Error) {
				domainName = "";
			};
			return (domainName);
		}
		public static function getUrlPattern(_arg1:String):Object{
			var _local2:RegExp = /^http:\/\/([^:\/]+)(?::(\d+))?(\/.*$)/i;
			var _local3:Object = _local2.exec(_arg1);
			var _local4:String = "";
			var _local5:Number = 80;
			var _local6:String = "";
			if (_local3){
				_local4 = _local3[1];
				_local5 = ((int(_local3[2])) || (80));
				_local6 = ((_local3[3]) || ("/"));
				return ({
						host:_local4,
						port:_local5,
						path:_local6
					});
			};
			return (null);
		}
		public static function isWhiteListDomain(_arg1:String, _arg2:Array, _arg3:Boolean=true):Boolean{
			var _local5:int;
			var _local6:RegExp;
			var _local7:String;
			var _local8:Object;
			var _local4:Boolean;
			if (_arg2){
				_local5 = _arg2.length;
			};
			if (_arg3){
				_local8 = getUrlPattern(_arg1);
				if (_local8){
					_arg1 = _local8.host;
				} else {
					return (false);
				};
			};
			var _local9:int;
			while (_local9 < _local5) {
				_local7 = _arg2[_local9];
				if (_local7){
					_local7 = _local7.replace(/\./g, "\\.");
					_local6 = new RegExp((("(\\." + _local7) + ")$"));
					if (((_local6.test(_arg1)) || ((_arg2[_local9] == _arg1)))){
						_local4 = true;
					};
				};
				_local9++;
			};
			return (_local4);
		}

	}
}


