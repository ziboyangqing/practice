/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.display.*;
    import flash.ui.*;

    public final class WF extends Sprite {

        public function WF():void{
            Main.addEventListener(SMPEvent.CONFIG_LOADED, this.maxHandler);
            Main.addEventListener(SMPEvent.RESIZE, this.resizeHandler);
            Main.addEventListener(SMPEvent.CONTROL_MAX, this.maxHandler);
        }
        public function maxHandler(_arg1:SMPEvent):void{
            if (((Config.video_max) || (Config.lrc_max))){
                if (((Config.video_max) && (Config.lrc_max))){
                    Config.lrc_max = false;
                };
                if (Config.video_max){
                    addChild(Main.mv);
                    Main.wr.main.addChild(Main.lc);
                } else {
                    if (Config.lrc_max){
                        addChild(Main.lc);
                        Main.wm.main.addChild(Main.mv);
                    };
                };
                this.resizeHandler();
                visible = true;
            } else {
                Mouse.show();
                Main.wm.main.addChild(Main.mv);
                Main.wr.main.addChild(Main.lc);
                visible = false;
            };
        }
        public function resizeHandler(_arg1:SMPEvent=null):void{
            SGraphics.drawRect(this, 0, 0, Config.width, Config.height, 1);
        }

    }
}
