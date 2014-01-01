/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    //import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import com.skin.iconBullet;
    import com.skin.iconClosed;
    import com.skin.iconOpened;

    public class IC extends Sprite {

        private static var bullet:BitmapData;
        private static var opened:BitmapData;
        private static var closed:BitmapData;
        private static var playing:DisplayObject;
        private static var xl:XMLList;

        public var tn:TN;
        private var td:Number = -1;

        public function IC(_arg1:TN):void{
            this.tn = _arg1;
            Main.addEventListener(SMPEvent.MODEL_STATE, this.status);
            this.status();
        }
        public static function ss(_arg1:XMLList):void{
            xl = _arg1;
            bullet = null;
            opened = null;
            closed = null;
            playing = null;
            if (xl){
                bulletLoad();
            };
        }
        private static function bulletLoad():void{
            Zip.GetSrc(xl.@bullet, bulletComplete);
        }
        private static function bulletComplete(_arg1:LoaderInfo):void{
            bullet = Zip.GetBMD(_arg1);
            openedLoad();
        }
        private static function openedLoad():void{
            Zip.GetSrc(xl.@opened, openedComplete);
        }
        private static function openedComplete(_arg1:LoaderInfo):void{
            opened = Zip.GetBMD(_arg1);
            closedLoad();
        }
        private static function closedLoad():void{
            Zip.GetSrc(xl.@closed, closedComplete);
        }
        private static function closedComplete(_arg1:LoaderInfo):void{
            closed = Zip.GetBMD(_arg1);
            playingLoad();
        }
        private static function playingLoad():void{
            Zip.GetSrc(xl.@playing, playingComplete);
        }
        private static function playingComplete(_arg1:LoaderInfo):void{
            if (_arg1){
                playing = _arg1.loader;
            };
            finish();
        }
        private static function finish():void{
            Main.sendEvent(UIEvent.ICONS_LOADED);
        }

        public function status(_arg1:SMPEvent=null):void{
            var _local2:Boolean;
            var _local3:Boolean;
            var _local4:Boolean;
            var _local5:DisplayObject;
            if (((_arg1) && (!(parent)))){
                this.remove();
                return;
            };
            if (Config.state == SMPStates.PLAYING){
                _local2 = true;
            };
            if (Main.item == this.tn){
                _local3 = true;
            };
            if (((((_local2) && (_local3))) && (playing))){
                _local5 = playing;
                _local4 = true;
            } else {
                if (this.tn.node_type == CS.NODE_LIST){
                    if (this.tn.opened){
                        if (opened){
                            _local5 = new Bitmap(opened);
                            _local4 = true;
                        } else {
                            _local5 = new iconOpened();
                        };
                    } else {
                        if (closed){
                            _local5 = new Bitmap(closed);
                            _local4 = true;
                        } else {
                            _local5 = new iconClosed();
                        };
                    };
                } else {
                    if (bullet){
                        _local5 = new Bitmap(bullet);
                        _local4 = true;
                    } else {
                        _local5 = new iconBullet();
                    };
                };
            };
            if (_local5){
                Main.clear(this);
                addChild(_local5);
            };
            var _local6:ColorTransform = new ColorTransform();
            if (!_local4){
                _local6.color = (_local3) ? Main.tr.colorUpon : Main.tr.colorBase;
            };
            transform.colorTransform = _local6;
            removeEventListener(Event.ENTER_FRAME, this.d_ing);
            if (((((_local2) && (_local3))) && (!(playing)))){
                addEventListener(Event.ENTER_FRAME, this.d_ing);
            };
        }
        public function remove():void{
            removeEventListener(Event.ENTER_FRAME, this.d_ing);
            Main.clear(this);
            Main.removeEventListener(SMPEvent.MODEL_STATE, this.status);
        }
        private function d_ing(_arg1:Event):void{
            if (alpha <= 0.2){
                this.td = 1;
            } else {
                if (alpha >= 1){
                    this.td = -1;
                };
            };
            alpha = (alpha + (this.td * 0.02));
        }

    }
}
