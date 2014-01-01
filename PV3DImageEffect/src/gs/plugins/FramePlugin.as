//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;

    public class FramePlugin extends TweenPlugin {

        public static const VERSION:Number = 1;
        public static const API:Number = 1;

        protected var _target:MovieClip;
        public var frame:int;

        public function FramePlugin(){
            this.propName = "frame";
            this.overwriteProps = ["frame"];
            this.round = true;
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (((!((_arg1 is MovieClip))) || (isNaN(_arg2)))){
                return (false);
            };
            this._target = (_arg1 as MovieClip);
            addTween(this, "frame", this._target.currentFrame, _arg2, "frame");
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            updateTweens(_arg1);
            this._target.gotoAndStop(this.frame);
        }

    }
}//package gs.plugins 
