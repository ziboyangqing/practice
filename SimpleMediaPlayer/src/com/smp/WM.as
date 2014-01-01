/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    import flash.net.*;

    public final class WM extends W {

        public var video:MediaView;

        public function WM():void{
            Main.mv = (this.video = new MediaView());
        }
        override protected function skinHandler(_arg1:SMPEvent):void{
            var _local2:XMLList = Main.sk.skin_xml.media;
            ss(_local2, 0, 0);
            this.video.ss(_local2.video, tw, th);
        }
        override protected function closeHandler(_arg1:MouseEvent):void{
            Main.sendEvent(SMPEvent.VIEW_VIDEO);
        }
        override protected function ws():void{
            this.video.ll(tw, th);
        }

    }
}
