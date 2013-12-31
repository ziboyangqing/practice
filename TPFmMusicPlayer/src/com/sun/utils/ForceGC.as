
package com.sun.utils {
	import flash.net.*;

	public class ForceGC {

		public static function gc():void{
			try {
				new LocalConnection().connect("foo");
				new LocalConnection().connect("foo");
			} catch(e:Error) {
			};
		}

	}
}


