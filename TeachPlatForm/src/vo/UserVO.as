package vo
{
	public class UserVO extends Object
	{
		public var value:Object;

		public function UserVO(username:String="",password:String="",action:String="",uid:int=0,cid:int=0,stype:String="",sdata:String="")
		{
			value={
					"username":username,
					"password":password,
					"action":action,
					"uid":uid,
					"cid":cid,
					"stype":stype,
					"sdata":sdata
			}
		}
	}
}

