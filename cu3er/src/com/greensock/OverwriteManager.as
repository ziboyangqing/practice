//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock {
    import com.greensock.core.*;

    public final class OverwriteManager {

        public static const version:Number = 6.1;
        public static const NONE:int = 0;
        public static const ALL_IMMEDIATE:int = 1;
        public static const AUTO:int = 2;
        public static const CONCURRENT:int = 3;
        public static const ALL_ONSTART:int = 4;
        public static const PREEXISTING:int = 5;

        public static var mode:int;
        public static var enabled:Boolean;

        public static function init(_arg1:int=2):int{
            if (TweenLite.version < 11.6){
                throw (new Error("Warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com."));
            };
            TweenLite.overwriteManager = OverwriteManager;
            mode = _arg1;
            enabled = true;
            return (mode);
        }
        public static function manageOverwrites(_arg1:TweenLite, _arg2:Object, _arg3:Array, _arg4:int):Boolean{
            var _local5:int;
            var _local6:Boolean;
            var _local7:TweenLite;
            var _local13:int;
            var _local14:Number;
            var _local15:Number;
            var _local16:TweenCore;
            var _local17:Number;
            var _local18:SimpleTimeline;
            if (_arg4 >= 4){
                _local13 = _arg3.length;
                _local5 = 0;
                while (_local5 < _local13) {
                    _local7 = _arg3[_local5];
                    if (_local7 != _arg1){
                        if (_local7.setEnabled(false, false)){
                            _local6 = true;
                        };
                    } else {
                        if (_arg4 == 5){
                            break;
                        };
                    };
                    _local5++;
                };
                return (_local6);
            };
            var _local8:Number = (_arg1.cachedStartTime + 1E-10);
            var _local9:Array = [];
            var _local10:Array = [];
            var _local11:int;
            var _local12:int;
            _local5 = _arg3.length;
            while (--_local5 > -1) {
                _local7 = _arg3[_local5];
                if ((((((_local7 == _arg1)) || (_local7.gc))) || (((!(_local7.initted)) && (((_local8 - _local7.cachedStartTime) <= 2E-10)))))){
                } else {
                    if (_local7.timeline != _arg1.timeline){
                        if (!getGlobalPaused(_local7)){
                            var _temp1 = _local11;
                            _local11 = (_local11 + 1);
                            var _local19 = _temp1;
                            _local10[_local19] = _local7;
                        };
                    } else {
                        if ((((((((_local7.cachedStartTime <= _local8)) && ((((_local7.cachedStartTime + _local7.totalDuration) + 1E-10) > _local8)))) && (!(_local7.cachedPaused)))) && (!((((_arg1.cachedDuration == 0)) && (((_local8 - _local7.cachedStartTime) <= 2E-10))))))){
                            var _temp2 = _local12;
                            _local12 = (_local12 + 1);
                            _local19 = _temp2;
                            _local9[_local19] = _local7;
                        };
                    };
                };
            };
            if (_local11 != 0){
                _local14 = _arg1.cachedTimeScale;
                _local15 = _local8;
                _local18 = _arg1.timeline;
                while (_local18) {
                    _local14 = (_local14 * _local18.cachedTimeScale);
                    _local15 = (_local15 + _local18.cachedStartTime);
                    _local18 = _local18.timeline;
                };
                _local8 = (_local14 * _local15);
                _local5 = _local11;
                while (--_local5 > -1) {
                    _local16 = _local10[_local5];
                    _local14 = _local16.cachedTimeScale;
                    _local15 = _local16.cachedStartTime;
                    _local18 = _local16.timeline;
                    while (_local18) {
                        _local14 = (_local14 * _local18.cachedTimeScale);
                        _local15 = (_local15 + _local18.cachedStartTime);
                        _local18 = _local18.timeline;
                    };
                    _local17 = (_local14 * _local15);
                    if ((((_local17 <= _local8)) && ((((((_local17 + (_local16.totalDuration * _local14)) + 1E-10) > _local8)) || ((_local16.cachedDuration == 0)))))){
                        var _temp3 = _local12;
                        _local12 = (_local12 + 1);
                        _local19 = _temp3;
                        _local9[_local19] = _local16;
                    };
                };
            };
            if (_local12 == 0){
                return (_local6);
            };
            _local5 = _local12;
            if (_arg4 == 2){
                while (--_local5 > -1) {
                    _local7 = _local9[_local5];
                    if (_local7.killVars(_arg2)){
                        _local6 = true;
                    };
                    if ((((_local7.cachedPT1 == null)) && (_local7.initted))){
                        _local7.setEnabled(false, false);
                    };
                };
            } else {
                while (--_local5 > -1) {
                    if (TweenLite(_local9[_local5]).setEnabled(false, false)){
                        _local6 = true;
                    };
                };
            };
            return (_local6);
        }
        public static function getGlobalPaused(_arg1:TweenCore):Boolean{
            var _local2:Boolean;
            while (_arg1) {
                if (_arg1.cachedPaused){
                    _local2 = true;
                    break;
                };
                _arg1 = _arg1.timeline;
            };
            return (_local2);
        }

    }
}//package com.greensock 
