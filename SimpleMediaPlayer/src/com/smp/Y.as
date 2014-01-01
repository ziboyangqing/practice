/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.*;
	import com.utils.AppUtil;

	import flash.display.*;

	public final class Y extends Plane {

		public var key:String;
		public var info:LoaderInfo;
		public var loader:SLoader;
		public var shim:SmartSprite;
		public var main:Sprite;

		public function Y():void{
			this.shim = new SmartSprite();
			this.main = new Sprite();
			super();
			addChild(this.shim);
			addChild(this.main);
			Main.addEventListener(SMPEvent.MODEL_LOAD, this.load);
			Main.addEventListener(SMPEvent.MODEL_STATE, this.stop);
		}
		public function stop(_arg1:SMPEvent):void{
			if (Config.state == SMPStates.STOPPED){
				this.init();
			};
		}
		public function load(_arg1:SMPEvent=null):void{
			this.init();
			var _local2:String = ((Main.item.image) || (Config.image_handler));
			if (!_local2){
				return;
			};
			_local2 = AppUtil.auto(_local2, Main.item);
			_local2 = AppUtil.auto(_local2, Config);
			_local2 = Main.fU(_local2, true);
			this.loader = new SLoader(_local2, this.loaded, true);
		}
		public function loaded(_arg1:LoaderInfo):void{
			if (_arg1){
				this.fit();
				this.main.addChild(this.loader);
			} else {
				this.loader = null;
			};
		}
		public function fit():void{
			if (this.loader){
				AppUtil.fit(this.loader, tw, th, Main.scalemode());
			};
		}
		public function init():void{
			if (this.loader){
				try {
					this.loader.close();
				} catch(e:Error) {
				};
				try {
					this.loader.unloadAndStop();
				} catch(e:Error) {
				};
				this.loader = null;
			};
			Main.clear(this.main);
		}
		override public function size():void{
			this.shim.size(tw, th);
			this.fit();
		}
		override public function set src(_arg1:String):void{
			if (this.key){
				Main.ca.removeKey(this.key);
				Main.apirm(this.info);
				this.info = null;
			};
			super.src = _arg1;
		}
		override public function srcComplete(_arg1:LoaderInfo):void{
			this.info = _arg1;
			this.key = Main.api(this.info);
			this.shim.show(Zip.getLD(this.info), tw, th);
		}

	}
}


