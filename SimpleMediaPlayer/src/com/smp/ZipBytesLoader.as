/*SimpleMediaPlayer*/
package com.smp {
    import flash.utils.*;
    import flash.events.*;
    import flash.display.*;
    import com.zip.*;
    import flash.system.*;

    public final class ZipBytesLoader {

        private var filename:String;
        private var onComplete:Function;
        private var zip:ZipFile;
        private var loader:Loader;

        public function ZipBytesLoader(file:String, completeFun:Function, zipSrc:ZipFile):void{
            this.filename = file;
            this.onComplete = completeFun;
            this.zip = zipSrc;
        }
        public function load():void{
            var _local2:ByteArray;
            var _local3:LoaderContext;
            if (!this.zip){
                this.sendError("Invalid zip");
                return;
            };
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.completeHandler);
            this.filename = this.filename.toLowerCase();
            var _local1:ZipEntry = this.zip.getEntry(this.filename);
            if (_local1){
                _local2 = new ByteArray();
                _local2.writeBytes(_local1.data);
                _local3 = new LoaderContext();
                _local3.allowCodeImport = true;
                this.loader.loadBytes(_local2, _local3);
            } else {
                this.sendError(("File not found:" + this.filename));
            };
        }
        private function sendError(_arg1:String):void{
            O.o(_arg1);
            this.errorHandler();
        }
        private function errorHandler(_arg1:Event=null):void{
            this.onComplete.call(null, null);
            Zip.next();
        }
        private function completeHandler(_arg1:Event):void{
            this.onComplete.call(null, this.loader.contentLoaderInfo);
            Zip.next();
        }

    }
}
