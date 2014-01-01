//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.core {

    public class SimpleTimeline extends TweenCore {

        protected var _firstChild:TweenCore;
        protected var _lastChild:TweenCore;
        public var autoRemoveChildren:Boolean;

        public function SimpleTimeline(_arg1:Object=null){
            super(0, _arg1);
        }
        public function insert(_arg1:TweenCore, _arg2=0):TweenCore{
            var _local3:SimpleTimeline = _arg1.timeline;
            if (((!(_arg1.cachedOrphan)) && (_local3))){
                _local3.remove(_arg1, true);
            };
            _arg1.timeline = this;
            _arg1.cachedStartTime = (Number(_arg2) + _arg1.delay);
            if (_arg1.gc){
                _arg1.setEnabled(true, true);
            };
            if (((_arg1.cachedPaused) && (!((_local3 == this))))){
                _arg1.cachedPauseTime = (_arg1.cachedStartTime + ((this.rawTime - _arg1.cachedStartTime) / _arg1.cachedTimeScale));
            };
            if (this._lastChild){
                this._lastChild.nextNode = _arg1;
            } else {
                this._firstChild = _arg1;
            };
            _arg1.prevNode = this._lastChild;
            this._lastChild = _arg1;
            _arg1.nextNode = null;
            _arg1.cachedOrphan = false;
            return (_arg1);
        }
        public function remove(_arg1:TweenCore, _arg2:Boolean=false):void{
            if (_arg1.cachedOrphan){
                return;
            };
            if (!_arg2){
                _arg1.setEnabled(false, true);
            };
            if (_arg1.nextNode){
                _arg1.nextNode.prevNode = _arg1.prevNode;
            } else {
                if (this._lastChild == _arg1){
                    this._lastChild = _arg1.prevNode;
                };
            };
            if (_arg1.prevNode){
                _arg1.prevNode.nextNode = _arg1.nextNode;
            } else {
                if (this._firstChild == _arg1){
                    this._firstChild = _arg1.nextNode;
                };
            };
            _arg1.cachedOrphan = true;
        }
        override public function renderTime(_arg1:Number, _arg2:Boolean=false, _arg3:Boolean=false):void{
            var _local5:Number;
            var _local6:TweenCore;
            var _local4:TweenCore = this._firstChild;
            this.cachedTotalTime = _arg1;
            this.cachedTime = _arg1;
            while (_local4) {
                _local6 = _local4.nextNode;
                if (((_local4.active) || ((((((_arg1 >= _local4.cachedStartTime)) && (!(_local4.cachedPaused)))) && (!(_local4.gc)))))){
                    if (!_local4.cachedReversed){
                        _local4.renderTime(((_arg1 - _local4.cachedStartTime) * _local4.cachedTimeScale), _arg2, false);
                    } else {
                        _local5 = (_local4.cacheIsDirty) ? _local4.totalDuration : _local4.cachedTotalDuration;
                        _local4.renderTime((_local5 - ((_arg1 - _local4.cachedStartTime) * _local4.cachedTimeScale)), _arg2, false);
                    };
                };
                _local4 = _local6;
            };
        }
        public function get rawTime():Number{
            return (this.cachedTotalTime);
        }

    }
}//package com.greensock.core 
