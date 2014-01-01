//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;
    import gs.utils.tween.*;

    public class EndArrayPlugin extends TweenPlugin {

        public static const VERSION:Number = 1.01;
        public static const API:Number = 1;

        protected var _a:Array;
        protected var _info:Array;

        public function EndArrayPlugin(){
            this._info = [];
            super();
            this.propName = "endArray";
            this.overwriteProps = ["endArray"];
        }
        public function init(_arg1:Array, _arg2:Array):void{
            this._a = _arg1;
            var _local3:int = (_arg2.length - 1);
            while (_local3 > -1) {
                if (((!((_arg1[_local3] == _arg2[_local3]))) && (!((_arg1[_local3] == null))))){
                    this._info[this._info.length] = new ArrayTweenInfo(_local3, this._a[_local3], (_arg2[_local3] - this._a[_local3]));
                };
                _local3--;
            };
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (((!((_arg1 is Array))) || (!((_arg2 is Array))))){
                return (false);
            };
            this.init((_arg1 as Array), _arg2);
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local2:int;
            var _local3:ArrayTweenInfo;
            var _local4:Number;
            var _local5:int;
            if (this.round){
                _local2 = (this._info.length - 1);
                while (_local2 > -1) {
                    _local3 = this._info[_local2];
                    _local4 = (_local3.start + (_local3.change * _arg1));
                    _local5 = ((_local4)<0) ? -1 : 1;
                    this._a[_local3.index] = ((((_local4 % 1) * _local5))>0.5) ? (int(_local4) + _local5) : int(_local4);
                    _local2--;
                };
            } else {
                _local2 = (this._info.length - 1);
                while (_local2 > -1) {
                    _local3 = this._info[_local2];
                    this._a[_local3.index] = (_local3.start + (_local3.change * _arg1));
                    _local2--;
                };
            };
        }

    }
}//package gs.plugins 
