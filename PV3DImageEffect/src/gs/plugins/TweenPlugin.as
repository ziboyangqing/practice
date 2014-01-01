//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import gs.*;
    import gs.utils.tween.*;

    public class TweenPlugin {

        public static const VERSION:Number = 1.03;
        public static const API:Number = 1;

        public var overwriteProps:Array;
        protected var _tweens:Array;
        public var propName:String;
        public var onComplete:Function;
        public var round:Boolean;
        protected var _changeFactor:Number = 0;

        public function TweenPlugin(){
            this._tweens = [];
            super();
        }
        public static function activate(_arg1:Array):Boolean{
            var _local2:int;
            var _local3:Object;
            _local2 = (_arg1.length - 1);
            while (_local2 > -1) {
                _local3 = new (_arg1[_local2])();
                TweenLite.plugins[_local3.propName] = _arg1[_local2];
                _local2--;
            };
            return (true);
        }

        protected function updateTweens(_arg1:Number):void{
            var _local2:int;
            var _local3:TweenInfo;
            var _local4:Number;
            var _local5:int;
            if (this.round){
                _local2 = (this._tweens.length - 1);
                while (_local2 > -1) {
                    _local3 = this._tweens[_local2];
                    _local4 = (_local3.start + (_local3.change * _arg1));
                    _local5 = ((_local4)<0) ? -1 : 1;
                    _local3.target[_local3.property] = ((((_local4 % 1) * _local5))>0.5) ? (int(_local4) + _local5) : int(_local4);
                    _local2--;
                };
            } else {
                _local2 = (this._tweens.length - 1);
                while (_local2 > -1) {
                    _local3 = this._tweens[_local2];
                    _local3.target[_local3.property] = (_local3.start + (_local3.change * _arg1));
                    _local2--;
                };
            };
        }
        public function set changeFactor(_arg1:Number):void{
            this.updateTweens(_arg1);
            this._changeFactor = _arg1;
        }
        protected function addTween(_arg1:Object, _arg2:String, _arg3:Number, _arg4, _arg5:String=null):void{
            var _local6:Number;
            if (_arg4 != null){
                _local6 = ((typeof(_arg4))=="number") ? (_arg4 - _arg3) : Number(_arg4);
                if (_local6 != 0){
                    this._tweens[this._tweens.length] = new TweenInfo(_arg1, _arg2, _arg3, _local6, ((_arg5) || (_arg2)), false);
                };
            };
        }
        public function killProps(_arg1:Object):void{
            var _local2:int;
            _local2 = (this.overwriteProps.length - 1);
            while (_local2 > -1) {
                if ((this.overwriteProps[_local2] in _arg1)){
                    this.overwriteProps.splice(_local2, 1);
                };
                _local2--;
            };
            _local2 = (this._tweens.length - 1);
            while (_local2 > -1) {
                if ((this._tweens[_local2].name in _arg1)){
                    this._tweens.splice(_local2, 1);
                };
                _local2--;
            };
        }
        public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            this.addTween(_arg1, this.propName, _arg1[this.propName], _arg2, this.propName);
            return (true);
        }
        public function get changeFactor():Number{
            return (this._changeFactor);
        }

    }
}//package gs.plugins 
