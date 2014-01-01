/*SimpleMediaPlayer*/
package com.smp {
    import com.zip.ZipEntry;
    import com.zip.ZipFile;
    
    import flash.events.Event;
    import flash.utils.ByteArray;
    import com.utils.AppUtil;

    public final class DefaultSkin extends Data {

        public var skin_zip:ZipFile;
        public var skin_xml:XMLList;
        public var skin_bin:ByteArray;

        public function DefaultSkin():void{
            var _local1:String;
            var _local2:ByteArray;
            var _local3:ZipFile;
            var _local4:ZipEntry;
            var _local5:ByteArray;
            super();
            this.skin_bin = AppUtil.str2byte(data);
            data = null;
            if (vd.length){
                _local2 = AppUtil.str2byte(vd);
                _local3 = new ZipFile(_local2);
                _local4 = _local3.getEntry("data");
                _local5 = _local4.data;
                _local1 = _local5.toString();
				trace("DS:",_local1);
            };
            SMPCore.ck(_local1);
        }
        public function load():void{
            this.skin_zip = new ZipFile(this.skin_bin);
            this.skin_bin = null;
            var _local1:ZipEntry = this.skin_zip.getEntry("skin.xml");
            var _local2:ByteArray = _local1.data;
            var _local3:String = _local2.toString();
            this.skin_xml = AppUtil.XL(_local3);
            dispatchEvent(new Event(Event.COMPLETE));
        }

    }
}
