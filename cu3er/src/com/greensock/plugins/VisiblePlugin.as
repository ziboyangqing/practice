//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import com.greensock.*;

    public class VisiblePlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected var _target:Object;
        protected var _tween:TweenLite;
        protected var _visible:Boolean;
        protected var _initVal:Boolean;

        public function VisiblePlugin(){
            this.propName = "visible";
            this.overwriteProps = ["visible"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            this._target = _arg1;
            this._tween = _arg3;
            this._initVal = this._target.visible;
            this._visible = Boolean(_arg2);
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            if ((((_arg1 == 1)) && ((((this._tween.cachedDuration == this._tween.cachedTime)) || ((this._tween.cachedTime == 0)))))){
                this._target.visible = this._visible;
            } else {
                this._target.visible = this._initVal;
            };
        }

    }
}//package com.greensock.plugins 
