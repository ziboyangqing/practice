//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock {
    import flash.display.*;
    import com.greensock.core.*;
    import flash.events.*;
    import com.greensock.plugins.*;
    import flash.utils.*;

    public class TweenLite extends TweenCore {

        public static const version:Number = 11.691;

        public static var plugins:Object = {};
        public static var fastEaseLookup:Dictionary = new Dictionary(false);
        public static var onPluginEvent:Function;
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
        public static var defaultEase:Function = TweenLite.easeOut;
        public static var overwriteManager:Object;
        public static var rootFrame:Number;
        public static var rootTimeline:SimpleTimeline;
        public static var rootFramesTimeline:SimpleTimeline;
        public static var masterList:Dictionary = new Dictionary(false);
        private static var _shape:Shape = new Shape();
        protected static var _reservedProps:Object = {
            ease:1,
            delay:1,
            overwrite:1,
            onComplete:1,
            onCompleteParams:1,
            useFrames:1,
            runBackwards:1,
            startAt:1,
            onUpdate:1,
            onUpdateParams:1,
            onStart:1,
            onStartParams:1,
            onInit:1,
            onInitParams:1,
            onReverseComplete:1,
            onReverseCompleteParams:1,
            onRepeat:1,
            onRepeatParams:1,
            proxiedEase:1,
            easeParams:1,
            yoyo:1,
            onCompleteListener:1,
            onUpdateListener:1,
            onStartListener:1,
            onReverseCompleteListener:1,
            onRepeatListener:1,
            orientToBezier:1,
            timeScale:1,
            immediateRender:1,
            repeat:1,
            repeatDelay:1,
            timeline:1,
            data:1,
            paused:1
        };

        public var target:Object;
        public var propTweenLookup:Object;
        public var ratio:Number = 0;
        public var cachedPT1:PropTween;
        protected var _ease:Function;
        protected var _overwrite:int;
        protected var _overwrittenProps:Object;
        protected var _hasPlugins:Boolean;
        protected var _notifyPluginsOfEnabled:Boolean;

        public function TweenLite(_arg1:Object, _arg2:Number, _arg3:Object){
            var _local5:TweenLite;
            super(_arg2, _arg3);
            if (_arg1 == null){
                throw (new Error("Cannot tween a null object."));
            };
            this.target = _arg1;
            if ((((this.target is TweenCore)) && (this.vars.timeScale))){
                this.cachedTimeScale = 1;
            };
            this.propTweenLookup = {};
            this._ease = defaultEase;
            this._overwrite = (((!((Number(_arg3.overwrite) > -1))) || (((!(overwriteManager.enabled)) && ((_arg3.overwrite > 1)))))) ? overwriteManager.mode : int(_arg3.overwrite);
            var _local4:Array = masterList[_arg1];
            if (!_local4){
                masterList[_arg1] = [this];
            } else {
                if (this._overwrite == 1){
                    for each (_local5 in _local4) {
                        if (!_local5.gc){
                            _local5.setEnabled(false, false);
                        };
                    };
                    masterList[_arg1] = [this];
                } else {
                    _local4[_local4.length] = this;
                };
            };
            if (((this.active) || (this.vars.immediateRender))){
                this.renderTime(0, false, true);
            };
        }
        public static function initClass():void{
            rootFrame = 0;
            rootTimeline = new SimpleTimeline(null);
            rootFramesTimeline = new SimpleTimeline(null);
            rootTimeline.cachedStartTime = (getTimer() * 0.001);
            rootFramesTimeline.cachedStartTime = rootFrame;
            rootTimeline.autoRemoveChildren = true;
            rootFramesTimeline.autoRemoveChildren = true;
            _shape.addEventListener(Event.ENTER_FRAME, updateAll, false, 0, true);
            if (overwriteManager == null){
                overwriteManager = {
                    mode:1,
                    enabled:false
                };
            };
        }
        public static function to(_arg1:Object, _arg2:Number, _arg3:Object):TweenLite{
            return (new TweenLite(_arg1, _arg2, _arg3));
        }
        public static function from(_arg1:Object, _arg2:Number, _arg3:Object):TweenLite{
            if (_arg3.isGSVars){
                _arg3 = _arg3.vars;
            };
            _arg3.runBackwards = true;
            if (!("immediateRender" in _arg3)){
                _arg3.immediateRender = true;
            };
            return (new TweenLite(_arg1, _arg2, _arg3));
        }
        public static function delayedCall(_arg1:Number, _arg2:Function, _arg3:Array=null, _arg4:Boolean=false):TweenLite{
            return (new TweenLite(_arg2, 0, {
                delay:_arg1,
                onComplete:_arg2,
                onCompleteParams:_arg3,
                immediateRender:false,
                useFrames:_arg4,
                overwrite:0
            }));
        }
        protected static function updateAll(_arg1:Event=null):void{
            var _local2:Dictionary;
            var _local3:Object;
            var _local4:Array;
            var _local5:int;
            rootTimeline.renderTime((((getTimer() * 0.001) - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale), false, false);
            rootFrame = (rootFrame + 1);
            rootFramesTimeline.renderTime(((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale), false, false);
            if (!(rootFrame % 60)){
                _local2 = masterList;
                for (_local3 in _local2) {
                    _local4 = _local2[_local3];
                    _local5 = _local4.length;
                    while (--_local5 > -1) {
                        if (TweenLite(_local4[_local5]).gc){
                            _local4.splice(_local5, 1);
                        };
                    };
                    if (_local4.length == 0){
                        delete _local2[_local3];
                    };
                };
            };
        }
        public static function killTweensOf(_arg1:Object, _arg2:Boolean=false, _arg3:Object=null):void{
            var _local4:Array;
            var _local5:int;
            var _local6:TweenLite;
            if ((_arg1 in masterList)){
                _local4 = masterList[_arg1];
                _local5 = _local4.length;
                while (--_local5 > -1) {
                    _local6 = _local4[_local5];
                    if (!_local6.gc){
                        if (_arg2){
                            _local6.complete(false, false);
                        };
                        if (_arg3 != null){
                            _local6.killVars(_arg3);
                        };
                        if ((((_arg3 == null)) || ((((_local6.cachedPT1 == null)) && (_local6.initted))))){
                            _local6.setEnabled(false, false);
                        };
                    };
                };
                if (_arg3 == null){
                    delete masterList[_arg1];
                };
            };
        }
        protected static function easeOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = (1 - (_arg1 / _arg4));
            return ((1 - (_arg1 * _arg1)));
        }

        protected function init():void{
            var _local1:String;
            var _local2:int;
            var _local3:*;
            var _local4:Boolean;
            var _local5:Array;
            var _local6:PropTween;
            if (this.vars.onInit){
                this.vars.onInit.apply(null, this.vars.onInitParams);
            };
            if (typeof(this.vars.ease) == "function"){
                this._ease = this.vars.ease;
            };
            if (this.vars.easeParams){
                this.vars.proxiedEase = this._ease;
                this._ease = this.easeProxy;
            };
            this.cachedPT1 = null;
            this.propTweenLookup = {};
            for (_local1 in this.vars) {
                if (_local1 == "time"){
                } else {
                    if ((((_local1 in _reservedProps)) && (!((((_local1 == "timeScale")) && ((this.target is TweenCore))))))){
                    } else {
                        if ((((_local1 in plugins)) && ((_local3 = new ((plugins[_local1] as Class))()).onInitTween(this.target, this.vars[_local1], this)))){
                            this.cachedPT1 = new PropTween(_local3, "changeFactor", 0, 1, ((_local3.overwriteProps.length)==1) ? _local3.overwriteProps[0] : "_MULTIPLE_", true, this.cachedPT1);
                            if (this.cachedPT1.name == "_MULTIPLE_"){
                                _local2 = _local3.overwriteProps.length;
                                while (--_local2 > -1) {
                                    this.propTweenLookup[_local3.overwriteProps[_local2]] = this.cachedPT1;
                                };
                            } else {
                                this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
                            };
                            if (_local3.priority){
                                this.cachedPT1.priority = _local3.priority;
                                _local4 = true;
                            };
                            if (((_local3.onDisable) || (_local3.onEnable))){
                                this._notifyPluginsOfEnabled = true;
                            };
                            this._hasPlugins = true;
                        } else {
                            this.cachedPT1 = new PropTween(this.target, _local1, Number(this.target[_local1]), ((typeof(this.vars[_local1]))=="number") ? (Number(this.vars[_local1]) - this.target[_local1]) : Number(this.vars[_local1]), _local1, false, this.cachedPT1);
                            this.propTweenLookup[_local1] = this.cachedPT1;
                        };
                    };
                };
            };
            if (_local4){
                onPluginEvent("onInitAllProps", this);
            };
            if (this.vars.runBackwards){
                _local6 = this.cachedPT1;
                while (_local6) {
                    _local6.start = (_local6.start + _local6.change);
                    _local6.change = -(_local6.change);
                    _local6 = _local6.nextNode;
                };
            };
            _hasUpdate = Boolean(!((this.vars.onUpdate == null)));
            if (this._overwrittenProps){
                this.killVars(this._overwrittenProps);
                if (this.cachedPT1 == null){
                    this.setEnabled(false, false);
                };
            };
            if ((((((((this._overwrite > 1)) && (this.cachedPT1))) && ((_local5 = masterList[this.target])))) && ((_local5.length > 1)))){
                if (overwriteManager.manageOverwrites(this, this.propTweenLookup, _local5, this._overwrite)){
                    this.init();
                };
            };
            this.initted = true;
        }
        override public function renderTime(_arg1:Number, _arg2:Boolean=false, _arg3:Boolean=false):void{
            var _local4:Boolean;
            var _local5:Number = this.cachedTime;
            if (_arg1 >= this.cachedDuration){
                this.cachedTotalTime = (this.cachedTime = this.cachedDuration);
                this.ratio = 1;
                _local4 = true;
                if (this.cachedDuration == 0){
                    if ((((((_arg1 == 0)) || ((_rawPrevTime < 0)))) && (!((_rawPrevTime == _arg1))))){
                        _arg3 = true;
                    };
                    _rawPrevTime = _arg1;
                };
            } else {
                if (_arg1 <= 0){
                    this.cachedTotalTime = (this.cachedTime = (this.ratio = 0));
                    if (_arg1 < 0){
                        this.active = false;
                        if (this.cachedDuration == 0){
                            if (_rawPrevTime >= 0){
                                _arg3 = true;
                                _local4 = true;
                            };
                            _rawPrevTime = _arg1;
                        };
                    };
                    if (((this.cachedReversed) && (!((_local5 == 0))))){
                        _local4 = true;
                    };
                } else {
                    this.cachedTotalTime = (this.cachedTime = _arg1);
                    this.ratio = this._ease(_arg1, 0, 1, this.cachedDuration);
                };
            };
            if ((((this.cachedTime == _local5)) && (!(_arg3)))){
                return;
            };
            if (!this.initted){
                this.init();
                if (((!(_local4)) && (this.cachedTime))){
                    this.ratio = this._ease(this.cachedTime, 0, 1, this.cachedDuration);
                };
            };
            if (((!(this.active)) && (!(this.cachedPaused)))){
                this.active = true;
            };
            if ((((((((_local5 == 0)) && (this.vars.onStart))) && (((!((this.cachedTime == 0))) || ((this.cachedDuration == 0)))))) && (!(_arg2)))){
                this.vars.onStart.apply(null, this.vars.onStartParams);
            };
            var _local6:PropTween = this.cachedPT1;
            while (_local6) {
                _local6.target[_local6.property] = (_local6.start + (this.ratio * _local6.change));
                _local6 = _local6.nextNode;
            };
            if (((_hasUpdate) && (!(_arg2)))){
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            if (((_local4) && (!(this.gc)))){
                if (((this._hasPlugins) && (this.cachedPT1))){
                    onPluginEvent("onComplete", this);
                };
                complete(true, _arg2);
            };
        }
        public function killVars(_arg1:Object, _arg2:Boolean=true):Boolean{
            var _local3:String;
            var _local4:PropTween;
            var _local5:Boolean;
            if (this._overwrittenProps == null){
                this._overwrittenProps = {};
            };
            for (_local3 in _arg1) {
                if ((_local3 in this.propTweenLookup)){
                    _local4 = this.propTweenLookup[_local3];
                    if (((_local4.isPlugin) && ((_local4.name == "_MULTIPLE_")))){
                        _local4.target.killProps(_arg1);
                        if (_local4.target.overwriteProps.length == 0){
                            _local4.name = "";
                        };
                        if (((!((_local3 == _local4.target.propName))) || ((_local4.name == "")))){
                            delete this.propTweenLookup[_local3];
                        };
                    };
                    if (_local4.name != "_MULTIPLE_"){
                        if (_local4.nextNode){
                            _local4.nextNode.prevNode = _local4.prevNode;
                        };
                        if (_local4.prevNode){
                            _local4.prevNode.nextNode = _local4.nextNode;
                        } else {
                            if (this.cachedPT1 == _local4){
                                this.cachedPT1 = _local4.nextNode;
                            };
                        };
                        if (((_local4.isPlugin) && (_local4.target.onDisable))){
                            _local4.target.onDisable();
                            if (_local4.target.activeDisable){
                                _local5 = true;
                            };
                        };
                        delete this.propTweenLookup[_local3];
                    };
                };
                if (((_arg2) && (!((_arg1 == this._overwrittenProps))))){
                    this._overwrittenProps[_local3] = 1;
                };
            };
            return (_local5);
        }
        override public function invalidate():void{
            if (((this._notifyPluginsOfEnabled) && (this.cachedPT1))){
                onPluginEvent("onDisable", this);
            };
            this.cachedPT1 = null;
            this._overwrittenProps = null;
            _hasUpdate = (this.initted = (this.active = (this._notifyPluginsOfEnabled = false)));
            this.propTweenLookup = {};
        }
        override public function setEnabled(_arg1:Boolean, _arg2:Boolean=false):Boolean{
            var _local3:Array;
            if (_arg1){
                _local3 = TweenLite.masterList[this.target];
                if (!_local3){
                    TweenLite.masterList[this.target] = [this];
                } else {
                    if (_local3.indexOf(this) == -1){
                        _local3[_local3.length] = this;
                    };
                };
            };
            super.setEnabled(_arg1, _arg2);
            if (((this._notifyPluginsOfEnabled) && (this.cachedPT1))){
                return (onPluginEvent((_arg1) ? "onEnable" : "onDisable", this));
            };
            return (false);
        }
        protected function easeProxy(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return (this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams)));
        }

    }
}//package com.greensock 
