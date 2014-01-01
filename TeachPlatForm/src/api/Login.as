package api
{
	import conf.Config;

	import net.DataLoader;

	import vo.UserVO;
	/**
	 *
	 * @author Administrator
	 *  Login.enter("admin1","123456");
	 *  Login.reg("admin1","123456");
	 *  Login.leave(3);
	 */	
	public class Login
	{
		private static var loader:DataLoader;
		private static  var backFun:Function=TeachPlatForm.backFun; 
		public function Login()
		{
		}
		public static  function reg(usr:String,pwd:String):void
		{
			var r:UserVO=new UserVO(usr,pwd,Config.REG);
			loader=new DataLoader(r.value,backFun);
		}
		public static  function enter(usr:String,pwd:String):void
		{
			var e:UserVO=new UserVO(usr,pwd,Config.LOGIN);
			loader=new DataLoader(e.value,backFun);
		}
		public static  function leave(uid:int):void
		{
			var l:UserVO=new UserVO("","",Config.LOGOUT,uid);
			loader=new DataLoader(l.value,backFun);
		}
	}
}

