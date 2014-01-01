//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock {
    import com.greensock.core.*;

    public class TimelineLite extends SimpleTimeline {

        public static const version:Number = 1.691;

        private static var _overwriteMode:int = (OverwriteManager.enabled) ? OverwriteManager.mode : OverwriteManager.init(2);
;

        protected var _labels:Object;
        protected var _endCaps:Array;

        public function TimelineLite(_arg1:Object=null){
            super(_arg1);
            this._endCaps = [null, null];
            this._labels = {};
            this.autoRemoveChildren = Boolean((this.vars.autoRemoveChildren == true));
            _hasUpdate = Boolean((typeof(this.vars.onUpdate) == "function"));
            if ((this.vars.tweens is Array)){
                this.insertMultiple(this.vars.tweens, 0, ((this.vars.align)!=null) ? this.vars.align : "normal", (this.vars.stagger) ? Number(this.vars.stagger) : 0);
            };
        }
        override public function remove(_arg1:TweenCore, _arg2:Boolean=false):void{
            if (_arg1.cachedOrphan){
                return;
            };
            if (!_arg2){
                _arg1.setEnabled(false, true);
            };
            var _local3:TweenCore = (this.gc) ? this._endCaps[0] : _firstChild;
            var _local4:TweenCore = (this.gc) ? this._endCaps[1] : _lastChild;
            if (_arg1.nextNode){
                _arg1.nextNode.prevNode = _arg1.prevNode;
            } else {
                if (_local4 == _arg1){
                    _local4 = _arg1.prevNode;
                };
            };
            if (_arg1.prevNode){
                _arg1.prevNode.nextNode = _arg1.nextNode;
            } else {
                if (_local3 == _arg1){
                    _local3 = _arg1.nextNode;
                };
            };
            if (this.gc){
                this._endCaps[0] = _local3;
                this._endCaps[1] = _local4;
            } else {
                _firstChild = _local3;
                _lastChild = _local4;
            };
            _arg1.cachedOrphan = true;
            setDirtyCache(true);
        }
        override public function insert(_arg1:TweenCore, _arg2=0):TweenCore{
            var _local6:TweenCore;
            var _local7:Number;
            var _local8:SimpleTimeline;
            if (typeof(_arg2) == "string"){
                if (!(_arg2 in this._labels)){
                    this.addLabel(_arg2, this.duration);
                };
                _arg2 = Number(this._labels[_arg2]);
            };
            var _local3:SimpleTimeline = _arg1.timeline;
            if (((!(_arg1.cachedOrphan)) && (_local3))){
                _local3.remove(_arg1, true);
            };
            _arg1.timeline = this;
            _arg1.cachedStartTime = (Number(_arg2) + _arg1.delay);
            if (((_arg1.cachedPaused) && (!((_local3 == this))))){
                _arg1.cachedPauseTime = (_arg1.cachedStartTime + ((this.rawTime - _arg1.cachedStartTime) / _arg1.cachedTimeScale));
            };
            if (_arg1.gc){
                _arg1.setEnabled(true, true);
            };
            setDirtyCache(true);
            var _local4:TweenCore = (this.gc) ? this._endCaps[0] : _firstChild;
            var _local5:TweenCore = (this.gc) ? this._endCaps[1] : _lastChild;
            if (_local5 == null){
                _local5 = _arg1;
                _local4 = _local5;
                _arg1.nextNode = (_arg1.prevNode = null);
            } else {
                _local6 = _local5;
                _local7 = _arg1.cachedStartTime;
                while (((!((_local6 == null))) && ((_local7 < _local6.cachedStartTime)))) {
                    _local6 = _local6.prevNode;
                };
                if (_local6 == null){
                    _local4.prevNode = _arg1;
                    _arg1.nextNode = _local4;
                    _arg1.prevNode = null;
                    _local4 = _arg1;
                } else {
                    if (_local6.nextNode){
                        _local6.nextNode.prevNode = _arg1;
                    } else {
                        if (_local6 == _local5){
                            _local5 = _arg1;
                        };
                    };
                    _arg1.prevNode = _local6;
                    _arg1.nextNode = _local6.nextNode;
                    _local6.nextNode = _arg1;
                };
            };
            _arg1.cachedOrphan = false;
            if (this.gc){
                this._endCaps[0] = _local4;
                this._endCaps[1] = _local5;
            } else {
                _firstChild = _local4;
                _lastChild = _local5;
            };
            if (((((this.gc) && (!(this.cachedPaused)))) && (((this.cachedStartTime + ((_arg1.cachedStartTime + (_arg1.cachedTotalDuration / _arg1.cachedTimeScale)) / this.cachedTimeScale)) > this.timeline.cachedTime)))){
                if ((((this.timeline == TweenLite.rootTimeline)) || ((this.timeline == TweenLite.rootFramesTimeline)))){
                    this.setTotalTime(this.cachedTotalTime, true);
                };
                this.setEnabled(true, false);
                _local8 = this.timeline;
                while (((_local8.gc) && (_local8.timeline))) {
                    if ((_local8.cachedStartTime + (_local8.totalDuration / _local8.cachedTimeScale)) > _local8.timeline.cachedTime){
                        _local8.setEnabled(true, false);
                    };
                    _local8 = _local8.timeline;
                };
            };
            return (_arg1);
        }
        public function append(_arg1:TweenCore, _arg2:Number=0):TweenCore{
            return (this.insert(_arg1, (this.duration + _arg2)));
        }
        public function prepend(_arg1:TweenCore, _arg2:Boolean=false):TweenCore{
            this.shiftChildren(((_arg1.totalDuration / _arg1.cachedTimeScale) + _arg1.delay), _arg2, 0);
            return (this.insert(_arg1, 0));
        }
        public function insertMultiple(_arg1:Array, _arg2=0, _arg3:String="normal", _arg4:Number=0):Array{
            var _local5:int;
            var _local6:TweenCore;
            var _local7:Number = ((Number(_arg2)) || (0));
            var _local8:int = _arg1.length;
            if (typeof(_arg2) == "string"){
                if (!(_arg2 in this._labels)){
                    this.addLabel(_arg2, this.duration);
                };
                _local7 = this._labels[_arg2];
            };
            _local5 = 0;
            while (_local5 < _local8) {
                _local6 = (_arg1[_local5] as TweenCore);
                this.insert(_local6, _local7);
                if (_arg3 == "sequence"){
                    _local7 = (_local6.cachedStartTime + (_local6.totalDuration / _local6.cachedTimeScale));
                } else {
                    if (_arg3 == "start"){
                        _local6.cachedStartTime = (_local6.cachedStartTime - _local6.delay);
                    };
                };
                _local7 = (_local7 + _arg4);
                _local5 = (_local5 + 1);
            };
            return (_arg1);
        }
        public function appendMultiple(_arg1:Array, _arg2:Number=0, _arg3:String="normal", _arg4:Number=0):Array{
            return (this.insertMultiple(_arg1, (this.duration + _arg2), _arg3, _arg4));
        }
        public function prependMultiple(_arg1:Array, _arg2:String="normal", _arg3:Number=0, _arg4:Boolean=false):Array{
            var _local5:TimelineLite = new TimelineLite({
                tweens:_arg1,
                align:_arg2,
                stagger:_arg3
            });
            this.shiftChildren(_local5.duration, _arg4, 0);
            this.insertMultiple(_arg1, 0, _arg2, _arg3);
            _local5.kill();
            return (_arg1);
        }
        public function addLabel(_arg1:String, _arg2:Number):void{
            this._labels[_arg1] = _arg2;
        }
        public function removeLabel(_arg1:String):Number{
            var _local2:Number = this._labels[_arg1];
            delete this._labels[_arg1];
            return (_local2);
        }
        public function getLabelTime(_arg1:String):Number{
            return (((_arg1 in this._labels)) ? Number(this._labels[_arg1]) : -1);
        }
        protected function parseTimeOrLabel(_arg1):Number{
            if (typeof(_arg1) == "string"){
                if (!(_arg1 in this._labels)){
                    throw (new Error((("TimelineLite error: the " + _arg1) + " label was not found.")));
                };
                return (this.getLabelTime(String(_arg1)));
            };
            return (Number(_arg1));
        }
        public function stop():void{
            this.paused = true;
        }
        public function gotoAndPlay(_arg1, _arg2:Boolean=true):void{
            setTotalTime(this.parseTimeOrLabel(_arg1), _arg2);
            play();
        }
        public function gotoAndStop(_arg1, _arg2:Boolean=true):void{
            setTotalTime(this.parseTimeOrLabel(_arg1), _arg2);
            this.paused = true;
        }
        public function goto(_arg1, _arg2:Boolean=true):void{
            setTotalTime(this.parseTimeOrLabel(_arg1), _arg2);
        }
        override public function renderTime(_arg1:Number, _arg2:Boolean=false, _arg3:Boolean=false):void{
            var _local8:TweenCore;
            var _local9:Boolean;
            var _local10:Boolean;
            var _local11:TweenCore;
            var _local12:Number;
            if (this.gc){
                this.setEnabled(true, false);
            } else {
                if (((!(this.active)) && (!(this.cachedPaused)))){
                    this.active = true;
                };
            };
            var _local4:Number = (this.cacheIsDirty) ? this.totalDuration : this.cachedTotalDuration;
            var _local5:Number = this.cachedTime;
            var _local6:Number = this.cachedStartTime;
            var _local7:Number = this.cachedTimeScale;
            var _local13:Boolean = this.cachedPaused;
            if (_arg1 >= _local4){
                if ((((_rawPrevTime <= _local4)) && (!((_rawPrevTime == _arg1))))){
                    this.cachedTotalTime = (this.cachedTime = _local4);
                    this.forceChildrenToEnd(_local4, _arg2);
                    _local9 = ((!(this.hasPausedChild())) && (!(this.cachedReversed)));
                    _local10 = true;
                    if ((((((this.cachedDuration == 0)) && (_local9))) && ((((_arg1 == 0)) || ((_rawPrevTime < 0)))))){
                        _arg3 = true;
                    };
                };
            } else {
                if (_arg1 <= 0){
                    if (_arg1 < 0){
                        this.active = false;
                        if ((((this.cachedDuration == 0)) && ((_rawPrevTime >= 0)))){
                            _arg3 = true;
                            _local9 = true;
                        };
                    } else {
                        if ((((_arg1 == 0)) && (!(this.initted)))){
                            _arg3 = true;
                        };
                    };
                    if ((((_rawPrevTime >= 0)) && (!((_rawPrevTime == _arg1))))){
                        this.cachedTotalTime = 0;
                        this.cachedTime = 0;
                        this.forceChildrenToBeginning(0, _arg2);
                        _local10 = true;
                        if (this.cachedReversed){
                            _local9 = true;
                        };
                    };
                } else {
                    this.cachedTotalTime = (this.cachedTime = _arg1);
                };
            };
            _rawPrevTime = _arg1;
            if ((((this.cachedTime == _local5)) && (!(_arg3)))){
                return;
            };
            if (!this.initted){
                this.initted = true;
            };
            if ((((((((_local5 == 0)) && (this.vars.onStart))) && (!((this.cachedTime == 0))))) && (!(_arg2)))){
                this.vars.onStart.apply(null, this.vars.onStartParams);
            };
            if (_local10){
            } else {
                if ((this.cachedTime - _local5) > 0){
                    _local8 = _firstChild;
                    while (_local8) {
                        _local11 = _local8.nextNode;
                        if (((this.cachedPaused) && (!(_local13)))){
                            break;
                        };
                        if (((_local8.active) || (((((!(_local8.cachedPaused)) && ((_local8.cachedStartTime <= this.cachedTime)))) && (!(_local8.gc)))))){
                            if (!_local8.cachedReversed){
                                _local8.renderTime(((this.cachedTime - _local8.cachedStartTime) * _local8.cachedTimeScale), _arg2, false);
                            } else {
                                _local12 = (_local8.cacheIsDirty) ? _local8.totalDuration : _local8.cachedTotalDuration;
                                _local8.renderTime((_local12 - ((this.cachedTime - _local8.cachedStartTime) * _local8.cachedTimeScale)), _arg2, false);
                            };
                        };
                        _local8 = _local11;
                    };
                } else {
                    _local8 = _lastChild;
                    while (_local8) {
                        _local11 = _local8.prevNode;
                        if (((this.cachedPaused) && (!(_local13)))){
                            break;
                        };
                        if (((_local8.active) || (((((!(_local8.cachedPaused)) && ((_local8.cachedStartTime <= _local5)))) && (!(_local8.gc)))))){
                            if (!_local8.cachedReversed){
                                _local8.renderTime(((this.cachedTime - _local8.cachedStartTime) * _local8.cachedTimeScale), _arg2, false);
                            } else {
                                _local12 = (_local8.cacheIsDirty) ? _local8.totalDuration : _local8.cachedTotalDuration;
                                _local8.renderTime((_local12 - ((this.cachedTime - _local8.cachedStartTime) * _local8.cachedTimeScale)), _arg2, false);
                            };
                        };
                        _local8 = _local11;
                    };
                };
            };
            if (((_hasUpdate) && (!(_arg2)))){
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            if (((((_local9) && ((((_local6 == this.cachedStartTime)) || (!((_local7 == this.cachedTimeScale))))))) && ((((_local4 >= this.totalDuration)) || ((this.cachedTime == 0)))))){
                complete(true, _arg2);
            };
        }
        protected function forceChildrenToBeginning(_arg1:Number, _arg2:Boolean=false):Number{
            var _local4:TweenCore;
            var _local5:Number;
            var _local3:TweenCore = _lastChild;
            var _local6:Boolean = this.cachedPaused;
            while (_local3) {
                _local4 = _local3.prevNode;
                if (((this.cachedPaused) && (!(_local6)))){
                    break;
                };
                if (((_local3.active) || (((((!(_local3.cachedPaused)) && (!(_local3.gc)))) && (((!((_local3.cachedTotalTime == 0))) || ((_local3.cachedDuration == 0)))))))){
                    if ((((_arg1 == 0)) && (((!((_local3.cachedDuration == 0))) || ((_local3.cachedStartTime == 0)))))){
                        _local3.renderTime((_local3.cachedReversed) ? _local3.cachedTotalDuration : 0, _arg2, false);
                    } else {
                        if (!_local3.cachedReversed){
                            _local3.renderTime(((_arg1 - _local3.cachedStartTime) * _local3.cachedTimeScale), _arg2, false);
                        } else {
                            _local5 = (_local3.cacheIsDirty) ? _local3.totalDuration : _local3.cachedTotalDuration;
                            _local3.renderTime((_local5 - ((_arg1 - _local3.cachedStartTime) * _local3.cachedTimeScale)), _arg2, false);
                        };
                    };
                };
                _local3 = _local4;
            };
            return (_arg1);
        }
        protected function forceChildrenToEnd(_arg1:Number, _arg2:Boolean=false):Number{
            var _local4:TweenCore;
            var _local5:Number;
            var _local3:TweenCore = _firstChild;
            var _local6:Boolean = this.cachedPaused;
            while (_local3) {
                _local4 = _local3.nextNode;
                if (((this.cachedPaused) && (!(_local6)))){
                    break;
                };
                if (((_local3.active) || (((((!(_local3.cachedPaused)) && (!(_local3.gc)))) && (((!((_local3.cachedTotalTime == _local3.cachedTotalDuration))) || ((_local3.cachedDuration == 0)))))))){
                    if ((((_arg1 == this.cachedDuration)) && (((!((_local3.cachedDuration == 0))) || ((_local3.cachedStartTime == this.cachedDuration)))))){
                        _local3.renderTime((_local3.cachedReversed) ? 0 : _local3.cachedTotalDuration, _arg2, false);
                    } else {
                        if (!_local3.cachedReversed){
                            _local3.renderTime(((_arg1 - _local3.cachedStartTime) * _local3.cachedTimeScale), _arg2, false);
                        } else {
                            _local5 = (_local3.cacheIsDirty) ? _local3.totalDuration : _local3.cachedTotalDuration;
                            _local3.renderTime((_local5 - ((_arg1 - _local3.cachedStartTime) * _local3.cachedTimeScale)), _arg2, false);
                        };
                    };
                };
                _local3 = _local4;
            };
            return (_arg1);
        }
        public function hasPausedChild():Boolean{
            var _local1:TweenCore = (this.gc) ? this._endCaps[0] : _firstChild;
            while (_local1) {
                if (((_local1.cachedPaused) || ((((_local1 is TimelineLite)) && ((_local1 as TimelineLite).hasPausedChild()))))){
                    return (true);
                };
                _local1 = _local1.nextNode;
            };
            return (false);
        }
        public function getChildren(_arg1:Boolean=true, _arg2:Boolean=true, _arg3:Boolean=true, _arg4:Number=-9999999999):Array{
            var _local5:Array = [];
            var _local6:int;
            var _local7:TweenCore = (this.gc) ? this._endCaps[0] : _firstChild;
            while (_local7) {
                if (_local7.cachedStartTime < _arg4){
                } else {
                    if ((_local7 is TweenLite)){
                        if (_arg2){
                            var _temp1 = _local6;
                            _local6 = (_local6 + 1);
                            var _local8 = _temp1;
                            _local5[_local8] = _local7;
                        };
                    } else {
                        if (_arg3){
                            var _temp2 = _local6;
                            _local6 = (_local6 + 1);
                            _local8 = _temp2;
                            _local5[_local8] = _local7;
                        };
                        if (_arg1){
                            _local5 = _local5.concat(TimelineLite(_local7).getChildren(true, _arg2, _arg3));
                            _local6 = _local5.length;
                        };
                    };
                };
                _local7 = _local7.nextNode;
            };
            return (_local5);
        }
        public function getTweensOf(_arg1:Object, _arg2:Boolean=true):Array{
            var _local5:int;
            var _local3:Array = this.getChildren(_arg2, true, false);
            var _local4:Array = [];
            var _local6:int = _local3.length;
            var _local7:int;
            _local5 = 0;
            while (_local5 < _local6) {
                if (TweenLite(_local3[_local5]).target == _arg1){
                    var _temp1 = _local7;
                    _local7 = (_local7 + 1);
                    var _local8 = _temp1;
                    _local4[_local8] = _local3[_local5];
                };
                _local5 = (_local5 + 1);
            };
            return (_local4);
        }
        public function shiftChildren(_arg1:Number, _arg2:Boolean=false, _arg3:Number=0):void{
            var _local5:String;
            var _local4:TweenCore = (this.gc) ? this._endCaps[0] : _firstChild;
            while (_local4) {
                if (_local4.cachedStartTime >= _arg3){
                    _local4.cachedStartTime = (_local4.cachedStartTime + _arg1);
                };
                _local4 = _local4.nextNode;
            };
            if (_arg2){
                for (_local5 in this._labels) {
                    if (this._labels[_local5] >= _arg3){
                        this._labels[_local5] = (this._labels[_local5] + _arg1);
                    };
                };
            };
            this.setDirtyCache(true);
        }
        public function killTweensOf(_arg1:Object, _arg2:Boolean=true, _arg3:Object=null):Boolean{
            var _local6:TweenLite;
            var _local4:Array = this.getTweensOf(_arg1, _arg2);
            var _local5:int = _local4.length;
            while (--_local5 > -1) {
                _local6 = _local4[_local5];
                if (_arg3 != null){
                    _local6.killVars(_arg3);
                };
                if ((((_arg3 == null)) || ((((_local6.cachedPT1 == null)) && (_local6.initted))))){
                    _local6.setEnabled(false, false);
                };
            };
            return (Boolean((_local4.length > 0)));
        }
        override public function invalidate():void{
            var _local1:TweenCore = (this.gc) ? this._endCaps[0] : _firstChild;
            while (_local1) {
                _local1.invalidate();
                _local1 = _local1.nextNode;
            };
        }
        public function clear(_arg1:Array=null):void{
            if (_arg1 == null){
                _arg1 = this.getChildren(false, true, true);
            };
            var _local2:int = _arg1.length;
            while (--_local2 > -1) {
                TweenCore(_arg1[_local2]).setEnabled(false, false);
            };
        }
        override public function setEnabled(_arg1:Boolean, _arg2:Boolean=false):Boolean{
            var _local3:TweenCore;
            if (_arg1 == this.gc){
                if (_arg1){
                    _local3 = this._endCaps[0];
                    _firstChild = _local3;
                    _lastChild = this._endCaps[1];
                    this._endCaps = [null, null];
                } else {
                    _local3 = _firstChild;
                    this._endCaps = [_firstChild, _lastChild];
                    _firstChild = (_lastChild = null);
                };
                while (_local3) {
                    _local3.setEnabled(_arg1, true);
                    _local3 = _local3.nextNode;
                };
            };
            return (super.setEnabled(_arg1, _arg2));
        }
        public function get currentProgress():Number{
            return ((this.cachedTime / this.duration));
        }
        public function set currentProgress(_arg1:Number):void{
            setTotalTime((this.duration * _arg1), false);
        }
        override public function get duration():Number{
            var _local1:Number;
            if (this.cacheIsDirty){
                _local1 = this.totalDuration;
            };
            return (this.cachedDuration);
        }
        override public function set duration(_arg1:Number):void{
            if (((!((this.duration == 0))) && (!((_arg1 == 0))))){
                this.timeScale = (this.duration / _arg1);
            };
        }
        override public function get totalDuration():Number{
            var _local1:Number;
            var _local2:Number;
            var _local3:TweenCore;
            var _local4:Number;
            var _local5:TweenCore;
            if (this.cacheIsDirty){
                _local1 = 0;
                _local3 = (this.gc) ? this._endCaps[0] : _firstChild;
                _local4 = -(Infinity);
                while (_local3) {
                    _local5 = _local3.nextNode;
                    if (_local3.cachedStartTime < _local4){
                        this.insert(_local3, (_local3.cachedStartTime - _local3.delay));
                    } else {
                        _local4 = _local3.cachedStartTime;
                    };
                    if (_local3.cachedStartTime < 0){
                        _local1 = (_local1 - _local3.cachedStartTime);
                        this.shiftChildren(-(_local3.cachedStartTime), false, -9999999999);
                    };
                    _local2 = (_local3.cachedStartTime + (_local3.totalDuration / _local3.cachedTimeScale));
                    if (_local2 > _local1){
                        _local1 = _local2;
                    };
                    _local3 = _local5;
                };
                this.cachedDuration = (this.cachedTotalDuration = _local1);
                this.cacheIsDirty = false;
            };
            return (this.cachedTotalDuration);
        }
        override public function set totalDuration(_arg1:Number):void{
            if (((!((this.totalDuration == 0))) && (!((_arg1 == 0))))){
                this.timeScale = (this.totalDuration / _arg1);
            };
        }
        public function get timeScale():Number{
            return (this.cachedTimeScale);
        }
        public function set timeScale(_arg1:Number):void{
            if (_arg1 == 0){
                _arg1 = 0.0001;
            };
            var _local2:Number = (((this.cachedPauseTime) || ((this.cachedPauseTime == 0)))) ? this.cachedPauseTime : this.timeline.cachedTotalTime;
            this.cachedStartTime = (_local2 - (((_local2 - this.cachedStartTime) * this.cachedTimeScale) / _arg1));
            this.cachedTimeScale = _arg1;
            setDirtyCache(false);
        }
        public function get useFrames():Boolean{
            var _local1:SimpleTimeline = this.timeline;
            while (_local1.timeline) {
                _local1 = _local1.timeline;
            };
            return (Boolean((_local1 == TweenLite.rootFramesTimeline)));
        }
        override public function get rawTime():Number{
            if (((this.cachedPaused) || (((!((this.cachedTotalTime == 0))) && (!((this.cachedTotalTime == this.cachedTotalDuration))))))){
                return (this.cachedTotalTime);
            };
            return (((this.timeline.rawTime - this.cachedStartTime) * this.cachedTimeScale));
        }

    }
}//package com.greensock 
