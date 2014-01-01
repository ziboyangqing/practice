/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.SMPEvent;
	import com.smp.events.SMPStates;
	import com.utils.AppUtil;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.media.Video;

	public final class MediaView extends Plane {

		public var show_icon:Boolean = true;
		public var show_buttons:Boolean = true;
		public var shim:SmartSprite;
		public var view:Sprite;
		public var back:Sprite;
		public var mc_black:Sprite;
		public var mc_position:Sprite;
		public var mc_rotation:Sprite;
		public var logo:Sprite;
		public var vi:VI;
		public var mixer:MX;
		public var type:String;

		public function MediaView():void{
			this.shim = new SmartSprite();
			this.view = new Sprite();
			this.back = new Sprite();
			this.mc_black = new Sprite();
			this.mc_position = new Sprite();
			this.mc_rotation = new Sprite();
			this.logo = new Sprite();
			super();
			this.type = CS.OTHER;
			addChild(this.shim);
			addChild(this.view);
			addChild(this.back);
			this.mixer = Main.mx = new MX();
			addChild(this.mixer);
			addChild(this.mc_black);
			this.mc_black.addChild(this.mc_position);
			this.mc_position.addChild(this.mc_rotation);
			addChild(this.logo);
			this.vi = new VI(this);
			addChild(this.vi);
			Main.vc = new ViewControl(this);
			addChild(Main.vc);
			Main.addEventListener(SMPEvent.SKIN_COMPLETE, this.firstSkin);
			Main.addEventListener(SMPEvent.MODEL_START, this.startHandler);
			Main.addEventListener(SMPEvent.MODEL_STATE, this.stateHandler);
			Main.addEventListener(SMPEvent.CONTROL_MAX, this.maxHandler);
			Main.addEventListener(SMPEvent.VIDEO_RESIZE, this.resizeHandler);
		}
		public function showMixer(_arg1:Boolean):Sprite{
			var _local2:String = (_arg1) ? CS.SOUND : CS.OTHER;
			Main.vc.start(_local2);
			Main.mx.start(_local2);
			return (this.mixer);
		}
		public function showMedia(_arg1:DisplayObject):Sprite{
			Main.clear(this.mc_rotation);
			if ((_arg1 is Video)){
				this.showVideo((_arg1 as Video));
			} else {
				this.showFlash(_arg1);
			};
			return (this.mc_rotation);
		}
		public function showVideo(_arg1:Video):void{
			if (_arg1){
				this.type = CS.VIDEO;
				Main.vc.start(this.type);
				this.mc_rotation.addChild(_arg1);
				this.resizeVideo();
			};
		}
		public function resizeVideo():void{
			AppUtil.rotate(this.mc_rotation, Main.item.rotation);
			this.fit();
			this.mc_black.graphics.clear();
			if (((((this.mc_rotation.numChildren) && ((this.mc_rotation.width > 0)))) && ((this.mc_rotation.height > 0)))){
				SGraphics.drawRect(this.mc_black, 0, 0, Config.video_width, Config.video_height, 1, 0);
			};
		}
		public function showFlash(_arg1:DisplayObject):void{
			if (_arg1){
				this.type = CS.FLASH;
				Main.vc.start(this.type);
				this.mc_rotation.addChild(_arg1);
				this.resizeFlash();
			};
		}
		public function resizeFlash():void{
			var _local2:Array;
			var _local3:int;
			var _local4:int;
			var _local5:int;
			var _local6:int;
			var _local7:int;
			var _local8:int;
			var _local9:Array;
			var _local10:Array;
			var _local11:Array;
			AppUtil.rotate(this.mc_rotation, Main.item.rotation);
			var _local1:String = Main.item.xywh;
			if (_local1){
				_local2 = AppUtil.xywh(_local1, Config.video_width, Config.video_height);
				_local3 = _local2[0];
				_local4 = _local2[1];
				_local5 = _local2[2];
				_local6 = _local2[3];
				this.mc_position.x = _local3;
				this.mc_position.y = _local4;
				_local7 = this.mc_rotation.width;
				_local8 = this.mc_rotation.height;
				if ((((_local7 > 0)) && ((_local8 > 0)))){
					if ((((_local5 > 0)) && ((_local6 > 0)))){
						this.mc_position.width = _local5;
						this.mc_position.height = _local6;
					} else {
						_local9 = AppUtil.array(_local1);
						_local10 = AppUtil.ns(_local9[0]);
						_local11 = AppUtil.ns(_local9[1]);
						this.mc_position.x = AppUtil.mxoy(_local3, _local10[1], _local7);
						this.mc_position.y = AppUtil.mxoy(_local4, _local11[1], _local8);
					};
				};
			} else {
				this.fit();
			};
		}
		public function fit():void{
			AppUtil.fit(this.mc_position, tw, th, Main.scalemode());
		}
		public function startHandler(_arg1:SMPEvent):void{
			this.type = Main.item.type;
			var _local2:String = ((Main.item.bg_video) || (Config.bg_video));
			if (_local2){
				_local2 = AppUtil.auto(_local2, Main.item);
				this.add(_local2, this.back);
			};
		}
		public function stateHandler(_arg1:SMPEvent):void{
			if (Config.state == SMPStates.STOPPED){
				this.type = CS.OTHER;
				this.mc_black.graphics.clear();
				Main.clear(this.mc_rotation);
				Main.rm(this.back);
				this.mc_position.x = (this.mc_position.y = 0);
				this.mc_position.scaleX = (this.mc_position.scaleY = 1);
			};
		}
		public function resizeHandler(_arg1:SMPEvent):void{
			if (this.type == CS.VIDEO){
				this.resizeVideo();
			} else {
				if (this.type == CS.FLASH){
					this.resizeFlash();
				} else {
					this.fit();
				};
			};
		}
		public function maxHandler(_arg1:SMPEvent):void{
			if (_arg1.data == SMPEvent.VIDEO_MAX){
				this.lo();
			};
		}
		override public function lo():void{
			var _local1:Array;
			visible = true;
			if (Config.video_max){
				_local1 = [0, 0, Config.width, Config.height];
			} else {
				if (((((!(_xywh)) || (!(_pw)))) || (!(_ph)))){
					visible = false;
					return;
				};
				_local1 = AppUtil.xywh(_xywh, _pw, _ph);
			};
			if (AppUtil.same(_local1, [tx, ty, tw, th])){
				return;
			};
			tx = _local1[0];
			ty = _local1[1];
			tw = _local1[2];
			th = _local1[3];
			x = tx;
			y = ty;
			if ((((Config.video_width == tw)) && ((Config.video_height == th)))){
				return;
			};
			this.shim.size(tw, th);
			scrollRect = new Rectangle(0, 0, tw, th);
			Config.video_width = tw;
			Config.video_height = th;
			Main.sendEvent(SMPEvent.VIDEO_RESIZE);
		}
		override public function set xywh(_arg1:String):void{
			_xywh = _arg1;
			this.lo();
		}
		override public function ll(_arg1:int, _arg2:int):void{
			_pw = _arg1;
			_ph = _arg2;
			this.lo();
		}
		override public function ss(_arg1:XMLList, _arg2:int, _arg3:int):void{
			_pw = _arg2;
			_ph = _arg3;
			_xywh = _arg1.@xywh;
			this.lo();
			this.show_icon = AppUtil.gOP(_arg1, "show_icon", true);
			this.show_buttons = AppUtil.gOP(_arg1, "show_buttons", true);
			display = AppUtil.gOP(_arg1, "display", visible);
			filters = SGraphics.filters(_arg1);
			src = _arg1.@src;
		}
		override public function srcComplete(_arg1:LoaderInfo):void{
			this.shim.show(Zip.getLD(_arg1), tw, th);
		}
		public function firstSkin(_arg1:SMPEvent=null):void{
			Main.removeEventListener(SMPEvent.SKIN_COMPLETE, this.firstSkin);
			this.add(Config.video_image, this.view, Config.video_scalemode);
			this.add(Config.logo, this.logo);
			this.logo.alpha = Config.logo_alpha;
		}
		/**
		 * 添加显示对象到容器中
		 */
		private function add(targetName:String, container:DisplayObjectContainer, scalemode:Number=NaN):void{
			var _local4:String;
			var _local5:Array;
			var _local6:Object;
			var _local7:BV;
			if (targetName){
				_local4 = AppUtil.auto(targetName, Config);
				_local5 = AppUtil.json(_local4);
				for each (_local6 in _local5) {
					if (!isNaN(scalemode) && !_local6.scalemode){
						_local6.scalemode = scalemode;
					};
					_local7 = new BV(_local6);
					container.addChild(_local7);
				};
			};
		}

	}
}


