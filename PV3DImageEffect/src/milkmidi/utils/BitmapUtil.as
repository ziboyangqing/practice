package milkmidi.utils {
    import flash.geom.*;
    import flash.display.*;
    import flash.errors.*;

    public class BitmapUtil {

        public static const MERGE_POSITION_TOP:String = "top";
        public static const MERGE_POSITION_RIGHT:String = "right";
        public static const MERGE_POSITION_DOWN:String = "down";
        public static const MERGE_POSITION_LEFT:String = "left";

        public function BitmapUtil(){
            throw (new IllegalOperationError("BitmapUtil cannot be instantiated."));
        }
        public static function mergeBitmap(_arg1:BitmapData, _arg2:BitmapData, _arg3:String="down", _arg4:Boolean=true):BitmapData{
            var _local5:BitmapData = new BitmapData(_arg1.width, (_arg1.height + _arg2.height), true, 0);
            _local5.copyPixels(_arg1, _arg1.rect, new Point());
            _local5.copyPixels(_arg2, _arg2.rect, new Point(0, _arg1.height));
            if (_arg4){
                _arg1.dispose();
                _arg2.dispose();
            };
            return (_local5);
        }
        public static function getBitmapData(_arg1):BitmapData{
            var _bitmap:* = null;
            var _ds:* = null;
            var _bmd:* = null;
            var _mat:* = null;
            var pData:* = _arg1;
            if (pData == null){
                return (null);
            };
            if ((pData is Class)){
                if ((pData is Bitmap)){
                    _bitmap = (new (pData)() as Bitmap);
                    return (_bitmap.bitmapData);
                };
                if ((pData is BitmapData)){
                    try {
                        pData = new (pData)();
                    } catch(err:Error) {
                        pData = new pData(0, 0);
                    };
                };
            };
            if ((pData is BitmapData)){
                return (pData);
            };
            if ((pData is DisplayObject)){
                _ds = (pData as DisplayObject);
                _bmd = new BitmapData(_ds.width, _ds.height, true, 0xFFFFFF);
                _mat = _ds.transform.matrix.clone();
                _mat.tx = 0;
                _mat.ty = 0;
                _bmd.draw(_ds, _mat, _ds.transform.colorTransform, _ds.blendMode, _bmd.rect, true);
                return (_bmd);
            };
            throw (new Error(("Can't BitmapUtil.getBitmapData" + pData)));
        }
        public static function mergeBitmapAlpha(_arg1:BitmapData, _arg2:BitmapData, _arg3:Boolean=true):BitmapData{
            var _local4:BitmapData = new BitmapData(_arg1.width, _arg1.height);
            _local4.copyPixels(_arg1, _arg1.rect, new Point());
            _local4.copyChannel(_arg2, _arg2.rect, new Point(), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
            if (_arg3){
                _arg1.dispose();
                _arg2.dispose();
            };
            return (_local4);
        }
        public static function reflect(_arg1, _arg2:Boolean=false, _arg3:Number=0.6, _arg4:Number=0, _arg5:Number=0.4):BitmapData{
            var _local17:Bitmap;
            if (((!((_arg1 is BitmapData))) && (!((_arg1 is DisplayObject))))){
                throw (new Error("error Type"));
            };
            var _local6:BitmapData = new BitmapData(_arg1.width, _arg1.height, true, 0);
            var _local7:Matrix = new Matrix(1, 0, 0, -1, 0, _arg1.height);
            var _local8:Rectangle = new Rectangle(0, 0, _arg1.width, _arg1.height);
            var _local9:Point = _local7.transformPoint(new Point(0, _arg1.height));
            _local7.tx = (_local9.x * -1);
            _local7.ty = ((_local9.y - _arg1.height) * -1);
            _local6.draw(_arg1, _local7, null, null, _local8, true);
            var _local10:Shape = new Shape();
            var _local11:String = GradientType.LINEAR;
            var _local12:Array = [0, 0, 0];
            var _local13:Array = [_arg3, ((_arg3 - _arg4) / 2), _arg4];
            var _local14:Array = [0, (0xFF * _arg5), 0xFF];
            var _local15:Matrix = new Matrix();
            var _local16:String = SpreadMethod.PAD;
            _local15.createGradientBox(_arg1.width, (_arg1.height / 2), (Math.PI / 2));
            _local10.graphics.beginGradientFill(_local11, _local12, _local13, _local14, _local15, _local16);
            _local10.graphics.drawRect(0, 0, _arg1.width, _arg1.height);
            _local10.graphics.endFill();
            _local6.draw(_local10, null, null, BlendMode.ALPHA);
            if (((_arg2) && ((_arg1 is Sprite)))){
                _local17 = new Bitmap(_local6);
                _local17.y = _arg1.height;
                Sprite(_arg1).addChild(_local17);
            };
            _local10 = null;
            return (_local6);
        }

    }
}//package milkmidi.utils 
