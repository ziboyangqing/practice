/*SimpleMediaPlayer*/
package com.smp {
    //import flash.events.*;
    import flash.display.*;
    //import flash.net.*;

    public final class SImage extends Sprite {

        public static var cache:Object = {};

        public function show(_arg1:TN):void{
            Main.clear(this);
            var _local2:String = (_arg1.key + _arg1.image);
            if (cache[_local2]){
                addChild(cache[_local2]);
                return;
            };
            var _local3:SImageLoader = new SImageLoader(_arg1);
            addChild(_local3);
        }

    }
}
