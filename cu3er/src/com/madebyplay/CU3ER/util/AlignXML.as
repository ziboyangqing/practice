package com.madebyplay.CU3ER.util 
{
    import com.madebyplay.CU3ER.model.*;
    import flash.display.*;
    import flash.geom.*;
    
    public class AlignXML extends Object
    {
        public function AlignXML()
        {
            super();
            return;
        }

        public static function align(arg1:flash.display.DisplayObject, arg2:XML, arg3:Number=-1, arg4:Number=-1):void
        {
            var loc1:*="TL";
            var loc2:*=arg1.width;
            var loc3:*=arg1.height;
            if (String(arg2.@width) != "") 
            {
                loc2 = Number(arg2.@width);
            }
            if (String(arg2.@height) != "") 
            {
                loc3 = Number(arg2.@height);
            }
            if (arg3 != -1) 
            {
                loc2 = arg3;
            }
            if (arg4 != -1) 
            {
                loc3 = arg4;
            }
            if (String(arg2.@align_pos) != "") 
            {
                loc1 = String(arg2.@align_pos);
            }
            if (String(arg2.@align_to) != "stage") 
            {
                com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.addItem(arg1, loc1, arg2.@x, arg2.@y, loc2, loc3);
            }
            else 
            {
                com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.addItem(arg1, loc1, arg2.@x, arg2.@y, loc2, loc3);
            }
            return;
        }

        public static function getItemPos(arg1:flash.display.DisplayObject, arg2:XML, arg3:Number=NaN, arg4:Number=NaN):flash.geom.Point
        {
            if (String(arg2.@align_to) == "stage") 
            {
                return com.madebyplay.CU3ER.model.GlobalVars.ALIGN_STAGE.getItemPos(arg1, arg3, arg4);
            }
            return com.madebyplay.CU3ER.model.GlobalVars.ALIGN_SLIDE.getItemPos(arg1, arg3, arg4);
        }
    }
}
