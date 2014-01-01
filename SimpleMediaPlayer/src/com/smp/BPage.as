/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.events.*;
    import com.utils.AppUtil;

    public final class BPage extends BaseBack {

        public var drag:Boolean = false;

        public function BPage(_arg1:Object):void{
            super(_arg1);
            init(Config.width, Config.height);
            this.drag = ((!(AppUtil.tof(bk.lock))) && (!(AppUtil.tof(bk.repeat))));
            addEventListener(MouseEvent.MOUSE_DOWN, this.sdrag);
            Main.addEventListener(SMPEvent.RESIZE, this.resizeHandler);
        }
        public function resizeHandler(_arg1:SMPEvent):void{
            bk.ll(Config.width, Config.height);
        }
        override public function rm():void{
            removeEventListener(MouseEvent.MOUSE_DOWN, this.sdrag);
            Main.removeEventListener(SMPEvent.RESIZE, this.resizeHandler);
            super.rm();
        }
        public function sdrag(_arg1:MouseEvent):void{
            if (((this.drag) || (_arg1.ctrlKey))){
                bk.startDrag();
                stage.addEventListener(MouseEvent.MOUSE_UP, this.edrag);
            };
        }
        public function edrag(_arg1:MouseEvent):void{
            bk.stopDrag();
            bk.nxywh();
            stage.removeEventListener(MouseEvent.MOUSE_UP, this.edrag);
        }

    }
}
