//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock {
    import flash.events.*;
    import com.greensock.core.*;
    import com.greensock.events.*;

    public class TimelineMax extends TimelineLite implements IEventDispatcher {

        public static const version:Number = 1.691;

        protected var _repeat:int;
        protected var _repeatDelay:Number;
        protected var _cyclesComplete:int;
        protected var _dispatcher:EventDispatcher;
        protected var _hasUpdateListener:Boolean;
        public var yoyo:Boolean;

        public function TimelineMax(_arg1:Object=null){
            super(_arg1);
            this._repeat = (this.vars.repeat) ? Number(this.vars.repeat) : 0;
            this._repeatDelay = (this.vars.repeatDelay) ? Number(this.vars.repeatDelay) : 0;
            this._cyclesComplete = 0;
            this.yoyo = Boolean((this.vars.yoyo == true));
            this.cacheIsDirty = true;
            if (((((((((!((this.vars.onCompleteListener == null))) || (!((this.vars.onUpdateListener == null))))) || (!((this.vars.onStartListener == null))))) || (!((this.vars.onRepeatListener == null))))) || (!((this.vars.onReverseCompleteListener == null))))){
                this.initDispatcher();
            };
        }
        private static function onInitTweenTo(_arg1:TweenLite, _arg2:TimelineMax, _arg3:Number):void{
            _arg2.paused = true;
            if (!isNaN(_arg3)){
                _arg2.currentTime = _arg3;
            };
            if (_arg1.vars.currentTime != _arg2.currentTime){
                _arg1.duration = (Math.abs((Number(_arg1.vars.currentTime) - _arg2.currentTime)) / _arg2.cachedTimeScale);
            };
        }
        private static function easeNone(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return ((_arg1 / _arg4));
        }

        public function addCallback(_arg1:Function, _arg2, _arg3:Array=null):TweenLite{
            var _local4:TweenLite = new TweenLite(_arg1, 0, {
                onComplete:_arg1,
                onCompleteParams:_arg3,
                overwrite:0,
                immediateRender:false
            });
            insert(_local4, _arg2);
            return (_local4);
        }
        public function removeCallback(_arg1:Function, _arg2=null):Boolean{
            var _local3:Array;
            var _local4:Boolean;
            var _local5:int;
            if (_arg2 == null){
                return (killTweensOf(_arg1, false));
            };
            if (typeof(_arg2) == "string"){
                if (!(_arg2 in _labels)){
                    return (false);
                };
                _arg2 = _labels[_arg2];
            };
            _local3 = getTweensOf(_arg1, false);
            _local5 = _local3.length;
            while (--_local5 > -1) {
                if (_local3[_local5].cachedStartTime == _arg2){
                    remove((_local3[_local5] as TweenCore));
                    _local4 = true;
                };
            };
            return (_local4);
        }
        public function tweenTo(_arg1, _arg2:Object=null):TweenLite{
            var _local4:String;
            var _local5:TweenLite;
            var _local3:Object = {
                ease:easeNone,
                overwrite:2,
                useFrames:this.useFrames,
                immediateRender:false
            };
            for (_local4 in _arg2) {
                _local3[_local4] = _arg2[_local4];
            };
            _local3.onInit = onInitTweenTo;
            _local3.onInitParams = [null, this, NaN];
            _local3.currentTime = parseTimeOrLabel(_arg1);
            _local5 = new TweenLite(this, (((Math.abs((Number(_local3.currentTime) - this.cachedTime)) / this.cachedTimeScale)) || (0.001)), _local3);
            _local5.vars.onInitParams[0] = _local5;
            return (_local5);
        }
        public function tweenFromTo(_arg1, _arg2, _arg3:Object=null):TweenLite{
            var _local4:TweenLite = this.tweenTo(_arg2, _arg3);
            _local4.vars.onInitParams[2] = parseTimeOrLabel(_arg1);
            _local4.duration = (Math.abs((Number(_local4.vars.currentTime) - _local4.vars.onInitParams[2])) / this.cachedTimeScale);
            return (_local4);
        }
        override public function renderTime(_arg1:Number, _arg2:Boolean=false, _arg3:Boolean=false):void{
            var _local9:TweenCore;
            var _local10:Boolean;
            var _local11:Boolean;
            var _local12:Boolean;
            var _local13:TweenCore;
            var _local14:Number;
            var _local16:Number;
            var _local17:int;
            var _local18:Boolean;
            var _local19:Boolean;
            var _local20:Boolean;
            if (this.gc){
                this.setEnabled(true, false);
            } else {
                if (((!(this.active)) && (!(this.cachedPaused)))){
                    this.active = true;
                };
            };
            var _local4:Number = (this.cacheIsDirty) ? this.totalDuration : this.cachedTotalDuration;
            var _local5:Number = this.cachedTime;
            var _local6:Number = this.cachedTotalTime;
            var _local7:Number = this.cachedStartTime;
            var _local8:Number = this.cachedTimeScale;
            var _local15:Boolean = this.cachedPaused;
            if (_arg1 >= _local4){
                if ((((_rawPrevTime <= _local4)) && (!((_rawPrevTime == _arg1))))){
                    this.cachedTotalTime = _local4;
                    if (((((!(this.cachedReversed)) && (this.yoyo))) && (!(((this._repeat % 2) == 0))))){
                        this.cachedTime = 0;
                        forceChildrenToBeginning(0, _arg2);
                    } else {
                        this.cachedTime = this.cachedDuration;
                        forceChildrenToEnd(this.cachedDuration, _arg2);
                    };
                    _local10 = ((!(this.hasPausedChild())) && (!(this.cachedReversed)));
                    _local11 = true;
                    if ((((((this.cachedDuration == 0)) && (_local10))) && ((((_arg1 == 0)) || ((_rawPrevTime < 0)))))){
                        _arg3 = true;
                    };
                };
            } else {
                if (_arg1 <= 0){
                    if (_arg1 < 0){
                        this.active = false;
                        if ((((this.cachedDuration == 0)) && ((_rawPrevTime >= 0)))){
                            _arg3 = true;
                            _local10 = true;
                        };
                    } else {
                        if ((((_arg1 == 0)) && (!(this.initted)))){
                            _arg3 = true;
                        };
                    };
                    if ((((_rawPrevTime >= 0)) && (!((_rawPrevTime == _arg1))))){
                        this.cachedTotalTime = 0;
                        this.cachedTime = 0;
                        forceChildrenToBeginning(0, _arg2);
                        _local11 = true;
                        if (this.cachedReversed){
                            _local10 = true;
                        };
                    };
                } else {
                    this.cachedTotalTime = (this.cachedTime = _arg1);
                };
            };
            _rawPrevTime = _arg1;
            if (this._repeat != 0){
                _local16 = (this.cachedDuration + this._repeatDelay);
                _local17 = this._cyclesComplete;
                this._cyclesComplete = ((this.cachedTotalTime / _local16) >> 0);
                if (this._cyclesComplete == (this.cachedTotalTime / _local16)){
                    this._cyclesComplete--;
                };
                if (_local17 != this._cyclesComplete){
                    _local12 = true;
                };
                if (_local10){
                    if (((this.yoyo) && ((this._repeat % 2)))){
                        this.cachedTime = 0;
                    };
                } else {
                    if (_arg1 > 0){
                        this.cachedTime = (((this.cachedTotalTime / _local16) - this._cyclesComplete) * _local16);
                        if (((this.yoyo) && ((this._cyclesComplete % 2)))){
                            this.cachedTime = (this.cachedDuration - this.cachedTime);
                        } else {
                            if (this.cachedTime >= this.cachedDuration){
                                this.cachedTime = this.cachedDuration;
                            };
                        };
                        if (this.cachedTime < 0){
                            this.cachedTime = 0;
                        };
                    } else {
                        this._cyclesComplete = 0;
                    };
                };
                if (((((_local12) && (!(_local10)))) && (((!((this.cachedTime == _local5))) || (_arg3))))){
                    _local18 = Boolean(((!(this.yoyo)) || (((this._cyclesComplete % 2) == 0))));
                    _local19 = Boolean(((!(this.yoyo)) || (((_local17 % 2) == 0))));
                    _local20 = Boolean((_local18 == _local19));
                    if (_local17 > this._cyclesComplete){
                        _local19 = !(_local19);
                    };
                    if (_local19){
                        _local5 = forceChildrenToEnd(this.cachedDuration, _arg2);
                        if (_local20){
                            _local5 = forceChildrenToBeginning(0, true);
                        };
                    } else {
                        _local5 = forceChildrenToBeginning(0, _arg2);
                        if (_local20){
                            _local5 = forceChildrenToEnd(this.cachedDuration, true);
                        };
                    };
                    _local11 = false;
                };
            };
            if ((((this.cachedTotalTime == _local6)) && (!(_arg3)))){
                return;
            };
            if (!this.initted){
                this.initted = true;
            };
            if ((((((_local6 == 0)) && (!((this.cachedTotalTime == 0))))) && (!(_arg2)))){
                if (this.vars.onStart){
                    this.vars.onStart.apply(null, this.vars.onStartParams);
                };
                if (this._dispatcher){
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
                };
            };
            if (_local11){
            } else {
                if ((this.cachedTime - _local5) > 0){
                    _local9 = _firstChild;
                    while (_local9) {
                        _local13 = _local9.nextNode;
                        if (((this.cachedPaused) && (!(_local15)))){
                            break;
                        };
                        if (((_local9.active) || (((((!(_local9.cachedPaused)) && ((_local9.cachedStartTime <= this.cachedTime)))) && (!(_local9.gc)))))){
                            if (!_local9.cachedReversed){
                                _local9.renderTime(((this.cachedTime - _local9.cachedStartTime) * _local9.cachedTimeScale), _arg2, false);
                            } else {
                                _local14 = (_local9.cacheIsDirty) ? _local9.totalDuration : _local9.cachedTotalDuration;
                                _local9.renderTime((_local14 - ((this.cachedTime - _local9.cachedStartTime) * _local9.cachedTimeScale)), _arg2, false);
                            };
                        };
                        _local9 = _local13;
                    };
                } else {
                    _local9 = _lastChild;
                    while (_local9) {
                        _local13 = _local9.prevNode;
                        if (((this.cachedPaused) && (!(_local15)))){
                            break;
                        };
                        if (((_local9.active) || (((((!(_local9.cachedPaused)) && ((_local9.cachedStartTime <= _local5)))) && (!(_local9.gc)))))){
                            if (!_local9.cachedReversed){
                                _local9.renderTime(((this.cachedTime - _local9.cachedStartTime) * _local9.cachedTimeScale), _arg2, false);
                            } else {
                                _local14 = (_local9.cacheIsDirty) ? _local9.totalDuration : _local9.cachedTotalDuration;
                                _local9.renderTime((_local14 - ((this.cachedTime - _local9.cachedStartTime) * _local9.cachedTimeScale)), _arg2, false);
                            };
                        };
                        _local9 = _local13;
                    };
                };
            };
            if (((_hasUpdate) && (!(_arg2)))){
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            if (((this._hasUpdateListener) && (!(_arg2)))){
                this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
            };
            if (((_local12) && (!(_arg2)))){
                if (this.vars.onRepeat){
                    this.vars.onRepeat.apply(null, this.vars.onRepeatParams);
                };
                if (this._dispatcher){
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
                };
            };
            if (((((_local10) && ((((_local7 == this.cachedStartTime)) || (!((_local8 == this.cachedTimeScale))))))) && ((((_local4 >= this.totalDuration)) || ((this.cachedTime == 0)))))){
                this.complete(true, _arg2);
            };
        }
        override public function complete(_arg1:Boolean=false, _arg2:Boolean=false):void{
            super.complete(_arg1, _arg2);
            if (((this._dispatcher) && (!(_arg2)))){
                if (((((this.cachedReversed) && ((this.cachedTotalTime == 0)))) && (!((this.cachedDuration == 0))))){
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REVERSE_COMPLETE));
                } else {
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                };
            };
        }
        public function getActive(_arg1:Boolean=true, _arg2:Boolean=true, _arg3:Boolean=false):Array{
            var _local6:int;
            var _local7:TweenCore;
            var _local4:Array = [];
            var _local5:Array = getChildren(_arg1, _arg2, _arg3);
            var _local8:int = _local5.length;
            var _local9:int;
            _local6 = 0;
            while (_local6 < _local8) {
                _local7 = _local5[_local6];
                if (((((((!(_local7.cachedPaused)) && ((_local7.timeline.cachedTotalTime >= _local7.cachedStartTime)))) && ((_local7.timeline.cachedTotalTime < (_local7.cachedStartTime + (_local7.cachedTotalDuration / _local7.cachedTimeScale)))))) && (!(OverwriteManager.getGlobalPaused(_local7.timeline))))){
                    var _temp1 = _local9;
                    _local9 = (_local9 + 1);
                    var _local10 = _temp1;
                    _local4[_local10] = _local5[_local6];
                };
                _local6 = (_local6 + 1);
            };
            return (_local4);
        }
        override public function invalidate():void{
            this._repeat = (this.vars.repeat) ? Number(this.vars.repeat) : 0;
            this._repeatDelay = (this.vars.repeatDelay) ? Number(this.vars.repeatDelay) : 0;
            this.yoyo = Boolean((this.vars.yoyo == true));
            if (((((((((!((this.vars.onCompleteListener == null))) || (!((this.vars.onUpdateListener == null))))) || (!((this.vars.onStartListener == null))))) || (!((this.vars.onRepeatListener == null))))) || (!((this.vars.onReverseCompleteListener == null))))){
                this.initDispatcher();
            };
            setDirtyCache(true);
            super.invalidate();
        }
        public function getLabelAfter(_arg1:Number=NaN):String{
            if (((!(_arg1)) && (!((_arg1 == 0))))){
                _arg1 = this.cachedTime;
            };
            var _local2:Array = this.getLabelsArray();
            var _local3:int = _local2.length;
            var _local4:int;
            while (_local4 < _local3) {
                if (_local2[_local4].time > _arg1){
                    return (_local2[_local4].name);
                };
                _local4 = (_local4 + 1);
            };
            return (null);
        }
        public function getLabelBefore(_arg1:Number=NaN):String{
            if (((!(_arg1)) && (!((_arg1 == 0))))){
                _arg1 = this.cachedTime;
            };
            var _local2:Array = this.getLabelsArray();
            var _local3:int = _local2.length;
            while (--_local3 > -1) {
                if (_local2[_local3].time < _arg1){
                    return (_local2[_local3].name);
                };
            };
            return (null);
        }
        protected function getLabelsArray():Array{
            var _local2:String;
            var _local1:Array = [];
            for (_local2 in _labels) {
                _local1[_local1.length] = {
                    time:_labels[_local2],
                    name:_local2
                };
            };
            _local1.sortOn("time", Array.NUMERIC);
            return (_local1);
        }
        protected function initDispatcher():void{
            if (this._dispatcher == null){
                this._dispatcher = new EventDispatcher(this);
            };
            if ((this.vars.onStartListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.START, this.vars.onStartListener, false, 0, true);
            };
            if ((this.vars.onUpdateListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.UPDATE, this.vars.onUpdateListener, false, 0, true);
                this._hasUpdateListener = true;
            };
            if ((this.vars.onCompleteListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.COMPLETE, this.vars.onCompleteListener, false, 0, true);
            };
            if ((this.vars.onRepeatListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.REPEAT, this.vars.onRepeatListener, false, 0, true);
            };
            if ((this.vars.onReverseCompleteListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.REVERSE_COMPLETE, this.vars.onReverseCompleteListener, false, 0, true);
            };
        }
        public function addEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false, _arg4:int=0, _arg5:Boolean=false):void{
            if (this._dispatcher == null){
                this.initDispatcher();
            };
            if (_arg1 == TweenEvent.UPDATE){
                this._hasUpdateListener = true;
            };
            this._dispatcher.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
        }
        public function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false):void{
            if (this._dispatcher != null){
                this._dispatcher.removeEventListener(_arg1, _arg2, _arg3);
            };
        }
        public function hasEventListener(_arg1:String):Boolean{
            return (((this._dispatcher)==null) ? false : this._dispatcher.hasEventListener(_arg1));
        }
        public function willTrigger(_arg1:String):Boolean{
            return (((this._dispatcher)==null) ? false : this._dispatcher.willTrigger(_arg1));
        }
        public function dispatchEvent(_arg1:Event):Boolean{
            return (((this._dispatcher)==null) ? false : this._dispatcher.dispatchEvent(_arg1));
        }
        public function get totalProgress():Number{
            return ((this.cachedTotalTime / this.totalDuration));
        }
        public function set totalProgress(_arg1:Number):void{
            setTotalTime((this.totalDuration * _arg1), false);
        }
        override public function get totalDuration():Number{
            var _local1:Number;
            if (this.cacheIsDirty){
                _local1 = super.totalDuration;
                this.cachedTotalDuration = ((this._repeat)==-1) ? 999999999999 : ((this.cachedDuration * (this._repeat + 1)) + (this._repeatDelay * this._repeat));
            };
            return (this.cachedTotalDuration);
        }
        override public function set currentTime(_arg1:Number):void{
            if (this._cyclesComplete == 0){
                setTotalTime(_arg1, false);
            } else {
                if (((this.yoyo) && (((this._cyclesComplete % 2) == 1)))){
                    setTotalTime(((this.duration - _arg1) + (this._cyclesComplete * (this.cachedDuration + this._repeatDelay))), false);
                } else {
                    setTotalTime((_arg1 + (this._cyclesComplete * (this.duration + this._repeatDelay))), false);
                };
            };
        }
        public function get repeat():int{
            return (this._repeat);
        }
        public function set repeat(_arg1:int):void{
            this._repeat = _arg1;
            setDirtyCache(true);
        }
        public function get repeatDelay():Number{
            return (this._repeatDelay);
        }
        public function set repeatDelay(_arg1:Number):void{
            this._repeatDelay = _arg1;
            setDirtyCache(true);
        }
        public function get currentLabel():String{
            return (this.getLabelBefore((this.cachedTime + 1E-8)));
        }

    }
}//package com.greensock 
