/*SimpleMediaPlayer*/
package com.smp {
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;

    public final class O {

        private static var lc:LocalConnection = new LocalConnection();

        public static function o(... _args):void{
            var s:* = null;
            var rest:* = _args;
            var str:* = rest.join(", ");
            lc.addEventListener(StatusEvent.STATUS, function (_arg1:Event):void{
            });
            s = ((("(" + System.totalMemory) + " B) ") + str.toString());
            //trace(s);
            try {
                lc.send("_cenfun_lc", "cenfunTrace", s);
            } catch(e:Error) {
                s = s.substr(0, 10000);
                lc.send("_cenfun_lc", "cenfunTrace", (s + "\n ... ..."));
            };
        }

    }
}
