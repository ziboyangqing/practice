/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import flash.net.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.system.*;
    import com.utils.AppUtil;

    public final class LR extends R {

        public var nowLine:Number;
        public var nowItem:TextField;
        public var offset:Number = 0;
        public var reg_tabo:RegExp;
        public var reg_line:RegExp;
        public var reg_time:RegExp;

        public function LR(_arg1:SLrc):void{
            this.reg_tabo = /\[(ti|ar|al|by|offset):([^\[\]]*)\]/ig;
            this.reg_line = /((\[(\d+):(\d+(\.\d+)?)\])+)([^\[\]]*)/ig;
            this.reg_time = /\[(\d+):(\d+(\.\d+)?)\]/ig;
            super(_arg1);
        }
        override public function ll(_arg1:int, _arg2:int):void{
            super.ll(_arg1, _arg2);
            if (lc.model == this){
                this.init();
            };
        }
        public function init():void{
            Main.clear(main);
            Effects.e(main);
            list.forEach(this.addList);
            if (lc.horizontal){
                main.x = Config.width;
                main.y = ((th - main.height) * 0.5);
            } else {
                main.x = 0;
                main.y = (Config.height * 2);
            };
            nowTime = NaN;
            this.nowLine = NaN;
            this.update();
        }
        public function update():void{
            if (((!(Main.item)) || (!(visible)))){
                return;
            };
            var _local1:Number = (Main.item.position * 1000);
            var _local2:int = list.length;
            if ((((_local1 == nowTime)) || (!(_local2)))){
                return;
            };
            nowTime = _local1;
            var _local3:int = this.getLrcLine(nowTime, 0, _local2);
            if (_local3 != this.nowLine){
                this.nowLine = _local3;
                this.roll();
            };
        }
        public function addList(_arg1:Array, _arg2:int, _arg3:Array):void{
            var _local4:TextField = this.getLrc(_arg1[1]);
            main.addChild(_local4);
        }
        public function getLrc(_arg1:String):TextField{
            if (!_arg1){
                _arg1 = " ";
            };
            var _local2:TextField = new TextField();
            _local2.selectable = false;
            _local2.mouseEnabled = false;
            if (lc.horizontal){
                _local2.autoSize = "left";
                _arg1 = ((" " + _arg1) + " ");
                _local2.x = main.width;
                if (lc.horizontal == 1){
                    _local2.visible = false;
                };
            } else {
                _local2.autoSize = lc.formatBase.align;
                _local2.multiline = true;
                _local2.wordWrap = true;
                _local2.width = tw;
                _local2.y = main.height;
            };
            _local2.htmlText = unescape(_arg1);
            _local2.setTextFormat(lc.formatBase);
            return (_local2);
        }
        public function getLrcLine(_arg1:Number, _arg2:int, _arg3:int):int{
            if ((_arg3 - _arg2) <= 1){
                return (_arg2);
            };
            var _local4:int = (_arg2 + Math.ceil(((_arg3 - _arg2) * 0.5)));
            var _local5:Number = list[_local4][0];
            if (_arg1 > _local5){
                return (this.getLrcLine(_arg1, _local4, _arg3));
            };
            if (_arg1 < _local5){
                return (this.getLrcLine(_arg1, _arg2, _local4));
            };
            return (_local4);
        }
        public function roll():void{
            var _local2:Number;
            var _local3:Number;
            var _local4:Number;
            var _local5:Number;
            if (this.nowItem){
                this.nowItem.setTextFormat(lc.formatBase);
                if (lc.horizontal == 1){
                    Effects.f(this.nowItem);
                };
            };
            var _local1:TextField = (main.getChildAt(this.nowLine) as TextField);
            if (!_local1){
                return;
            };
            rowChange(_local1.text);
            if (lc.horizontal){
                _local2 = ((tw - _local1.width) * 0.5);
                if (_local2 < 0){
                    _local2 = 0;
                };
                _local3 = (_local2 - _local1.x);
                Effects.m(main, "x", _local3, tw);
            } else {
                _local4 = ((th - _local1.height) * 0.5);
                if (_local4 < 0){
                    _local4 = 0;
                };
                _local5 = (_local4 - _local1.y);
                Effects.m(main, "y", _local5, th);
            };
            _local1.visible = true;
            _local1.setTextFormat(lc.formatUpon);
            this.nowItem = _local1;
        }
        public function parse(_arg1:String):Boolean{
            var _local4:String;
            var _local6:String;
            list = [];
            var _local2:Array = _arg1.match(this.reg_tabo);
            var _local3:Array = [];
            for each (_local4 in _local2) {
                _local6 = _local4.replace(this.reg_tabo, this.setTabo);
                if (_local6){
                    _local3.push(_local6);
                };
            };
            if (((_local3.length) && (Config.lrc_idtags))){
                list.push([0, _local3.join(" - ")]);
            };
            var _local5:Array = _arg1.match(this.reg_line);
            _local5.forEach(this.getLine);
            if (list.length){
                list.sort(this.sortWay);
                return (true);
            };
            return (false);
        }
        public function setTabo():String{
            var _local2:String = arguments[1];
            var _local3:String = arguments[2];
            if (_local2.toLowerCase() == "offset"){
                this.offset = parseInt(_local3);
                return ("");
            };
            return (_local3);
        }
        public function getLine(_arg1:String, _arg2:int, _arg3:Array):void{
            _arg1.replace(this.reg_line, this.setLine);
        }
        public function setLine():String{
            var _local5:String;
            var _local2:String = arguments[6];
            _local2 = AppUtil.rn(_local2);
            var _local3:String = arguments[1];
            var _local4:Array = _local3.match(this.reg_time);
            _local4 = _local4.map(this.getTimes);
            for each (_local5 in _local4) {
                list.push([parseFloat(_local5), _local2]);
            };
            return (null);
        }
        public function getTimes(_arg1:String, _arg2:int, _arg3:Array):String{
            var _local4:String = _arg1.replace(this.reg_time, this.getTime);
            return (_local4);
        }
        public function getTime():String{
            var _local2:String = arguments[1];
            var _local3:String = arguments[2];
            var _local4:int = int(((((parseInt(_local2) * 60000) + (parseFloat(_local3) * 1000)) - this.offset) - 100));
            return (_local4.toString());
        }
        public function sortWay(_arg1:Array, _arg2:Array):Number{
            if (_arg1[0] > _arg2[0]){
                return (1);
            };
            if (_arg1[0] < _arg2[0]){
                return (-1);
            };
            return (0);
        }

    }
}
