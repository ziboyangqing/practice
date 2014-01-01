//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.plugins {
    import flash.display.*;
    import gs.*;
    import flash.filters.*;

    public class GlowFilterPlugin extends FilterPlugin {

        public static const VERSION:Number = 1;
        public static const API:Number = 1;

        public function GlowFilterPlugin(){
            this.propName = "glowFilter";
            this.overwriteProps = ["glowFilter"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = GlowFilter;
            initFilter(_arg2, new GlowFilter(0xFFFFFF, 0, 0, 0, ((_arg2.strength) || (1)), ((_arg2.quality) || (2)), _arg2.inner, _arg2.knockout));
            return (true);
        }

    }
}//package gs.plugins 
