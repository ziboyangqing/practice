/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.SMPEvent;
    import com.smp.events.SMPStates;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.LoaderInfo;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filters.BlurFilter;
    import flash.filters.ColorMatrixFilter;
    import flash.filters.DisplacementMapFilter;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.media.SoundMixer;
    import flash.utils.ByteArray;
    import com.utils.AppUtil;

    public final class MX extends Sprite {

        public var tw:Number = 0;
        public var th:Number = 0;
        public var mc:Number;
        public var mf:Boolean;
        public var md:Boolean;
        public var mz:int = 1;
        public var tl:Array;
        public var cs:Number = 1;
        public var cl:Array;
        public var br:BlurFilter;
        public var cm:ColorMatrixFilter;
        public var bd:BitmapData;
        public var bdbd:BitmapData;
        public var rt:Rectangle;
        public var pt:Point;
        public var mF:Sprite;
        public var mS:Shape;
        public var fn:Function;
        public var ml:Array;
        public var bn:int;
        public var dy:Number;
        public var dz:Number = 0;
        public var listVal:Array;
        public var listDot:Array;
        public var listBar:Array;
        public var list256:Array;
        public var list512:Array;
        public var main:Sprite;
        public var self:Sprite;
        public var type:String;

        public function MX():void{
            this.tl = [1, 2, 4];
            this.pt = new Point(0, 0);
            this.mF = new Sprite();
            this.mS = new Shape();
            super();
            this.type = CS.OTHER;
            this.main = new Sprite();
            addChild(this.main);
            this.cm = new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.9, 0]);
            this.br = new BlurFilter(8, 8, 2);
            this.self = new Sprite();
            this.mS.cacheAsBitmap = true;
            this.self.addChild(this.mS);
            this.mF.cacheAsBitmap = true;
            this.self.addChild(this.mF);
            addChild(this.self);
            this.ml = this.gML();
            this.cl = this.gCL();
            Main.addEventListener(SMPEvent.VIDEO_RESIZE, this.resizeHandler);
            Main.addEventListener(SMPEvent.CONFIG_LOADED, this.configHandler, false, 0, true);
            this.resizeHandler();
        }
        public function configHandler(_arg1:SMPEvent):void{
            this.mc = AppUtil.color(Config.mixer_color);
            if (Config.mixer_src){
                this.load();
            };
            this.listen();
        }
        public function load():void{
            var _local1:String = Config.mixer_src;
            _local1 = AppUtil.auto(_local1, Config);
            _local1 = Main.fU(_local1, true);
            new SLoader(_local1, this.loaded);
        }
        public function loaded(_arg1:LoaderInfo):void{
            var _local2:String;
            if (_arg1){
                _local2 = Main.api(_arg1);
                this.main.addChild(Zip.getLD(_arg1));
            } else {
                visible = false;
            };
        }
        public function listen():void{
            Main.addEventListener(SMPEvent.MODEL_STATE, this.stateHandler);
            Main.addEventListener(SMPEvent.MODEL_START, this.startHandler);
            Main.addEventListener(SMPEvent.MIXER_PREV, this.prevHandler);
            Main.addEventListener(SMPEvent.MIXER_NEXT, this.nextHandler);
            Main.addEventListener(SMPEvent.MIXER_COLOR, this.colorHandler);
            Main.addEventListener(SMPEvent.MIXER_DISPLACE, this.displaceHandler);
            Main.addEventListener(SMPEvent.MIXER_FILTER, this.filterHandler);
            this.displaceHandler();
        }
        public function resizeHandler(_arg1:SMPEvent=null):void{
            var _local2:Number = Config.video_width;
            var _local3:Number = Config.video_height;
            if ((((_local2 > 0)) && ((_local3 > 0)))){
                this.tw = _local2;
                this.th = _local3;
                visible = true;
            } else {
                visible = false;
            };
            this.start();
        }
        public function stateHandler(_arg1:SMPEvent):void{
            if ((((Config.state == SMPStates.COMPLETED)) || ((Config.state == SMPStates.STOPPED)))){
                this.stop();
            };
        }
        public function startHandler(_arg1:SMPEvent):void{
            this.type = Main.item.type;
            this.start();
        }
        public function stop():void{
            if (!hasEventListener(Event.ENTER_FRAME)){
                return;
            };
            this.cs = Math.floor((this.cl.length * Math.random()));
            removeEventListener(Event.ENTER_FRAME, this.draw);
            this.mS.graphics.clear();
            this.clearF();
        }
        public function init():void{
            this.dz = 0;
            this.bn = (this.tw * 0.125);
            if (this.bn > 0x0200){
                this.bn = 0x0200;
            };
            this.dy = (this.th * 0.008);
            this.listVal = this.zero(this.bn);
            this.listDot = this.zero(this.bn);
            this.listBar = this.zero(this.bn);
            this.list256 = this.zero(0x0100);
            this.list512 = this.zero(0x0200);
            this.rt = new Rectangle(0, 0, this.tw, this.th);
            this.bd = new BitmapData(this.tw, this.th, true, 0);
            while (this.mF.numChildren) {
                this.mF.removeChildAt(0);
            };
            this.mF.addChild(new Bitmap(this.bd));
        }
        public function start(_arg1:String=null):void{
            if (_arg1 == this.type){
                return;
            };
            if (_arg1){
                this.type = _arg1;
            };
            this.stop();
            if (((((((!(visible)) || (!((this.type == CS.SOUND))))) || ((Config.state == SMPStates.STOPPED)))) || (Config.mixer_src))){
                return;
            };
            this.init();
            this.play();
        }
        public function play():void{
            this.mc = AppUtil.color(Config.mixer_color);
            if ((this.tw * this.th) > (600 * 400)){
                this.mf = false;
            } else {
                this.mf = Config.mixer_filter;
            };
            this.md = Config.mixer_displace;
            var _local1:Number = this.ml.length;
            var _local2:Number = Config.mixer_id;
            if (_local2 == _local1){
                return;
            };
            if ((((_local2 < 0)) || ((_local2 > _local1)))){
                _local2 = Math.floor((_local1 * Math.random()));
            };
            Main.setCookie("mixer_id", _local2, true);
            this.fn = this.ml[_local2];
            if ((this.fn is Function)){
                addEventListener(Event.ENTER_FRAME, this.draw);
            };
        }
        public function draw(_arg1:Event):void{
            this.fn.call();
        }
        public function prevHandler(_arg1:SMPEvent):void{
            var _local2:Number;
            if (_arg1.data != null){
                _local2 = parseInt(_arg1.data.toString());
                Config.mixer_id = (isNaN(_local2)) ? 1 : _local2;
            } else {
                Config.mixer_id--;
            };
            if (Config.mixer_id < 0){
                Config.mixer_id = this.ml.length;
            };
            this.start();
        }
        public function nextHandler(_arg1:SMPEvent):void{
            var _local2:Number;
            if (_arg1.data != null){
                _local2 = parseInt(_arg1.data.toString());
                Config.mixer_id = (isNaN(_local2)) ? 1 : _local2;
            } else {
                Config.mixer_id++;
            };
            if (Config.mixer_id > this.ml.length){
                Config.mixer_id = 0;
            };
            this.start();
        }
        public function colorHandler(_arg1:SMPEvent):void{
            if (_arg1.data != null){
                this.mc = AppUtil.color(_arg1.data.toString());
            } else {
                this.mc = (Math.random() * 0xFFFFFF);
            };
            Config.mixer_displace = (this.md = false);
            Config.mixer_color = this.mc.toString(16);
            Main.setCookie("mixer_color", Config.mixer_color);
        }
        public function displaceHandler(_arg1:SMPEvent=null):void{
            if (_arg1){
                if (_arg1.data != null){
                    Config.mixer_displace = AppUtil.tof(_arg1.data.toString());
                } else {
                    Config.mixer_displace = !(Config.mixer_displace);
                };
            };
            this.md = Config.mixer_displace;
            if (this.md){
                Config.mixer_filter = (this.mf = true);
                this.cs = Math.floor((this.cl.length * Math.random()));
            } else {
                this.mc = AppUtil.color(Config.mixer_color);
                this.mf = Config.mixer_filter;
            };
            Main.setCookie("mixer_displace", Config.mixer_displace);
        }
        public function filterHandler(_arg1:SMPEvent):void{
            if (_arg1.data != null){
                Config.mixer_filter = AppUtil.tof(_arg1.data.toString());
            } else {
                Config.mixer_filter = !(Config.mixer_filter);
            };
            this.mf = Config.mixer_filter;
            if (!this.mf){
                Config.mixer_displace = (this.md = false);
                this.mc = AppUtil.color(Config.mixer_color);
                this.clearF();
            };
            Main.setCookie("mixer_filter", Config.mixer_filter);
        }
        public function rC():void{
            var _local1:Number = Math.random();
            if (_local1 > 0.99){
                this.mz = (this.mz * -1);
                if (_local1 > 0.999){
                    this.tl.push(this.tl.shift());
                };
            };
            var _local2:Number = Math.round(((this.mz * _local1) * 5));
            this.cs = (this.cs + _local2);
            if (this.cs < 0){
                this.cs = (this.cl.length - 1);
            } else {
                if (this.cs >= this.cl.length){
                    this.cs = 0;
                };
            };
            this.mc = this.cl[this.cs];
        }
        public function gCL():Array{
            var _local1:Array = [];
            var _local2:Array = [];
            var _local3:Array = [];
            var _local4:Array = [];
            var _local5:Array = [];
            var _local6:Array = [];
            var _local7:int;
            while (_local7 < 0xFF) {
                _local1.push((0xFF0000 + (_local7 * 0x0100)));
                _local2.push((((0xFF - _local7) * 65536) + 0xFF00));
                _local3.push((0xFF00 + _local7));
                _local4.push((((0xFF - _local7) * 0x0100) + 0xFF));
                _local5.push((0xFF + (_local7 * 65536)));
                _local6.push(((0xFF - _local7) + 0xFF0000));
                _local7 = (_local7 + 3);
            };
            var _local8:Array = [];
            _local8 = _local8.concat(_local1).concat(_local2).concat(_local3).concat(_local4).concat(_local5).concat(_local6);
            return (_local8);
        }
        public function clearF():void{
            if (this.bd){
                this.bd.fillRect(this.bd.rect, 0);
            };
        }
        public function sF(_arg1:Boolean=true):void{
            if (this.mf){
                this.bd.draw(this.mS);
                if (this.md){
                    this.rC();
                    if (_arg1){
                        this.applyDisplace(this.bd);
                    } else {
                        this.bd.applyFilter(this.bd, this.rt, this.pt, this.cm);
                    };
                } else {
                    this.bd.applyFilter(this.bd, this.rt, this.pt, this.cm);
                };
                this.bd.applyFilter(this.bd, this.rt, this.pt, this.br);
            };
        }
        public function applyDisplace(_arg1:BitmapData):void{
            this.bdbd = _arg1.clone();
            var _local2:DisplacementMapFilter = new DisplacementMapFilter(this.bdbd, this.pt, this.tl[0], this.tl[1], 10, 10, "clamp");
            _arg1.applyFilter(this.bdbd, _arg1.rect, this.pt, _local2);
        }
        public function gb(_arg1:Boolean=false):ByteArray{
            var _local2:ByteArray = new ByteArray();
            if (SoundMixer.areSoundsInaccessible()){
                this.stop();
            } else {
                try {
                    SoundMixer.computeSpectrum(_local2, _arg1);
                } catch(e:Error) {
                };
            };
            return (_local2);
        }
        public function lr(_arg1:ByteArray, _arg2:Boolean=false):ByteArray{
            var _local4:ByteArray;
            var _local5:Number;
            var _local6:Number;
            var _local7:Number;
            var _local3:ByteArray = new ByteArray();
            _arg1.position = 0;
            if (_arg1.bytesAvailable){
                _local4 = new ByteArray();
                _arg1.position = 0x0400;
                _arg1.readBytes(_local4);
                _arg1.position = 0;
                while (_local4.bytesAvailable) {
                    _local5 = _arg1.readFloat();
                    _local6 = _local4.readFloat();
                    if (((_arg2) || ((((_local5 > 0)) && ((_local6 > 0)))))){
                        _local7 = ((_local5 > _local6)) ? _local5 : _local6;
                    } else {
                        if ((((_local5 < 0)) && ((_local6 < 0)))){
                            _local7 = ((_local5 < _local6)) ? _local5 : _local6;
                        } else {
                            _local7 = ((_local5 + _local6) * 0.5);
                        };
                    };
                    _local3.writeFloat(_local7);
                };
                _local3.position = 0;
            };
            return (_local3);
        }
        public function m01():void{
            var _local7:Number;
            var _local1:ByteArray = this.lr(this.gb(true), true);
            var _local2:Number = (this.tw * 0.00390625);
            var _local3:int = (this.th * 0.666);
            this.mS.graphics.clear();
            this.mS.graphics.beginFill(this.mc);
            var _local4:Number = (this.tw / this.bn);
            var _local5:int = (Math.floor(((252 / this.bn) - 1)) * 4);
            var _local6:int;
            while ((((_local6 < this.bn)) && (_local1.bytesAvailable))) {
                _local7 = (_local3 * _local1.readFloat());
                if (_local5){
                    _local1.position = (_local1.position + _local5);
                };
                this.listVal[_local6] = (this.listVal[_local6] * 1.1);
                this.listDot[_local6] = (this.listDot[_local6] - this.listVal[_local6]);
                if (this.listDot[_local6] < _local7){
                    this.listVal[_local6] = (this.dy * 0.5);
                    this.listDot[_local6] = _local7;
                };
                this.listBar[_local6] = (this.listBar[_local6] - (this.listVal[_local6] + 2));
                if (this.listBar[_local6] < _local7){
                    this.listBar[_local6] = _local7;
                };
                this.mS.graphics.drawRect((_local4 * _local6), this.th, (_local4 - 1), -(this.listBar[_local6]));
                this.mS.graphics.drawRect((_local4 * _local6), ((this.th - this.listDot[_local6]) - 1), (_local4 - 1), 1);
                _local6++;
            };
            this.mS.graphics.endFill();
            this.sF(false);
        }
        public function m02():void{
            var _local5:Number;
            var _local6:int;
            var _local1:ByteArray = this.lr(this.gb());
            var _local2:int = (this.th * 0.5);
            var _local3:Number = (this.tw * 0.00390625);
            var _local4:int = (_local2 * 0.8);
            this.mS.graphics.clear();
            this.mS.graphics.lineStyle(1, this.mc);
            if (_local1.bytesAvailable){
                _local5 = (_local4 * _local1.readFloat());
                this.mS.graphics.moveTo(0, (_local2 + _local5));
                _local6 = 1;
                while (_local6 < 0x0100) {
                    _local5 = (_local4 * _local1.readFloat());
                    this.mS.graphics.lineTo((_local6 * _local3), (_local2 + _local5));
                    _local6++;
                };
            };
            this.sF(false);
        }
        public function m03():void{
            var _local4:int;
            var _local5:Number;
            var _local1:ByteArray = this.gb(true);
            var _local2:Number = (this.tw * 0.001953125);
            var _local3:int = (this.th * 0.666);
            this.mS.graphics.clear();
            this.mS.graphics.beginFill(this.mc);
            this.mS.graphics.moveTo((this.tw * 0.5), this.th);
            if (_local1.bytesAvailable){
                _local4 = 0xFF;
                while (_local4 > 0) {
                    _local5 = (_local3 * _local1.readFloat());
                    this.mS.graphics.lineTo((_local4 * _local2), (this.th - _local5));
                    _local4--;
                };
                this.mS.graphics.lineTo(0, this.th);
                this.mS.graphics.moveTo((this.tw * 0.5), this.th);
                _local4 = 0x0100;
                while (_local4 < 0x0200) {
                    _local5 = (_local3 * _local1.readFloat());
                    this.mS.graphics.lineTo((_local4 * _local2), (this.th - _local5));
                    _local4++;
                };
            };
            this.mS.graphics.lineTo(this.tw, this.th);
            this.mS.graphics.endFill();
            this.sF(false);
        }
        public function m04():void{
            var _local5:Number;
            var _local1:ByteArray = this.lr(this.gb(true), true);
            var _local2:Number = (this.tw * 0.00390625);
            var _local3:int = (this.th * 0.666);
            this.mS.graphics.clear();
            this.mS.graphics.lineStyle(1, this.mc);
            this.mS.graphics.beginFill(this.mc);
            this.mS.graphics.moveTo(0, this.th);
            var _local4:int = 1;
            while ((((_local4 < 0x0100)) && (_local1.bytesAvailable))) {
                _local5 = (_local3 * _local1.readFloat());
                this.list256[_local4] = (this.list256[_local4] - (this.dy * 2));
                if (this.list256[_local4] < _local5){
                    this.list256[_local4] = _local5;
                };
                this.mS.graphics.lineTo((_local4 * _local2), (this.th - this.list256[_local4]));
                _local4++;
            };
            this.mS.graphics.lineTo(this.tw, this.th);
            this.mS.graphics.endFill();
            this.sF(false);
        }
        public function m05():void{
            var _local6:Number;
            var _local1:ByteArray = this.gb(true);
            var _local2:int = (this.th * 0.5);
            var _local3:Number = (this.tw * 0.00390625);
            var _local4:int = (this.th * 0.4);
            this.mS.graphics.clear();
            this.mS.graphics.beginFill(this.mc);
            this.mS.graphics.moveTo(0, _local2);
            var _local5:int;
            while (_local1.bytesAvailable) {
                _local6 = (_local4 * _local1.readFloat());
                this.list512[_local5] = (this.list512[_local5] - (this.dy * 2));
                if (this.list512[_local5] < _local6){
                    this.list512[_local5] = _local6;
                };
                if (_local5 >= 0x0100){
                    if (_local5 == 0x0100){
                        this.mS.graphics.lineTo(this.tw, _local2);
                        this.mS.graphics.lineTo(0, _local2);
                    };
                    this.mS.graphics.lineTo(((_local5 - 0x0100) * _local3), (_local2 - this.list512[_local5]));
                } else {
                    this.mS.graphics.lineTo((_local5 * _local3), (_local2 + this.list512[_local5]));
                };
                _local5++;
            };
            this.mS.graphics.lineTo(this.tw, _local2);
            this.mS.graphics.lineTo(0, _local2);
            this.sF(false);
        }
        public function m06():void{
            var _local6:Number;
            var _local7:int;
            var _local8:Number;
            var _local9:Number;
            var _local10:Number;
            var _local1:ByteArray = this.lr(this.gb(true), true);
            var _local2:int = (this.tw * 0.5);
            var _local3:int = (this.th * 0.5);
            var _local4:int = (this.th * 0.3);
            this.mS.graphics.clear();
            this.mS.graphics.lineStyle(5, this.mc);
            this.mS.graphics.moveTo(_local2, _local3);
            var _local5:int;
            while (_local1.bytesAvailable) {
                _local6 = ((_local4 * _local1.readFloat()) + 5);
                this.list256[_local5] = (this.list256[_local5] - this.dy);
                if (this.list256[_local5] < _local6){
                    this.list256[_local5] = _local6;
                    this.list512[_local5] = (Math.random() * 360);
                };
                _local6 = this.list256[_local5];
                _local7 = this.list512[_local5];
                _local8 = (_local7 * (Math.PI / 180));
                _local9 = ((_local6 * Math.cos(_local8)) + _local2);
                _local10 = ((_local6 * Math.sin(_local8)) + _local3);
                this.mS.graphics.moveTo(_local2, _local3);
                this.mS.graphics.lineTo(_local9, _local10);
                _local5++;
            };
            this.sF(false);
        }
        public function m07():void{
            var _local4:int;
            var _local1:ByteArray = this.lr(this.gb(true), true);
            this.mS.graphics.clear();
            var _local2:int = 20;
            var _local3:int;
            while ((((_local3 < 0x0100)) && (_local1.bytesAvailable))) {
                if (this.list256[_local3] < 1){
                    this.list256[_local3] = 1;
                    _local4 = (_local2 * _local1.readFloat());
                    this.list256[(_local3 + 1)] = _local4;
                    this.list256[(_local3 + 2)] = (((this.tw - (2 * _local2)) * Math.random()) + _local2);
                    _local4 = (_local4 * 0.5);
                    if (_local4 < 3){
                        _local4 = 3;
                    };
                    this.list256[(_local3 + 3)] = _local4;
                } else {
                    var _local5:Array = this.list256;
                    var _local6:int = (_local3 + 1);
                    var _local7:int = (_local5[_local6] - 1);
                    _local5[_local6] = _local7;
                    this.list256[_local3] = (this.list256[_local3] + this.list256[(_local3 + 1)]);
                    if (this.list256[(_local3 + 3)] > 3){
                        this.list256[(_local3 + 3)] = (this.list256[(_local3 + 3)] - 0.5);
                    };
                };
                this.mS.graphics.beginFill(this.mc);
                this.mS.graphics.drawCircle(this.list256[(_local3 + 2)], (this.th - this.list256[_local3]), this.list256[(_local3 + 3)]);
                this.mS.graphics.endFill();
                _local3 = (_local3 + 8);
            };
            this.sF();
        }
        public function m08():void{
            var _local4:Number;
            var _local1:ByteArray = this.lr(this.gb(true), true);
            var _local2:int = 10;
            this.mS.graphics.clear();
            var _local3:int;
            while ((((_local3 < 0x0100)) && (_local1.bytesAvailable))) {
                _local4 = (_local2 * _local1.readFloat());
                if (this.list256[_local3] < 1){
                    this.list256[(_local3 + 1)] = (((this.tw - (2 * _local2)) * Math.random()) + _local2);
                    this.list256[(_local3 + 2)] = (((this.th - (2 * _local2)) * Math.random()) + _local2);
                    this.list256[(_local3 + 3)] = false;
                };
                if (this.list256[_local3] < _local4){
                    this.list256[_local3] = _local4;
                };
                this.list256[_local3] = (this.list256[_local3] - 0.5);
                if ((((((_local4 > 8)) && (_local3))) || (this.list256[(_local3 + 3)]))){
                    if (this.list256[(_local3 + 3)]){
                        if (this.list256[(_local3 + 4)] > 0){
                            this.list256[(_local3 + 4)] = (this.list256[(_local3 + 4)] - 0.05);
                        } else {
                            this.list256[(_local3 + 3)] = false;
                        };
                    } else {
                        this.list256[(_local3 + 4)] = 1;
                        this.list256[(_local3 + 3)] = true;
                    };
                    this.mS.graphics.lineStyle(1, this.mc, this.list256[(_local3 + 4)]);
                    this.mS.graphics.lineTo(this.list256[(_local3 + 1)], this.list256[(_local3 + 2)]);
                };
                this.mS.graphics.beginFill(this.mc);
                this.mS.graphics.drawCircle(this.list256[(_local3 + 1)], this.list256[(_local3 + 2)], this.list256[_local3]);
                this.mS.graphics.moveTo(this.list256[(_local3 + 1)], this.list256[(_local3 + 2)]);
                this.mS.graphics.endFill();
                _local3 = (_local3 + 8);
            };
            this.sF(false);
        }
        public function m09():void{
            var _local4:Number;
            var _local12:Point;
            var _local14:Number;
            var _local15:int;
            var _local16:Number;
            var _local17:Number;
            var _local18:Number;
            var _local1:ByteArray = this.gb(true);
            var _local2:Number = (this.tw * 0.5);
            var _local3:Number = (this.th * 0.5);
            this.mS.graphics.clear();
            this.mS.graphics.lineStyle(1, this.mc);
            var _local5:int = (this.th * 0.3);
            var _local6:Array = [];
            var _local7:Number = 0;
            var _local8:Number = 0;
            var _local9:int = 1;
            while (_local1.bytesAvailable) {
                _local14 = _local1.readFloat();
                if (_local14 > 0){
                    _local4 = ((_local14 * _local5) + 5);
                    _local7 = (_local7 + _local4);
                    _local8 = (_local7 / _local9);
                    _local6.push((_local4 - _local8));
                    _local9++;
                };
            };
            var _local10:int;
            var _local11:int = _local6.length;
            var _local13:int;
            while (_local10 < _local11) {
                _local4 = (Math.abs(((_local6[_local10] - _local8) * 0.5)) + _local8);
                this.list512[_local10] = (this.list512[_local10] - this.dy);
                if (this.list512[_local10] < _local4){
                    this.list512[_local10] = _local4;
                };
                _local4 = this.list512[_local10];
                _local15 = (Math.round(((_local10 * 360) / _local11)) + this.dz);
                _local16 = (_local15 * (Math.PI / 180));
                _local17 = (Math.round((_local4 * Math.cos(_local16))) + _local2);
                _local18 = (Math.round((_local4 * Math.sin(_local16))) + _local3);
                if (_local10 == 0){
                    this.mS.graphics.moveTo(_local2, _local3);
                    _local12 = new Point(_local17, _local18);
                };
                this.mS.graphics.lineTo(_local17, _local18);
                if ((_local15 - _local13) > 8){
                    this.mS.graphics.lineTo(_local2, _local3);
                    this.mS.graphics.moveTo(_local17, _local18);
                    _local13 = _local15;
                };
                _local10++;
            };
            if (_local12){
                this.mS.graphics.lineTo(_local12.x, _local12.y);
            };
            this.dz++;
            this.sF(false);
        }
        public function m10():void{
            var _local4:Number;
            var _local1:ByteArray = this.lr(this.gb(true), true);
            var _local2:int = 20;
            this.mS.graphics.clear();
            this.mS.graphics.lineStyle(1, this.mc);
            var _local3:int;
            while ((((_local3 < 0x0100)) && (_local1.bytesAvailable))) {
                _local4 = (_local2 * _local1.readFloat());
                if (this.list256[_local3] < 1){
                    this.list256[(_local3 + 1)] = (((this.tw - (2 * _local2)) * Math.random()) + _local2);
                    this.list256[(_local3 + 2)] = (((this.th - (2 * _local2)) * Math.random()) + _local2);
                };
                if (this.list256[_local3] < _local4){
                    this.list256[_local3] = _local4;
                };
                var _local5:Array = this.list256;
                var _local6:int = _local3;
                var _local7:int = (_local5[_local6] - 1);
                _local5[_local6] = _local7;
                this.mS.graphics.drawCircle(this.list256[(_local3 + 1)], this.list256[(_local3 + 2)], this.list256[_local3]);
                _local3 = (_local3 + 8);
            };
            this.sF();
        }
        public function gML():Array{
            return ([this.m01, this.m02, this.m03, this.m04, this.m05, this.m06, this.m07, this.m08, this.m09, this.m10]);
        }
        public function zero(_arg1:int):Array{
            var _local2:Array = [];
            var _local3:int;
            while (_local3 < _arg1) {
                _local2.push(0);
                _local3++;
            };
            return (_local2);
        }

    }
}
