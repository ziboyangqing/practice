/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;

    public final class BV extends BaseBack {

        public function BV(_arg1:Object):void{
            super(_arg1);
            init(Config.video_width, Config.video_height);
            Main.addEventListener(SMPEvent.VIDEO_RESIZE, this.resizeHandler);
        }
        public function resizeHandler(_arg1:SMPEvent):void{
            bk.ll(Config.video_width, Config.video_height);
        }
        override public function rm():void{
            Main.removeEventListener(SMPEvent.VIDEO_RESIZE, this.resizeHandler);
            super.rm();
        }

    }
}
