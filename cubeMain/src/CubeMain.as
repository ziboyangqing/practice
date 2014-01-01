package {
    import com.milkmidi.display.BaseMC;
    import com.milkmidi.display.FPS;//性能监视器
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.geom.Matrix;
    
    import caurina.transitions.Tweener;
    
    import myevents.MyEvent;
	[SWF(width="1000",height="600",backgroundColor="0x000000")]
    public class CubeMain extends BaseMC {

        private var bitmap:Bitmap;
        private var bmp:BitmapData;
        private var world:CubeMain3DWorld;
        public var mask_mc:MovieClip;
        private var _matrix:Matrix;

        public function CubeMain(){
			mask_mc=new maskMc();//渐变，倒影效果
            bitmap = new Bitmap();//快照
            _matrix = new Matrix();
            super();
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.showDefaultContextMenu = false;
            this.addChild(new FPS(0, 0));
        }
        /*public function Outro(_arg1:int):void{
            if (world){
                world.outroAnimation(_arg1);
            };
        }*/
        override protected function onRemoveFromStage(_arg1:Event=null):void{
            super.onRemoveFromStage(_arg1);
            this.removeEventListener(Event.ENTER_FRAME, onEventEnterFrame);
        }
        private function onIntroAnimationComplete(_arg1:Event):void{
            bitmap.alpha = 0;
            Tweener.addTween(bitmap, {
                alpha:1,
                time:0.8
            });
            this.addChild(bitmap);
            world.render = true;
            this.addEventListener(Event.ENTER_FRAME, onEventEnterFrame);
            onEventEnterFrame();
            world.render = false;
        }
        public function Display():void{
            trace((super.toString() + " .Display()"));
            this.addChild(world);
            if (world){
                world.startAnimation();
            };
            onStageResize();
        }
        override protected function onAdd2Stage(_arg1:Event=null):void{
            super.onAdd2Stage(_arg1);
        }
        public function SetFocus(_arg1:int):void{
            world.setFace(_arg1);
        }
        private function onOutroAnimationStart(_arg1:MyEvent):void{
            Tweener.addTween(bitmap, {
                alpha:0,
                time:0.8
            });
            this.removeEventListener(Event.ENTER_FRAME, onEventEnterFrame);
        }
        override protected function onLoaderInfoInit(_arg1:Event):void{
            super.onLoaderInfoInit(_arg1);
            world = new CubeMain3DWorld();
            world.addEventListener(MyEvent.INTRO_COMPLETE, onIntroAnimationComplete);
            world.addEventListener(MyEvent.OUTRO_START, onOutroAnimationStart);
            world.addEventListener(MyEvent.OUTRO_COMPLETE, onOutroAnimationComplete);
            bitmap.scaleY = -1;//镜像效果
            bitmap.cacheAsBitmap = true;
            bitmap.mask = mask_mc;//400*400
            Display();
        }
        private function onOutroAnimationComplete(_arg1:MyEvent):void{
        }
        private function onEventEnterFrame(_arg1:Event=null):void{
            if (!world.render){
                return;
            };
            if (bmp){
                bmp.dispose();
            };
            bmp = new BitmapData(400, 400, true, 0);//快照内容
            bmp.draw(this, _matrix);
            bitmap.bitmapData = bmp;
        }
        public function Destroy():void{
            world.removeEventListener(MyEvent.INTRO_COMPLETE, onIntroAnimationComplete);
            world.removeEventListener(MyEvent.OUTRO_START, onOutroAnimationStart);
            world.removeEventListener(MyEvent.OUTRO_COMPLETE, onOutroAnimationComplete);
            world.destroy();
            super.destroy();
        }
        override protected function onStageResize(_arg1:Event=null):void{
            super.onStageResize(_arg1);
            _matrix.identity();
            bitmap.x = stage.stageWidth / 2 - 200;//水平居中
            mask_mc.x = bitmap.x;
            mask_mc.y =stage.stageHeight / 2-400;
            bitmap.y = mask_mc.y + 450;
            _matrix.translate(-stage.stageWidth / 2 + 200, -stage.stageHeight / 2 +200);
        }

    }
}