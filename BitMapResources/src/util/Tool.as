package util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;

	/**
	 * @ 模块功能：资源反射类
	 */
	public class Tool
	{
		public function Tool()
		{
		}

		public static function getClass(name:String):Class
		{
			if(ApplicationDomain.currentDomain.hasDefinition(name))
			{
				return ApplicationDomain.currentDomain.getDefinition(name) as Class;
			}
			trace("当前安全域不存在"+ name +"的反射");
			return null;
		}

		/**
		 * 创建位图数据
		 * @param name
		 * @return
		 *
		 */		
		public static function createBmd(name:String):BitmapData
		{
			var bmdClass:Class = getClass(name);
			if(bmdClass)
			{
				return new bmdClass(0 , 0);
			}
			return null;
		}
		/**
		 *
		 * @param name calss name
		 * @return  BitmapData
		 *
		 */		
		public static function getBmd(name:String):BitmapData
		{
			var bmdClass:Class = getClass(name);
			if(bmdClass)
			{
				return new bmdClass(0,0);
			}
			return null;
		}
		/**
		 * 从资源中提取(创建)一个位图
		 * @param name	资源名称
		 * @return
		 */
		public static function createBmp(name:String):Bitmap
		{
			var bmd:BitmapData = createBmd(name);
			if (bmd)
			{
				return new Bitmap(createBmd(name));
			}
			else
			{
				return null;
			}
		}

		/**
		 * 创建MovieClip对象
		 * @param name
		 * @return
		 *
		 */		
		public static function createMovieClip(name:String):MovieClip
		{
			var mcClass:Class = getClass(name);
			return (new mcClass() as MovieClip);
		}

		/**
		 * 创建Sprite对象
		 * @return
		 *
		 */		
		public static function createSp(name:String):Sprite
		{
			var spClass:Class = getClass(name);
			return (new spClass() as Sprite);
		}
		/**
		 *
		 * @param bmd
		 * @param xdimension 横向分割数
		 * @param ydimension 纵向分割数
		 * @return bmd数组
		 * 走向：Z
		 */		
		public static function SplitBMD(bmd:BitmapData, xdimension:int=1, ydimension:int=1):Array{
			var bmdY:BitmapData;
			var i:int;
			var bmdX:BitmapData;
			var result:Array = [];
			var w:int = bmd.width;
			var h:int = bmd.height;
			var xsize:int = int((w / xdimension));
			var ysize:int = int((h / ydimension));
			var j:int;
			while (j < ydimension) {
				bmdY = new BitmapData(w, ysize, true, 0);
				bmdY.copyPixels(bmd, new Rectangle(0, (ysize * j), w, ysize), new Point(0, 0));
				i = 0;
				while (i < xdimension) {
					bmdX = new BitmapData(xsize, ysize, true, 0);
					bmdX.copyPixels(bmdY, new Rectangle((xsize * i), 0, xsize, ysize), new Point(0, 0));
					result.push(bmdX);
					i++;
				};
				bmdY.dispose();
				j++;
			};
			bmd.dispose();
			return (result);
		}
	}
}

