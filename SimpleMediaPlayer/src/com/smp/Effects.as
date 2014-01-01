/*SimpleMediaPlayer*/
package com.smp {
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;

    public final class Effects {

        public static var d:Dictionary = new Dictionary(false);

        public static function e(_arg1:DisplayObject):void{
            if (d[_arg1]){
                d[_arg1].stop();
                delete d[_arg1];
            };
        }
        public static function f(_arg1:DisplayObject):void{
            var alpha:* = NaN;
            var obj:* = _arg1;
            e(obj);
            alpha = obj.alpha;
            var option:* = {
                target:obj,
                from:alpha,
                till:0,
                step:function (_arg1:Number):void{
                    obj.alpha = _arg1;
                },
                complete:function ():void{
                    obj.visible = false;
                    obj.alpha = alpha;
                    delete d[obj];
                }
            };
            d[obj] = new Animation(option);
        }
        public static function m(_arg1:DisplayObject, _arg2:String, _arg3:Number, _arg4:Number):void{
            var obj:* = _arg1;
            var attr:* = _arg2;
            var endv:* = _arg3;
            var max:* = _arg4;
            e(obj);
            var l:* = (endv - obj[attr]);
            var a:* = Math.abs(l);
            if ((((a > max)) || ((a < 3)))){
                obj[attr] = endv;
                return;
            };
            var option:* = {
                target:obj,
                from:obj[attr],
                till:endv,
                step:function (_arg1:Number):void{
                    obj[attr] = _arg1;
                },
                complete:function ():void{
                    delete d[obj];
                }
            };
            d[obj] = new Animation(option);
        }

    }
}
