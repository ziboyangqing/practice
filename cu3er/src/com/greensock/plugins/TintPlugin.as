//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import flash.geom.*;
    import flash.display.*;
    import com.greensock.*;
    import com.greensock.core.*;

    public class TintPlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected static var _props:Array = ["redMultiplier", "greenMultiplier", "blueMultiplier", "alphaMultiplier", "redOffset", "greenOffset", "blueOffset", "alphaOffset"];

        protected var _transform:Transform;

        public function TintPlugin(){
            this.propName = "tint";
            this.overwriteProps = ["tint"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (!(_arg1 is DisplayObject)){
                return (false);
            };
            var _local4:ColorTransform = new ColorTransform();
            if (((!((_arg2 == null))) && (!((_arg3.vars.removeTint == true))))){
                _local4.color = uint(_arg2);
            };
            this._transform = DisplayObject(_arg1).transform;
            var _local5:ColorTransform = this._transform.colorTransform;
            _local4.alphaMultiplier = _local5.alphaMultiplier;
            _local4.alphaOffset = _local5.alphaOffset;
            this.init(_local5, _local4);
            return (true);
        }
        public function init(_arg1:ColorTransform, _arg2:ColorTransform):void{
            var _local4:String;
            var _local3:int = _props.length;
            var _local5:int = _tweens.length;
            while (_local3--) {
                _local4 = _props[_local3];
                if (_arg1[_local4] != _arg2[_local4]){
                    var _temp1 = _local5;
                    _local5 = (_local5 + 1);
                    var _local6 = _temp1;
                    _tweens[_local6] = new PropTween(_arg1, _local4, _arg1[_local4], (_arg2[_local4] - _arg1[_local4]), "tint", false);
                };
            };
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local2:ColorTransform;
            var _local3:PropTween;
            var _local4:int;
            if (this._transform){
                _local2 = this._transform.colorTransform;
                _local4 = _tweens.length;
                while (--_local4 > -1) {
                    _local3 = _tweens[_local4];
                    _local2[_local3.property] = (_local3.start + (_local3.change * _arg1));
                };
                this._transform.colorTransform = _local2;
            };
        }

    }
}//package com.greensock.plugins 
