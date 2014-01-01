package
{
	
	import com.smp.Data;
	import com.utils.AppUtil;
	
	import flash.display.Sprite;
	
	
	public class Demo extends Sprite
	{
		public function Demo()
		{
			trace(AppUtil.ut,AppUtil.uc);
			var hero:String=AppUtil.e64("http://flashas.heroedu.cn/");
			trace(hero,AppUtil.d64(hero));
			trace(Data.vd);
		}
	}
}