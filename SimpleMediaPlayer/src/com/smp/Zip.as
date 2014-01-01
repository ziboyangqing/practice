/*SimpleMediaPlayer*/
package com.smp {
    //import com.smp.events.*;
    import com.zip.ZipConstants;
    import com.zip.ZipEntry;
    import com.zip.ZipFile;
    
    import flash.display.AVM1Movie;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.LoaderInfo;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    import flash.utils.Endian;
	/**
	 * GetFile(s) from ZipFile(bin)
	 */
    public final class Zip {

        private static var queue:Array = [];
        private static var gzing:Boolean;

        public static function GetSrc(src:String, completeFun:Function, ZipSrc:ZipFile=null):void{
			//trace("Zip:",src,completeFun,ZipSrc);
            if (!src){
                completeFun(null);
                return;
            };
            if (ZipSrc == null){
                ZipSrc = Main.sk.skin_zip;
            };
            var _local4:ZipBytesLoader = new ZipBytesLoader(src, completeFun, ZipSrc);
            queue.push(_local4);
            if (!gzing){
                next();
            };
        }
        public static function next():void{
            var _local1:ZipBytesLoader;
            if (queue.length){
                _local1 = queue.shift();
                _local1.load();
            } else {
                gzing = false;
            };
        }
        public static function GetBMD(_arg1:LoaderInfo):BitmapData{
            var _local2:Bitmap;
            if (_arg1){
                if ((_arg1.content is Bitmap)){
                    _local2 = (_arg1.content as Bitmap);
                    if (_local2){
                        if (((_local2.width) && (_local2.height))){
                            return (_local2.bitmapData);
                        };
                    };
                };
            };
            return (null);
        }
        public static function getLD(_arg1:LoaderInfo):DisplayObject{
            var _local2:Bitmap;
            if (_arg1){
                if (_arg1.contentType == CS.APP_FLASH){
                    if ((_arg1.content is AVM1Movie)){
                        return (_arg1.loader);
                    };
                    return (_arg1.content);
                };
                _local2 = (_arg1.content as Bitmap);
                if (_local2){
                    if (((((_local2.width) && (_local2.height))) && (_arg1.childAllowsParent))){
                        return (new SBitMap(mBD(_local2.bitmapData)));
                    };
                    return (_local2);
                };
            };
            return (new Bitmap());
        }
		/*
		_arg2:横向分割数
		_arg3:纵向分割数
		*/
        public static function SplitBMD(bmd:BitmapData, xdimension:int=1, ydimension:int=1):Array{
            var _local11:BitmapData;
            var _local12:int;
            var _local13:BitmapData;
            var _local4:BitmapData = mBD(bmd);
            var _local5:Array = [];
            var _local6:int = _local4.width;
            var _local7:int = _local4.height;
            var _local8:int = int((_local6 / xdimension));
            var _local9:int = int((_local7 / ydimension));
            var _local10:int;
            while (_local10 < ydimension) {
                _local11 = new BitmapData(_local6, _local9, true, 0);
                _local11.copyPixels(_local4, new Rectangle(0, (_local9 * _local10), _local6, _local9), new Point(0, 0));
                _local12 = 0;
                while (_local12 < xdimension) {
                    _local13 = new BitmapData(_local8, _local9, true, 0);
                    _local13.copyPixels(_local11, new Rectangle((_local8 * _local12), 0, _local8, _local9), new Point(0, 0));
                    _local5.push(_local13);
                    _local12++;
                };
                _local11.dispose();
                _local10++;
            };
            _local4.dispose();
            return (_local5);
        }
        public static function mBD(_arg1:BitmapData):BitmapData{
            var _local2:BitmapData;
            if (Main.sk.mask_color){
                _local2 = new BitmapData(_arg1.width, _arg1.height, true, 0);
                _local2.threshold(_arg1, _arg1.rect, new Point(0, 0), "==", Main.sk.mask_color, 0, 4294967295, true);
                return (_local2);
            };
            return (_arg1);
        }
        public static function extract(_arg1:ByteArray):Array{
            var _local2:ZipFile;
            var _local3:Array;
            var _local4:Array;
            var _local5:int;
            var _local6:ZipEntry;
            if (!_arg1){
                return ([_arg1]);
            };
            _arg1.position = 0;
            _arg1.endian = Endian.LITTLE_ENDIAN;
            if (_arg1.readUnsignedInt() == ZipConstants.LOCSIG){
                try {
                    _local2 = new ZipFile(_arg1);
                } catch(e:Error) {
                };
                if (_local2){
                    _local3 = [];
                    _local4 = _local2.entryNames;
                    _local5 = 0;
                    while (_local5 < _local4.length) {
                        _local6 = _local2.getEntry(_local4[_local5]);
                        if (_local6){
                            if (_local6.size){
                                _local3.push(_local6.data);
                            };
                        };
                        _local5++;
                    };
                    return (_local3);
                };
            };
            return ([_arg1]);
        }

    }
}
