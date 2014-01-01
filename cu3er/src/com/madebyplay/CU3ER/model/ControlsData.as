package com.madebyplay.CU3ER.model 
{
    public class ControlsData extends Object
    {
        public function ControlsData(arg1:XML)
        {
            super();
            this._xml = arg1;
            this.getFromXML();
            return;
        }

        public function set autoHide_btnNext(arg1:Boolean):void
        {
            this._autoHide_btnNext = arg1;
            return;
        }

        public function get autoHideTime_btnNext():Number
        {
            return this._autoHideTime_btnNext;
        }

        public function set autoHideTime_btnNext(arg1:Number):void
        {
            this._autoHideTime_btnNext = arg1;
            return;
        }

        public function get autoHide_btnPrev():Boolean
        {
            return this._autoHide_btnPrev;
        }

        public function set autoHide_btnPrev(arg1:Boolean):void
        {
            this._autoHide_btnPrev = arg1;
            return;
        }

        public function get autoHideTime_btnPrev():Number
        {
            return this._autoHideTime_btnPrev;
        }

        public function set autoHideTime_btnPrev(arg1:Number):void
        {
            this._autoHideTime_btnPrev = arg1;
            return;
        }

        public function get hideOnTransition_autoPlayIndicator():Boolean
        {
            return this._hideOnTransition_autoPlayIndicator;
        }

        public function set hideOnTransition_autoPlayIndicator(arg1:Boolean):void
        {
            this._hideOnTransition_autoPlayIndicator = arg1;
            return;
        }

        public function get hideOnTransition_btnNext():Boolean
        {
            return this._hideOnTransition_btnNext;
        }

        public function set hideOnTransition_btnNext(arg1:Boolean):void
        {
            this._hideOnTransition_btnNext = arg1;
            return;
        }

        public function get hideOnTransition_btnPrev():Boolean
        {
            return this._hideOnTransition_btnPrev;
        }

        public function set hideOnTransition_btnPrev(arg1:Boolean):void
        {
            this._hideOnTransition_btnPrev = arg1;
            return;
        }

        public function getFromXML():void
        {
            if (String(this._xml.auto_play_indicator.auto_hide) == "true") 
            {
                this._autoHide_autoPlayIndicator = true;
            }
            if (String(this._xml.next_button.auto_hide) == "true") 
            {
                this._autoHide_btnNext = true;
            }
            if (String(this._xml.prev_button.auto_hide) == "true") 
            {
                this._autoHide_btnPrev = true;
            }
            if (String(this._xml.auto_play_indicator.auto_hide.@time) != "") 
            {
                this._autoHideTime_autoPlayIndicator = Number(this._xml.auto_play_indicator.auto_hide.@time);
            }
            if (String(this._xml.next_button.auto_hide.@time) != "") 
            {
                this._autoHideTime_btnNext = Number(this._xml.next_button.auto_hide.@time);
            }
            if (String(this._xml.prev_button.auto_hide.@time) != "") 
            {
                this._autoHideTime_btnPrev = Number(this._xml.prev_button.auto_hide.@time);
            }
            if (String(this._xml.auto_play_indicator.hide_on_transition) == "false") 
            {
                this._hideOnTransition_autoPlayIndicator = false;
            }
            if (String(this._xml.next_button.hide_on_transition) == "false") 
            {
                this._hideOnTransition_btnNext = false;
            }
            if (String(this._xml.prev_button.hide_on_transition) == "false") 
            {
                this._hideOnTransition_btnPrev = false;
            }
            if (String(this._xml.auto_play_indicator) != "") 
            {
                this._autoPlayIndicator = XML(this._xml.auto_play_indicator);
            }
            if (String(this._xml.prev_button) != "") 
            {
                this._btnPrev = XML(this._xml.prev_button);
            }
            if (String(this._xml.next_button) != "") 
            {
                this._btnNext = XML(this._xml.next_button);
            }
            return;
        }

        public function get autoPlayIndicator():XML
        {
            return this._autoPlayIndicator;
        }

        public function set autoPlayIndicator(arg1:XML):void
        {
            this._autoPlayIndicator = arg1;
            return;
        }

        public function get btnPrev():XML
        {
            return this._btnPrev;
        }

        public function set btnPrev(arg1:XML):void
        {
            this._btnPrev = arg1;
            return;
        }

        public function get btnNext():XML
        {
            return this._btnNext;
        }

        public function set btnNext(arg1:XML):void
        {
            this._btnNext = arg1;
            return;
        }

        public function get autoHide_autoPlayIndicator():Boolean
        {
            return this._autoHide_autoPlayIndicator;
        }

        public function set autoHide_autoPlayIndicator(arg1:Boolean):void
        {
            this._autoHide_autoPlayIndicator = arg1;
            return;
        }

        public function get autoHideTime_autoPlayIndicator():Number
        {
            return this._autoHideTime_autoPlayIndicator;
        }

        public function set autoHideTime_autoPlayIndicator(arg1:Number):void
        {
            this._autoHideTime_autoPlayIndicator = arg1;
            return;
        }

        public function get autoHide_btnNext():Boolean
        {
            return this._autoHide_btnNext;
        }

        internal var _xml:XML;

        internal var _autoHide_autoPlayIndicator:Boolean=false;

        internal var _autoHideTime_autoPlayIndicator:Number=5;

        internal var _autoHide_btnNext:Boolean=false;

        internal var _autoHideTime_btnNext:Number=5;

        internal var _autoHide_btnPrev:Boolean=false;

        internal var _autoHideTime_btnPrev:Number=5;

        internal var _hideOnTransition_autoPlayIndicator:Boolean=true;

        internal var _hideOnTransition_btnNext:Boolean=true;

        internal var _hideOnTransition_btnPrev:Boolean=true;

        internal var _btnPrev:XML;

        internal var _btnNext:XML;

        internal var _autoPlayIndicator:XML;
    }
}
