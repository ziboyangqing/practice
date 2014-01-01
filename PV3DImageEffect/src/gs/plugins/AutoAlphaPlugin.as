//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;

    public class AutoAlphaPlugin extends TweenPlugin {

        public static const VERSION:Number = 1;
        public static const API:Number = 1;

        protected var _tweenVisible:Boolean;
        protected var _target:Object;
        protected var _visible:Boolean;
        protected var _tween:TweenLite;

        public function AutoAlphaPlugin(){
            this.propName = "autoAlpha";
            this.overwriteProps = ["alpha", "visible"];
            this.onComplete = this.onCompleteTween;
        }
        override public function killProps(_arg1:Object):void{
            super.killProps(_arg1);
            this._tweenVisible = !(Boolean(("visible" in _arg1)));
        }
        public function onCompleteTween():void{
            if (((((this._tweenVisible) && (!((this._tween.vars.runBackwards == true))))) && ((this._tween.ease == this._tween.vars.ease)))){
                this._target.visible = this._visible;
            };
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            this._target = _arg1;
            this._tween = _arg3;
            this._visible = Boolean(!((_arg2 == 0)));
            this._tweenVisible = true;
            addTween(_arg1, "alpha", _arg1.alpha, _arg2, "alpha");
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            updateTweens(_arg1);
            if (((!((this._target.visible == true))) && (this._tweenVisible))){
                this._target.visible = true;
            };
        }

    }
}//package gs.plugins 
