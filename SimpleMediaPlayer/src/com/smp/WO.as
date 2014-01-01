/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.events.*;
    import flash.display.*;
    import com.zip.*;

    public final class WO extends W {

        public var pane:SPannel;

        public function WO():void{
            this.pane = new SPannel();
            main.addChild(this.pane);
        }
        override public function set visible(_arg1:Boolean):void{
            super.visible = _arg1;
            this.pane.display = _arg1.toString();
        }
        override protected function skinHandler(_arg1:SMPEvent):void{
            var _local2:XMLList = Main.sk.skin_xml.option;
            ss(_local2, 0, 0);
            this.pane.ss(_local2.pane, tw, th);
            Scrollbar.ss(this.pane, _local2.scrollbar);
        }
        override protected function closeHandler(_arg1:MouseEvent):void{
            Main.sendEvent(SMPEvent.VIEW_OPTION);
        }
        override protected function ws():void{
            this.pane.ll(tw, th);
        }

    }
}
