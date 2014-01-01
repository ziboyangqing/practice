package milkmidi.utils {
    import flash.system.*;
    import flash.net.*;

    public class SystemUtil {

        public static function totalMemory():uint{
            return ((System.totalMemory / 0x0400));
        }
        public static function clearMemory():void{
            trace((("memory currently in use:" + SystemUtil.totalMemory()) + " kb"));
            try {
                new LocalConnection().connect("foo");
                new LocalConnection().connect("foo");
            } catch(e) {
            };
            System.gc();
            trace("SystemUtil.clearMemory()");
            trace((("memory from cleared    :" + SystemUtil.totalMemory()) + " kb"));
        }

    }
} 
