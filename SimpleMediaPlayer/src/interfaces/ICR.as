/*SimpleMediaPlayer*/
package interfaces {
	import com.ui.LSD;

    public interface ICR {

        function set y(_arg1:Number):void;
        function set x(_arg1:Number):void;
        function setSize(_arg1:Number, _arg2:Number):void;
        function get lsd():LSD;
        function set lsd(_arg1:LSD):void;
        function get data():Object;
        function set data(_arg1:Object):void;
        function get selected():Boolean;
        function set selected(_arg1:Boolean):void;
        function setMouseState(_arg1:String):void;

    }
}
