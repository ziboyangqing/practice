//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;

    public class VisiblePlugin extends TweenPlugin {

        public static const VERSION:Number = 1;
        public static const API:Number = 1;

        protected var _target:Object;
        protected var _visible:Boolean;
        protected var _tween:TweenLite;

        public function VisiblePlugin(){
            this.propName = "visible";
            this.overwriteProps = ["visible"];
            this.onComplete = this.onCompleteTween;
        }
        public function onCompleteTween():void{
            if (((!((this._tween.vars.runBackwards == true))) && ((this._tween.ease == this._tween.vars.ease)))){
                this._target.visible = this._visible;
            };
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            this._target = _arg1;
            this._tween = _arg3;
            this._visible = Boolean(_arg2);
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            if (this._target.visible != true){
                this._target.visible = true;
            };
        }

    }
}//package gs.plugins 
