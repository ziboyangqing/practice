//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;

    public class RoundPropsPlugin extends TweenPlugin {

        public static const VERSION:Number = 1;
        public static const API:Number = 1;

        public function RoundPropsPlugin(){
            this.propName = "roundProps";
            this.overwriteProps = [];
            this.round = true;
        }
        public function add(_arg1:Object, _arg2:String, _arg3:Number, _arg4:Number):void{
            addTween(_arg1, _arg2, _arg3, (_arg3 + _arg4), _arg2);
            this.overwriteProps[this.overwriteProps.length] = _arg2;
        }

    }
}//package gs.plugins 
