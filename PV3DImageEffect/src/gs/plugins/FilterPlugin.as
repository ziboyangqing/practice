//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;
    import flash.filters.*;
    import gs.utils.tween.*;

    public class FilterPlugin extends TweenPlugin {

        public static const VERSION:Number = 1.03;
        public static const API:Number = 1;

        protected var _remove:Boolean;
        protected var _target:Object;
        protected var _index:int;
        protected var _filter:BitmapFilter;
        protected var _type:Class;

        public function onCompleteTween():void{
            var _local1:int;
            var _local2:Array;
            if (this._remove){
                _local2 = this._target.filters;
                if (!(_local2[this._index] is this._type)){
                    _local1 = (_local2.length - 1);
                    while (_local1 > -1) {
                        if ((_local2[_local1] is this._type)){
                            _local2.splice(_local1, 1);
                            break;
                        };
                        _local1--;
                    };
                } else {
                    _local2.splice(this._index, 1);
                };
                this._target.filters = _local2;
            };
        }
        protected function initFilter(_arg1:Object, _arg2:BitmapFilter):void{
            var _local4:String;
            var _local5:int;
            var _local6:HexColorsPlugin;
            var _local3:Array = this._target.filters;
            this._index = -1;
            if (_arg1.index != null){
                this._index = _arg1.index;
            } else {
                _local5 = (_local3.length - 1);
                while (_local5 > -1) {
                    if ((_local3[_local5] is this._type)){
                        this._index = _local5;
                        break;
                    };
                    _local5--;
                };
            };
            if ((((((this._index == -1)) || ((_local3[this._index] == null)))) || ((_arg1.addFilter == true)))){
                this._index = ((_arg1.index)!=null) ? _arg1.index : _local3.length;
                _local3[this._index] = _arg2;
                this._target.filters = _local3;
            };
            this._filter = _local3[this._index];
            this._remove = Boolean((_arg1.remove == true));
            if (this._remove){
                this.onComplete = this.onCompleteTween;
            };
            var _local7:Object = ((_arg1.isTV)==true) ? _arg1.exposedVars : _arg1;
            for (_local4 in _local7) {
                if (((((((((!((_local4 in this._filter))) || ((this._filter[_local4] == _local7[_local4])))) || ((_local4 == "remove")))) || ((_local4 == "index")))) || ((_local4 == "addFilter")))){
                } else {
                    if ((((((_local4 == "color")) || ((_local4 == "highlightColor")))) || ((_local4 == "shadowColor")))){
                        _local6 = new HexColorsPlugin();
                        _local6.initColor(this._filter, _local4, this._filter[_local4], _local7[_local4]);
                        _tweens[_tweens.length] = new TweenInfo(_local6, "changeFactor", 0, 1, _local4, false);
                    } else {
                        if ((((((((_local4 == "quality")) || ((_local4 == "inner")))) || ((_local4 == "knockout")))) || ((_local4 == "hideObject")))){
                            this._filter[_local4] = _local7[_local4];
                        } else {
                            addTween(this._filter, _local4, this._filter[_local4], _local7[_local4], _local4);
                        };
                    };
                };
            };
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local2:int;
            var _local3:TweenInfo;
            var _local4:Array = this._target.filters;
            _local2 = (_tweens.length - 1);
            while (_local2 > -1) {
                _local3 = _tweens[_local2];
                _local3.target[_local3.property] = (_local3.start + (_local3.change * _arg1));
                _local2--;
            };
            if (!(_local4[this._index] is this._type)){
                this._index = (_local4.length - 1);
                _local2 = (_local4.length - 1);
                while (_local2 > -1) {
                    if ((_local4[_local2] is this._type)){
                        this._index = _local2;
                        break;
                    };
                    _local2--;
                };
            };
            _local4[this._index] = this._filter;
            this._target.filters = _local4;
        }

    }
}//package gs.plugins 
