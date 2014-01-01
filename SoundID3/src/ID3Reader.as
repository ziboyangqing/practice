package {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	[Event("id3")]
	public class ID3Reader extends EventDispatcher {

		private var version:Number; // ID3 version (major.minor)
		private var length:Number; // ID3 tag size in bytes
		public var frames:Array; // holds all our ID3 frames
		private var bytes:ByteArray;
		public var APIC:ByteArray;
		private var tagdata:ByteArray;
		private var stream:URLStream;
		private var id3length:Number;
		private var file:String="";

		public function ID3Reader(file:String="") {
			frames=new Array();
			frames["APIC"]=new Array();
			APIC=new ByteArray();
			stream=new URLStream();
			tagdata=new ByteArray();
			id3length=0;
			stream.load(new URLRequest(file));
			stream.addEventListener(ProgressEvent.PROGRESS, onStreamProgress);
			//data ? load(data) : 0;
		}

		private function onStreamProgress(event:ProgressEvent):void {
			trace(event.bytesLoaded,"/",event.bytesTotal);
			// if we have the first 10 bytes, use them to read how many bytes the ID3 tag will be
			if (stream.bytesAvailable >= 10 && id3length < 10) {
				stream.readBytes(tagdata, 0, 10);
				// takes 10 bytes out of the stream;
				id3length=ID3Reader.getid3length(tagdata);
			}
			if (stream.bytesAvailable > id3length) {
				readID3();
			} // if we have the ID3 data, continue
		}

		private function readID3():void {
			stream.readBytes(tagdata, 10, stream.bytesAvailable);
			// add the remainder of the stream into the same byte array;
			stream.close();
			load(tagdata);
		}

		public static function getid3length(data:ByteArray):Number {
			var length:Number;
			if (data.bytesAvailable >= 8 && data.readUTFBytes(3).toUpperCase() == "ID3") {
				data.readByte();
				data.readByte(); // storing tag version
				data.readByte(); // storing flags byte
				length=data.readInt(); // storing tag length
			} else {
				length=-1;
			}
			return length;
		}

		public function load(data:ByteArray):void {
			bytes=data;
			bytes.position=0
			if (bytes.readUTFBytes(3).toUpperCase() == "ID3") {
				// process ID3 tag header
				version=bytes.readByte() + bytes.readByte() / 100; // storing tag version
				bytes.readByte();
				length=bytes.readInt(); // storing tag length
				readFrames();
			} else {
				trace("noid3:", bytes.readUTFBytes(3));
			}
		}

		private function readFrames():void {
			// looping through ID3 frames
			var id:String=bytes.readUTFBytes(4); // storing frame id
			while (bytes.position < length - 10) {
				if (id == "APIC") {
					frames["APIC"]=readAPIC();
					break; // stopping here for now.
				} else if (id == "COMM" || id == "USLT") {
					frames[id]=readCOMM();
					trace("id:", id);
					trace("description: " + frames[id].description);
					trace("text: " + frames[id].text);
				} else if (id.charAt(0) == "T") {
					frames[id]=readTextFrame();
					trace("id:", id, frames[id].encoding, frames[id].text);
				} else if (id.charAt(0) == "W") {
					frames[id]=readWebFrame();
				} else if (id == "") {
					trace("padding?");
					break;
				} else {
					readUnknown();
				}
				id=bytes.readUTFBytes(4);
			}
			dispatchEvent(new Event(Event.ID3));
		}

		private function onID3Loaded(event:Event):void {
			// display the song title
			if (frames["TIT2"]) {
			}
			// display the artist name
			if (frames["TPE1"]) {
			}
			if (frames["TALB"]) {
				//trace(reader.frames["TALB"].text);
			}
		}

		private function readWebFrame():Object {
			var obj:Object=new Object();
			obj.length=bytes.readInt(); // store frame length
			bytes.position+=2; // add two to skip flags in frame header
			obj.text=bytes.readUTFBytes(obj.length);
			return obj;
		}

		private function readCOMM():Object {
			var obj:Object=new Object();
			obj.length=bytes.readInt(); // store frame length
			bytes.position+=2; // add two to skip flags in frame header
			var cs:uint   =bytes.position;
			obj.encoding=bytes.readByte(); // storing text encoding
			obj.language=bytes.readUTFBytes(3); // storing language
			obj.description=readString();
			obj.text=bytes.readUTFBytes(obj.length - (bytes.position - cs));
			return obj;
		}

		private function readUnknown():void {
			var length:int=bytes.readInt(); // read length of unknown frame
			bytes.position+=length + 2; // add two to skip flags in frame header
		}

		private function readTXXXFrame():Object {
			var obj:Object=new Object();
			obj.length=bytes.readInt(); // store frame length
			bytes.position+=2; // add two to skip flags in frame header
			var cs:uint   =bytes.position;
			obj.encoding=bytes.readByte(); // storing text encoding
			obj.description=readString();
			obj.text=bytes.readUTFBytes(obj.length - (bytes.position - cs));
			return obj;
		}

		private function readTextFrame():Object {
			var obj:Object=new Object();
			obj.length=bytes.readInt(); // store frame length
			bytes.position+=2; // add two to skip flags in frame header
			obj.encoding=bytes.readByte(); // storing text encoding
			//obj.text=bytes.readUTFBytes(obj.length - 1);
			obj.text=bytes.readMultiByte(obj.length-1,"unicode");
			return obj;
		}

		private function readAPIC():Object {
			var obj:Object=new Object(); // create object for return
			obj.data=new ByteArray(); // create ByteArray to store image data
			obj.length=bytes.readInt(); // store frame length
			bytes.position+=2; // add two to skip flags in frame header
			var cs:uint   =bytes.position; // storing where frame data begins
			obj.encoding=bytes.readByte(); // storing text encoding
			obj.mime=readString();
			obj.type=bytes.readByte();
			obj.description=readString();
			APIC.writeBytes(bytes, bytes.position + 2, (bytes.position - cs) + obj.length - 2);
			bytes.position=cs + obj.length;
			return obj;
		}

		private function readString():String {
			var e:uint, s:uint=bytes.position; // (e)nd, (s)tart
			var b:Number=bytes.readByte(); // (b)yte
			while (b != 0x00) {
				b=bytes.readByte()
			};
			e=bytes.position--;
			bytes.position=s;
			return bytes.readUTFBytes(e - s);
		}

		//unicode string to ByteArray    
		public static function StrToByteArray(strValue:String, uLen:uint=0):ByteArray {
			var byAaryR:ByteArray=new ByteArray();
			byAaryR.endian=Endian.LITTLE_ENDIAN;
			for (var i:int=0; i < strValue.length; ++i) {
				byAaryR.writeShort(strValue.charCodeAt(i));
			}
			for (i=0; i < (uLen - strValue.length); ++i) {
				byAaryR.writeShort(0);
			}
			return byAaryR;
		}

		//ByteArray to unicode string   
		public static function byArrayToString(byArray:ByteArray):String {
			byArray.position=0;
			var strReturn:String=new String();
			for (var i:int=0; i < byArray.length / 2; ++i) {
				var strRep:String=byArray.readMultiByte(2, "unicode");
				strReturn=replaceAt(strReturn, strRep, i, i);
			}
			return strReturn;
		}

		public static function replaceAt(char:String, value:String, beginIndex:int, endIndex:int):String {
			beginIndex=Math.max(beginIndex, 0);
			endIndex=Math.min(endIndex, char.length);
			var firstPart:String =char.substr(0, beginIndex);
			var secondPart:String=char.substr(endIndex, char.length);
			return (firstPart + value + secondPart);
		}


	}
}

