package com.madebyplay.CU3ER.controller 
{
    import com.greensock.*;
    import com.madebyplay.CU3ER.interfaces.*;
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.CU3ER.view.controls.*;
    import com.madebyplay.CU3ER.view.preloaders.*;
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;
    
    public class Controls extends flash.events.EventDispatcher
    {
        public function Controls(arg1:com.madebyplay.CU3ER.controller.Player, arg2:com.madebyplay.CU3ER.model.ControlsData)
        {
            super();
            this._player = arg1;
            this._data = arg2;
            this._createElements();
            return;
        }

        public function getMaxHideTime():Number
        {
            return this._maxHideTime;
        }

        public function showAutoHide():void
        {
            if (!(this._player.currSlide.description == null) && this._player.data.descriptionData.autoHide && this._player.currSlide.isDescriptionHidden) 
            {
                this._player.currSlide.showDescription();
            }
            if (!(this._btnNext == null) && this._data.autoHide_btnNext && this._btnNext.hidden) 
            {
                this._btnNext.show();
            }
            if (!(this._btnPrev == null) && this._data.autoHide_btnPrev && this._btnPrev.hidden) 
            {
                this._btnPrev.show();
            }
            if (this._player.data.autoPlayIndicator && this._data.autoHide_autoPlayIndicator && this._autoPlayIndicator.isHidden() && !this._autoPlayFinished) 
            {
                this._autoPlayIndicator.show();
            }
            return;
        }

        public function initAutoHide():void
        {
            if (!this._hideTimersInitialized) 
            {
                this._hideTimersInitialized = true;
                if (!(this._player.data.descriptionData == null) && this._player.data.descriptionData.autoHide) 
                {
                    if (!(this._timerHide_desc == null) && this._timerHide_desc.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                    {
                        this._timerHide_desc.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_desc);
                    }
                    this._timerHide_desc = new flash.utils.Timer(this._player.data.descriptionData.autoHideTime * 1000, 1);
                    this._timerHide_desc.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_desc, false, 0, true);
                }
                if (this._data.autoHide_autoPlayIndicator) 
                {
                    if (!(this._timerHide_autoPlayIndicator == null) && this._timerHide_autoPlayIndicator.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                    {
                        this._timerHide_autoPlayIndicator.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_autoPlayIndicator);
                    }
                    this._timerHide_autoPlayIndicator = new flash.utils.Timer(this._data.autoHideTime_autoPlayIndicator * 1000, 1);
                    this._timerHide_autoPlayIndicator.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_autoPlayIndicator, false, 0, true);
                }
                if (this._data.autoHide_btnNext) 
                {
                    if (!(this._timerHide_btnNext == null) && this._timerHide_btnNext.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                    {
                        this._timerHide_btnNext.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_btnNext);
                    }
                    this._timerHide_btnNext = new flash.utils.Timer(this._data.autoHideTime_btnNext * 1000, 1);
                    this._timerHide_btnNext.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_btnNext, false, 0, true);
                }
                if (this._data.autoHide_btnPrev) 
                {
                    if (!(this._timerHide_btnPrev == null) && this._timerHide_btnPrev.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                    {
                        this._timerHide_btnPrev.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_btnPrev);
                    }
                    this._timerHide_btnPrev = new flash.utils.Timer(this._data.autoHideTime_btnPrev * 1000, 1);
                    this._timerHide_btnPrev.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_btnPrev, false, 0, true);
                }
            }
            return;
        }

        internal function _onAutoHide_desc(arg1:flash.events.TimerEvent):void
        {
            if (!(this._timerHide_desc == null) && this._player.currState == com.madebyplay.CU3ER.controller.Player.STATE_FREE) 
            {
                this._player.currSlide.hideDescription(true);
            }
            return;
        }

        internal function _onAutoHide_autoPlayIndicator(arg1:flash.events.TimerEvent):void
        {
            if (this._player.data.autoPlay && !(this._timerHide_autoPlayIndicator == null) && this._player.currState == com.madebyplay.CU3ER.controller.Player.STATE_FREE) 
            {
                this._autoPlayIndicator.hide();
            }
            return;
        }

        public function hideOnTransition():void
        {
            if (this._player.data.autoPlayIndicator) 
            {
                this._hiddenOnTransition_autoPlay = this._autoPlayIndicator.isHidden();
            }
            if (this._btnNext != null) 
            {
                this._hiddenOnTransition_btnNext = this._btnNext.hidden;
            }
            if (this._btnPrev != null) 
            {
                this._hiddenOnTransition_btnPrev = this._btnPrev.hidden;
            }
            this._maxHideTime = 0;
            if (this._player.data.autoPlayIndicator && this._data.hideOnTransition_autoPlayIndicator && !this._autoPlayIndicator.isHidden()) 
            {
                this._autoPlayIndicator.hide();
                this._maxHideTime = Math.max(this._maxHideTime, this._autoPlayIndicator.getHideTime());
            }
            if (!(this._btnNext == null) && this._data.hideOnTransition_btnNext && !this._btnNext.hidden) 
            {
                this._btnNext.hide();
                this._maxHideTime = Math.max(this._maxHideTime, this._btnNext.getHideTime());
            }
            if (!(this._btnPrev == null) && this._data.hideOnTransition_btnPrev && !this._btnPrev.hidden) 
            {
                this._btnPrev.hide();
                this._maxHideTime = Math.max(this._maxHideTime, this._btnPrev.getHideTime());
            }
            if (!(this._player.currSlide.description == null) && (this._player.data.descriptionData.hideOnTransition || this._player.data.descriptionData.bakeOnTransition)) 
            {
                this._hiddenOnTransition_desc = true;
                if (!this._player.data.descriptionData.bakeOnTransition) 
                {
                    this._player.currSlide.hideDescription();
                    this._maxHideTime = Math.max(this._maxHideTime, this._player.currSlide.hideTime);
                }
            }
            return;
        }

        internal function _onAutoHide_btnNext(arg1:flash.events.TimerEvent):void
        {
            if (!(this._btnNext == null) && !(this._timerHide_btnNext == null) && this._player.currState == com.madebyplay.CU3ER.controller.Player.STATE_FREE) 
            {
                this._btnNext.hide();
            }
            return;
        }

        internal function _onAutoHide_btnPrev(arg1:flash.events.TimerEvent):void
        {
            if (!(this._btnPrev == null) && !(this._timerHide_btnPrev == null) && this._player.currState == com.madebyplay.CU3ER.controller.Player.STATE_FREE) 
            {
                this._btnPrev.hide();
            }
            return;
        }

        public function clearAutoHide():void
        {
            if (this._hideTimersInitialized) 
            {
                if (!(this._timerHide_desc == null) && this._timerHide_desc.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                {
                    this._timerHide_desc.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_desc);
                }
                if (!(this._timerHide_autoPlayIndicator == null) && this._timerHide_autoPlayIndicator.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                {
                    this._timerHide_autoPlayIndicator.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_autoPlayIndicator);
                }
                if (!(this._timerHide_btnNext == null) && this._timerHide_btnNext.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                {
                    this._timerHide_btnNext.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_btnNext);
                }
                if (!(this._timerHide_btnPrev == null) && this._timerHide_btnPrev.hasEventListener(flash.events.TimerEvent.TIMER_COMPLETE)) 
                {
                    this._timerHide_btnPrev.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this._onAutoHide_btnPrev);
                }
            }
            return;
        }

        public function resetHideTimers():void
        {
            if (this._timerHide_desc != null) 
            {
                this._timerHide_desc.reset();
            }
            if (this._timerHide_autoPlayIndicator != null) 
            {
                this._timerHide_autoPlayIndicator.reset();
            }
            if (this._timerHide_btnNext != null) 
            {
                this._timerHide_btnNext.reset();
            }
            if (this._timerHide_btnPrev != null) 
            {
                this._timerHide_btnPrev.reset();
            }
            return;
        }

        public function startHideTimers():void
        {
            if (this._timerHide_desc != null) 
            {
                this._timerHide_desc.start();
            }
            if (this._timerHide_autoPlayIndicator != null) 
            {
                this._timerHide_autoPlayIndicator.start();
            }
            if (this._timerHide_btnNext != null) 
            {
                this._timerHide_btnNext.start();
            }
            if (this._timerHide_btnPrev != null) 
            {
                this._timerHide_btnPrev.start();
            }
            return;
        }

        public function get autoPlayIndicator():com.madebyplay.CU3ER.interfaces.IPreloader
        {
            return this._autoPlayIndicator;
        }

        public function get btnPrev():com.madebyplay.CU3ER.view.controls.BtnControl
        {
            return this._btnPrev;
        }

        public function get percent():Number
        {
            return this._percent;
        }

        public function set percent(arg1:Number):void
        {
            this._percent = arg1;
            if (this._player.data.autoPlayIndicator) 
            {
                this._autoPlayIndicator.updatePercent(this._percent);
            }
            return;
        }

        public function get paused():Boolean
        {
            return this._paused;
        }

        public function set paused(arg1:Boolean):void
        {
            this._paused = arg1;
            return;
        }

        public function get hideTimersInitialized():Boolean
        {
            return this._hideTimersInitialized;
        }

        internal function _onNext(arg1:flash.events.MouseEvent):void
        {
            this._player.next();
            return;
        }

        internal function _createElements():void
        {
            var loc1:*=null;
            this._view = new flash.display.MovieClip();
            if (this._data.btnNext != null) 
            {
                this._btnNext = new com.madebyplay.CU3ER.view.controls.BtnControl(this._data.btnNext, "next");
                this._btnNext.addEventListener(flash.events.MouseEvent.MOUSE_UP, this._onNext, false, 0, true);
                if (String(this._data.btnNext.@align_to) != "stage") 
                {
                    this._view.addChild(this._btnNext);
                }
                else 
                {
                    this._player.CU3ER.addChild(this._btnNext);
                }
            }
            if (this._data.btnPrev != null) 
            {
                this._btnPrev = new com.madebyplay.CU3ER.view.controls.BtnControl(this._data.btnPrev, "prev");
                this._btnPrev.addEventListener(flash.events.MouseEvent.MOUSE_UP, this._onPrev, false, 0, true);
                if (String(this._data.btnPrev.@align_to) != "stage") 
                {
                    this._view.addChild(this._btnPrev);
                }
                else 
                {
                    this._player.CU3ER.addChild(this._btnPrev);
                }
            }
            if (this._player.data.autoPlayIndicator) 
            {
                if (this._data.autoPlayIndicator.@type != "circular") 
                {
                    loc1 = new com.madebyplay.CU3ER.view.preloaders.PreloaderLinear(this._data.autoPlayIndicator);
                }
                else 
                {
                    loc1 = new com.madebyplay.CU3ER.view.preloaders.PreloaderCircular(this._data.autoPlayIndicator);
                }
                this._autoPlayIndicator = com.madebyplay.CU3ER.interfaces.IPreloader(loc1);
                loc1.name = "autoPlay";
                loc1.buttonMode = true;
                loc1.addEventListener(flash.events.MouseEvent.MOUSE_UP, this._onAutoPlayPause);
                if (String(this._data.autoPlayIndicator.@align_to) != "stage") 
                {
                    this._view.addChild(loc1);
                }
                else 
                {
                    this._player.CU3ER.addChild(loc1);
                }
            }
            this._player.holder.addChild(this._view);
            return;
        }

        public function play():void
        {
            this._paused = false;
            this._player.pauseAutoPlay();
            return;
        }

        public function pause():void
        {
            this._paused = true;
            this._player.pauseAutoPlay();
            return;
        }

        internal function _onAutoPlayPause(arg1:flash.events.MouseEvent=null):void
        {
            if (this._player.currState != com.madebyplay.CU3ER.controller.Player.STATE_FREE) 
            {
                return;
            }
            this._paused = !this._paused;
            this._player.pauseAutoPlay();
            if (this._paused) 
            {
                this._player.pausedOnRollover = 2;
            }
            else 
            {
                this._player.pausedOnRollover = 0;
            }
            return;
        }

        public function updateAutoPlay(arg1:Number):void
        {
            if (this._player.data.autoPlayIndicator) 
            {
                this._percent = arg1;
                this._autoPlayIndicator.updatePercent(arg1);
            }
            return;
        }

        public function get btnNext():com.madebyplay.CU3ER.view.controls.BtnControl
        {
            return this._btnNext;
        }

        internal function _onPrev(arg1:flash.events.MouseEvent):void
        {
            this._player.prev();
            return;
        }

        public function show():void
        {
            if (this._btnNext != null) 
            {
                this._btnNext.show();
            }
            if (this._btnPrev != null) 
            {
                this._btnPrev.show();
            }
            if (this._player.data.autoPlayIndicator && !this._autoPlayFinished) 
            {
                this._autoPlayIndicator.show();
            }
            return;
        }

        public function hide():void
        {
            if (this._btnNext != null) 
            {
                this._btnNext.hide();
            }
            if (this._btnPrev != null) 
            {
                this._btnPrev.hide();
            }
            if (this._player.data.autoPlayIndicator) 
            {
                this._autoPlayIndicator.hide();
            }
            return;
        }

        public function hideAutoPlay():void
        {
            this._autoPlayFinished = true;
            if (this._player.data.autoPlayIndicator) 
            {
                com.greensock.TweenLite.delayedCall(0.2, this._autoPlayIndicator.hide);
            }
            return;
        }

        public function showHideOnTransition():void
        {
            if (this._player.data.autoPlayIndicator && this._data.hideOnTransition_autoPlayIndicator && !this._hiddenOnTransition_autoPlay && this._autoPlayIndicator.isHidden() && !this._autoPlayFinished) 
            {
                this._autoPlayIndicator.show();
            }
            if (!(this._player.currSlide.description == null) && this._player.data.descriptionData.hideOnTransition) 
            {
                this._hiddenOnTransition_desc = false;
                this._player.currSlide.showDescription();
            }
            if (!(this._btnNext == null) && this._data.hideOnTransition_btnNext && !this._hiddenOnTransition_btnNext) 
            {
                this._btnNext.show();
            }
            if (!(this._btnPrev == null) && this._data.hideOnTransition_btnPrev && !this._hiddenOnTransition_btnPrev) 
            {
                this._btnPrev.show();
            }
            return;
        }

        internal var _data:com.madebyplay.CU3ER.model.ControlsData;

        internal var _btnNext:com.madebyplay.CU3ER.view.controls.BtnControl;

        internal var _btnPrev:com.madebyplay.CU3ER.view.controls.BtnControl;

        internal var _view:flash.display.MovieClip;

        internal var _player:com.madebyplay.CU3ER.controller.Player;

        internal var _percent:Number;

        internal var _paused:Boolean=false;

        internal var _timerHide_autoPlayIndicator:flash.utils.Timer;

        internal var _timerHide_btnNext:flash.utils.Timer;

        internal var _timerHide_btnPrev:flash.utils.Timer;

        internal var _timerHide_desc:flash.utils.Timer;

        internal var _hideTimersInitialized:Boolean=false;

        internal var _hiddenOnTransition_btnNext:Boolean=false;

        internal var _hiddenOnTransition_btnPrev:Boolean=false;

        internal var _hiddenOnTransition_autoPlay:Boolean=false;

        internal var _hiddenOnTransition_desc:Boolean=false;

        internal var _autoPlayFinished:Boolean=false;

        internal var _maxHideTime:Number=0;

        internal var _autoPlayIndicator:com.madebyplay.CU3ER.interfaces.IPreloader;
    }
}
