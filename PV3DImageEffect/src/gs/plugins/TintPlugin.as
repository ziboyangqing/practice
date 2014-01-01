//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.geom.*;
    import flash.display.*;
    import gs.*;
    import gs.utils.tween.*;

    public class TintPlugin extends TweenPlugin {

        public static const VERSION:Number = 1.01;
        public static const API:Number = 1;

        protected static var _props:Array = ["redMultiplier", "greenMultiplier", "blueMultiplier", "alphaMultiplier", "redOffset", "greenOffset", "blueOffset", "alphaOffset"];

        protected var _target:DisplayObject;
        protected var _ct:ColorTransform;

        public function TintPlugin(){
            this.propName = "tint";
            this.overwriteProps = ["tint"];
        }
        public function init(_arg1:DisplayObject, _arg2:ColorTransform):void{
            var _local3:int;
            var _local4:String;
            this._target = _arg1;
            this._ct = this._target.transform.colorTransform;
            _local3 = (_props.length - 1);
            while (_local3 > -1) {
                _local4 = _props[_local3];
                if (this._ct[_local4] != _arg2[_local4]){
                    _tweens[_tweens.length] = new TweenInfo(this._ct, _local4, this._ct[_local4], (_arg2[_local4] - this._ct[_local4]), "tint", false);
                };
                _local3--;
            };
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (!(_arg1 is DisplayObject)){
                return (false);
            };
            var _local4:ColorTransform = new ColorTransform();
            if (((!((_arg2 == null))) && (!((_arg3.exposedVars.removeTint == true))))){
                _local4.color = uint(_arg2);
            };
            if (((!((_arg3.exposedVars.alpha == undefined))) || (!((_arg3.exposedVars.autoAlpha == undefined))))){
                _local4.alphaMultiplier = ((_arg3.exposedVars.alpha)!=undefined) ? _arg3.exposedVars.alpha : _arg3.exposedVars.autoAlpha;
                _arg3.killVars({
                    alpha:1,
                    autoAlpha:1
                });
            } else {
                _local4.alphaMultiplier = _arg1.alpha;
            };
            this.init((_arg1 as DisplayObject), _local4);
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            updateTweens(_arg1);
            this._target.transform.colorTransform = this._ct;
        }

    }
}//package gs.plugins 
