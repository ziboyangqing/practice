package component.controls
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class ZMovieClip extends Sprite
	{
		private var up:Sprite;
		private var over:Sprite;
		private var down:Sprite;
		private var smooth:Boolean=true;
		private var positions:Array=["up","over","down"];
		public function ZMovieClip(bmdArray:Array,start:int=0)
		{
			up=new Sprite();
			up.name="up";
			over=new Sprite();
			over.name="over";
			down=new Sprite();
			down.name="down";
			up.addChild(new Bitmap(bmdArray[start],"auto",smooth));
			over.addChild(new Bitmap(bmdArray[start+1],"auto",smooth));
			down.addChild(new Bitmap(bmdArray[start+2],"auto",smooth));
			addChild(down);
			addChild(over);
			addChild(up);
			mouseChildren=false;
		}
		public function goto(pos:String):void{
			for(var i:int=0;i< positions.length;i++){
				var target:Sprite=getChildByName(positions[i]) as Sprite;
				if (positions[i]==pos){
					target.visible=true;
				}else{
					target.visible=false;
				}
			}
		}
	}
}

