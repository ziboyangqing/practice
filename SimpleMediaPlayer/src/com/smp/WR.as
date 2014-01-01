/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.events.*;
    import flash.display.*;
    import flash.text.*;
    import flash.net.*;
    import flash.system.*;

    public final class WR extends W {

        public var text:SLrc;

        public function WR():void{
            Main.lc = (this.text = new SLrc());
        }
        override public function set visible(_arg1:Boolean):void{
            super.visible = _arg1;
            this.text.display = _arg1.toString();
        }
        override protected function skinHandler(_arg1:SMPEvent):void{
            var _local2:XMLList = Main.sk.skin_xml.lrc;
            ss(_local2, 0, 0);
            this.text.ss(_local2.text, tw, th);
        }
        override protected function closeHandler(_arg1:MouseEvent):void{
            Main.sendEvent(SMPEvent.VIEW_LRC);
        }
        override protected function ws():void{
            this.text.ll(tw, th);
        }

    }
}
