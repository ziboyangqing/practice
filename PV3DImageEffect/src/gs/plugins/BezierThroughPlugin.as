//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import gs.*;

    public class BezierThroughPlugin extends BezierPlugin {

        public static const VERSION:Number = 1;
        public static const API:Number = 1;

        public function BezierThroughPlugin(){
            this.propName = "bezierThrough";
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (!(_arg2 is Array)){
                return (false);
            };
            init(_arg3, (_arg2 as Array), true);
            return (true);
        }

    }
}//package gs.plugins 
