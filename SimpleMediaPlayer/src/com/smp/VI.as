/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.SMPEvent;
    import com.smp.events.SMPStates;
    
    import flash.display.Bitmap;
    import flash.display.Graphics;
    import flash.display.Sprite;

    public final class VI extends Sprite {

        public var ip:Sprite;
        public var ld:loadingUI;
        public var ib:Sprite;
        public var ic:Number = 0xFFFFFF;
        public var ia:Number = 0.6;
        public var mv:MediaView;
		[Embed(source="../../../assets/bpm.png")]
		private var logo:Class;
		private var lg:Bitmap;
        public function VI(_arg1:MediaView):void{
            this.ip = new Sprite();
            this.ib = new Sprite();
			//lg=new logo();
			//lg.visible=false;
			
            super();
            this.mv = _arg1;
            mouseEnabled = false;
            mouseChildren = false;
            var _local2:Graphics = this.ip.graphics;
            _local2.beginFill(0, this.ia);
            _local2.drawRoundRect(-25, -25, 50, 50, 10);
            _local2.endFill();
            _local2.beginFill(this.ic, this.ia);
            _local2.moveTo(-10, 12);
            _local2.lineTo(-10, -12);
            _local2.lineTo(12, 0);
            _local2.endFill();
            this.ip.visible = false;
			addChild(this.ip);
            var _local3:Graphics = this.ib.graphics;
            _local3.beginFill(0, this.ia);
            _local3.drawRoundRect(-25, -25, 50, 50, 10);
            _local3.endFill();
            this.ld = new loadingUI(this.ic, 10, 12);
            this.ld.alpha = this.ia;
            this.ib.addChild(this.ld);
            this.ib.visible = false;
            addChild(this.ib);
			//ib.addChild(lg);
			Main.addEventListener(SMPEvent.VIDEO_RESIZE, this.ll);
            Main.addEventListener(SMPEvent.MODEL_STATE, this.cc);
            this.cc();
            this.ll();
        }
        private function cc(_arg1:SMPEvent=null):void{
            if (!this.mv.show_icon){
                if (this.ip.visible){
                    this.ip.visible = false;
                };
                return;
            };
			//暂停状态指示
            if (Config.state == SMPStates.PAUSED){
               //this.ip.visible = true;
				//lg.visible=true;
            } else {
                this.ip.visible = false;
				//lg.visible=false;
            };
            if (Config.state == SMPStates.CONNECTING){
                Config.buffer_percent = 0;
                this.si();
            } else {
                if (Config.state == SMPStates.BUFFERING){
                    this.si();
                } else {
                    this.hi();
                };
            };
        }
        private function si():void{
            var _local1:String = "";
            if (Config.buffer_percent){
                _local1 = String(Config.buffer_percent);
            };
            this.ld.s(_local1);
            if (!this.ib.visible){
                this.ib.visible = true;
                this.ld.g();
            };
        }
        private function hi():void{
            if (this.ib.visible){
                this.ld.e();
                this.ib.visible = false;
            };
        }
        private function ll(_arg1:SMPEvent=null):void{
            x = (Config.video_width * 0.5);
            y = (Config.video_height * 0.5);
            if ((((Config.video_width < width)) || ((Config.video_height < height)))){
                visible = false;
            } else {
                visible = true;
            };
        }

    }
}
