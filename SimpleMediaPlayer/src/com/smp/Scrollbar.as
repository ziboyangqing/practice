/*SimpleMediaPlayer*/
package com.smp {
    //import flash.utils.*;
    //import flash.events.*;
    import flash.display.*;
    import com.ui.*;

    public final class Scrollbar {

        private var bw:Number;
        private var bh:Number;
        private var sb:BaseScrollPanel;
        private var xl:XMLList;

        public function Scrollbar(_arg1:BaseScrollPanel, _arg2:XMLList):void{
            this.sb = _arg1;
            this.xl = _arg2;
            Zip.GetSrc(this.xl.@thumb_src, this.thumbComplete);
        }
        public static function ss(_arg1:BaseScrollPanel, _arg2:XMLList):void{
            new Scrollbar(_arg1, _arg2);
        }

        private function thumbComplete(_arg1:LoaderInfo):void{
            var _local3:Array;
            var _local4:SBitMap;
            var _local5:SBitMap;
            var _local6:SBitMap;
            this.sb.clearStyle("thumbUpSkin");
            this.sb.clearStyle("thumbOverSkin");
            this.sb.clearStyle("thumbDownSkin");
            var _local2:BitmapData = Zip.GetBMD(_arg1);
            if (_local2){
                _local3 = Zip.SplitBMD(_local2, 3, 1);
                _local4 = new SBitMap(_local3[0]);
                _local5 = new SBitMap(_local3[1]);
                _local6 = new SBitMap(_local3[2]);
                this.sb.setStyle("thumbUpSkin", _local4);
                this.sb.setStyle("thumbOverSkin", _local5);
                this.sb.setStyle("thumbDownSkin", _local6);
                this.bw = _local4.width;
            };
            this.thumbDone();
        }
        private function thumbDone():void{
            Zip.GetSrc(this.xl.@button_src, this.buttonComplete);
        }
        private function buttonComplete(_arg1:LoaderInfo):void{
            var _local3:Array;
            var _local4:Bitmap;
            var _local5:Bitmap;
            var _local6:Bitmap;
            var _local7:Bitmap;
            var _local8:Bitmap;
            var _local9:Bitmap;
            this.sb.clearStyle("upArrowUpSkin");
            this.sb.clearStyle("upArrowOverSkin");
            this.sb.clearStyle("upArrowDownSkin");
            this.sb.clearStyle("downArrowUpSkin");
            this.sb.clearStyle("downArrowOverSkin");
            this.sb.clearStyle("downArrowDownSkin");
            this.bh = 0;
            var _local2:BitmapData = Zip.GetBMD(_arg1);
            if (_local2){
                _local3 = Zip.SplitBMD(_local2, 3, 2);
                _local4 = new Bitmap(_local3[0]);
                _local5 = new Bitmap(_local3[1]);
                _local6 = new Bitmap(_local3[2]);
                _local7 = new Bitmap(_local3[3]);
                _local8 = new Bitmap(_local3[4]);
                _local9 = new Bitmap(_local3[5]);
                this.sb.setStyle("upArrowUpSkin", _local4);
                this.sb.setStyle("upArrowOverSkin", _local5);
                this.sb.setStyle("upArrowDownSkin", _local6);
                this.sb.setStyle("downArrowUpSkin", _local7);
                this.sb.setStyle("downArrowOverSkin", _local8);
                this.sb.setStyle("downArrowDownSkin", _local9);
                this.bh = _local4.height;
                if (isNaN(this.bw)){
                    this.bw = _local4.width;
                };
            };
            this.buttonDone();
        }
        private function buttonDone():void{
            Zip.GetSrc(this.xl.@track_src, this.trackComplete);
        }
        private function trackComplete(_arg1:LoaderInfo):void{
            var _local3:SBitMap;
            var _local4:SBitMap;
            var _local5:SBitMap;
            this.sb.clearStyle("trackUpSkin");
            this.sb.clearStyle("trackOverSkin");
            this.sb.clearStyle("trackDownSkin");
            var _local2:BitmapData = Zip.GetBMD(_arg1);
            if (_local2){
                _local3 = new SBitMap(_local2);
                _local4 = new SBitMap(_local2.clone());
                _local5 = new SBitMap(_local2.clone());
                this.sb.setStyle("trackUpSkin", _local3);
                this.sb.setStyle("trackOverSkin", _local4);
                this.sb.setStyle("trackDownSkin", _local5);
                if (isNaN(this.bw)){
                    this.bw = _local3.width;
                };
            };
            this.trackDone();
        }
        private function trackDone():void{
            this.sb.updateSize(this.bw, this.bh);
            Zip.GetSrc(this.xl.@thumb_icon, this.iconComplete);
        }
        private function iconComplete(_arg1:LoaderInfo):void{
            this.sb.clearStyle("thumbIcon");
            if (_arg1){
                this.sb.setStyle("thumbIcon", _arg1.loader);
            };
        }

    }
}
