package api
{

	import net.DataLoader;

	public class SData
	{
		private static var loader:DataLoader;
		private static var backFun:Function=TeachPlatForm.backFun;
		public function SData()
		{
		}
		public static function put(data:Object):void{
			loader=new DataLoader(data,backFun);
		}
	}
}

