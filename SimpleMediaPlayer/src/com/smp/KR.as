/*SimpleMediaPlayer*/
package com.smp {
    import flash.text.TextFormat;
    import com.utils.AppUtil;

    public class KR extends R {

        public var ti:String = "";
        public var ar:String = "";
        public var al:String = "";
        public var by:String = "";
        public var offset:int = 0;
        public var line_mode:int = 2;
        public var time_preview:int = 5000;
        public var time_sec3:int = 8000;
        public var show_info:Boolean = true;
        public var margin:int = 0;
        public var leading:int = 0;
        public var align_one:String;
        public var align_two:String;
        public var formatBase:TextFormat;
        public var formatUpon:TextFormat;
        public var now:Array;
        public var pre:Array;
        public var posRoll:Number;
        public var nowRoll:KL;

        public function KR(_arg1:SLrc):void{
            this.formatBase = new TextFormat();
            this.formatUpon = new TextFormat();
            this.now = [];
            this.pre = [];
            super(_arg1);
        }
        public function ss(_arg1:XMLList):void{
            var _local4:XML;
            var _local2:XMLList = _arg1.copy();
            if (_local2.kmc){
                for each (_local4 in _local2.kmc.attributes()) {
                    _local2.@[_local4.name()] = _local4.toString();
                };
            };
            var _local3:int = 2;
            if (lc.horizontal){
                _local3 = 1;
            };
            this.line_mode = AppUtil.gOP(_local2, "line_mode", _local3);
            if (((!((this.line_mode == 0))) && (!((this.line_mode == 1))))){
                this.line_mode = _local3;
            };
            this.time_preview = AppUtil.gOP(_local2, "time_preview", 5000);
            this.time_sec3 = AppUtil.gOP(_local2, "time_sec3", 8000);
            this.show_info = ((AppUtil.gOP(_local2, "show_info", true)) && (Config.lrc_idtags));
            this.margin = AppUtil.gOP(_local2, "margin", 0);
            this.leading = AppUtil.gOP(_local2, "leading", 0);
            this.formatBase = AppUtil.format(_local2);
            this.formatUpon = AppUtil.format(_local2, 1);
            this.align_one = ((this.formatBase.align) || (CS.CENTER));
            this.align_two = ((this.formatUpon.align) || (CS.CENTER));
            this.formatBase.align = (this.formatUpon.align = CS.LEFT);
            this.formatBase.leading = (this.formatUpon.leading = 0);
            this.formatUpon.font = this.formatBase.font;
            this.formatUpon.size = this.formatBase.size;
            this.formatUpon.bold = this.formatBase.bold;
            main.filters = SGraphics.filters(_local2.kmc);
            this.init(true);
        }
        override public function ll(_arg1:int, _arg2:int):void{
            super.ll(_arg1, _arg2);
            if (lc.model == this){
                this.init();
            };
        }
        public function init(_arg1:Boolean=false):void{
            var _local2:KL;
            for each (_local2 in list) {
                _local2.ll(_arg1);
            };
            if (this.line_mode == 0){
                Effects.e(main);
                this.posRoll = 0;
                main.y = (Config.height * 2);
                if (!_arg1){
                    this.roll();
                };
            } else {
                main.y = 0;
            };
            nowTime = 0;
            if (_arg1){
                this.update();
            };
        }
        public function update():void{
            var _local2:KL;
            var _local3:int;
            if (((!(Main.item)) || (!(visible)))){
                return;
            };
            var _local1:Number = (Main.item.position * 1000);
            if ((((_local1 == nowTime)) || (!(list.length)))){
                return;
            };
            nowTime = _local1;
            this.now = [];
            this.pre = [];
            for each (_local2 in list) {
                _local2.choose(_local1);
            };
            _local3 = this.now.length;
            if (_local3){
                _local2 = this.now.pop();
                _local2.update(_local1);
                rowChange(_local2.text);
                if (this.line_mode == 0){
                    this.nowRoll = _local2;
                    this.roll();
                } else {
                    if ((((this.line_mode == 2)) && (this.now.length))){
                        _local2 = this.now.pop();
                        _local2.update(_local1);
                    };
                };
                for each (_local2 in this.now) {
                    _local2.hide();
                };
            };
            if (this.pre.length){
                if ((((((this.line_mode == 1)) && ((_local3 == 0)))) || ((((this.line_mode == 2)) && ((_local3 < 2)))))){
                    _local2 = this.pre.shift();
                    _local2.show(_local1);
                };
                for each (_local2 in this.pre) {
                    _local2.hide();
                };
            };
        }
        public function roll():void{
            var _local1:int = Math.round((th * 0.5));
            if (this.nowRoll){
                _local1 = (_local1 - Math.round((this.nowRoll.ty + (this.nowRoll.th * 0.5))));
            };
            if (_local1 != this.posRoll){
                Effects.m(main, "y", _local1, th);
                this.posRoll = _local1;
            };
        }
        public function parse(_arg1:String):Boolean{
            var xml:* = null;
            var l:* = null;
            var fxml:* = null;
            var fline:* = null;
            var ftime:* = 0;
            var arr:* = null;
            var ais:* = null;
            var j:* = 0;
            var len:* = 0;
            var ptime:* = NaN;
            var ntime:* = NaN;
            var etime:* = NaN;
            var i:* = 0;
            var info:* = null;
            var line:* = null;
            var str:* = _arg1;
            try {
                xml = new XML(str);
            } catch(e:Error) {
                return (false);
            };
            if (!xml.children().length()){
                return (false);
            };
            this.ti = AppUtil.gOP(xml, "ti", "");
            this.ar = AppUtil.gOP(xml, "ar", "");
            this.al = AppUtil.gOP(xml, "al", "");
            this.by = AppUtil.gOP(xml, "by", "");
            this.offset = AppUtil.gOP(xml, "offset", 0);
            if (this.show_info){
                fxml = xml.children()[0];
                fline = new KL(fxml, 0, this);
                ftime = fline.time.start;
                if (ftime){
                    if (ftime > (this.time_preview + 1000)){
                        arr = [this.ti, this.ar, this.al, this.by];
                        ais = [];
                        j = 0;
                        while (j < arr.length) {
                            if (arr[j]){
                                ais.push(arr[j]);
                            };
                            j = (j + 1);
                        };
                        len = ais.length;
                        if (len){
                            ptime = (Math.round((((ftime - this.time_preview) - 1000) / len)) * 0.001);
                            ntime = 0;
                            etime = ptime;
                            i = 0;
                            while (i < len) {
                                info = new XML((((((("<l t=\"" + ntime) + ",") + etime) + "\">[") + ais[i]) + "]</l>"));
                                xml.insertChildBefore(fxml, info);
                                ntime = (ntime + ptime);
                                etime = (etime + ptime);
                                i = (i + 1);
                            };
                        };
                    };
                };
            };
            list = [];
            Main.clear(main);
            for each (l in xml.children()) {
                line = new KL(l, list.length, this);
                if (((line.time.start) || (line.time.end))){
                    list.push(line);
                    line.ll(true);
                    main.addChild(line);
                };
            };
            if (!list.length){
                return (false);
            };
            return (true);
        }

    }
}
