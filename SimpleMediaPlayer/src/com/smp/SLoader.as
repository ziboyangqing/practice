/*SimpleMediaPlayer*/
package com.smp {
	import flash.utils.*;
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;

	public final class SLoader extends Loader {

		private var onComplete:Function;
		private var smoothing:Boolean;

		public function SLoader(_arg1:*, _arg2:Function, _arg3:Boolean=false):void{
			var src:* = _arg1;
			var _onComplete:* = _arg2;
			var _smoothing:Boolean = _arg3;
			super();
			this.onComplete = _onComplete;
			this.smoothing = _smoothing;
			if (!src){
				this.error();
				return;
			};
			contentLoaderInfo.addEventListener(Event.COMPLETE, this.loaded, false, 0, true);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.error, false, 0, true);
			try {
				if ((src is ByteArray)){
					loadBytes(src);
				} else {
					load(new URLRequest(src));
				};
			} catch(e:Error) {
				error();
			};
		}
		private function error(_arg1:Event=null):void{
			this.onComplete.call(null, null);
		}
		private function loaded(_arg1:Event):void{
			var _local2:Bitmap;
			if (this.smoothing){
				if (contentLoaderInfo.childAllowsParent){
					if (((content) && ((content is Bitmap)))){
						_local2 = (content as Bitmap);
						if (((_local2.width) && (_local2.height))){
							try {
								_local2.smoothing = true;
							} catch(e:Error) {
							};
						};
					};
				};
			};
			this.onComplete.call(null, contentLoaderInfo);
		}

	}
}


