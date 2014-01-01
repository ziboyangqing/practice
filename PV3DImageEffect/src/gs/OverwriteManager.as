//Created by Action Script Viewer - http://www.buraks.com/asv
package gs {
    import flash.utils.*;
    import gs.utils.tween.*;
    import flash.errors.*;

    public class OverwriteManager {

        public static const ALL:int = 1;
        public static const NONE:int = 0;
        public static const AUTO:int = 2;
        public static const CONCURRENT:int = 3;
        public static const version:Number = 3.01;

        public static var mode:int;
        public static var enabled:Boolean;

        public static function killVars(_arg1:Object, _arg2:Object, _arg3:Array):void{
            var _local4:int;
            var _local5:String;
            var _local6:TweenInfo;
            _local4 = (_arg3.length - 1);
            while (_local4 > -1) {
                _local6 = _arg3[_local4];
                if ((_local6.name in _arg1)){
                    _arg3.splice(_local4, 1);
                } else {
                    if (((_local6.isPlugin) && ((_local6.name == "_MULTIPLE_")))){
                        _local6.target.killProps(_arg1);
                        if (_local6.target.overwriteProps.length == 0){
                            _arg3.splice(_local4, 1);
                        };
                    };
                };
                _local4--;
            };
            for (_local5 in _arg1) {
                delete _arg2[_local5];
            };
        }
        public static function manageOverwrites(_arg1:TweenLite, _arg2:Array):void{
            var _local7:int;
            var _local8:TweenLite;
            var _local9:Array;
            var _local10:Object;
            var _local11:int;
            var _local12:TweenInfo;
            var _local13:Array;
            var _local3:Object = _arg1.vars;
            var _local4:int = ((_local3.overwrite)==undefined) ? mode : int(_local3.overwrite);
            if ((((_local4 < 2)) || ((_arg2 == null)))){
                return;
            };
            var _local5:Number = _arg1.startTime;
            var _local6:Array = [];
            _local7 = (_arg2.length - 1);
            while (_local7 > -1) {
                _local8 = _arg2[_local7];
                if (((((!((_local8 == _arg1))) && ((_local8.startTime <= _local5)))) && (((_local8.startTime + ((_local8.duration * 1000) / _local8.combinedTimeScale)) > _local5)))){
                    _local6[_local6.length] = _local8;
                };
                _local7--;
            };
            if ((((_local6.length == 0)) || ((_arg1.tweens.length == 0)))){
                return;
            };
            if (_local4 == AUTO){
                _local9 = _arg1.tweens;
                _local10 = {};
                _local7 = (_local9.length - 1);
                while (_local7 > -1) {
                    _local12 = _local9[_local7];
                    if (((_local12.isPlugin) && ((_local12.name == "_MULTIPLE_")))){
                        _local13 = _local12.target.overwriteProps;
                        _local11 = (_local13.length - 1);
                        while (_local11 > -1) {
                            _local10[_local13[_local11]] = true;
                            _local11--;
                        };
                    } else {
                        _local10[_local12.name] = true;
                    };
                    _local7--;
                };
                _local7 = (_local6.length - 1);
                while (_local7 > -1) {
                    killVars(_local10, _local6[_local7].exposedVars, _local6[_local7].tweens);
                    _local7--;
                };
            } else {
                _local7 = (_local6.length - 1);
                while (_local7 > -1) {
                    _local6[_local7].enabled = false;
                    _local7--;
                };
            };
        }
        public static function init(_arg1:int=2):int{
            if (TweenLite.version < 10.04){
                trace("TweenLite warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
            };
            TweenLite.overwriteManager = OverwriteManager;
            mode = _arg1;
            enabled = true;
            return (mode);
        }

    }
}//package gs 
