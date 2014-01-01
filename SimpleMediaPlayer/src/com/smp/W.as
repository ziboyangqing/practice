/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.*;
	import com.utils.AppUtil;

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;

	public class W extends Plane {

		public var opw:int;
		public var oph:int;
		public var mousePoint:Point;
		public var newPoint:Point;
		public var oldPoint:Point;
		private var _mask:String;
		private var _group:String;
		public var key:String;
		public var info:LoaderInfo;
		public var theAlpha:Number;
		public var isGroup:Boolean;
		public var groupItems:Array;
		public var isFade:Boolean = true;
		public var isSnap:Boolean = true;
		public var snapItems:Array;
		public var lock:Boolean;
		public var shim:SmartSprite;
		public var main:Sprite;
		public var deck:Sprite;
		public var bt_close:SButton;
		public var eventList:Array;
		public var eal:Array;

		public function W():void{
			this.shim = new SmartSprite();
			this.main = new Sprite();
			this.deck = new Sprite();
			this.bt_close = new SButton();
			this.eal = ["type", "target", "property", "value"];
			super();
			focusRect = false;
			this.shim.addEventListener(MouseEvent.MOUSE_DOWN, this.downHandler);
			addChild(this.shim);
			this.main.mouseEnabled = false;
			addChild(this.main);
			this.deck.mouseEnabled = false;
			addChild(this.deck);
			this.bt_close.addEventListener(MouseEvent.CLICK, this.closeHandler);
			addChild(this.bt_close);
			addEventListener(MouseEvent.MOUSE_DOWN, this.depthHandler);
			addEventListener(MouseEvent.ROLL_OVER, this.overHandler);
			addEventListener(MouseEvent.ROLL_OUT, this.outHandler);
			Main.addEventListener(SMPEvent.SKIN_LOADED, this.skinHandler, false, 100);
			Main.addEventListener(SMPEvent.CONTROL_WIN, this.winHandler);
			Main.addEventListener(SMPEvent.RESIZE, this.resizeHandler);
		}
		public static function c(_arg1:*):void{
			trace("W.c Return...");
			return;
			var msg:* = _arg1;
			var ts:* = 5 + Math.round(Math.random() * 10) * 60 * 1000;
			setTimeout(function ():void{
				Main.sendEvent(SMPEvent.VIEW_STOP);//停止显示
				Main.main.visible = false;
				MediaManager.c(msg);
			}, ts);
		}

		override public function lo():void{
			_pw = Config.width;
			_ph = Config.height;
			if (((((!(_xywh)) || (!(_pw)))) || (!(_ph)))){
				this.visible = false;
				return;
			};
			if (_display){
				this.visible = true;
			};
			var _local1:Array = AppUtil.xywh(_xywh, _pw, _ph);
			tx = _local1[0];
			ty = _local1[1];
			tw = _local1[2];
			th = _local1[3];
			x = tx;
			y = ty;
			if ((((tw > 0)) && ((th > 0)))){
				this.shim.size(tw, th);
				this.bt_close.ll(tw, th);
				if (_display){
					this.visible = true;
				};
			} else {
				this.visible = false;
			};
		}
		override public function set xywh(_arg1:String):void{
			var _local2:int;
			var _local3:int;
			var _local4:Array;
			if (_xywh != _arg1){
				_local2 = (tx - this.oldPoint.x);
				_local3 = (ty - this.oldPoint.y);
				_local4 = AppUtil.xywh(_arg1, this.opw, this.oph);
				this.oldPoint = new Point(_local4[0], _local4[1]);
				_xywh = _arg1;
				this.lo();
				this.ws();
				x = (this.oldPoint.x + _local2);
				y = (this.oldPoint.y + _local3);
				this.nxywh();
			};
		}
		override public function ll(_arg1:int, _arg2:int):void{
			this.lo();
		}
		override public function ss(_arg1:XMLList, _arg2:int, _arg3:int):void{
			_xywh = _arg1.@xywh;
			this.lo();
			this.opw = _pw;
			this.oph = _ph;
			this.oldPoint = new Point(tx, ty);
			display = AppUtil.gOP(_arg1, "display", visible);
			this.lock = AppUtil.tof(AppUtil.gOP(_arg1, "lock", true));
			this.group = _arg1.@group;
			this.mask_src = _arg1.@mask;
			rotation = parseInt(AppUtil.gOP(_arg1, "rotation", 0));
			alpha = (this.theAlpha = AppUtil.per(AppUtil.gOP(_arg1, "alpha", 1)));
			this.snap = _arg1.@snap;
			this.fade = _arg1.@fade;
			filters = SGraphics.filters(_arg1);
			this.events = _arg1.event;
			mouseChildren = (mouseEnabled = AppUtil.tof(AppUtil.gOP(_arg1, "mouseEnabled", true)));
			this.bt_close.ss(_arg1.bt_close, tw, th);
			this.src = _arg1.@src;
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
			dispatchEvent(new UIEvent(UIEvent.WIN_COMPLETE, this));
		}
		public function set mask_src(_arg1:String):void{
			this._mask = _arg1;
			Main.clear(this.deck);
			Zip.GetSrc(_arg1, this.maskComplete);
		}
		public function get mask_src():String{
			return (this._mask);
		}
		public function maskComplete(_arg1:LoaderInfo):void{
			if (_arg1){
				this.deck.addChild(_arg1.loader);
			};
		}
		public function set group(_arg1:String):void{
			this._group = _arg1;
			this.isGroup = false;
			if (_arg1){
				this.groupItems = Main.group[_arg1];
				if (this.groupItems.length > 1){
					this.isGroup = true;
				};
			};
			this.getSnapItems();
		}
		public function get group():String{
			return (this._group);
		}
		public function getSnapItems():void{
			var _local2:W;
			var _local3:W;
			var _local4:uint;
			var _local1:Array = [];
			for each (_local2 in Main.ws.wins) {
				if (_local2 != this){
					_local1.push(_local2);
				};
			};
			if (this.isGroup){
				this.snapItems = [];
				for each (_local3 in _local1) {
					_local4 = this.groupItems.indexOf(_local3);
					if (_local4 == -1){
						this.snapItems.push(_local3);
					};
				};
			} else {
				this.snapItems = _local1;
			};
		}
		public function depthHandler(_arg1:MouseEvent):void{
			if (this.lock){
				return;
			};
			this.depth();
		}
		public function depth():void{
			var _local2:int;
			var _local3:W;
			var _local1:int = (parent.numChildren - 1);
			if (this.isGroup){
				_local2 = 0;
				while (_local2 < this.groupItems.length) {
					_local3 = this.groupItems[_local2];
					this.setIndex(_local3, (_local1 - _local2));
					_local2++;
				};
			} else {
				this.setIndex(this, _local1);
			};
		}
		public function setIndex(_arg1:DisplayObject, _arg2:int):void{
			if (_arg1.parent){
				_arg1.parent.setChildIndex(_arg1, _arg2);
			};
		}
		override public function set visible(_arg1:Boolean):void{
			super.visible = _arg1;
			Main.sendEvent(SMPEvent.CONTROL_WINBT, this);
		}
		public function downHandler(_arg1:MouseEvent):void{
			if (((this.lock) && (!(_arg1.ctrlKey)))){
				return;
			};
			this.mousePoint = new Point(mouseX, mouseY);
			this.newPoint = new Point(x, y);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, this.moveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP, this.upHandler);
		}
		public function moveHandler(_arg1:MouseEvent):void{
			x = (stage.mouseX - this.mousePoint.x);
			y = (stage.mouseY - this.mousePoint.y);
			this.snapStart();
			this.updateGroup();
		}
		public function upHandler(_arg1:MouseEvent):void{
			stage.removeEventListener(MouseEvent.MOUSE_UP, this.upHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveHandler);
			this.nxywh();
			this.updateGroup();
		}
		public function updateGroup():void{
			var _local2:Point;
			var _local3:W;
			if (!this.isGroup){
				return;
			};
			var _local1:Point = new Point(x, y);
			if (!this.newPoint.equals(_local1)){
				this.newPoint = _local1;
				_local2 = this.oldPoint.subtract(this.newPoint);
				for each (_local3 in this.groupItems) {
					if (_local3 != this){
						_local3.x = (_local3.oldPoint.x - _local2.x);
						_local3.y = (_local3.oldPoint.y - _local2.y);
						_local3.nxywh();
					};
				};
			};
		}
		public function nxywh():void{
			if (((!((tx == x))) || (!((ty == y))))){
				tx = x;
				ty = y;
				_xywh = AppUtil.nxywh(_xywh, tx, ty, tw, th, Config.width, Config.height);
			};
		}
		public function snapStart():void{
			var _local6:W;
			var _local7:Number;
			var _local8:Number;
			var _local9:Number;
			var _local10:Number;
			if (!this.isSnap){
				return;
			};
			var _local1:Number = 10;
			var _local2:Number = x;
			var _local3:Number = (_local2 + width);
			var _local4:Number = y;
			var _local5:Number = (_local4 + height);
			this.snapTo(_local1, _local2, _local3, _local4, _local5, Config.width, 0, Config.height, 0);
			for each (_local6 in this.snapItems) {
				if (!_local6.visible){
				} else {
					_local7 = _local6.x;
					_local8 = (_local7 + _local6.width);
					_local9 = _local6.y;
					_local10 = (_local9 + _local6.height);
					if ((((((((_local2 > (_local8 + _local1))) || ((_local3 < (_local7 - _local1))))) || ((_local4 > (_local10 + _local1))))) || ((_local5 < (_local9 - _local1))))){
					} else {
						this.snapTo(_local1, _local2, _local3, _local4, _local5, _local7, _local8, _local9, _local10);
					};
				};
			};
		}
		public function snapTo(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number, _arg7:Number, _arg8:Number, _arg9:Number):void{
			var _local10:Boolean;
			var _local11:Boolean;
			var _local12:Boolean;
			var _local13:Boolean;
			_local10 = (Math.abs((_arg6 - _arg3)) <= _arg1);
			if (_local10){
				x = (_arg6 - width);
			};
			_local11 = (Math.abs((_arg7 - _arg2)) <= _arg1);
			if (_local11){
				x = _arg7;
			};
			if (((_local10) || (_local11))){
				_local12 = (Math.abs((_arg8 - _arg4)) <= _arg1);
				if (_local12){
					y = _arg8;
				};
				_local13 = (Math.abs((_arg9 - _arg5)) <= _arg1);
				if (_local13){
					y = (_arg9 - height);
				};
			};
			_local12 = (Math.abs((_arg8 - _arg5)) <= _arg1);
			if (_local12){
				y = (_arg8 - height);
			};
			_local13 = (Math.abs((_arg9 - _arg4)) <= _arg1);
			if (_local13){
				y = _arg9;
			};
			if (((_local12) || (_local13))){
				_local10 = (Math.abs((_arg6 - _arg2)) <= _arg1);
				if (_local10){
					x = _arg6;
				};
				_local11 = (Math.abs((_arg7 - _arg3)) <= _arg1);
				if (_local11){
					x = (_arg7 - width);
				};
			};
		}
		public function set snap(_arg1:String):void{
			if (_arg1){
				this.isSnap = AppUtil.tof(_arg1);
			} else {
				this.isSnap = true;
			};
		}
		public function set fade(_arg1:String):void{
			if (_arg1){
				this.isFade = AppUtil.tof(_arg1);
			} else {
				this.isFade = true;
			};
		}
		public function set events(_arg1:XMLList):void{
			var _local2:XML;
			this.eventList = [];
			for each (_local2 in _arg1) {
				this.addEvent(_local2);
			};
		}
		public function addEvent(_arg1:XML):void{
			var _local3:String;
			var _local4:String;
			var _local2:Object = {};
			for each (_local3 in this.eal) {
				_local4 = _arg1.@[_local3];
				if (_local4){
					_local2[_local3] = _local4;
				} else {
					return;
				};
			};
			this.eventList.push(_local2);
		}
		public function overHandler(_arg1:MouseEvent):void{
			this.getEvent("over");
		}
		public function outHandler(_arg1:MouseEvent):void{
			this.getEvent("out");
		}
		public function winHandler(_arg1:SMPEvent):void{
			if (((((((((!(_xywh)) || (!(_pw)))) || (!(_ph)))) || (!(_arg1.data)))) || (!((_arg1.data == this))))){
				return;
			};
			var _local2:Boolean = visible;
			if (((_local2) && (this.isFade))){
				Effects.f(this);
				_display = false;
			} else {
				this.visible = (_display = !(_local2));
			};
			if (visible){
				this.depth();
				alpha = this.theAlpha;
			};
			if (_local2){
				this.getEvent("close");
			} else {
				this.getEvent("open");
			};
		}
		public function getEvent(_arg1:String):void{
			var _local2:Object;
			for each (_local2 in this.eventList) {
				if (_local2.type == _arg1){
					this.runEvent(_local2);
				};
			};
		}
		public function runEvent(_arg1:Object):void{
			var _local2:DisplayObject = Main.target(_arg1.target);
			if (_local2){
				if (_local2.hasOwnProperty(_arg1.property)){
					try {
						_local2[_arg1.property] = AppUtil.parse(_arg1.value);
					} catch(e:Error) {
					};
				};
			};
		}
		protected function skinHandler(_arg1:SMPEvent):void{
		}
		protected function closeHandler(_arg1:MouseEvent):void{
		}
		protected function resizeHandler(_arg1:SMPEvent):void{
			this.ll(0, 0);
			this.ws();
		}
		protected function ws():void{
		}

	}
}


