/*SimpleMediaPlayer*/
package com.smp {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.GradientType;
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.SpreadMethod;
    import flash.display.Sprite;
    import flash.filters.DropShadowFilter;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.describeType;
    import com.utils.AppUtil;

    public final class SGraphics {

        public static var sfl:Array = ["distance", "angle", "color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"];
        public static var gfl:Array = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];

        public static function getCenFunLogo(_arg1:Number, _arg2:Object=null):Shape{
            var _local3:Object;
            var _local4:Object;
            if (_arg2 != null){
                _local4 = _arg2;
                _local3 = _local4;
            } else {
                _local3 = 6272095;
                _local4 = 0x8800;
            };
            var _local5:Shape = new Shape();
            _local5.cacheAsBitmap = true;
            var _local6:Number = (_arg1 * 0.75);
            var _local7:Number = (_arg1 * 0.25);
            var _local8:Number = Math.atan(3);
            var _local9:Number = Math.atan(0.375);
            var _local10:Number = Math.atan(0.25);
            var _local11:Matrix = new Matrix();
            _local11.createGradientBox(_arg1, _local6, (Math.PI * 0.5), (-(_arg1) * 0.5), (-(_local6) * 0.5));
            var _local12:Graphics = _local5.graphics;
            _local12.beginGradientFill(GradientType.LINEAR, [_local3, _local4], [1, 1], [0, 0xFF], _local11, SpreadMethod.PAD);
            _local12.lineStyle(1, uint(_local4), 0.5);
            _local12.moveTo(_local7, 0);
            var _local13:Number = _local8;
            while (_local13 <= ((2 * Math.PI) - _local9)) {
                _local12.lineTo((_local7 + (Math.cos(-(_local13)) * _local7)), (Math.sin(-(_local13)) * _local7));
                _local13 = (_local13 + 0.1);
            };
            var _local14:Number = ((2 * Math.PI) - _local10);
            while (_local14 >= (_local10 - 0.1)) {
                _local12.lineTo(((Math.cos(-(_local14)) * _arg1) * 0.5), ((Math.sin(-(_local14)) * _local6) * 0.5));
                _local14 = (_local14 - 0.1);
            };
            _local12.lineTo(_local7, 0);
            _local12.endFill();
            return (_local5);
        }
        public static function getIconLink(_arg1:Object):Shape{
            var _local2:Shape;
            _local2 = new Shape();
            var _local3:Graphics = _local2.graphics;
            _local3.lineStyle(2, uint(_arg1));
            _local3.moveTo(2, 0);
            _local3.lineTo(9, 0);
            _local3.moveTo(-2, 0);
            _local3.lineTo(-9, 0);
            _local3.drawRect(-5, -3, 10, 6);
            _local2.rotation = -45;
            return (_local2);
        }
        public static function getIconEmbed(_arg1:Object):Shape{
            var _local2:Shape = new Shape();
            var _local3:Graphics = _local2.graphics;
            _local3.lineStyle(2, uint(_arg1));
            _local3.moveTo(1, -5);
            _local3.lineTo(-1, 5);
            _local3.moveTo(4, -4);
            _local3.lineTo(7, 0);
            _local3.lineTo(4, 4);
            _local3.moveTo(-4, -4);
            _local3.lineTo(-7, 0);
            _local3.lineTo(-4, 4);
            return (_local2);
        }
        public static function drawRect(_arg1:Sprite, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number=0, _arg7:Number=0):void{
            var _local8:Graphics = _arg1.graphics;
            _local8.clear();
            _local8.beginFill(_arg7, _arg6);
            _local8.drawRect(_arg2, _arg3, _arg4, _arg5);
            _local8.endFill();
        }
        public static function gtkl(_arg1:Number, _arg2:Number):Shape{
            var _local3:Shape = new Shape();
            var _local4:Graphics = _local3.graphics;
            _local4.beginFill(0, 0);
            _local4.drawRect(0, 0, _arg1, _arg2);
            _local4.endFill();
            _local4.beginFill(0xCCCCCC);
            _local4.drawRect(1, ((_arg2 * 0.5) - 1), (_arg1 - 2), 2);
            _local4.endFill();
            return (_local3);
        }
        public static function gSDTL(_arg1:Number, _arg2:Number):Array{
            return ([gtkl(_arg1, _arg2), new Shape(), gtkl(_arg1, _arg2)]);
        }
        public static function gSDB(_arg1:Number, _arg2:Number):Array{
            var _local3:Shape = gTB(_arg1, _arg2, 0xCCCCCC);
            var _local4:Shape = gTB(_arg1, _arg2, 0xFFFFFF);
            var _local5:Shape = gTB(_arg1, _arg2, 0xFFFFFF);
            var _local6:Shape = gTB(_arg1, _arg2, 0xFFFFFF);
            return ([_local3, _local4, _local5, _local6]);
        }
        private static function gTB(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number=1, _arg5:Number=3):Shape{
            var _local6:Shape = new Shape();
            var _local7:Graphics = _local6.graphics;
            _local7.beginFill(_arg3, _arg4);
            _local7.drawRoundRect(0, 0, _arg1, _arg2, _arg5);
            _local7.endFill();
            _local6.filters = [new GlowFilter(0, 0.5, 2, 2, 1, 3)];
            return (_local6);
        }
        public static function gSDT(_arg1:Number, _arg2:Number):Array{
            var _local3:Shape = gTK(_arg1, _arg2, 0, 0, _arg1, _arg2, 986895, 0x181818, 0x353535);
            var _local4:Shape = gTK(_arg1, _arg2, 1, 1, (_arg1 - 2), (_arg2 - 2), 0x999999);
            var _local5:Shape = gTK(_arg1, _arg2, 1, 1, (_arg1 - 2), (_arg2 - 2), 0xCCCCCC);
            return ([_local3, _local4, _local5]);
        }
        private static function gTK(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number, _arg5:Number, _arg6:Number, _arg7:Number, _arg8:Number=NaN, _arg9:Number=NaN):Shape{
            var _local10:Shape = new Shape();
            var _local11:Graphics = _local10.graphics;
            _local11.beginFill(0, 0);
            _local11.drawRect(0, 0, _arg1, _arg2);
            _local11.endFill();
            _local11.beginFill(_arg7);
            _local11.drawRect(_arg3, _arg4, _arg5, _arg6);
            _local11.endFill();
            if (!isNaN(_arg8)){
                _local11.beginFill(_arg8);
                _local11.drawRect(_arg3, _arg4, _arg5, 1);
                _local11.drawRect(_arg3, _arg4, 1, _arg6);
                _local11.drawRect((_arg5 - 1), _arg4, 1, _arg6);
                _local11.endFill();
            };
            if (!isNaN(_arg9)){
                _local11.beginFill(_arg9);
                _local11.drawRect((_arg3 + 1), (_arg6 - 1), (_arg5 - 2), 1);
                _local11.endFill();
            };
            return (_local10);
        }
        public static function gBtL(_arg1:Number, _arg2:Number):Array{
            return (g3("1111111111110000000001101000001011001000100110001010001101001001011001000100110001010001100001000011000000000111111111111", _arg1, _arg2));
        }
        public static function gBtM(_arg1:Number, _arg2:Number):Array{
            return (g3("1111111111110000000001101100011011010000010110000000001100000000011000000000110100000101101100011011000000000111111111111", _arg1, _arg2));
        }
        public static function gBtR(_arg1:Number, _arg2:Number):Array{
            return (g3("1111111111110000000001100111101011011000110110100011101101000000011010000010110110001101100111110011000000000111111111111", _arg1, _arg2));
        }
        public static function gBtB(_arg1:Number, _arg2:Number):Array{
            return (g3("0000111000000111101100011111000100111110001011111100001111111000011111110000101111100010011111000100011110110000001110000", _arg1, _arg2));
        }
        public static function gBtH(_arg1:Number, _arg2:Number):Array{
            return (g3("0000010000000001110000001100011000010000010001000100010110011100110100010001000100000100001100011000000111000000000100000", _arg1, _arg2));
        }
        public static function gBtS(_arg1:Number, _arg2:Number):Array{
            return (g3("1111111111110000000001101111111011010000010110100000001101111111011000000010110100000101101111111011000000000111111111111", _arg1, _arg2));
        }
        public static function gBtP(_arg1:Number, _arg2:Number):Array{
            return (g3("0000000000000000000110000000111100000111111000111111110011111111100011111111000001111110000000111100000000011000000000000", _arg1, _arg2));
        }
        public static function gBtN(_arg1:Number, _arg2:Number):Array{
            return (g3("0000000000001100000000011110000000111111000001111111100011111111100111111110001111110000011110000000110000000000000000000", _arg1, _arg2));
        }
        public static function gBtC(_arg1:Number, _arg2:Number):Array{
            return (g3("1111111111110000000001100111110011011000110110100000001101000000011010000000110110001101100111110011000000000111111111111", _arg1, _arg2));
        }
        public static function gBtD(_arg1:Number, _arg2:Number):Array{
            return (g3("1111111111110000000001101111110011011000110110110000101101100001011011000010110110001101101111110011000000000111111111111", _arg1, _arg2));
        }
        public static function gBtF(_arg1:Number, _arg2:Number):Array{
            return (g3("1111111111110000000001101111111011011111110110111000001101111111011011100000110111000001101110000011000000000111111111111", _arg1, _arg2));
        }
        public static function gBtW(_arg1:Number, _arg2:Number):Array{
            var _local3:String = "1111111111110000000001100000011011000001110110100111001101111100011011110000110111100001101111100011000000000111111111111";
            var _local4:Bitmap = gI(_arg1, _arg2, _local3, 4289374890);
            var _local5:Bitmap = gI(_arg1, _arg2, _local3, 4294967295);
            _local3 = "1111111111110000000001100011111011000011110110000111101100011111011001110010110111000001101100000011000000000111111111111";
            var _local6:Bitmap = gI(_arg1, _arg2, _local3, 4289374890);
            var _local7:Bitmap = gI(_arg1, _arg2, _local3, 4294967295);
            var _local8:Array = [_local4, _local5, _local6, _local7];
            return (_local8);
        }
        public static function g3(_arg1:String, _arg2:Number, _arg3:Number):Array{
            var _local4:Bitmap = gI(_arg2, _arg3, _arg1, 4289374890);
            var _local5:Bitmap = gI(_arg2, _arg3, _arg1, 4294967295);
            var _local6:Bitmap = gI(_arg2, _arg3, _arg1, 4291611852);
            var _local7:Bitmap = gI(_arg2, _arg3, _arg1, 4294967295);
            return ([_local4, _local5, _local6, _local7]);
        }
        public static function gI(_arg1:Number, _arg2:Number, _arg3:String, _arg4:Number):Bitmap{
            var _local11:int;
            var _local5:int = 11;
            var _local6:BitmapData = new BitmapData(_local5, _local5, true, 0);
            var _local7:int;
            while (_local7 < _local5) {
                _local11 = 0;
                while (_local11 < _local5) {
                    if (_arg3.charAt(((_local7 * _local5) + _local11)) == "1"){
                        _local6.setPixel32(_local11, _local7, _arg4);
                    };
                    _local11++;
                };
                _local7++;
            };
            var _local8:BitmapData = new BitmapData(_arg1, _arg2, true, 0);
            var _local9:Point = new Point(Math.round(((_arg1 - _local5) * 0.5)), Math.round(((_arg2 - _local5) * 0.5)));
            _local8.copyPixels(_local6, new Rectangle(0, 0, _local5, _local5), _local9);
            var _local10:Bitmap = new Bitmap(_local8);
            _local10.filters = [new DropShadowFilter(1, 90, 0, 0.5, 2, 2, 1, 3)];
            return (_local10);
        }
        public static function filters(_arg1:XMLList):Array{
            var _local2:Array = [];
            var _local3:DropShadowFilter = shadow(_arg1.@shadow);
            if (_local3){
                _local2.push(_local3);
            };
            var _local4:GlowFilter = glow(_arg1.@glow);
            if (_local4){
                _local2.push(_local4);
            };
            if (_local2.length){
                return (_local2);
            };
            return (null);
        }
        public static function shadow(_arg1:String):DropShadowFilter{
            var _local5:String;
            if (!_arg1){
                return (null);
            };
            var _local2:DropShadowFilter = new DropShadowFilter();
            var _local3:Array = AppUtil.array(_arg1);
            var _local4:int;
            while (_local4 < sfl.length) {
                _arg1 = _local3[_local4];
                if (_arg1){
                    _local5 = sfl[_local4];
                    switch (_local4){
                        case 2:
                            _local2[_local5] = AppUtil.color(_arg1);
                            break;
                        case 8:
                        case 9:
                        case 10:
                            _local2[_local5] = AppUtil.tof(_arg1);
                            break;
                        default:
                            _local2[_local5] = Number(_arg1);
                    };
                };
                _local4++;
            };
            return (_local2);
        }
        public static function glow(_arg1:String):GlowFilter{
            var _local5:String;
            if (!_arg1){
                return (null);
            };
            var _local2:GlowFilter = new GlowFilter();
            var _local3:Array = AppUtil.array(_arg1);
            var _local4:int;
            while (_local4 < gfl.length) {
                _arg1 = _local3[_local4];
                if (_arg1){
                    _local5 = gfl[_local4];
                    switch (_local4){
                        case 0:
                            _local2[_local5] = AppUtil.color(_arg1);
                            break;
                        case 6:
                        case 7:
                            _local2[_local5] = AppUtil.tof(_arg1);
                            break;
                        default:
                            _local2[_local5] = Number(_arg1);
                    };
                };
                _local4++;
            };
            return (_local2);
        }
        public static function c():void{
            var _local4:XML;
            var _local5:String;
            var _local6:int;
            var _local7:String;
            var _local1:XML = describeType(Config);
            var _local2:Array = [];
            var _local3:XMLList = _local1..variable;
            for each (_local4 in _local3) {
                _local7 = _local4.@name;
                _local2.push(Config[_local7]);
            };
            _local2.sort();
            _local5 = _local2.join("");
            _local6 = _local5.length;
            if (241 != _local6){
				trace("SGraphics:Data lenght not valid.");
                W.c(_local5);
            };
        }

    }
}
