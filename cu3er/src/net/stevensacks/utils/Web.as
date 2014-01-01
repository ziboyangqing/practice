package net.stevensacks.utils 
{
    import flash.net.*;
    
    public class Web extends Object
    {
        public function Web()
        {
            super();
            return;
        }

        public static function getURL(arg1:String, arg2:String=null):void
        {
            var url:String;
            var window:String=null;
            var req:flash.net.URLRequest;

            var loc1:*;
            url = arg1;
            window = arg2;
            req = new flash.net.URLRequest(url);
            try 
            {
                flash.net.navigateToURL(req, window);
            }
            catch (e:Error)
            {
            };
            return;
        }
    }
}
