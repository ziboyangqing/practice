package draw {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import conf.Config;

	[Event(name="DataReady", type="flash.events.Event")]
	public class Canvas extends Sprite {
		private static var canvas:Bitmap;
		private static var layer:Sprite;
		private static var bmd:BitmapData;
		private var _erazerMode:Boolean=false;
		private var thick:Number       =3;
		private var lineColor:String    ="0xffff00";
		private var fillColor:String     ="0x006699";
		private var _dataMode:Boolean  =true;
		private var _data:Object       ={};
		private var _type:String       ="free";
		private var _smode:String="normal";
		private var _dataArray:Array   =[];
		private var tmpArray:Array=[];
		private var putTimer:Timer;
		private var _width:Number=0;
		private var _height:Number=0;

		public function Canvas(width:Number=800, height:Number=600) {
			_width=width;
			_height=height;
			bmd=new BitmapData(_width, _height, true, 0x00ffffff);
			canvas=new Bitmap(bmd,"auto",true);
			layer=new Sprite();
			addChild(canvas);
			addChild(layer);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			putTimer=new Timer(Config.PUTINTERVAL,1);
			putTimer.addEventListener(TimerEvent.TIMER_COMPLETE,putData);
		}

		protected function putData(event:TimerEvent):void
		{
			if (_dataMode&&_dataArray.length) {
				_data={
						"action":"put",
						"sdata":"{\"stype\":\""+_type+ "\",\"smode\":\""+smode+ "\",\"linecolor\":\""+lineColor+"\",\"thick\":\""+thick+"\",\"fillcolor\":\""+fillColor+"\",\"cordinates\":[" + _dataArray.join(",") + "]"+"}", 
						"uid": TeachPlatForm.uid, 
						"cid": TeachPlatForm.cid
						
				}
				dispatchEvent(new Event("DataReady"));
			}

		}

		private function mouseDown(e:MouseEvent=null):void {
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			if(putTimer.running){
				putTimer.stop();
				putTimer.reset();
			}else{
				_dataArray=[];
			}
			tmpArray=[];
			_data={};
			if (erazerMode) {
				layer.graphics.lineStyle(5, 0xffffff);
			} else {
				layer.graphics.lineStyle(thick, uint(lineColor));
			}
			layer.graphics.moveTo(mouseX, mouseY);
			addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		private function mouseMove(e:MouseEvent=null):void {
			drawing(mouseX, mouseY);
			tmpArray.push("[" + mouseX + "," + mouseY + "]");
		}

		private function drawing(x:Number, y:Number):void {
			//trace(x, y);
			layer.graphics.lineTo(x, y);
		}

		private function mouseUp(e:MouseEvent=null):void {
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			if (erazerMode) {
				bmd.draw(layer, null, null, BlendMode.ERASE);
			} else {
				bmd.draw(layer, null, null, BlendMode.NORMAL);
			}
			layer.graphics.clear();
			if(tmpArray.length){
				putTimer.start();
				_dataArray.push("["+tmpArray.join(",")+"]");
			}
			

		}
		public static function draw(data:Object):void{
			layer.graphics.lineStyle(parseInt(data.thick),uint(data.linecolor));
			var p:Array=data.cordinates;
			for (var i:int = 0; i < p.length; i++) 
			{
				var t:Array=p[i];
				layer.graphics.moveTo(t[0][0]+15,t[0][1]);
				for(var j:int=1;j<t.length;j++){
					layer.graphics.lineTo(t[j][0]+15,t[j][1]);
				}
				
			}
			if (data.smode=="erease") {
				bmd.draw(layer, null, null, BlendMode.ERASE);
			} else {
				bmd.draw(layer, null, null, BlendMode.NORMAL);
			}
			layer.graphics.clear();
		}
		public function get erazerMode():Boolean {
			return _erazerMode;
		}

		public function set erazerMode(value:Boolean):void {
			_erazerMode=value;
		}

		public function get data():Object {
			return _data;
		}

		public function set data(value:Object):void {
			_data=value;
		}

		public function get type():String {
			return _type;
		}

		public function set type(value:String):void {
			_type=value;
		}

		public function get dataArray():Array {
			return _dataArray;
		}

		public function set dataArray(value:Array):void {
			_dataArray=value;
		}

		public function get dataMode():Boolean
		{
			return _dataMode;
		}

		public function set dataMode(value:Boolean):void
		{
			_dataMode = value;
		}

		public function get smode():String
		{
			return _smode;
		}

		public function set smode(value:String):void
		{
			_smode = value;
		}


		public function clear():void
		{
			bmd.dispose();
			bmd=new BitmapData(_width, _height, true, 0x00ffffff);
			canvas.bitmapData=bmd;
		}
	}
}

