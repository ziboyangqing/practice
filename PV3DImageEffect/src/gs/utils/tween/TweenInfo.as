//Created by Action Script Viewer - http://www.buraks.com/asv
package gs.utils.tween {

    public class TweenInfo {

        public var start:Number;
        public var name:String;
        public var change:Number;
        public var target:Object;
        public var property:String;
        public var isPlugin:Boolean;

        public function TweenInfo(_arg1:Object, _arg2:String, _arg3:Number, _arg4:Number, _arg5:String, _arg6:Boolean){
            this.target = _arg1;
            this.property = _arg2;
            this.start = _arg3;
            this.change = _arg4;
            this.name = _arg5;
            this.isPlugin = _arg6;
        }
    }
}//package gs.utils.tween 
