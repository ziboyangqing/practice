/*SimpleMediaPlayer*/
package interfaces {

    public interface IPlane {

        function set display(_arg1:String):void;
        function get display():String;
        function set src(_arg1:String):void;
        function get src():String;
        function set xywh(_arg1:String):void;
        function get xywh():String;
        function ss(_arg1:XMLList, _arg2:int, _arg3:int):void;
        function ll(_arg1:int, _arg2:int):void;
        function lo():void;

    }
}
