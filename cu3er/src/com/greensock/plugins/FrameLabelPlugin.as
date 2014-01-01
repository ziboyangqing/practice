//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import flash.display.*;
    import com.greensock.*;

    public class FrameLabelPlugin extends FramePlugin {

        public static const API:Number = 1;

        public function FrameLabelPlugin(){
            this.propName = "frameLabel";
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if ((!(_arg3.target) is MovieClip)){
                return (false);
            };
            _target = (_arg1 as MovieClip);
            this.frame = _target.currentFrame;
            var _local4:Array = _target.currentLabels;
            var _local5:String = _arg2;
            var _local6:int = _target.currentFrame;
            var _local7:int = _local4.length;
            while (_local7--) {
                if (_local4[_local7].name == _local5){
                    _local6 = _local4[_local7].frame;
                    break;
                };
            };
            if (this.frame != _local6){
                addTween(this, "frame", this.frame, _local6, "frame");
            };
            return (true);
        }

    }
}//package com.greensock.plugins 
