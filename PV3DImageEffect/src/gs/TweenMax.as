//Created by Action Script Viewer - http://www.buraks.com/asv
package gs {
    import flash.events.*;
    import flash.utils.*;
    import gs.plugins.*;
    import gs.utils.tween.*;
    import gs.events.*;

    public class TweenMax extends TweenLite implements IEventDispatcher {

        public static const version:Number = 10.06;

        public static var removeTween:Function = TweenLite.removeTween;
        private static var _overwriteMode:int = (OverwriteManager.enabled) ? OverwriteManager.mode : OverwriteManager.init();
;
        protected static var _pausedTweens:Dictionary = new Dictionary(false);
        protected static var _globalTimeScale:Number = 1;
        public static var killTweensOf:Function = TweenLite.killTweensOf;
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
        private static var _activatedPlugins:Boolean = TweenPlugin.activate([TintPlugin, RemoveTintPlugin, FramePlugin, AutoAlphaPlugin, VisiblePlugin, VolumePlugin, EndArrayPlugin, HexColorsPlugin, BlurFilterPlugin, ColorMatrixFilterPlugin, BevelFilterPlugin, DropShadowFilterPlugin, GlowFilterPlugin, RoundPropsPlugin, BezierPlugin, BezierThroughPlugin, ShortRotationPlugin]);
        private static var _versionCheck:Boolean = ((TweenLite.version)<10.06) ? trace("TweenMax error! Please update your TweenLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.") : true;
;

        protected var _dispatcher:EventDispatcher;
        protected var _callbacks:Object;
        public var pauseTime:Number;
        protected var _repeatCount:Number;
        protected var _timeScale:Number;

        public function TweenMax(_arg1:Object, _arg2:Number, _arg3:Object){
            super(_arg1, _arg2, _arg3);
            if (((!((this.combinedTimeScale == 1))) && ((this.target is TweenMax)))){
                this._timeScale = 1;
                this.combinedTimeScale = _globalTimeScale;
            } else {
                this._timeScale = this.combinedTimeScale;
                this.combinedTimeScale = (this.combinedTimeScale * _globalTimeScale);
            };
            if (((!((this.combinedTimeScale == 1))) && (!((this.delay == 0))))){
                this.startTime = (this.initTime + (this.delay * (1000 / this.combinedTimeScale)));
            };
            if (((((!((this.vars.onCompleteListener == null))) || (!((this.vars.onUpdateListener == null))))) || (!((this.vars.onStartListener == null))))){
                this.initDispatcher();
                if ((((_arg2 == 0)) && ((this.delay == 0)))){
                    this.onUpdateDispatcher();
                    this.onCompleteDispatcher();
                };
            };
            this._repeatCount = 0;
            if (((!(isNaN(this.vars.yoyo))) || (!(isNaN(this.vars.loop))))){
                this.vars.persist = true;
            };
        }
        public static function set globalTimeScale(_arg1:Number):void{
            setGlobalTimeScale(_arg1);
        }
        public static function pauseAll(_arg1:Boolean=true, _arg2:Boolean=false):void{
            changePause(true, _arg1, _arg2);
        }
        public static function killAllDelayedCalls(_arg1:Boolean=false):void{
            killAll(_arg1, false, true);
        }
        public static function setGlobalTimeScale(_arg1:Number):void{
            var _local3:int;
            var _local4:Array;
            if (_arg1 < 1E-5){
                _arg1 = 1E-5;
            };
            var _local2:Dictionary = masterList;
            _globalTimeScale = _arg1;
            for each (_local4 in _local2) {
                _local3 = (_local4.length - 1);
                while (_local3 > -1) {
                    if ((_local4[_local3] is TweenMax)){
                        _local4[_local3].timeScale = (_local4[_local3].timeScale * 1);
                    };
                    _local3--;
                };
            };
        }
        public static function get globalTimeScale():Number{
            return (_globalTimeScale);
        }
        public static function getTweensOf(_arg1:Object):Array{
            var _local4:TweenLite;
            var _local5:int;
            var _local2:Array = masterList[_arg1];
            var _local3:Array = [];
            if (_local2 != null){
                _local5 = (_local2.length - 1);
                while (_local5 > -1) {
                    if (!_local2[_local5].gc){
                        _local3[_local3.length] = _local2[_local5];
                    };
                    _local5--;
                };
            };
            for each (_local4 in _pausedTweens) {
                if (_local4.target == _arg1){
                    _local3[_local3.length] = _local4;
                };
            };
            return (_local3);
        }
        public static function delayedCall(_arg1:Number, _arg2:Function, _arg3:Array=null, _arg4:Boolean=false):TweenMax{
            return (new TweenMax(_arg2, 0, {
                delay:_arg1,
                onComplete:_arg2,
                onCompleteParams:_arg3,
                persist:_arg4,
                overwrite:0
            }));
        }
        public static function isTweening(_arg1:Object):Boolean{
            var _local2:Array = getTweensOf(_arg1);
            var _local3:int = (_local2.length - 1);
            while (_local3 > -1) {
                if (((_local2[_local3].active) && (!(_local2[_local3].gc)))){
                    return (true);
                };
                _local3--;
            };
            return (false);
        }
        public static function changePause(_arg1:Boolean, _arg2:Boolean=true, _arg3:Boolean=false):void{
            var _local5:Boolean;
            var _local4:Array = getAllTweens();
            var _local6:int = (_local4.length - 1);
            while (_local6 > -1) {
                _local5 = (_local4[_local6].target == _local4[_local6].vars.onComplete);
                if ((((_local4[_local6] is TweenMax)) && ((((_local5 == _arg3)) || (!((_local5 == _arg2))))))){
                    _local4[_local6].paused = _arg1;
                };
                _local6--;
            };
        }
        public static function killAllTweens(_arg1:Boolean=false):void{
            killAll(_arg1, true, false);
        }
        public static function from(_arg1:Object, _arg2:Number, _arg3:Object):TweenMax{
            _arg3.runBackwards = true;
            return (new TweenMax(_arg1, _arg2, _arg3));
        }
        public static function killAll(_arg1:Boolean=false, _arg2:Boolean=true, _arg3:Boolean=true):void{
            var _local5:Boolean;
            var _local6:int;
            var _local4:Array = getAllTweens();
            _local6 = (_local4.length - 1);
            while (_local6 > -1) {
                _local5 = (_local4[_local6].target == _local4[_local6].vars.onComplete);
                if ((((_local5 == _arg3)) || (!((_local5 == _arg2))))){
                    if (_arg1){
                        _local4[_local6].complete(false);
                        _local4[_local6].clear();
                    } else {
                        TweenLite.removeTween(_local4[_local6], true);
                    };
                };
                _local6--;
            };
        }
        public static function getAllTweens():Array{
            var _local3:Array;
            var _local4:int;
            var _local5:TweenLite;
            var _local1:Dictionary = masterList;
            var _local2:Array = [];
            for each (_local3 in _local1) {
                _local4 = (_local3.length - 1);
                while (_local4 > -1) {
                    if (!_local3[_local4].gc){
                        _local2[_local2.length] = _local3[_local4];
                    };
                    _local4--;
                };
            };
            for each (_local5 in _pausedTweens) {
                _local2[_local2.length] = _local5;
            };
            return (_local2);
        }
        public static function resumeAll(_arg1:Boolean=true, _arg2:Boolean=false):void{
            changePause(false, _arg1, _arg2);
        }
        public static function to(_arg1:Object, _arg2:Number, _arg3:Object):TweenMax{
            return (new TweenMax(_arg1, _arg2, _arg3));
        }

        public function dispatchEvent(_arg1:Event):Boolean{
            if (this._dispatcher == null){
                return (false);
            };
            return (this._dispatcher.dispatchEvent(_arg1));
        }
        public function get reversed():Boolean{
            return ((this.ease == this.reverseEase));
        }
        public function set reversed(_arg1:Boolean):void{
            if (this.reversed != _arg1){
                this.reverse();
            };
        }
        public function get progress():Number{
            var _local1:Number = (isNaN(this.pauseTime)) ? currentTime : this.pauseTime;
            var _local2:Number = (((((_local1 - this.initTime) * 0.001) - (this.delay / this.combinedTimeScale)) / this.duration) * this.combinedTimeScale);
            if (_local2 > 1){
                return (1);
            };
            if (_local2 < 0){
                return (0);
            };
            return (_local2);
        }
        override public function set enabled(_arg1:Boolean):void{
            if (!_arg1){
                _pausedTweens[this] = null;
                delete _pausedTweens[this];
            };
            super.enabled = _arg1;
            if (_arg1){
                this.combinedTimeScale = (this._timeScale * _globalTimeScale);
            };
        }
        protected function onStartDispatcher(... _args):void{
            if (this._callbacks.onStart != null){
                this._callbacks.onStart.apply(null, this.vars.onStartParams);
            };
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
        }
        public function setDestination(_arg1:String, _arg2, _arg3:Boolean=true):void{
            var _local5:int;
            var _local6:Object;
            var _local7:Array;
            var _local8:Boolean;
            var _local9:Array;
            var _local10:Object;
            var _local11:int;
            var _local12:Array;
            var _local4:Number = this.progress;
            if (this.initted){
                if (((!(_arg3)) && (!((_local4 == 0))))){
                    _local5 = (this.tweens.length - 1);
                    while (_local5 > -1) {
                        if (this.tweens[_local5].name == _arg1){
                            this.tweens[_local5].target[this.tweens[_local5].property] = this.tweens[_local5].start;
                        };
                        _local5--;
                    };
                };
                _local6 = this.vars;
                _local7 = this.tweens;
                _local8 = _hasPlugins;
                this.tweens = [];
                this.vars = (this.exposedVars = {});
                this.vars[_arg1] = _arg2;
                this.initTweenVals();
                if (((!((this.ease == this.reverseEase))) && ((_local6.ease is Function)))){
                    this.ease = _local6.ease;
                };
                if (((_arg3) && (!((_local4 == 0))))){
                    this.adjustStartValues();
                };
                _local9 = this.tweens;
                this.vars = _local6;
                this.tweens = _local7;
                _local10 = {};
                _local5 = (_local9.length - 1);
                while (_local5 > -1) {
                    if (_local9[_local5][4] == "_MULTIPLE_"){
                        _local12 = _local9[_local5][0].overwriteProps;
                        _local11 = (_local12.length - 1);
                        while (_local11 > -1) {
                            _local10[_local12[_local11]] = true;
                            _local11--;
                        };
                    } else {
                        _local10[_local9[_local5][4]] = true;
                    };
                    _local5--;
                };
                killVars(_local10);
                this.tweens = this.tweens.concat(_local9);
                _hasPlugins = Boolean(((_local8) || (_hasPlugins)));
            };
            this.vars[_arg1] = _arg2;
        }
        override public function initTweenVals():void{
            var _local1:int;
            var _local2:int;
            var _local3:String;
            var _local4:String;
            var _local5:Array;
            var _local6:Object;
            var _local7:TweenInfo;
            if (this.exposedVars.startAt != null){
                this.exposedVars.startAt.overwrite = 0;
                new TweenMax(this.target, 0, this.exposedVars.startAt);
            };
            super.initTweenVals();
            if ((((this.exposedVars.roundProps is Array)) && (!((TweenLite.plugins.roundProps == null))))){
                _local5 = this.exposedVars.roundProps;
                _local1 = (_local5.length - 1);
                while (_local1 > -1) {
                    _local3 = _local5[_local1];
                    _local2 = (this.tweens.length - 1);
                    while (_local2 > -1) {
                        _local7 = this.tweens[_local2];
                        if (_local7.name == _local3){
                            if (_local7.isPlugin){
                                _local7.target.round = true;
                            } else {
                                if (_local6 == null){
                                    _local6 = new TweenLite.plugins.roundProps();
                                    _local6.add(_local7.target, _local3, _local7.start, _local7.change);
                                    _hasPlugins = true;
                                    this.tweens[_local2] = new TweenInfo(_local6, "changeFactor", 0, 1, _local3, true);
                                } else {
                                    _local6.add(_local7.target, _local3, _local7.start, _local7.change);
                                    this.tweens.splice(_local2, 1);
                                };
                            };
                        } else {
                            if (((((_local7.isPlugin) && ((_local7.name == "_MULTIPLE_")))) && (!(_local7.target.round)))){
                                _local4 = ((" " + _local7.target.overwriteProps.join(" ")) + " ");
                                if (_local4.indexOf(((" " + _local3) + " ")) != -1){
                                    _local7.target.round = true;
                                };
                            };
                        };
                        _local2--;
                    };
                    _local1--;
                };
            };
        }
        public function restart(_arg1:Boolean=false):void{
            if (_arg1){
                this.initTime = currentTime;
                this.startTime = (currentTime + (this.delay * (1000 / this.combinedTimeScale)));
            } else {
                this.startTime = currentTime;
                this.initTime = (currentTime - (this.delay * (1000 / this.combinedTimeScale)));
            };
            this._repeatCount = 0;
            if (this.target != this.vars.onComplete){
                this.render(this.startTime);
            };
            this.pauseTime = NaN;
            _pausedTweens[this] = null;
            delete _pausedTweens[this];
            this.enabled = true;
        }
        public function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false):void{
            if (this._dispatcher != null){
                this._dispatcher.removeEventListener(_arg1, _arg2, _arg3);
            };
        }
        public function addEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false, _arg4:int=0, _arg5:Boolean=false):void{
            if (this._dispatcher == null){
                this.initDispatcher();
            };
            if ((((_arg1 == TweenEvent.UPDATE)) && (!((this.vars.onUpdate == this.onUpdateDispatcher))))){
                this.vars.onUpdate = this.onUpdateDispatcher;
                _hasUpdate = true;
            };
            this._dispatcher.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
        }
        protected function adjustStartValues():void{
            var _local2:Number;
            var _local3:Number;
            var _local4:Number;
            var _local5:TweenInfo;
            var _local6:int;
            var _local1:Number = this.progress;
            if (_local1 != 0){
                _local2 = this.ease(_local1, 0, 1, 1);
                _local3 = (1 / (1 - _local2));
                _local6 = (this.tweens.length - 1);
                while (_local6 > -1) {
                    _local5 = this.tweens[_local6];
                    _local4 = (_local5.start + _local5.change);
                    if (_local5.isPlugin){
                        _local5.change = ((_local4 - _local2) * _local3);
                    } else {
                        _local5.change = ((_local4 - _local5.target[_local5.property]) * _local3);
                    };
                    _local5.start = (_local4 - _local5.change);
                    _local6--;
                };
            };
        }
        override public function render(_arg1:uint):void{
            var _local3:Number;
            var _local4:TweenInfo;
            var _local5:int;
            var _local2:Number = (((_arg1 - this.startTime) * 0.001) * this.combinedTimeScale);
            if (_local2 >= this.duration){
                _local2 = this.duration;
                _local3 = ((((this.ease == this.vars.ease)) || ((this.duration == 0.001)))) ? 1 : 0;
            } else {
                _local3 = this.ease(_local2, 0, 1, this.duration);
            };
            _local5 = (this.tweens.length - 1);
            while (_local5 > -1) {
                _local4 = this.tweens[_local5];
                _local4.target[_local4.property] = (_local4.start + (_local3 * _local4.change));
                _local5--;
            };
            if (_hasUpdate){
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            if (_local2 == this.duration){
                this.complete(true);
            };
        }
        protected function initDispatcher():void{
            var _local1:Object;
            var _local2:String;
            if (this._dispatcher == null){
                this._dispatcher = new EventDispatcher(this);
                this._callbacks = {
                    onStart:this.vars.onStart,
                    onUpdate:this.vars.onUpdate,
                    onComplete:this.vars.onComplete
                };
                if (this.vars.isTV == true){
                    this.vars = this.vars.clone();
                } else {
                    _local1 = {};
                    for (_local2 in this.vars) {
                        _local1[_local2] = this.vars[_local2];
                    };
                    this.vars = _local1;
                };
                this.vars.onStart = this.onStartDispatcher;
                this.vars.onComplete = this.onCompleteDispatcher;
                if ((this.vars.onStartListener is Function)){
                    this._dispatcher.addEventListener(TweenEvent.START, this.vars.onStartListener, false, 0, true);
                };
                if ((this.vars.onUpdateListener is Function)){
                    this._dispatcher.addEventListener(TweenEvent.UPDATE, this.vars.onUpdateListener, false, 0, true);
                    this.vars.onUpdate = this.onUpdateDispatcher;
                    _hasUpdate = true;
                };
                if ((this.vars.onCompleteListener is Function)){
                    this._dispatcher.addEventListener(TweenEvent.COMPLETE, this.vars.onCompleteListener, false, 0, true);
                };
            };
        }
        public function willTrigger(_arg1:String):Boolean{
            if (this._dispatcher == null){
                return (false);
            };
            return (this._dispatcher.willTrigger(_arg1));
        }
        public function set progress(_arg1:Number):void{
            this.startTime = (currentTime - ((this.duration * _arg1) * 1000));
            this.initTime = (this.startTime - (this.delay * (1000 / this.combinedTimeScale)));
            if (!this.started){
                activate();
            };
            this.render(currentTime);
            if (!isNaN(this.pauseTime)){
                this.pauseTime = currentTime;
                this.startTime = 999999999999999;
                this.active = false;
            };
        }
        public function reverse(_arg1:Boolean=true, _arg2:Boolean=true):void{
            this.ease = ((this.vars.ease)==this.ease) ? this.reverseEase : this.vars.ease;
            var _local3:Number = this.progress;
            if (((_arg1) && ((_local3 > 0)))){
                this.startTime = (currentTime - ((((1 - _local3) * this.duration) * 1000) / this.combinedTimeScale));
                this.initTime = (this.startTime - (this.delay * (1000 / this.combinedTimeScale)));
            };
            if (_arg2 != false){
                if (_local3 < 1){
                    this.resume();
                } else {
                    this.restart();
                };
            };
        }
        protected function onUpdateDispatcher(... _args):void{
            if (this._callbacks.onUpdate != null){
                this._callbacks.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
        }
        public function set paused(_arg1:Boolean):void{
            if (_arg1){
                this.pause();
            } else {
                this.resume();
            };
        }
        public function resume():void{
            this.enabled = true;
            if (!isNaN(this.pauseTime)){
                this.initTime = (this.initTime + (currentTime - this.pauseTime));
                this.startTime = (this.initTime + (this.delay * (1000 / this.combinedTimeScale)));
                this.pauseTime = NaN;
                if (((!(this.started)) && ((currentTime >= this.startTime)))){
                    activate();
                } else {
                    this.active = this.started;
                };
                _pausedTweens[this] = null;
                delete _pausedTweens[this];
            };
        }
        public function get paused():Boolean{
            return (isNaN(this.pauseTime));
        }
        public function reverseEase(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return (this.vars.ease((_arg4 - _arg1), _arg2, _arg3, _arg4));
        }
        public function killProperties(_arg1:Array):void{
            var _local3:int;
            var _local2:Object = {};
            _local3 = (_arg1.length - 1);
            while (_local3 > -1) {
                _local2[_arg1[_local3]] = true;
                _local3--;
            };
            killVars(_local2);
        }
        public function hasEventListener(_arg1:String):Boolean{
            if (this._dispatcher == null){
                return (false);
            };
            return (this._dispatcher.hasEventListener(_arg1));
        }
        public function pause():void{
            if (isNaN(this.pauseTime)){
                this.pauseTime = currentTime;
                this.startTime = 999999999999999;
                this.enabled = false;
                _pausedTweens[this] = this;
            };
        }
        override public function complete(_arg1:Boolean=false):void{
            if (((((!(isNaN(this.vars.yoyo))) && ((((this._repeatCount < this.vars.yoyo)) || ((this.vars.yoyo == 0)))))) || (((!(isNaN(this.vars.loop))) && ((((this._repeatCount < this.vars.loop)) || ((this.vars.loop == 0)))))))){
                this._repeatCount++;
                if (!isNaN(this.vars.yoyo)){
                    this.ease = ((this.vars.ease)==this.ease) ? this.reverseEase : this.vars.ease;
                };
                this.startTime = (_arg1) ? (this.startTime + (this.duration * (1000 / this.combinedTimeScale))) : currentTime;
                this.initTime = (this.startTime - (this.delay * (1000 / this.combinedTimeScale)));
            } else {
                if (this.vars.persist == true){
                    this.pause();
                };
            };
            super.complete(_arg1);
        }
        public function set timeScale(_arg1:Number):void{
            if (_arg1 < 1E-5){
                _arg1 = (this._timeScale = 1E-5);
            } else {
                this._timeScale = _arg1;
                _arg1 = (_arg1 * _globalTimeScale);
            };
            this.initTime = ((currentTime - ((((currentTime - this.initTime) - (this.delay * (1000 / this.combinedTimeScale))) * this.combinedTimeScale) * (1 / _arg1))) - (this.delay * (1000 / _arg1)));
            if (this.startTime != 999999999999999){
                this.startTime = (this.initTime + (this.delay * (1000 / _arg1)));
            };
            this.combinedTimeScale = _arg1;
        }
        public function invalidate(_arg1:Boolean=true):void{
            var _local2:Number;
            if (this.initted){
                _local2 = this.progress;
                if (((!(_arg1)) && (!((_local2 == 0))))){
                    this.progress = 0;
                };
                this.tweens = [];
                _hasPlugins = false;
                this.exposedVars = ((this.vars.isTV)==true) ? this.vars.exposedProps : this.vars;
                this.initTweenVals();
                this._timeScale = ((this.vars.timeScale) || (1));
                this.combinedTimeScale = (this._timeScale * _globalTimeScale);
                this.delay = ((this.vars.delay) || (0));
                if (isNaN(this.pauseTime)){
                    this.startTime = (this.initTime + ((this.delay * 1000) / this.combinedTimeScale));
                };
                if (((((!((this.vars.onCompleteListener == null))) || (!((this.vars.onUpdateListener == null))))) || (!((this.vars.onStartListener == null))))){
                    if (this._dispatcher != null){
                        this.vars.onStart = this._callbacks.onStart;
                        this.vars.onUpdate = this._callbacks.onUpdate;
                        this.vars.onComplete = this._callbacks.onComplete;
                        this._dispatcher = null;
                    };
                    this.initDispatcher();
                };
                if (_local2 != 0){
                    if (_arg1){
                        this.adjustStartValues();
                    } else {
                        this.progress = _local2;
                    };
                };
            };
        }
        public function get timeScale():Number{
            return (this._timeScale);
        }
        protected function onCompleteDispatcher(... _args):void{
            if (this._callbacks.onComplete != null){
                this._callbacks.onComplete.apply(null, this.vars.onCompleteParams);
            };
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
        }

    }
}//package gs 
