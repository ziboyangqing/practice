package stext {
	import conf.Config;

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class SmartText extends Sprite {
		private var tf:TextField  =new TextField();
		private var tft:TextFormat=new TextFormat(Config.FONT, Config.FONTSIZE);
		private var tw:int=100;
		private var th:int=30;

		public function SmartText(w:int=300,h:int=30,type:String="D") {
			tw=w;
			th=h;
			switch (type) {
			case "D":  {
				tf.type=TextFieldType.DYNAMIC;
				tf.border=true;
				break;
			}
			case "I":  {
				tf.type=TextFieldType.INPUT;
			}
			default:  {
				break;
			}
			}
			addChild(tf);
			fit();
		}

		private function fit():void
		{
			tf.x=tf.y=0;
			tf.defaultTextFormat=tft;
			tf.width=(tf.textWidth>tw)?tf.textWidth:tw;
			tf.height=(tf.textHeight>th)?tf.textHeight:th;
		}
		public function set text(text:String):void{
			tf.text=text;
			fit();
		}
		public function get text():String{
			return tf.text;
		}
	}
}

