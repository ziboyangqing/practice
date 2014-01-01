/*SimpleMediaPlayer*/
package com.smp {
    //import flash.events.*;
    import flash.display.*;
    //import flash.net.*;
    import com.utils.AppUtil;

    public final class SImageLoader extends Sprite {

        public var ld:loadingUI;
        public var tw:Number;
        public var th:Number;
        public var tn:TN;

        public function SImageLoader(_arg1:TN):void{
            this.tn = _arg1;
            this.tw = Main.tr.image_width;
            this.th = Main.tr.image_height;
            this.ld = new loadingUI(Main.tr.colorBase, 6, 8);
            this.ld.x = (this.tw * 0.5);
            this.ld.y = (this.th * 0.5);
            addChild(this.ld);
            var _local2:String = ((this.tn.image) || (Config.image_handler));
            if (!_local2){
                this.init();
                return;
            };
            _local2 = AppUtil.auto(_local2, this.tn);
            _local2 = AppUtil.auto(_local2, Config);
            _local2 = Main.fU(_local2);
            new SLoader(_local2, this.loaded, true);
        }
        private function loaded(_arg1:LoaderInfo):void{
            if (_arg1){
                this.add(_arg1.loader);
            } else {
                this.init();
            };
        }
        public function init():void{
            Zip.GetSrc(Main.tr.image, this.done);
        }
        private function done(_arg1:LoaderInfo):void{
            if (_arg1){
                this.loaded(_arg1);
            } else {
                this.rld();
            };
        }
        public function add(_arg1:DisplayObject):void{
            this.rld();
            AppUtil.fit(_arg1, this.tw, this.th, Main.scalemode(this.tn));
            addChild(_arg1);
            SImage.cache[(this.tn.key + this.tn.image)] = _arg1;
        }
        private function rld():void{
            this.ld.e();
            removeChild(this.ld);
        }

    }
}
