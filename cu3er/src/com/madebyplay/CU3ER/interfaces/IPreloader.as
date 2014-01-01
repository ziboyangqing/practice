package com.madebyplay.CU3ER.interfaces 
{
    public interface IPreloader
    {
        function show():void;

        function hide():void;

        function updatePercent(arg1:Number):void;

        function destroy():void;

        function reset():void;

        function isHidden():Boolean;

        function getHideTime():Number;

        function getPercent():Number;
    }
}
