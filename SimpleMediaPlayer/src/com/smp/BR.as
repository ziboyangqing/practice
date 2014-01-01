/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;

    public final class BR extends BaseBack {

        public function BR(_arg1:Object):void{
            super(_arg1);
            init(Config.lrc_width, Config.lrc_height);
            Main.addEventListener(SMPEvent.LRC_RESIZE, this.resizeHandler);
        }
        public function resizeHandler(_arg1:SMPEvent):void{
            bk.ll(Config.lrc_width, Config.lrc_height);
        }
        override public function rm():void{
            Main.removeEventListener(SMPEvent.LRC_RESIZE, this.resizeHandler);
            super.rm();
        }

    }
}
