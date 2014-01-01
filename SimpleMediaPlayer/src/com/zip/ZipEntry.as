package com.zip 
{
    import flash.utils.*;
    
    public class ZipEntry extends Object
    {
        public function ZipEntry()
        {
            super();
            this.data = new flash.utils.ByteArray();
            return;
        }

        public function get name():String
        {
            return this._name;
        }

        public function set name(arg1:String):void
        {
            arg1 = arg1.toLocaleLowerCase();
            this._name = arg1;
            return;
        }

        public function toString():String
        {
            return this._name;
        }

        internal var _name:String;

        public var data:flash.utils.ByteArray;

        public var extra:flash.utils.ByteArray;

        public var version:int;

        public var flag:int;

        public var encoding:String="";

        public var method:int=-1;

        public var dostime:uint;

        public var crc32:uint;

        public var compressedSize:int=-1;

        public var size:int=-1;

        public var nameLength:uint;

        public var extraLength:uint;
    }
}
