package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;

	public class SoundID3 extends Sprite
	{
		private var snd:Sound;
		private var context:SoundLoaderContext;

		private var surl:String="";
		private var _length:Number;
		private var container:Sprite;
		private var reader:ID3Reader;
		private var imgBitmap:BitmapData;
		private var imgLoader:Loader=new Loader();
		private var bmp:Bitmap;
		public function SoundID3(){
			//surl="http://flashas.heroedu.cn/mp3/baihu.mp3";
			surl="Water_And_A_Flame.mp3";
			//surl="ru.mp3";
			loadMP3(surl);
		}

		private function loadMP3(file:String):void
		{
			reader=new ID3Reader(file);
			reader.addEventListener(Event.ID3,onID3Loaded);

		}

		private function onID3Loaded(event:Event):void
		{
			imgLoader=new Loader();
			imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			imgLoader.loadBytes(reader.APIC);
		}

		private function onImageLoaded(event:Event):void
		{
			imgBitmap=new BitmapData(imgLoader.width, imgLoader.height, false, 0x000000);
			imgBitmap.draw(imgLoader, new Matrix);
			bmp=new Bitmap(imgBitmap);
			//bmp.width = 75;
			//bmp.height = 75;
			addChild(bmp);
		}
	}
}


