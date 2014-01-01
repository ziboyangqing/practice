/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.SMPEvent;
	import com.smp.events.SMPStates;
	import com.smp.events.UIEvent;
	import com.utils.AppUtil;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.utils.ByteArray;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public final class SLrc extends Plane {

		public var loader:SURLLodader;
		public var formatBase:TextFormat;
		public var formatUpon:TextFormat;
		public var fontsize:Number = 12;
		public var scale:Number = 1;
		public var max_scale:Number = 2;
		public var max_button:Boolean = false;
		public var horizontal:int = 0;
		public var shim:SmartSprite;
		public var view:Sprite;
		public var back:Sprite;
		public var lrc:LR;
		public var kmc:KR;
		public var des:DE;
		public var bar:Sprite;
		public var btL:SButton;
		public var sdS:Slide;
		public var mcS:Sprite;
		public var btW:SButton;
		public var draging:Boolean = false;
		public var dragpos:Number;
		public var rail:Sprite;
		public var mark:TextField;
		public var markFormat:TextFormat;
		public var model:Object;
		public var f_t:uint;

		public function SLrc():void{
			this.formatBase = new TextFormat();
			this.formatUpon = new TextFormat();
			this.shim = new SmartSprite();
			this.view = new Sprite();
			this.back = new Sprite();
			this.rail = new Sprite();
			super();
			this.formatBase.align = (this.formatUpon.align = "left");
			this.formatBase.color = (this.formatUpon.color = 0);
			this.formatBase.size = (this.formatUpon.size = 12);
			addChild(this.shim);
			this.view.mouseEnabled = false;
			this.view.mouseChildren = false;
			addChild(this.view);
			this.back.mouseEnabled = false;
			this.back.mouseChildren = false;
			addChild(this.back);
			this.lrc = new LR(this);
			addChild(this.lrc);
			this.kmc = new KR(this);
			addChild(this.kmc);
			this.des = new DE(this);
			addChild(this.des);
			this.markFormat = new TextFormat();
			this.markFormat.font = "Verdana";
			this.markFormat.size = 9;
			this.markFormat.align = "right";
			this.mark = new TextField();
			this.mark.defaultTextFormat = this.markFormat;
			this.mark.selectable = false;
			this.mark.height = 15;
			this.mark.mouseEnabled = false;
			this.rail.addChild(this.mark);
			this.rail.mouseEnabled = false;
			this.rail.visible = false;
			addChild(this.rail);
			this.bar = new Sprite();
			this.bar.y = 3;
			addChild(this.bar);
			this.btW = new SButton();
			this.btW.ds(-20, 0, 20, 20, SGraphics.gBtW(20, 20));
			this.btW.addEventListener(MouseEvent.CLICK, this.btMaxHandler);
			this.bar.addChild(this.btW);
			this.mcS = new Sprite();
			this.sdS = new Slide();
			this.sdS.ds(SGraphics.gSDB(8, 12), SGraphics.gSDTL(80, 20), "-19, 20, 80, 20", 80, 20);
			SGraphics.drawRect(this.sdS, 0, 0, 120, 20, 0, 0x333333);
			this.sdS.rotation = 90;
			this.sdS.visible = false;
			this.sdS.addEventListener(UIEvent.SLIDER_PERCENT, this.sdsHandler);
			this.mcS.addChild(this.sdS);
			this.btL = new SButton();
			this.btL.ds(-40, 0, 20, 20, SGraphics.gBtL(20, 20));
			this.mcS.addChild(this.btL);
			this.mcS.addEventListener(MouseEvent.MOUSE_OVER, this.sdsOver);
			this.mcS.addEventListener(MouseEvent.MOUSE_OUT, this.sdsOut);
			this.bar.addChild(this.mcS);
			Main.addEventListener(SMPEvent.MODEL_START, this.startHandler);
			Main.addEventListener(SMPEvent.MODEL_STATE, this.stateHandler);
			Main.addEventListener(SMPEvent.CONTROL_MAX, this.maxHandler);
			Main.addEventListener(SMPEvent.LRC_RESIZE, this.resizeHandler);
			Main.addEventListener(SMPEvent.SKIN_COMPLETE, this.firstSkin);
			Main.addEventListener(SMPEvent.LRC_LOAD, this.lrcLoad);
			Main.addEventListener(SMPEvent.LRC_LOADED, this.lrcLoaded);
			doubleClickEnabled = true;
			addEventListener(MouseEvent.DOUBLE_CLICK, this.dbclickHandler);
			addEventListener(MouseEvent.ROLL_OVER, this.overHandler);
			addEventListener(MouseEvent.ROLL_OUT, this.outHandler);
			addEventListener(MouseEvent.MOUSE_MOVE, this.moveHandler);
		}
		public function firstSkin(_arg1:SMPEvent):void{
			Main.removeEventListener(SMPEvent.SKIN_COMPLETE, this.firstSkin);
			this.add(Config.lrc_image, this.view, Config.lrc_scalemode);
			this.des.init(Config.description);
			this.drag_init();
			this.hide();
		}
		private function add(_arg1:String, _arg2:DisplayObjectContainer, _arg3:Number=NaN):void{
			var _local4:String;
			var _local5:Array;
			var _local6:Object;
			var _local7:BR;
			if (_arg1){
				_local4 = AppUtil.auto(_arg1, Config);
				_local5 = AppUtil.json(_local4);
				for each (_local6 in _local5) {
					if (((!(isNaN(_arg3))) && (!(_local6.scalemode)))){
						_local6.scalemode = _arg3;
					};
					_local7 = new BR(_local6);
					_arg2.addChild(_local7);
				};
			};
		}
		public function btMaxHandler(_arg1:MouseEvent):void{
			Main.sendEvent(SMPEvent.LRC_MAX);
		}
		public function dbclickHandler(_arg1:MouseEvent):void{
			Main.sendEvent(SMPEvent.LRC_MAX);
		}
		public function maxHandler(_arg1:SMPEvent):void{
			if (_arg1.data == SMPEvent.LRC_MAX){
				this.lo();
			};
		}
		public function stateHandler(_arg1:SMPEvent):void{
			if (Config.state == SMPStates.STOPPED){
				this.stop();
				Main.rm(this.back);
			};
		}
		public function startHandler(_arg1:SMPEvent):void{
			var _local2:String = ((Main.item.bg_lrc) || (Config.bg_lrc));
			if (_local2){
				_local2 = AppUtil.auto(_local2, Main.item);
				this.add(_local2, this.back);
			};
			Main.sendEvent(SMPEvent.LRC_LOAD);
		}
		public function lrcLoad(_arg1:SMPEvent):void{
			var _local2:String;
			if (_arg1.data != null){
				_local2 = _arg1.data.toString();
			} else {
				if (Main.item){
					_local2 = ((Main.item.lrc) || (Config.lrc_handler));
				};
			};
			if (!_local2){
				this.textLoad();
				return;
			};
			this.des.init();
			_local2 = AppUtil.auto(_local2, Main.item);
			_local2 = AppUtil.auto(_local2, Config);
			_local2 = Main.fU(_local2);
			this.loader = new SURLLodader(_local2, this.lrcError, this.lrcProgress, this.lrcDone);
		}
		public function lrcProgress(_arg1:uint, _arg2:uint):void{
			var _local3:String = "";
			if (_arg2){
				_local3 = (Math.round(((_arg1 / _arg2) * 100)) + "%");
			};
			this.des.text(_local3);
		}
		public function lrcError(_arg1:String):void{
			O.o(_arg1);
			Main.sendEvent(SMPEvent.LRC_ERROR, _arg1);
			this.textLoad();
		}
		public function lrcDone(_arg1:ByteArray):void{
			var _local2:Array = Zip.extract(_arg1);
			Main.sendEvent(SMPEvent.LRC_LOADED, _local2[0]);
		}
		public function lrcLoaded(_arg1:SMPEvent):void{
			var _local2:String = "";
			if (_arg1.data){
				_local2 = _arg1.data.toString();
			};
			this.parse(_local2);
		}
		public function parse(_arg1:String):void{
			var _local2:String;
			var _local3:RegExp;
			var _local4:Boolean;
			if (_arg1){
				trace(AppUtil.d64("Y2VuZnVuX211c2ljX3BsYXllcl92ZXJzaW9u"));
				/*_local2 = Main[AppUtil.d64("Y2VuZnVuX211c2ljX3BsYXllcl92ZXJzaW9u")];
				if (_local2.indexOf((Main + "")) == -1){
					Main.sendEvent(CS.ERROR, this);
					return;
				};*/
				_local3 = /^\s*$/;
				if (!_local3.test(_arg1)){
					_local4 = this.kmc.parse(_arg1);
					if (_local4){
						this.model = this.kmc;
						Main.sendEvent(SMPEvent.LRC_COMPLETE, CS.KMC);
						this.init();
						return;
					};
					_local4 = this.lrc.parse(_arg1);
					if (_local4){
						this.model = this.lrc;
						Main.sendEvent(SMPEvent.LRC_COMPLETE, CS.LRC);
						this.init();
						return;
					};
					this.model = null;
					this.des.init(_arg1);
					Main.sendEvent(SMPEvent.LRC_COMPLETE, CS.DES);
					this.init();
					Main.sendEvent(SMPEvent.LRC_ROWCHANGE, _arg1);
					return;
				};
			};
			this.lrcError("Invaild lrc content");
		}
		public function textLoad():void{
			var _local1:String;
			if (Main.item){
				_local1 = Main.item.text;
			};
			this.stop(_local1);
		}
		public function stop(_arg1:String=""):void{
			this.model = null;
			Main.removeEventListener(SMPEvent.MODEL_TIME, this.update);
			if (this.loader){
				this.loader.stop();
				this.loader = null;
			};
			this.lrc.stop();
			this.kmc.stop();
			this.des.init(((_arg1) || (Config.description)));
			this.drag_stop();
		}
		public function init():void{
			Main.removeEventListener(SMPEvent.MODEL_TIME, this.update);
			this.des.clear();
			if (!visible){
				return;
			};
			if (this.model){
				this.des.stop();
				this.model.init();
				this.model.visible = true;
				Main.addEventListener(SMPEvent.MODEL_TIME, this.update);
			} else {
				this.des.auto();
			};
			this.drag_init();
		}
		public function update(_arg1:Event):void{
			if (((((!(visible)) || (!(this.model)))) || (this.draging))){
				return;
			};
			this.model.update();
		}
		public function drag_init():void{
			if (((((this.des.overflow) || ((((this.model == this.lrc)) && (!(this.horizontal)))))) || ((((this.model == this.kmc)) && ((this.kmc.line_mode == 0)))))){
				buttonMode = true;
				addEventListener(MouseEvent.MOUSE_DOWN, this.sdrag);
			} else {
				this.drag_stop();
			};
		}
		public function drag_stop():void{
			buttonMode = false;
			removeEventListener(MouseEvent.MOUSE_DOWN, this.sdrag);
		}
		public function sdrag(_arg1:MouseEvent):void{
			if (this.bar.hitTestPoint(mouseX, mouseY)){
				return;
			};
			this.dragpos = mouseY;
			stage.addEventListener(MouseEvent.MOUSE_UP, this.edrag);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, this.idrag);
		}
		public function idrag(_arg1:MouseEvent):void{
			var _local2:Number;
			var _local3:Rectangle;
			if (this.dragpos == mouseY){
				return;
			};
			if (this.model){
				if (this.draging){
					this.find();
				} else {
					this.draging = true;
					this.rail.visible = true;
					_local2 = (this.model.main.height - 2);
					_local3 = new Rectangle(0, ((th * 0.5) - _local2), 0, _local2);
					this.model.main.startDrag(false, _local3);
				};
			} else {
				this.des.idrag();
			};
		}
		public function edrag(_arg1:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.idrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.edrag);
			if (this.model){
				if (this.draging){
					this.model.main.stopDrag();
					this.rail.visible = false;
					this.draging = false;
					this.find();
				};
			} else {
				this.des.edrag();
			};
		}
		public function find():void{
			var _local3:int;
			var _local4:DisplayObject;
			var _local5:KL;
			var _local1:Point = new Point((tw * 0.5), (th * 0.5));
			var _local2:Array = this.model.main.getObjectsUnderPoint(_local1);
			for each (_local4 in _local2) {
				if ((((this.model == this.lrc)) && ((_local4 is TextField)))){
					_local3 = this.model.main.getChildIndex(_local4);
					this.seek(_local3);
					break;
				};
				if (this.model == this.kmc){
					while (_local4.parent) {
						_local4 = _local4.parent;
						if ((_local4 is KL)){
							_local5 = (_local4 as KL);
							break;
						};
					};
					if (_local5){
						_local3 = this.model.main.getChildIndex(_local5);
						this.seek(_local3);
						break;
					};
				};
			};
		}
		public function seek(_arg1:int):void{
			var _local3:String;
			var _local2:Number = 0;
			if (this.model == this.lrc){
				_local2 = (this.lrc.list[_arg1][0] * 0.001);
			} else {
				if (this.model == this.kmc){
					_local2 = (this.kmc.list[_arg1].time.start * 0.001);
				};
			};
			if (this.draging){
				_local3 = ((AppUtil.zero((_local2 / 60)) + ":") + AppUtil.zero((_local2 % 60)));
				this.mark.text = _local3;
			} else {
				_local2 = (_local2 - Main.item.position);
				Main.sendEvent(SMPEvent.VIEW_PROGRESS, _local2);
			};
		}
		public function resizeHandler(_arg1:SMPEvent):void{
			var e:* = _arg1;
			SGraphics.drawRect(this, 0, 0, tw, th);
			this.bar.x = (tw - 5);
			var _local3:Graphics = this.rail.graphics;
			with (_local3) {
				clear();
				lineStyle(1, formatBase.color);
				moveTo(2, 0);
				lineTo((tw - 2), 0);
				moveTo(1, -5);
				lineTo(1, 6);
				moveTo((tw - 2), -5);
				lineTo((tw - 2), 6);
			};
			this.rail.y = Math.ceil((th * 0.5));
			this.markFormat.color = this.formatBase.color;
			this.mark.defaultTextFormat = this.markFormat;
			this.mark.width = (tw - 2);
			this.kmc.ll(tw, th);
			this.lrc.ll(tw, th);
			this.des.ll(tw, th);
		}
		override public function lo():void{
			var _local1:Array;
			if (Config.lrc_max){
				_local1 = [0, 0, Config.width, Config.height];
				this.formatBase.size = (this.formatUpon.size = int((this.fontsize * this.scale)));
				this.btW.reverse = false;
			} else {
				if (((((!(_xywh)) || (!(_pw)))) || (!(_ph)))){
					visible = false;
					return;
				};
				_local1 = AppUtil.xywh(_xywh, _pw, _ph);
				this.mcS.visible = false;
				this.btW.visible = false;
				this.formatBase.size = (this.formatUpon.size = this.fontsize);
				this.btW.reverse = true;
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
			if ((((Config.lrc_width == tw)) && ((Config.lrc_height == th)))){
				return;
			};
			this.shim.size(tw, th);
			scrollRect = new Rectangle(0, 0, tw, th);
			Config.lrc_width = tw;
			Config.lrc_height = th;
			Main.sendEvent(SMPEvent.LRC_RESIZE);
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
			this.formatBase = AppUtil.format(_arg1);
			this.formatUpon = AppUtil.format(_arg1, 1);
			this.fontsize = ((int(this.formatBase.size)) || (12));
			var _local4:TextFormat = AppUtil.format_merge(this.formatBase);
			this.des.ss(_local4);
			this.horizontal = AppUtil.gOP(_arg1, "horizontal", 0);
			this.max_button = AppUtil.gOP(_arg1, "max_button", false);
			this.max_scale = AppUtil.gOP(_arg1, "max_scale", 2);
			if (((((isNaN(this.max_scale)) || ((this.max_scale < 2)))) || ((this.max_scale > 10)))){
				this.max_scale = 2;
			};
			this.sdsHandler();
			this.display = AppUtil.gOP(_arg1, "display", visible);
			filters = SGraphics.filters(_arg1);
			src = _arg1.@src;
			this.kmc.ss(_arg1);
			this.drag_init();
			_pw = _arg2;
			_ph = _arg3;
			_xywh = _arg1.@xywh;
			this.lo();
		}
		override public function set display(_arg1:String):void{
			super.display = _arg1;
			this.init();
		}
		override public function srcComplete(_arg1:LoaderInfo):void{
			this.shim.show(Zip.getLD(_arg1), tw, th);
		}
		public function sdsOver(_arg1:MouseEvent):void{
			this.sdS.visible = true;
		}
		public function sdsOut(_arg1:MouseEvent):void{
			this.sdS.visible = false;
		}
		public function sdsHandler(_arg1:UIEvent=null):void{
			var _local2:Number;
			var _local3:Number;
			if (_arg1){
				_local2 = this.sdS.percent;
				this.scale = (1 + ((this.max_scale - 1) * _local2));
				this.scale = AppUtil.clamp(this.scale, 1, this.max_scale);
				_local3 = int((this.fontsize * this.scale));
				if (_local3 != this.formatBase.size){
					this.formatBase.size = (this.formatUpon.size = _local3);
					Config.lrc_scale = this.scale;
					Main.setCookie("lrc_scale", Config.lrc_scale);
					Main.sendEvent(SMPEvent.LRC_RESIZE);
				};
			} else {
				this.scale = Number(Config.lrc_scale);
				this.scale = AppUtil.clamp(this.scale, 1, this.max_scale);
				_local2 = ((this.scale - 1) / (this.max_scale - 1));
				this.sdS.percent = _local2;
			};
		}
		public function overHandler(_arg1:MouseEvent):void{
			this.show();
			this.des.hover(true);
		}
		public function moveHandler(_arg1:MouseEvent):void{
			this.show();
		}
		public function outHandler(_arg1:MouseEvent):void{
			this.hide();
			this.des.hover(false);
		}
		public function show():void{
			if (((((((!(Config.lrc_max)) && (!(this.max_button)))) || ((tw < 60)))) || ((th < 26)))){
				return;
			};
			Mouse.show();
			if (((Config.lrc_max) && ((this.model == this.lrc)))){
				this.mcS.visible = true;
			};
			this.btW.visible = true;
			clearTimeout(this.f_t);
			this.f_t = setTimeout(this.hide, 2000);
		}
		public function hide():void{
			clearTimeout(this.f_t);
			var _local1:Boolean = this.bar.hitTestPoint(stage.mouseX, stage.mouseY, true);
			if (_local1){
				return;
			};
			if (((Config.lrc_max) && (Config.fullscreen))){
				Mouse.hide();
			};
			this.mcS.visible = false;
			this.btW.visible = false;
		}

	}
}


