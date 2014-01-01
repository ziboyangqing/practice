//Created by Action Script Viewer - http://www.buraks.com/asv
package gs {
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import gs.plugins.*;
    import gs.utils.tween.*;

    public class TweenLite {

        public static const version:Number = 10.06;

        private static var _timer:Timer = new Timer(2000);
        public static var defaultEase:Function = TweenLite.easeOut;
        public static var plugins:Object = {};
        public static var currentTime:uint;
        public static var masterList:Dictionary = new Dictionary(false);
        protected static var _reservedProps:Object = {
            ease:1,
            delay:1,
            overwrite:1,
            onComplete:1,
            onCompleteParams:1,
            runBackwards:1,
            startAt:1,
            onUpdate:1,
            onUpdateParams:1,
            roundProps:1,
            onStart:1,
            onStartParams:1,
            persist:1,
            renderOnStart:1,
            proxiedEase:1,
            easeParams:1,
            yoyo:1,
            loop:1,
            onCompleteListener:1,
            onUpdateListener:1,
            onStartListener:1,
            orientToBezier:1
        };
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
        public static var timingSprite:Sprite = new Sprite();
        public static var overwriteManager:Object;
        private static var _tlInitted:Boolean;

        public var started:Boolean;
        public var delay:Number;
        protected var _hasUpdate:Boolean;
        protected var _hasPlugins:Boolean;
        public var initted:Boolean;
        public var active:Boolean;
        public var startTime:Number;
        public var target:Object;
        public var duration:Number;
        public var gc:Boolean;
        public var tweens:Array;
        public var vars:Object;
        public var ease:Function;
        public var exposedVars:Object;
        public var initTime:Number;
        public var combinedTimeScale:Number;

        public function TweenLite(_arg1:Object, _arg2:Number, _arg3:Object){
            if (_arg1 == null){
                return;
            };
            if (!_tlInitted){
                TweenPlugin.activate([TintPlugin, RemoveTintPlugin, FramePlugin, AutoAlphaPlugin, VisiblePlugin, VolumePlugin, EndArrayPlugin]);
                currentTime = getTimer();
                timingSprite.addEventListener(Event.ENTER_FRAME, updateAll, false, 0, true);
                if (overwriteManager == null){
                    overwriteManager = {
                        mode:1,
                        enabled:false
                    };
                };
                _timer.addEventListener("timer", killGarbage, false, 0, true);
                _timer.start();
                _tlInitted = true;
            };
            this.vars = _arg3;
            this.duration = ((_arg2) || (0.001));
            this.delay = ((_arg3.delay) || (0));
            this.combinedTimeScale = ((_arg3.timeScale) || (1));
            this.active = Boolean((((_arg2 == 0)) && ((this.delay == 0))));
            this.target = _arg1;
            if (typeof(this.vars.ease) != "function"){
                this.vars.ease = defaultEase;
            };
            if (this.vars.easeParams != null){
                this.vars.proxiedEase = this.vars.ease;
                this.vars.ease = this.easeProxy;
            };
            this.ease = this.vars.ease;
            this.exposedVars = ((this.vars.isTV)==true) ? this.vars.exposedVars : this.vars;
            this.tweens = [];
            this.initTime = currentTime;
            this.startTime = (this.initTime + (this.delay * 1000));
            var _local4:int = ((((_arg3.overwrite == undefined)) || (((!(overwriteManager.enabled)) && ((_arg3.overwrite > 1)))))) ? overwriteManager.mode : int(_arg3.overwrite);
            if (((!((_arg1 in masterList))) || ((_local4 == 1)))){
                masterList[_arg1] = [this];
            } else {
                masterList[_arg1].push(this);
            };
            if ((((((this.vars.runBackwards == true)) && (!((this.vars.renderOnStart == true))))) || (this.active))){
                this.initTweenVals();
                if (this.active){
                    this.render((this.startTime + 1));
                } else {
                    this.render(this.startTime);
                };
                if (((((!((this.exposedVars.visible == null))) && ((this.vars.runBackwards == true)))) && ((this.target is DisplayObject)))){
                    this.target.visible = this.exposedVars.visible;
                };
            };
        }
        public static function updateAll(_arg1:Event=null):void{
            var _local4:Array;
            var _local5:int;
            var _local6:TweenLite;
            var _local2:uint = (currentTime = getTimer());
            var _local3:Dictionary = masterList;
            for each (_local4 in _local3) {
                _local5 = (_local4.length - 1);
                while (_local5 > -1) {
                    _local6 = _local4[_local5];
                    if (_local6.active){
                        _local6.render(_local2);
                    } else {
                        if (_local6.gc){
                            _local4.splice(_local5, 1);
                        } else {
                            if (_local2 >= _local6.startTime){
                                _local6.activate();
                                _local6.render(_local2);
                            };
                        };
                    };
                    _local5--;
                };
            };
        }
        public static function removeTween(_arg1:TweenLite, _arg2:Boolean=true):void{
            if (_arg1 != null){
                if (_arg2){
                    _arg1.clear();
                };
                _arg1.enabled = false;
            };
        }
        public static function killTweensOf(_arg1:Object=null, _arg2:Boolean=false):void{
            var _local3:Array;
            var _local4:int;
            var _local5:TweenLite;
            if (((!((_arg1 == null))) && ((_arg1 in masterList)))){
                _local3 = masterList[_arg1];
                _local4 = (_local3.length - 1);
                while (_local4 > -1) {
                    _local5 = _local3[_local4];
                    if (((_arg2) && (!(_local5.gc)))){
                        _local5.complete(false);
                    };
                    _local5.clear();
                    _local4--;
                };
                delete masterList[_arg1];
            };
        }
        public static function from(_arg1:Object, _arg2:Number, _arg3:Object):TweenLite{
            _arg3.runBackwards = true;
            return (new TweenLite(_arg1, _arg2, _arg3));
        }
        public static function easeOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = (_arg1 / _arg4);
            return ((((-(_arg3) * _arg1) * (_arg1 - 2)) + _arg2));
        }
        protected static function killGarbage(_arg1:TimerEvent):void{
            var _local3:Object;
            var _local2:Dictionary = masterList;
            for (_local3 in _local2) {
                if (_local2[_local3].length == 0){
                    delete _local2[_local3];
                };
            };
        }
        public static function delayedCall(_arg1:Number, _arg2:Function, _arg3:Array=null):TweenLite{
            return (new TweenLite(_arg2, 0, {
                delay:_arg1,
                onComplete:_arg2,
                onCompleteParams:_arg3,
                overwrite:0
            }));
        }
        public static function to(_arg1:Object, _arg2:Number, _arg3:Object):TweenLite{
            return (new TweenLite(_arg1, _arg2, _arg3));
        }

        public function get enabled():Boolean{
            return ((this.gc) ? false : true);
        }
        public function set enabled(_arg1:Boolean):void{
            var _local2:Array;
            var _local3:Boolean;
            var _local4:int;
            if (_arg1){
                if (!(this.target in masterList)){
                    masterList[this.target] = [this];
                } else {
                    _local2 = masterList[this.target];
                    _local4 = (_local2.length - 1);
                    while (_local4 > -1) {
                        if (_local2[_local4] == this){
                            _local3 = true;
                            break;
                        };
                        _local4--;
                    };
                    if (!_local3){
                        _local2[_local2.length] = this;
                    };
                };
            };
            this.gc = (_arg1) ? false : true;
            if (this.gc){
                this.active = false;
            } else {
                this.active = this.started;
            };
        }
        public function clear():void{
            this.tweens = [];
            this.vars = (this.exposedVars = {ease:this.vars.ease});
            this._hasUpdate = false;
        }
        public function render(_arg1:uint):void{
            var _local3:Number;
            var _local4:TweenInfo;
            var _local5:int;
            var _local2:Number = ((_arg1 - this.startTime) * 0.001);
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
            if (this._hasUpdate){
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            if (_local2 == this.duration){
                this.complete(true);
            };
        }
        public function activate():void{
            this.started = (this.active = true);
            if (!this.initted){
                this.initTweenVals();
            };
            if (this.vars.onStart != null){
                this.vars.onStart.apply(null, this.vars.onStartParams);
            };
            if (this.duration == 0.001){
                this.startTime = (this.startTime - 1);
            };
        }
        public function initTweenVals():void{
            var _local1:String;
            var _local2:int;
            var _local3:*;
            var _local4:TweenInfo;
            for (_local1 in this.exposedVars) {
                if ((_local1 in _reservedProps)){
                } else {
                    if ((_local1 in plugins)){
                        _local3 = new (plugins[_local1])();
                        if (_local3.onInitTween(this.target, this.exposedVars[_local1], this) == false){
                            this.tweens[this.tweens.length] = new TweenInfo(this.target, _local1, this.target[_local1], ((typeof(this.exposedVars[_local1]))=="number") ? (this.exposedVars[_local1] - this.target[_local1]) : Number(this.exposedVars[_local1]), _local1, false);
                        } else {
                            this.tweens[this.tweens.length] = new TweenInfo(_local3, "changeFactor", 0, 1, ((_local3.overwriteProps.length)==1) ? _local3.overwriteProps[0] : "_MULTIPLE_", true);
                            this._hasPlugins = true;
                        };
                    } else {
                        this.tweens[this.tweens.length] = new TweenInfo(this.target, _local1, this.target[_local1], ((typeof(this.exposedVars[_local1]))=="number") ? (this.exposedVars[_local1] - this.target[_local1]) : Number(this.exposedVars[_local1]), _local1, false);
                    };
                };
            };
            if (this.vars.runBackwards == true){
                _local2 = (this.tweens.length - 1);
                while (_local2 > -1) {
                    _local4 = this.tweens[_local2];
                    this.tweens[_local2].start = (_local4.start + _local4.change);
                    _local4.change = -(_local4.change);
                    _local2--;
                };
            };
            if (this.vars.onUpdate != null){
                this._hasUpdate = true;
            };
            if (((TweenLite.overwriteManager.enabled) && ((this.target in masterList)))){
                overwriteManager.manageOverwrites(this, masterList[this.target]);
            };
            this.initted = true;
        }
        protected function easeProxy(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return (this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams)));
        }
        public function killVars(_arg1:Object):void{
            if (overwriteManager.enabled){
                overwriteManager.killVars(_arg1, this.exposedVars, this.tweens);
            };
        }
        public function complete(_arg1:Boolean=false):void{
            var _local2:int;
            if (!_arg1){
                if (!this.initted){
                    this.initTweenVals();
                };
                this.startTime = (currentTime - ((this.duration * 1000) / this.combinedTimeScale));
                this.render(currentTime);
                return;
            };
            if (this._hasPlugins){
                _local2 = (this.tweens.length - 1);
                while (_local2 > -1) {
                    if (((this.tweens[_local2].isPlugin) && (!((this.tweens[_local2].target.onComplete == null))))){
                        this.tweens[_local2].target.onComplete();
                    };
                    _local2--;
                };
            };
            if (this.vars.persist != true){
                this.enabled = false;
            };
            if (this.vars.onComplete != null){
                this.vars.onComplete.apply(null, this.vars.onCompleteParams);
            };
        }

    }
}//package gs 
