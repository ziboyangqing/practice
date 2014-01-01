//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import gs.*;
    import gs.utils.tween.*;

    public class BezierPlugin extends TweenPlugin {

        protected static const _RAD2DEG:Number = 57.2957795130823;
        public static const VERSION:Number = 1.01;
        public static const API:Number = 1;

        protected var _future:Object;
        protected var _orient:Boolean;
        protected var _orientData:Array;
        protected var _target:Object;
        protected var _beziers:Object;

        public function BezierPlugin(){
            this._future = {};
            super();
            this.propName = "bezier";
            this.overwriteProps = [];
        }
        public static function parseBeziers(_arg1:Object, _arg2:Boolean=false):Object{
            var _local3:int;
            var _local4:Array;
            var _local5:Object;
            var _local6:String;
            var _local7:Object = {};
            if (_arg2){
                for (_local6 in _arg1) {
                    _local4 = _arg1[_local6];
                    _local5 = [];
                    _local7[_local6] = _local5;
                    if (_local4.length > 2){
                        _local5[_local5.length] = [_local4[0], (_local4[1] - ((_local4[2] - _local4[0]) / 4)), _local4[1]];
                        _local3 = 1;
                        while (_local3 < (_local4.length - 1)) {
                            _local5[_local5.length] = [_local4[_local3], (_local4[_local3] + (_local4[_local3] - _local5[(_local3 - 1)][1])), _local4[(_local3 + 1)]];
                            _local3++;
                        };
                    } else {
                        _local5[_local5.length] = [_local4[0], ((_local4[0] + _local4[1]) / 2), _local4[1]];
                    };
                };
            } else {
                for (_local6 in _arg1) {
                    _local4 = _arg1[_local6];
                    _local5 = [];
                    _local7[_local6] = _local5;
                    if (_local4.length > 3){
                        _local5[_local5.length] = [_local4[0], _local4[1], ((_local4[1] + _local4[2]) / 2)];
                        _local3 = 2;
                        while (_local3 < (_local4.length - 2)) {
                            _local5[_local5.length] = [_local5[(_local3 - 2)][2], _local4[_local3], ((_local4[_local3] + _local4[(_local3 + 1)]) / 2)];
                            _local3++;
                        };
                        _local5[_local5.length] = [_local5[(_local5.length - 1)][2], _local4[(_local4.length - 2)], _local4[(_local4.length - 1)]];
                    } else {
                        if (_local4.length == 3){
                            _local5[_local5.length] = [_local4[0], _local4[1], _local4[2]];
                        } else {
                            if (_local4.length == 2){
                                _local5[_local5.length] = [_local4[0], ((_local4[0] + _local4[1]) / 2), _local4[1]];
                            };
                        };
                    };
                };
            };
            return (_local7);
        }

        override public function killProps(_arg1:Object):void{
            var _local2:String;
            for (_local2 in this._beziers) {
                if ((_local2 in _arg1)){
                    delete this._beziers[_local2];
                };
            };
            super.killProps(_arg1);
        }
        protected function init(_arg1:TweenLite, _arg2:Array, _arg3:Boolean):void{
            var _local5:int;
            var _local6:String;
            this._target = _arg1.target;
            if (_arg1.exposedVars.orientToBezier == true){
                this._orientData = [["x", "y", "rotation", 0]];
                this._orient = true;
            } else {
                if ((_arg1.exposedVars.orientToBezier is Array)){
                    this._orientData = _arg1.exposedVars.orientToBezier;
                    this._orient = true;
                };
            };
            var _local4:Object = {};
            _local5 = 0;
            while (_local5 < _arg2.length) {
                for (_local6 in _arg2[_local5]) {
                    if (_local4[_local6] == undefined){
                        _local4[_local6] = [_arg1.target[_local6]];
                    };
                    if (typeof(_arg2[_local5][_local6]) == "number"){
                        _local4[_local6].push(_arg2[_local5][_local6]);
                    } else {
                        _local4[_local6].push((_arg1.target[_local6] + Number(_arg2[_local5][_local6])));
                    };
                };
                _local5++;
            };
            for (_local6 in _local4) {
                this.overwriteProps[this.overwriteProps.length] = _local6;
                if (_arg1.exposedVars[_local6] != undefined){
                    if (typeof(_arg1.exposedVars[_local6]) == "number"){
                        _local4[_local6].push(_arg1.exposedVars[_local6]);
                    } else {
                        _local4[_local6].push((_arg1.target[_local6] + Number(_arg1.exposedVars[_local6])));
                    };
                    delete _arg1.exposedVars[_local6];
                    _local5 = (_arg1.tweens.length - 1);
                    while (_local5 > -1) {
                        if (_arg1.tweens[_local5].name == _local6){
                            _arg1.tweens.splice(_local5, 1);
                        };
                        _local5--;
                    };
                };
            };
            this._beziers = parseBeziers(_local4, _arg3);
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (!(_arg2 is Array)){
                return (false);
            };
            this.init(_arg3, (_arg2 as Array), false);
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local2:int;
            var _local3:String;
            var _local4:Object;
            var _local5:Number;
            var _local6:uint;
            var _local7:Number;
            var _local8:int;
            var _local9:Object;
            var _local10:Boolean;
            var _local11:Number;
            var _local12:Number;
            var _local13:Array;
            var _local14:Number;
            if (_arg1 == 1){
                for (_local3 in this._beziers) {
                    _local2 = (this._beziers[_local3].length - 1);
                    this._target[_local3] = this._beziers[_local3][_local2][2];
                };
            } else {
                for (_local3 in this._beziers) {
                    _local6 = this._beziers[_local3].length;
                    if (_arg1 < 0){
                        _local2 = 0;
                    } else {
                        if (_arg1 >= 1){
                            _local2 = (_local6 - 1);
                        } else {
                            _local2 = int((_local6 * _arg1));
                        };
                    };
                    _local5 = ((_arg1 - (_local2 * (1 / _local6))) * _local6);
                    _local4 = this._beziers[_local3][_local2];
                    if (this.round){
                        _local7 = (_local4[0] + (_local5 * (((2 * (1 - _local5)) * (_local4[1] - _local4[0])) + (_local5 * (_local4[2] - _local4[0])))));
                        _local8 = ((_local7)<0) ? -1 : 1;
                        this._target[_local3] = ((((_local7 % 1) * _local8))>0.5) ? (int(_local7) + _local8) : int(_local7);
                    } else {
                        this._target[_local3] = (_local4[0] + (_local5 * (((2 * (1 - _local5)) * (_local4[1] - _local4[0])) + (_local5 * (_local4[2] - _local4[0])))));
                    };
                };
            };
            if (this._orient){
                _local9 = this._target;
                _local10 = this.round;
                this._target = this._future;
                this.round = false;
                this._orient = false;
                this.changeFactor = (_arg1 + 0.01);
                this._target = _local9;
                this.round = _local10;
                this._orient = true;
                _local2 = 0;
                while (_local2 < this._orientData.length) {
                    _local13 = this._orientData[_local2];
                    _local14 = ((_local13[3]) || (0));
                    _local11 = (this._future[_local13[0]] - this._target[_local13[0]]);
                    _local12 = (this._future[_local13[1]] - this._target[_local13[1]]);
                    this._target[_local13[2]] = ((Math.atan2(_local12, _local11) * _RAD2DEG) + _local14);
                    _local2++;
                };
            };
        }

    }
}//package gs.plugins 
