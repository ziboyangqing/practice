package
{
	import flash.display.Sprite;
	import flash.net.LocalConnection;
	import flash.system.Security;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	[SWF(width="600",height="600",backgroundColor="#000000",frameRate="30")]
	/**
	 *debug console
	 * @author Administrator
	 *
	 */	
	public class AS3Debugger extends Sprite
	{
		private var info:TextField;
		private var conn:LocalConnection;
		private var connstr:String="_debugConnectionStr";
		private var tf:TextFormat;
		public function AS3Debugger()
		{
			info=new TextField();
			info.multiline=true;
			info.border=true;
			info.width=600;
			info.height=600;
			info.type=TextFieldType.DYNAMIC;
			addChild(info);
			conn=new LocalConnection();
			conn.client=this;
			Security.allowDomain("*");
			conn.connect(connstr);
		}
		public function transMsg(txt:String,id:String):void
		{
			info.htmlText+=id+":"+txt+"\n";
		}

	}
}

