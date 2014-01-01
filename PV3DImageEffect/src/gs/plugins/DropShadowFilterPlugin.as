//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;
    import flash.filters.*;

    public class DropShadowFilterPlugin extends FilterPlugin {

        public static const VERSION:Number = 1;
        public static const API:Number = 1;

        public function DropShadowFilterPlugin(){
            this.propName = "dropShadowFilter";
            this.overwriteProps = ["dropShadowFilter"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = DropShadowFilter;
            initFilter(_arg2, new DropShadowFilter(0, 45, 0, 0, 0, 0, 1, ((_arg2.quality) || (2)), _arg2.inner, _arg2.knockout, _arg2.hideObject));
            return (true);
        }

    }
}//package gs.plugins 
