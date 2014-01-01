//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import com.greensock.core.*;
    import flash.filters.*;

    public class FilterPlugin extends TweenPlugin {

        public static const VERSION:Number = 2.03;
        public static const API:Number = 1;

        protected var _target:Object;
        protected var _type:Class;
        protected var _filter:BitmapFilter;
        protected var _index:int;
        protected var _remove:Boolean;

        protected function initFilter(_arg1:Object, _arg2:BitmapFilter, _arg3:Array):void{
            var _local5:String;
            var _local6:int;
            var _local7:HexColorsPlugin;
            var _local4:Array = this._target.filters;
            var _local8:Object = ((_arg1 is BitmapFilter)) ? {} : _arg1;
            this._index = -1;
            if (_local8.index != null){
                this._index = _local8.index;
            } else {
                _local6 = _local4.length;
                while (_local6--) {
                    if ((_local4[_local6] is this._type)){
                        this._index = _local6;
                        break;
                    };
                };
            };
            if ((((((this._index == -1)) || ((_local4[this._index] == null)))) || ((_local8.addFilter == true)))){
                this._index = ((_local8.index)!=null) ? _local8.index : _local4.length;
                _local4[this._index] = _arg2;
                this._target.filters = _local4;
            };
            this._filter = _local4[this._index];
            if (_local8.remove == true){
                this._remove = true;
                this.onComplete = this.onCompleteTween;
            };
            _local6 = _arg3.length;
            while (_local6--) {
                _local5 = _arg3[_local6];
                if ((((_local5 in _arg1)) && (!((this._filter[_local5] == _arg1[_local5]))))){
                    if ((((((_local5 == "color")) || ((_local5 == "highlightColor")))) || ((_local5 == "shadowColor")))){
                        _local7 = new HexColorsPlugin();
                        _local7.initColor(this._filter, _local5, this._filter[_local5], _arg1[_local5]);
                        _tweens[_tweens.length] = new PropTween(_local7, "changeFactor", 0, 1, _local5, false);
                    } else {
                        if ((((((((_local5 == "quality")) || ((_local5 == "inner")))) || ((_local5 == "knockout")))) || ((_local5 == "hideObject")))){
                            this._filter[_local5] = _arg1[_local5];
                        } else {
                            addTween(this._filter, _local5, this._filter[_local5], _arg1[_local5], _local5);
                        };
                    };
                };
            };
        }
        public function onCompleteTween():void{
            var _local1:Array;
            var _local2:int;
            if (this._remove){
                _local1 = this._target.filters;
                if (!(_local1[this._index] is this._type)){
                    _local2 = _local1.length;
                    while (_local2--) {
                        if ((_local1[_local2] is this._type)){
                            _local1.splice(_local2, 1);
                            break;
                        };
                    };
                } else {
                    _local1.splice(this._index, 1);
                };
                this._target.filters = _local1;
            };
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local3:PropTween;
            var _local2:int = _tweens.length;
            var _local4:Array = this._target.filters;
            while (_local2--) {
                _local3 = _tweens[_local2];
                _local3.target[_local3.property] = (_local3.start + (_local3.change * _arg1));
            };
            if (!(_local4[this._index] is this._type)){
                _local2 = (this._index = _local4.length);
                while (_local2--) {
                    if ((_local4[_local2] is this._type)){
                        this._index = _local2;
                        break;
                    };
                };
            };
            _local4[this._index] = this._filter;
            this._target.filters = _local4;
        }

    }
}//package com.greensock.plugins 
