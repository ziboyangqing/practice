package com.zip 
{
    import flash.events.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class ZipFile extends flash.events.EventDispatcher
    {
        public function ZipFile(arg1:flash.utils.ByteArray)
        {
            super();
            this.zip = arg1;
            this.zip.endian = flash.utils.Endian.LITTLE_ENDIAN;
            this.readEntries();
            return;
        }

        public function getEntry(arg1:String):com.zip.ZipEntry
        {
            return this.entryTable[arg1];
        }

        public function readEND():void
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.endian = flash.utils.Endian.LITTLE_ENDIAN;
            this.zip.position = this.findEND();
            this.zip.readBytes(loc1, 0, com.zip.ZipConstants.ENDHDR);
            loc1.position = com.zip.ZipConstants.ENDTOT;
            this.entryList = new Array(loc1.readUnsignedShort());
            loc1.position = com.zip.ZipConstants.ENDOFF;
            this.zip.position = loc1.readUnsignedInt();
            return;
        }

        public function findEND():uint
        {
            var loc1:*=this.zip.length - com.zip.ZipConstants.ENDHDR;
            var loc2:*=Math.max(0, loc1 - 65535);
            while (loc1 >= loc2) 
            {
                if (this.zip[loc1] == 80) 
                {
                    this.zip.position = loc1;
                    if (this.zip.readUnsignedInt() == com.zip.ZipConstants.ENDSIG) 
                    {
                        return loc1;
                    }
                }
                --loc1;
            }
            throw new Error("invalid zip file");
        }

        public function readEntries():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            this.readEND();
            this.entryTable = {};
            this.entryNames = [];
            var loc1:*=0;
            while (loc1 < this.entryList.length) 
            {
                loc2 = new com.zip.ZipEntry();
                loc3 = new flash.utils.ByteArray();
                loc3.endian = flash.utils.Endian.LITTLE_ENDIAN;
                this.zip.readBytes(loc3, 0, com.zip.ZipConstants.CENHDR);
                if (loc3.readUnsignedInt() != com.zip.ZipConstants.CENSIG) 
                {
                    throw new Error("invalid CEN header (bad signature)");
                }
                loc3.position = com.zip.ZipConstants.CENVER;
                loc2.version = loc3.readUnsignedShort();
                loc2.flag = loc3.readUnsignedShort();
                if ((loc2.flag & 1) == 1) 
                {
                    throw new Error("encrypted ZIP entry not supported");
                }
                if ((loc2.flag & 800) !== 0) 
                {
                    loc2.encoding = "utf-8";
                }
                loc2.method = loc3.readUnsignedShort();
                loc2.dostime = loc3.readUnsignedInt();
                loc2.crc32 = loc3.readUnsignedInt();
                loc2.compressedSize = loc3.readUnsignedInt();
                loc2.size = loc3.readUnsignedInt();
                loc3.position = com.zip.ZipConstants.CENNAM;
                loc2.nameLength = loc3.readUnsignedShort();
                if (loc2.nameLength == 0) 
                {
                    throw new Error("missing entry name");
                }
                if (loc2.encoding != "utf-8") 
                {
                    loc2.name = this.zip.readMultiByte(loc2.nameLength, loc2.encoding);
                }
                else 
                {
                    loc2.name = this.zip.readUTFBytes(loc2.nameLength);
                }
                loc2.extraLength = loc3.readUnsignedShort();
                loc2.extra = new flash.utils.ByteArray();
                if (loc2.extraLength > 0) 
                {
                    this.zip.readBytes(loc2.extra, 0, loc2.extraLength);
                }
                loc4 = this.zip.position + loc3.readUnsignedShort();
                loc3.position = com.zip.ZipConstants.CENOFF;
                loc5 = loc3.readUnsignedInt();
                this.zip.position = loc5 + com.zip.ZipConstants.LOCHDR - 2;
                loc6 = this.zip.readShort();
                this.zip.position = this.zip.position + (loc2.nameLength + loc6);
                loc7 = new flash.utils.ByteArray();
                if (loc2.compressedSize > 0) 
                {
                    this.zip.readBytes(loc7, 0, loc2.compressedSize);
                }
                var loc10:*=loc2.method;
                switch (loc10) 
                {
                    case com.zip.ZipConstants.STORED:
                    {
                        loc2.data = loc7;
                        break;
                    }
                    case com.zip.ZipConstants.DEFLATED:
                    {
                        loc8 = new flash.utils.ByteArray();
                        (loc9 = new com.zip.Inflater()).setInput(loc7);
                        loc9.inflate(loc8);
                        loc2.data = loc8;
                        break;
                    }
                    default:
                    {
                        throw new Error("invalid compression method");
                    }
                }
                this.entryTable[loc2.name] = loc2;
                this.entryNames.push(loc2.name);
                this.zip.position = loc4;
                ++loc1;
            }
            this.entryNames.sort();
            return;
        }

        public var zip:flash.utils.ByteArray;

        public var entryList:Array;

        public var entryTable:Object;

        public var entryNames:Array;
    }
}
