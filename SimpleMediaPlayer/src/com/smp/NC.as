/*SimpleMediaPlayer*/
package com.smp {

    public dynamic class NC {

        private var callback:Object;

        public function NC(_arg1:Object):void{
            this.callback = _arg1;
        }
        private function close(... _args):void{
            this.ncs({close:true}, "close");
        }
        private function ncs(_arg1:Object, _arg2:String):void{
            var _local4:Object;
            var _local3:Object = {};
            for (_local4 in _arg1) {
                _local3[_local4] = _arg1[_local4];
            };
            _local3["type"] = _arg2;
            this.callback.metaHandler(_local3);
        }
        public function onBWCheck(... _args):Number{
            return (0);
        }
        public function onBWDone(... _args):void{
            if (_args.length > 0){
                this.ncs({bandwidth:_args[0]}, "bandwidth");
            };
        }
        public function onCaption(_arg1:String, _arg2:Number, ... _args):void{
            this.ncs({
                captions:_arg1,
                speaker:_arg2
            }, "caption");
        }
        public function onCaptionInfo(_arg1:Object, ... _args):void{
            this.ncs(_arg1, "captioninfo");
        }
        public function onCuePoint(_arg1:Object, ... _args):void{
            this.ncs(_arg1, "cuepoint");
        }
        public function onFCSubscribe(_arg1:Object, ... _args):void{
            this.ncs(_arg1, "fcsubscribe");
        }
        public function onHeaderData(_arg1:Object, ... _args):void{
            var _local6:String;
            var _local7:String;
            var _local3:Object = new Object();
            var _local4:String = "-";
            var _local5:String = "_";
            for (_local6 in _arg1) {
                _local7 = _local6.replace("-", "_");
                _local3[_local7] = _arg1[_local6];
            };
            this.ncs(_local3, "headerdata");
        }
        public function onID3(... _args):void{
            this.ncs(_args[0], "id3");
        }
        public function onImageData(_arg1:Object, ... _args):void{
            this.ncs(_arg1, "imagedata");
        }
        public function onLastSecond(_arg1:Object, ... _args):void{
            this.ncs(_arg1, "lastsecond");
        }
        public function onMetaData(_arg1:Object, ... _args):void{
            if (((_args) && ((_args.length > 0)))){
                _args.splice(0, 0, _arg1);
                this.ncs({arguments:_args}, "metadata");
            } else {
                this.ncs(_arg1, "metadata");
            };
        }
        public function onPlayStatus(... _args):void{
            var _local2:Object;
            for each (_local2 in _args) {
                if (((_local2) && (_local2.hasOwnProperty("code")))){
                    if (_local2.code == "NetStream.Play.Complete"){
                        this.ncs(_local2, "complete");
                    } else {
                        this.ncs(_local2, "playstatus");
                    };
                };
            };
        }
        public function onSDES(... _args):void{
            this.ncs(_args[0], "sdes");
        }
        public function onXMPData(... _args):void{
            this.ncs(_args[0], "xmp");
        }
        public function onXMP(... _args):void{
            this.onXMPData(_args);
        }
        public function RtmpSampleAccess(... _args):void{
            this.ncs(_args[0], "rtmpsampleaccess");
        }
        public function onTextData(_arg1:Object, ... _args):void{
            this.ncs(_arg1, "textdata");
        }
        public function onFI(_arg1:Object, ... _args):void{
            this.ncs(_arg1, "timecode");
        }

    }
}
