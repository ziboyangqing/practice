/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import flash.net.*;
    import flash.media.*;

    public class SSoundPlayer extends EventDispatcher {

        public var channel:SoundChannel;
        public var transform:SoundTransform;
        public var filter:Function;
        private var sounder:Sound;
        private var sampler:Sound;
        private var latency:Number = 0;
        private var truepos:Number = 0;
        private var bufferlen:Number;
        private var loaded:Boolean;
        private var seekpos:Number = 0;
        private var reading:Boolean;
        private var state:String;
        private var sample:Boolean;
        private var tid:uint;

        public function SSoundPlayer():void{
            this.transform = new SoundTransform();
            super();
            this.filter = EQ.filter;
        }
        public function load(_arg1:URLRequest, _arg2:SoundLoaderContext):void{
            var stream:* = _arg1;
            var context:* = _arg2;
            this.state = SMPStates.CONNECTING;
            this.loaded = false;
            this.bufferlen = context.bufferTime;
            this.sounder = new Sound();
            this.sounder.addEventListener(Event.OPEN, this.openHandler, false, 0, true);
            this.sounder.addEventListener(Event.COMPLETE, this.loadedHandler, false, 0, true);
            this.sounder.addEventListener(Event.ID3, this.id3Handler, false, 0, true);
            this.sounder.addEventListener(IOErrorEvent.IO_ERROR, this.errorHandler, false, 0, true);
            this.sounder.addEventListener(ProgressEvent.PROGRESS, this.progressHandler, false, 0, true);
            try {
                this.sounder.load(stream, context);
            } catch(e:Error) {
                errorHandler(new IOErrorEvent(IOErrorEvent.IO_ERROR));
            };
            if (Config.sound_sample){
                this.sample = true;
            } else {
                this.sample = false;
            };
            if (this.sample){
                this.sampler = new Sound();
                this.sampler.addEventListener(SampleDataEvent.SAMPLE_DATA, this.sampleHandler, false, 0, true);
            };
        }
        public function play(_arg1:Number):void{
            if (!this.sounder){
                return;
            };
            this.state = SMPStates.PLAYING;
            var _local2:Number = this.length;
            if (_arg1 > _local2){
                _arg1 = Math.floor(_local2);
            };
            this.channelStop();
            if (this.sample){
                this.seekpos = Math.round((_arg1 * 44.1));
                this.channel = this.sampler.play(_arg1);
            } else {
                this.channel = this.sounder.play(_arg1);
                this.channel.addEventListener(Event.SOUND_COMPLETE, this.completeHandler, false, 0, true);
            };
            this.volume();
        }
        public function pause():void{
            this.state = SMPStates.PAUSED;
            this.channelStop();
        }
        public function stop():void{
            this.state = SMPStates.STOPPED;
            this.loaded = false;
            this.seekpos = 0;
            this.channelStop();
            if (this.sounder){
                this.sounder.removeEventListener(Event.OPEN, this.openHandler);
                this.sounder.removeEventListener(Event.COMPLETE, this.loadedHandler);
                this.sounder.removeEventListener(Event.ID3, this.id3Handler);
                this.sounder.removeEventListener(IOErrorEvent.IO_ERROR, this.errorHandler);
                this.sounder.removeEventListener(ProgressEvent.PROGRESS, this.progressHandler);
                try {
                    this.sounder.close();
                } catch(e:Error) {
                };
                this.sounder = null;
            };
            if (this.sampler){
                this.sampler.removeEventListener(SampleDataEvent.SAMPLE_DATA, this.sampleHandler);
                try {
                    this.sampler.close();
                } catch(e:Error) {
                };
                this.sampler = null;
            };
        }
        private function channelStop():void{
            if (this.channel){
                this.channel.stop();
                this.channel.removeEventListener(Event.SOUND_COMPLETE, this.completeHandler);
                this.channel = null;
            };
            clearTimeout(this.tid);
        }
        public function volume():void{
            this.transform.volume = Config.volume;
            this.transform.pan = Config.panning;
            if (this.channel){
                this.channel.soundTransform = this.transform;
            };
        }
        public function get id3():ID3Info{
            var _local1:ID3Info;
            try {
                _local1 = this.sounder.id3;
            } catch(e:Error) {
            };
            return (_local1);
        }
        public function get length():Number{
            return (this.sounder.length);
        }
        public function get buffering():Boolean{
            if (this.sample){
                return (this.reading);
            };
            return (this.sounder.isBuffering);
        }
        public function get position():Number{
            var _local1:Number = 0;
            if (this.channel){
                _local1 = this.channel.position;
            };
            return (_local1);
        }
        private function resume():void{
            if (((((this.sample) && ((this.state == SMPStates.PLAYING)))) && (this.reading))){
                if (((this.loaded) || ((this.length > (this.bufferlen + this.position))))){
                    this.play(this.position);
                };
            };
        }
        private function progressHandler(_arg1:ProgressEvent):void{
            this.resume();
            dispatchEvent(_arg1);
        }
        private function openHandler(_arg1:Event):void{
            dispatchEvent(_arg1);
        }
        private function loadedHandler(_arg1:Event):void{
            this.loaded = true;
            this.resume();
            dispatchEvent(_arg1);
        }
        private function errorHandler(_arg1:IOErrorEvent):void{
            dispatchEvent(_arg1);
        }
        private function id3Handler(_arg1:Event):void{
            dispatchEvent(_arg1);
        }
        private function completeHandler(_arg1:Event=null):void{
            if (!_arg1){
                _arg1 = new Event(Event.SOUND_COMPLETE);
            };
            dispatchEvent(_arg1);
        }
        private function sampleHandler(_arg1:SampleDataEvent):void{
            var _local2:ByteArray = new ByteArray();
            var _local3:Number = 0;
            if (isNaN(this.seekpos)){
                _local3 = this.sounder.extract(_local2, EQ.length);
            } else {
                _local3 = this.sounder.extract(_local2, EQ.length, this.seekpos);
                this.seekpos = NaN;
            };
            if (_local3 == EQ.length){
                this.reading = false;
            } else {
                if (this.loaded){
                    if (this.channel){
                        this.channel.addEventListener(Event.SOUND_COMPLETE, this.completeHandler, false, 0, true);
                    } else {
                        this.tid = setTimeout(this.completeHandler, 500);
                    };
                } else {
                    this.reading = true;
                };
            };
            if (_local3 > 0){
                if ((this.filter is Function)){
                    _local2 = this.filter(_local2);
                };
                _arg1.data.writeBytes(_local2);
            };
        }

    }
}
