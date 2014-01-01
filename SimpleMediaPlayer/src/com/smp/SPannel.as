/*SimpleMediaPlayer*/
package com.smp {
	import com.smp.events.SMPEvent;
	import com.smp.events.SMPStates;
	import com.smp.events.UIEvent;
	import com.ui.SCP;
	import com.zip.ZipFile;

	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	import com.utils.AppUtil;
	import interfaces.IPlane;

	public final class SPannel extends SCP implements IPlane {

		private var _xywh:String;
		private var _pw:int;
		private var _ph:int;
		public var tx:int;
		public var ty:int;
		public var tw:int;
		public var th:int;
		private var _display:Boolean = true;
		private var _src:String;
		public var shim:SmartSprite;
		public var box:Sprite;
		public var formatBase:TextFormat;
		public var formatUpon:TextFormat;
		public var headFormat:TextFormat;
		public var skin_list:Array;
		public var next_id:int;
		public var load_id:int;
		public var load_rd:RD;
		public var load_lb:String;
		public var loaded:Boolean = false;
		public var loading:Boolean = false;
		public var ready:Boolean = false;
		public var head1:TextField;
		public var head2:TextField;
		public var link1:LK;
		public var link2:LK;
		public var link3:LK;
		public var link4:LK;
		public var copy_url:String;
		public var copy_embed:String;
		public var latest_version:Number;

		public function SPannel():void{
			this.shim = new SmartSprite();
			this.box = new Sprite();
			this.skin_list = [];
			super();
			verticalLineScrollSize = 20;
			Main.addEventListener(SMPEvent.SKIN_LOAD, this.init, false, 0);
			addChild(this.shim);
		}
		public function init(_arg1:SMPEvent):void{
			var _local6:int;
			this.loaded = false;
			this.skin_list = [];
			var _local2:String = Main.ds.skin_xml.@name;
			var _local3:Object = {
					id:0,
					data:{name:_local2},
					state:SMPStates.LOADED
				};
			this.skin_list.push(_local3);
			var _local4:Array = Main.sk.skin_list;
			var _local5:int = _local4.length;
			if (_local5){
				_local6 = 0;
				while (_local6 < _local5) {
					this.skin_list.push({
							id:(_local6 + 1),
							src:_local4[_local6],
							opened:Config.skin_info,
							state:SMPStates.WAITING
						});
					_local6++;
				};
			};
		}
		public function lo():void{
			if (((((!(this._xywh)) || (!(this._pw)))) || (!(this._ph)))){
				visible = false;
				return;
			};
			var _local1:Array = AppUtil.xywh(this._xywh, this._pw, this._ph);
			this.tx = _local1[0];
			this.ty = _local1[1];
			this.tw = _local1[2];
			this.th = _local1[3];
			move(this.tx, this.ty);
			if ((((this.tw > 0)) && ((this.th > 0)))){
				setSize(this.tw, this.th);
				visible = true;
			} else {
				visible = false;
			};
		}
		public function set xywh(_arg1:String):void{
			if (this._xywh != _arg1){
				this._xywh = _arg1;
				this.lo();
			};
		}
		public function get xywh():String{
			return (this._xywh);
		}
		public function ll(_arg1:int, _arg2:int):void{
			if (((!((this._pw == _arg1))) || (!((this._ph == _arg2))))){
				this._pw = _arg1;
				this._ph = _arg2;
				this.lo();
			};
		}
		public function ss(_arg1:XMLList, _arg2:int, _arg3:int):void{
			this.formatBase = AppUtil.format(_arg1);
			this.formatUpon = AppUtil.format(_arg1, 1);
			this.headFormat = AppUtil.format(_arg1);
			this.headFormat.size = (this.formatBase.size + 2);
			this.headFormat.bold = true;
			this.head1 = AppUtil.text(Main.info.queryMessage("option_title_skins"), this.headFormat);
			this.head2 = AppUtil.text(Main.info.queryMessage("option_title_about"), this.headFormat);
			var _local4:String = Main.info.queryMessage("option_copied");
			this.link1 = new LK(this.formatBase, this.formatUpon, SGraphics.getIconLink(this.formatBase.color), Main.info.queryMessage("option_copy_url"), _local4);
			this.link1.addEventListener(MouseEvent.CLICK, this.linkClick, false, 0, true);
			this.link2 = new LK(this.formatBase, this.formatUpon, SGraphics.getIconEmbed(this.formatBase.color), Main.info.queryMessage("option_copy_embed"), _local4);
			this.link2.addEventListener(MouseEvent.CLICK, this.linkClick, false, 0, true);
			var _local5:String = Main.VERSION;
			if (_local5.indexOf((Main + "")) == -1){
				Main.sendEvent(CS.ERROR, _local5);
				_local5 = (Main + "");
			};
			this.link3 = new LK(this.formatBase, this.formatUpon, SGraphics.getCenFunLogo(15, this.formatBase.color), _local5);
			this.link3.tips = ((("Flash Player: " + Config.flash_version) + "\nGPU Mode: ") + Config.flash_gpu);
			this.link3.addEventListener(MouseEvent.CLICK, this.linkClick, false, 0, true);
			this.ready = true;
			this.start();
			this.display = AppUtil.gOP(_arg1, "display", visible);
			filters = SGraphics.filters(_arg1);
			this.src = _arg1.@src;
			this._pw = _arg2;
			this._ph = _arg3;
			this._xywh = _arg1.@xywh;
			this.lo();
		}
		public function set display(_arg1:String):void{
			this._display = AppUtil.tof(_arg1);
			visible = this._display;
			this.start();
		}
		public function get display():String{
			return (this._display.toString());
		}
		public function set src(_arg1:String):void{
			this._src = _arg1;
			Zip.GetSrc(_arg1, this.srcComplete);
		}
		public function get src():String{
			return (this._src);
		}
		public function srcComplete(_arg1:LoaderInfo):void{
			this.shim.show(Zip.getLD(_arg1), this.tw, this.th);
		}
		public function linkClick(_arg1:MouseEvent):void{
			var _local2:String;
			if (_arg1.currentTarget == this.link1){
				this.link1.clicked();
				AppUtil.copy(Config.share_url);
				return;
			};
			if (_arg1.currentTarget == this.link2){
				this.link2.clicked();
				AppUtil.copy(Config.share_html);
				return;
			};
			if (_arg1.currentTarget == this.link3){
				_local2 = Main.LINK;
				if (!_local2 || !(_local2 == AppUtil.cmp[2])){
					_local2 = AppUtil.cmp[2];
					trace("非法盗用");
						//W.c(this);
				};
				AppUtil.open(_local2, Config.link_target);
				return;
			};
			if (_arg1.currentTarget == this.link4){
				AppUtil.open("http://cmp.cenfun.com/update/", Config.link_target);
				return;
			};
		}
		public function start():void{
			if (((((!(this.ready)) || (!(visible)))) || (this.loading))){
				return;
			};
			this.drawBox();
			if (!this.loaded){
				this.next_id = 1;
				this.loadSkin();
			};
			this.checkUpdate();
		}
		public function loadSkin():void{
			if (this.next_id >= this.skin_list.length){
				this.loaded = true;
				return;
			};
			this.load_id = this.next_id;
			if (AppUtil.isin(this.skin_list[this.load_id]["state"], [SMPStates.LOADED, SMPStates.ERROR])){
				this.next();
				return;
			};
			this.load_rd = this.skin_list[this.load_id]["radio"];
			this.load_lb = ((this.load_id + ".") + Main.info.queryMessage("option_skin_loading"));
			this.skin_list[this.load_id]["state"] = SMPStates.LOADING;
			this.loading = true;
			var _local1:String = this.skin_list[this.load_id]["src"];
			_local1 = Main.fU(_local1, true);
			new SURLLodader(_local1, this.skinError, this.skinProgress, this.skinComplete, false);
		}
		public function next():void{
			this.loading = false;
			if (!visible){
				return;
			};
			this.drawBox();
			this.next_id++;
			this.loadSkin();
		}
		public function skinProgress(_arg1:uint, _arg2:uint):void{
			var _local3:String;
			if (this.load_rd){
				_local3 = "";
				if (_arg2){
					_local3 = (Math.round(((_arg1 / _arg2) * 100)) + "%");
				};
				this.load_rd.label = ((this.load_lb + " ") + _local3);
			};
		}
		public function skinError(_arg1:String=""):void{
			this.skin_list[this.load_id]["state"] = SMPStates.ERROR;
			this.next();
		}
		public function skinComplete(_arg1:ByteArray):void{
			var xml:* = null;
			var preview:* = null;
			var skin_zip:* = null;
			var v:* = null;
			var n:* = null;
			var ba:* = _arg1;
			ba = AppUtil.csf(ba);
			try {
				skin_zip = new ZipFile(ba);
			} catch(e:Error) {
				skinError();
				return;
			};
			var zipEntry:* = skin_zip.getEntry("skin.xml");
			if (!zipEntry){
				this.skinError();
				return;
			};
			var fileData:* = zipEntry.data;
			fileData = AppUtil.bom(fileData);
			var str:* = fileData.toString();
			var skin_xml:* = AppUtil.XL(str);
			if (!skin_xml.children().length()){
				this.skinError();
				return;
			};
			var data:* = {};
			var xl:* = skin_xml.@*;
			for each (xml in xl) {
				v = xml.toString();
				if (v){
					n = xml.name().toString();
					data[n] = v;
				};
			};
			this.skin_list[this.load_id]["bytes"] = ba;
			this.skin_list[this.load_id]["data"] = data;
			this.skin_list[this.load_id]["state"] = SMPStates.LOADED;
			preview = skin_xml.@preview;
			if (preview){
				Zip.GetSrc(preview, this.imgComplete, skin_zip);
			} else {
				this.next();
			};
		}
		public function imgComplete(_arg1:LoaderInfo):void{
			if (_arg1){
				this.skin_list[this.load_id]["preview"] = _arg1.loader;
			};
			this.next();
		}
		public function drawBox():void{
			var _local1:Object;
			var _local2:Sprite;
			this.box.graphics.clear();
			Main.clear(this.box);
			this.box.addChild(this.head1);
			for each (_local1 in this.skin_list) {
				if ((((_local1.id == 0)) && (((((!(Config.default_skin)) && ((this.skin_list.length > 1)))) || (!(_local1.data.name)))))){
				} else {
					_local2 = this.drawSkin(_local1);
					_local2.y = this.box.height;
					this.box.addChild(_local2);
				};
			};
			this.head2.y = (this.box.height + 2);
			this.box.addChild(this.head2);
			if (Config.share_cmp){
				this.link1.y = this.box.height;
				this.box.addChild(this.link1);
				this.link2.y = this.box.height;
				this.box.addChild(this.link2);
			};
			this.link3.y = this.box.height;
			this.box.addChild(this.link3);
			if (this.link4){
				this.link4.y = this.box.height;
				this.box.addChild(this.link4);
			};
			SGraphics.drawRect(this.box, 0, 0, this.tw, (this.box.height + 3));
			source = this.box;
		}
		public function drawSkin(_arg1:Object):Sprite{
			//var _local7:SI;
			var _local2:RD = new RD(this.formatBase, this.formatUpon);
			_local2.addEventListener(UIEvent.RADIO_CLICK, this.skinChange);
			_local2.addEventListener(UIEvent.LABEL_CLICK, this.infoChange);
			var _local3:int = _arg1["id"];
			_local2.value = _local3;
			if (Config.skin_id == _local3){
				_local2.selected = true;
			} else {
				_local2.selected = false;
			};
			var _local4:String = _arg1["state"];
			var _local5:String = _local3 + ".";
			switch (_local4){
			case SMPStates.WAITING:
				_local5 = (_local5 + Main.info.queryMessage("option_skin_waiting"));
				break;
			case SMPStates.LOADING:
				_local5 = (_local5 + Main.info.queryMessage("option_skin_loading"));
				break;
			case SMPStates.ERROR:
				_local2.enabled = false;
				_local5 = (_local5 + (((Main.info.queryMessage("option_skin_error") + "(") + _arg1["src"]) + ")"));
				break;
			case SMPStates.LOADED:
				_local5 = (_local5 + _arg1["data"]["name"]);
				break;
			default:
				_local5 = (_local5 + _arg1["src"]);
			};
			_local2.label = _local5;
			var _local6:Sprite = new Sprite();
			_local2.x = 5;
			_local6.addChild(_local2);
			_arg1["radio"] = _local2;
			/*if ((((((_local3 > 0)) && ((_local4 == SMPStates.LOADED)))) && (_arg1["opened"]))){
				_local7 = new SI(_arg1, this.formatBase, this.formatUpon, _local2.width, _local2.height, this.tw);
				_local6.addChild(_local7);
			};*/
			return (_local6);
		}
		public function skinChange(_arg1:UIEvent):void{
			Config.skin_id = Number(_arg1.data);
			Main.sendEvent(SMPEvent.SKIN_CHANGE);
		}
		public function infoChange(_arg1:UIEvent):void{
			var _local2:Object = this.skin_list[_arg1.data];
			if (_local2["state"] == SMPStates.LOADED){
				_local2["opened"] = !(_local2["opened"]);
				this.drawBox();
			};
		}
		public function checkUpdate():void{
			var _local2:Number;
			if (((!(Config.check_update)) || ((Config.check_update.length < 8)))){
				return;
			};
			if (((this.latest_version) || (!(Config.cmp_host)))){
				return;
			};
			var _local1:Number = parseInt((Main.getCookie("check_update_date") + ""));
			if (_local1){
				_local2 = new Date().getTime();
				if ((_local2 - _local1) < ((1000 * 60) * 60)){
					return;
				};
			};
			new SURLLodader(Config.check_update, this.checkError, this.checkProgress, this.checkComplete);
		}
		public function checkError(_arg1:String=""):void{
		}
		public function checkProgress(_arg1:uint, _arg2:uint):void{
		}
		public function checkComplete(_arg1:ByteArray):void{
			var _local2:XMLList = AppUtil.XL(_arg1.toString());
			this.latest_version = parseInt(_local2.cmp.@build);
			var _local3:Number = parseInt(Config.version.substr(-6));
			if (this.latest_version > _local3){
				this.link4 = new LK(this.formatBase, this.formatUpon, new Shape(), "Check Update");
				this.link4.tips = ((("Latest Version: " + _local2.cmp.@version) + " b") + this.latest_version);
				this.link4.addEventListener(MouseEvent.CLICK, this.linkClick, false, 0, true);
			};
			Main.setCookie("check_update_date", (new Date().getTime() + ""));
		}

	}
}


