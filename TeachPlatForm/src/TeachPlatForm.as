package
{
	import api.Login;
	import api.SData;

	import conf.Config;

	import draw.Canvas;

	import fl.controls.Button;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import net.DataLoader;


	[SWF(width="1000",height="600",frameRate="30",backgroundColor="#006699")]
	public class TeachPlatForm extends Sprite
	{
		private var obj:Object={"username":"admin",	"password":"123456",	"action":"login"};
		private var dtloader:DataLoader;
		public static var backFun:Function=handleData;
		public static var uid:int=0;
		public static var cid:int=0;
		private var sw:Number=10;
		private var sh:Number=10;
		private var canvas:Canvas;

		private var getTimer:Timer;
		private var dataInterval:int=0;

		private var clearBtn:Button;

		public function TeachPlatForm()
		{
			if(stage){
				init();
			}else{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}

		}
		/**
		 * 处理返回数据
		 *
		 * */
		public static function handleData(data:*,type:String=""):void{
			trace(data);
			data=JSON.parse(data);
			for (var o:* in data){
				trace("back",o,data[o]);
			}
			var s:*=data.sdata;
			if(s){
				s.linecolor='0xff6699';
				Canvas.draw(s);
			}


		}
		private function setTimer():void{
			getTimer=new Timer(Config.GETINTERVAL);
		}
		private function setListener():void{
			getTimer.addEventListener(TimerEvent.TIMER,getData);
			canvas.addEventListener("DataReady",handleCanvasData);
			stage.doubleClickEnabled=true;
			stage.addEventListener(MouseEvent.DOUBLE_CLICK,switchMode);
			stage.addEventListener(Event.RESIZE,resize);
			clearBtn.addEventListener(MouseEvent.CLICK,clearCanvas);
		}

		protected function clearCanvas(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			canvas.clear();
		}

		protected function resize(event:Event=null):void
		{
			canvas=new Canvas(stage.stageWidth,stage.stageHeight);
		}

		protected function getData(event:TimerEvent):void
		{
			// TODO Auto-generated method stub

		}

		protected function putData(event:TimerEvent):void
		{
			// TODO Auto-generated method stub

		}
		private function init(e:Event=null):void{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			sw=int(stage.stageWidth);
			sh=int(stage.stageHeight);
			canvas=new Canvas(sw,sh);
			addChild(canvas);
			clearBtn=new Button();
			clearBtn.label="CLEAR";
			addChild(clearBtn);
			setTimer();
			setListener();			
		}

		protected function handleCanvasData(event:Event):void
		{
			var c:Canvas=event.target as Canvas;
			for (var i:* in c.data)
			{
				//trace("send:",i,":",c.data[i]);
			}
			SData.put(c.data);
			trace("putting...",c.data.action);
		}

		protected function switchMode(event:MouseEvent):void
		{
			canvas.erazerMode=!canvas.erazerMode;
			trace(canvas.erazerMode);
		}

	}
}

