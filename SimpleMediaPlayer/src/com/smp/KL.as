/*SimpleMediaPlayer*/
package com.smp {
	//import flash.events.*;
	import flash.display.*;
	import flash.text.*;
	//import flash.filters.*;
	//import flash.net.*;
	import com.utils.AppUtil;

	public class KL extends Sprite {

		public var kmc:KR;
		public var xml:XML;
		public var index:int;
		public var type:String;
		public var tx:Number = 0;
		public var ty:Number = 0;
		public var tw:Number = 0;
		public var th:Number = 0;
		public var pw:Number = 0;
		public var ph:Number = 0;
		public var align:String;
		public var text:String = "";
		public var time:Object;
		public var list:Array;
		public var tips:String;
		public var head:KT;
		public var dots:Array;
		public var sec3:Sprite;
		public var line_base:Sprite;
		public var line_upon:Sprite;
		public var mask_base:Sprite;
		public var mask_upon:Sprite;
		public var formatBase:TextFormat;
		public var formatUpon:TextFormat;
		public var prev:KL;
		public var main:Sprite;

		public function KL(_arg1:XML, _arg2:int, _arg3:KR):void{
			this.main = new Sprite();
			super();
			this.kmc = _arg3;
			this.xml = _arg1;
			this.index = _arg2;
			this.type = (((this.index % 2) == 0)) ? CS.LINE_ONE : CS.LINE_TWO;
			this.prev = this.kmc.list[(this.index - 1)];
			this.time = this.parseTime(this.xml.@t, this.kmc.offset);
			this.list = this.parseText(this.xml.text());
			addChild(this.main);
		}
		public function ll(_arg1:Boolean=false):void{
			this.pw = this.kmc.tw;
			this.ph = this.kmc.th;
			if (_arg1){
				this.lo();
			};
			if (this.kmc.line_mode == 0){
				this.align = this.kmc.align_one;
				this.ty = (this.th * this.index);
			} else {
				if (_arg1){
					visible = false;
				};
				if (this.kmc.line_mode == 1){
					this.align = this.kmc.align_one;
					this.ty = ((this.ph - this.th) * 0.5);
				} else {
					if (this.type == CS.LINE_ONE){
						this.align = this.kmc.align_one;
						this.ty = ((this.ph * 0.5) - this.th);
					} else {
						this.align = this.kmc.align_two;
						this.ty = (this.ph * 0.5);
					};
				};
			};
			if (this.align == CS.LEFT){
				this.tx = this.kmc.margin;
			} else {
				if (this.align == CS.RIGHT){
					this.tx = ((this.pw - this.tw) - this.kmc.margin);
				} else {
					this.tx = ((this.pw - this.tw) * 0.5);
				};
			};
			x = this.tx;
			y = this.ty;
		}
		public function checkSec3():Boolean{
			if (this.kmc.line_mode == 0){
				return (false);
			};
			var _local1:Number = 0;
			var _local2:Boolean;
			if (this.prev){
				_local1 = this.prev.time.end;
				if ((((this.prev.time.list.length == 0)) && ((this.time.list.length > 0)))){
					_local2 = true;
				};
			} else {
				if (((!(this.kmc.show_info)) && ((this.time.start > 3000)))){
					_local2 = true;
				};
			};
			if (((((this.time.start - _local1) > this.kmc.time_sec3)) || (_local2))){
				return (true);
			};
			return (false);
		}
		public function lo():void{
			this.formatBase = this.kmc.formatBase;
			this.formatUpon = this.kmc.formatUpon;
			Main.clear(this.main);
			this.main.graphics.clear();
			this.line_base = this.lineText(this.formatBase);
			this.line_upon = this.lineText(this.formatUpon);
			this.mask_base = this.lineMask(this.line_base.width, this.line_base.height);
			this.mask_upon = this.lineMask(this.line_base.width, this.line_base.height);
			this.mask_upon.width = 0;
			this.line_base.mask = this.mask_base;
			this.line_upon.mask = this.mask_upon;
			this.th = (this.line_base.height + this.kmc.leading);
			if (this.checkSec3()){
				this.sec3 = this.newSec3(this.th);
				this.main.addChild(this.sec3);
			};
			if (this.tips){
				this.head = new KT(this.tips, this.formatBase);
				this.head.tx = this.main.width;
				this.main.addChild(this.head);
			};
			var _local1:Sprite = new Sprite();
			_local1.addChild(this.line_base);
			_local1.addChild(this.mask_base);
			_local1.addChild(this.line_upon);
			_local1.addChild(this.mask_upon);
			_local1.x = this.main.width;
			_local1.y = (this.kmc.leading * 0.5);
			this.main.addChild(_local1);
			this.tw = this.main.width;
			SGraphics.drawRect(this.main, 0, 0, this.tw, this.th);
		}
		public function choose(_arg1:Number):void{
			if ((((_arg1 > this.time.start)) && ((_arg1 < this.time.end)))){
				this.kmc.now.push(this);
				return;
			};
			if ((((_arg1 < this.time.start)) && (!((this.kmc.line_mode == 0))))){
				if (this.prev){
					if (_arg1 >= this.prev.time.start){
						if (_arg1 > (this.time.start - this.kmc.time_preview)){
							this.kmc.pre.push(this);
							return;
						};
					};
				} else {
					if (_arg1 > (this.time.start - this.kmc.time_preview)){
						this.kmc.pre.push(this);
						return;
					};
				};
			};
			this.hide();
		}
		public function update(_arg1:Number):void{
			var _local4:int;
			var _local5:Number;
			var _local6:int;
			var _local7:int;
			var _local8:Number;
			var _local9:KT;
			this.hideSec3();
			var _local2:Number = 0;
			var _local3:Number = (_arg1 - this.time.start);
			if (_local3 > 0){
				_local4 = 0;
				_local5 = 0;
				_local6 = this.time.list.length;
				_local7 = 0;
				while (_local7 < _local6) {
					_local8 = this.time.list[_local7];
					if (_local3 <= _local8){
						_local4 = _local7;
						_local5 = (_local3 / _local8);
						break;
					};
					_local3 = (_local3 - _local8);
					_local7++;
				};
				if ((((_local4 >= 0)) && ((_local4 < this.line_base.numChildren)))){
					_local9 = (this.line_base.getChildAt(_local4) as KT);
					if (_local9){
						_local2 = (_local9.tx + (_local9.tw * _local5));
					};
				};
			};
			this.showPos(_local2);
		}
		public function showPos(_arg1:Number):void{
			this.mask_base.x = _arg1;
			this.mask_base.width = (this.tw - _arg1);
			this.mask_upon.width = _arg1;
			if (!visible){
				visible = true;
			};
		}
		public function show(_arg1:Number):void{
			this.showPos(0);
			this.showSec3(_arg1);
		}
		public function hide():void{
			if (this.kmc.line_mode == 0){
				this.showPos(0);
			} else {
				if (visible){
					this.visible = false;
				};
			};
		}
		public function showSec3(_arg1:Number):void{
			var _local2:Shape;
			var _local3:int;
			if (!this.sec3){
				return;
			};
			this.sec3.visible = true;
			for each (_local2 in this.dots) {
				_local2.alpha = 1;
			};
			_local3 = Math.floor(((this.time.start - _arg1) * 0.001));
			if (_local3 == 2){
				this.dots[0].alpha = 0.1;
			} else {
				if (_local3 == 1){
					this.dots[0].alpha = 0.1;
					this.dots[1].alpha = 0.1;
				} else {
					if (_local3 == 0){
						this.dots[0].alpha = 0.1;
						this.dots[1].alpha = 0.1;
						this.dots[2].alpha = 0.1;
					};
				};
			};
		}
		public function hideSec3():void{
			if (!this.sec3){
				return;
			};
			this.sec3.visible = false;
		}
		public function parseText(_arg1:String):Array{
			var _local5:int;
			var _local6:String;
			var _local7:Array;
			if (!_arg1){
				return ([]);
			};
			this.text = _arg1.replace(AppUtil.MID_TAG, "");
			var _local2:Array = _arg1.match(/^\(([^\)]+)\)/);
			if ((_local2 is Array)){
				this.tips = _local2[0];
				_arg1 = _arg1.substr(this.tips.length);
			};
			var _local3:Array = [];
			var _local4:RegExp = /^\[([^\]]+)\]/;
			while (_arg1.length) {
				_local5 = 1;
				_local7 = _arg1.match(_local4);
				if ((_local7 is Array)){
					_local5 = _local7[0].length;
					_local6 = _local7[1];
				} else {
					_local6 = _arg1.charAt(0);
				};
				_local3.push(_local6);
				_arg1 = _arg1.substr(_local5);
			};
			return (_local3);
		}
		public function lineText(_arg1:TextFormat):Sprite{
			var _local6:KT;
			var _local2:Sprite = new Sprite();
			var _local3:int = this.list.length;
			var _local4:int;
			var _local5:int;
			while (_local5 < _local3) {
				_local6 = new KT(this.list[_local5], _arg1);
				_local6.tx = _local4;
				_local2.addChild(_local6);
				_local4 = (_local4 + _local6.tw);
				_local5++;
			};
			return (_local2);
		}
		public function newSec3(_arg1:Number):Sprite{
			var _local4:Shape;
			var _local2:Sprite = new Sprite();
			this.dots = [];
			var _local3:int;
			while (_local3 < 3) {
				_local4 = this.newO(_arg1);
				_local4.x = ((_arg1 * _local3) * 0.6);
				_local2.addChild(_local4);
				this.dots.push(_local4);
				_local3++;
			};
			SGraphics.drawRect(_local2, 0, 0, (_local2.width + 3), _local2.height);
			return (_local2);
		}
		public function newO(_arg1:Number):Shape{
			var _local2:Shape = new Shape();
			var _local3:uint = int(this.formatBase.color);
			_local2.graphics.beginFill(_local3, 1);
			_local2.graphics.drawCircle((_arg1 * 0.2), (_arg1 * 0.5), (_arg1 * 0.2));
			_local2.graphics.endFill();
			return (_local2);
		}
		public function lineMask(_arg1:Number, _arg2:Number):Sprite{
			var _local3:Sprite = new Sprite();
			SGraphics.drawRect(_local3, 0, 0, _arg1, _arg2, 1, 0xFFFFFF);
			return (_local3);
		}
		public function parseTime(_arg1:String, _arg2:Number):Object{
			var _local4:Array;
			var _local3:Object = {
					start:0,
					end:0,
					list:[]
				};
			if (_arg1){
				_local4 = AppUtil.array(_arg1);
				_local3.start = (this.parseMin(_local4.shift()) + _arg2);
				_local3.end = (this.parseMin(_local4.shift()) + _arg2);
				_local3.list = _local4.map(this.parseNum);
			};
			return (_local3);
		}
		public function parseNum(_arg1:*, _arg2:int, _arg3:Array):Number{
			var _local4:Number = parseInt(_arg1);
			if (isNaN(_local4)){
				_local4 = 0;
			};
			return (_local4);
		}
		public function parseMin(_arg1:String):Number{
			var _local5:Number;
			var _local2:Array = _arg1.split(AppUtil.COLON);
			var _local3:int = _local2.length;
			var _local4:Number = 0;
			while (_local2.length) {
				_local5 = parseFloat(_local2.pop());
				if (!isNaN(_local5)){
					_local4 = (_local4 + (_local5 * Math.pow(60, ((_local3 - _local2.length) - 1))));
				};
			};
			_local4 = int((_local4 * 1000));
			return (_local4);
		}

	}
}


