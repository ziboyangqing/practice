package  {
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import com.smp.loadingUI;
	import com.smp.Main;
	[SWF(width="580",height="380",backgroundColor="#000000")]
	public final class SimpleMediaPlayer extends MovieClip {

		private var i:LoaderInfo;
		private var ld:loadingUI;

		public function SimpleMediaPlayer():void{
			addEventListener(Event.ADDED_TO_STAGE, this.initStage, false, 0, true);
		}
		//初始化
		private function initStage(_arg1:Event=null):void{
			removeEventListener(Event.ADDED_TO_STAGE, this.initStage);
			stage.align = "TL";
			stage.scaleMode = "noScale";
			this.i = root.loaderInfo;
			//加载完毕
			if (this.i.bytesLoaded == this.i.bytesTotal){
				trace("MainLoadCom");
			};
			//进度指示
			this.ld = new loadingUI();
			addChild(this.ld);
			//加载进度监听
			this.i.addEventListener(ProgressEvent.PROGRESS, this.handlePreload, false, 0, true);
			this.i.addEventListener(Event.COMPLETE, this.preloadComplete, false, 0, true);
		}
		//处理加载进度
		private function handlePreload(_arg1:ProgressEvent):void{
			var _local2 :String= "";
			if (_arg1.bytesTotal){
				_local2 = Math.round(((_arg1.bytesLoaded / _arg1.bytesTotal) * 100)).toString();
			};
			//显示数字
			this.ld.s(_local2);
			this.ld.x = (stage.stageWidth * 0.5);
			this.ld.y = (stage.stageHeight * 0.5);
		}
		private function preloadComplete(_arg1:Event):void{
			//卸载进度指示器中的侦听
			this.ld.e();
			removeChild(this.ld);
			addChild(new Main());
		}
	}
} 


