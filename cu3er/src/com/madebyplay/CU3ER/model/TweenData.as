//Created by Action Script Viewer - http://www.buraks.com/asv
package com.madebyplay.CU3ER.model {
    import com.greensock.easing.*;

    public class TweenData {

        private var _xml:XML;
        private var _tweenShow:Object;
        private var _tweenOver:Object;
        private var _tweenHide:Object;
        private var _tweenSelected:Object;
        private var _copyList:Array;
        private var _ignoreList:Array;
        private var _ignoreListStr:String = "";
        private var _alphaShow:Number;
        private var _alphaHide:Number;
        private var _alphaOver:Number;
        private var _alphaSelected:Number;
        private var _timeShow:Number;
        private var _timeHide:Number;
        private var _timeOver:Number;
        private var _timeSelected:Number;

        public function TweenData(_arg1:XML, _arg2:Array=null, _arg3:Array=null){
            var _local4:int;
            var _local5:*;
            this._tweenShow = {
                time:0.3,
                delay:0,
                alpha:0.85,
                rotation:0,
                alpha:0,
                x:0,
                y:0,
                scaleX:1,
                scaleY:1,
                visible:true,
                ease:Sine.easeOut
            };
            this._tweenOver = {
                time:0.3,
                delay:0,
                alpha:1,
                x:0,
                y:0,
                scaleX:1,
                scaleY:1,
                visible:true,
                ease:Sine.easeOut
            };
            this._tweenHide = {
                time:0.3,
                delay:0,
                alpha:0,
                x:0,
                y:0,
                scaleX:1,
                scaleY:1,
                visible:false,
                ease:Sine.easeOut
            };
            this._tweenSelected = {
                time:0.3,
                delay:0,
                alpha:0.5,
                x:0,
                y:0,
                scaleX:1,
                scaleY:1,
                visible:true,
                ease:Sine.easeOut
            };
            this._copyList = new Array("time", "delay", "x", "y", "alpha", "rotation", "tint", "scaleX", "scaleY", "visible", "ease");
            this._ignoreList = new Array();
            super();
            this._tweenShow.alpha = DefaultValues.ALPHA_tweenShow;
            this._tweenOver.alpha = DefaultValues.ALPHA_tweenOver;
            this._tweenHide.alpha = DefaultValues.ALPHA_tweenHide;
            this._tweenSelected.alpha = DefaultValues.ALPHA_tweenSelected;
            if (_arg2 != null){
                this._copyList = _arg2;
            };
            if (_arg3 != null){
                this._ignoreList = _arg3;
                this._ignoreListStr = (_arg3.join(",") + ",");
                _local4 = 0;
                while (_local4 < this._ignoreList.length) {
                    delete this._tweenShow[this._ignoreList[_local4]];
                    delete this._tweenOver[this._ignoreList[_local4]];
                    delete this._tweenHide[this._ignoreList[_local4]];
                    delete this._tweenSelected[this._ignoreList[_local4]];
                    _local4++;
                };
                for (_local5 in this._tweenHide) {
                };
            };
            this.getFromXML(_arg1);
        }
        public function getFromXML(_arg1:XML):void{
            (this._xml = _arg1);
            var _local2:int;
            while (_local2 < this._copyList.length) {
                if (this._ignoreListStr.indexOf(this._copyList[_local2]) > -1){
                } else {
                    if (this._copyList[_local2] == "delay"){
                        if ((((String(this._xml.tweenShow.@tempDelay) == "")) && (!((this._xml.tweenShow.@delay == undefined))))){
                            (this._xml.tweenShow.@tempDelay = String(this._xml.tweenShow.@delay));
                        };
                        (this._tweenShow["delay"] = 0);
                        if ((((String(this._xml.tweenHide.@tempDelay) == "")) && (!((this._xml.tweenHide.@delay == undefined))))){
                            (this._xml.tweenHide.@tempDelay = String(this._xml.tweenHide.@delay));
                        };
                        (this._tweenHide["delay"] = 0);
                        if ((((String(this._xml.tweenOver.@tempDelay) == "")) && (!((this._xml.tweenOver.@delay == undefined))))){
                            (this._xml.tweenOver.@tempDelay = String(this._xml.tweenOver.@delay));
                        };
                        (this._tweenOver["delay"] = 0);
                        if ((((String(this._xml.tweenSelected.@tempDelay) == "")) && (!((this._xml.tweenSelected.@delay == undefined))))){
                            (this._xml.tweenSelected.@tempDelay = String(this._xml.tweenSelected.@delay));
                        };
                        (this._tweenSelected["delay"] = 0);
                    } else {
                        if (this._copyList[_local2] == "tint"){
                            if (this._xml.tweenShow.attribute(this._copyList[_local2]) != undefined){
                                (this._tweenShow[this._copyList[_local2]] = parseInt(String(this._xml.tweenShow.attribute(this._copyList[_local2])), 16));
                            };
                            if (this._xml.tweenHide.attribute(this._copyList[_local2]) != undefined){
                                (this._tweenHide[this._copyList[_local2]] = parseInt(String(this._xml.tweenHide.attribute(this._copyList[_local2])), 16));
                            };
                            if (this._xml.tweenOver.attribute(this._copyList[_local2]) != undefined){
                                (this._tweenOver[this._copyList[_local2]] = parseInt(String(this._xml.tweenOver.attribute(this._copyList[_local2])), 16));
                            };
                            if (this._xml.tweenSelected.attribute(this._copyList[_local2]) != undefined){
                                (this._tweenSelected[this._copyList[_local2]] = parseInt(String(this._xml.tweenSelected.attribute(this._copyList[_local2])), 16));
                            };
                        } else {
                            if (this._copyList[_local2] == "ease"){
                                if (this._xml.tweenShow.attribute(this._copyList[_local2]) != undefined){
                                    (this._tweenShow[this._copyList[_local2]] = GlobalVars.getTweenFunction(String(this._xml.tweenShow.attribute(this._copyList[_local2]))));
                                };
                                if (this._xml.tweenHide.attribute(this._copyList[_local2]) != undefined){
                                    (this._tweenHide[this._copyList[_local2]] = GlobalVars.getTweenFunction(String(this._xml.tweenHide.attribute(this._copyList[_local2]))));
                                };
                                if (this._xml.tweenOver.attribute(this._copyList[_local2]) != undefined){
                                    (this._tweenOver[this._copyList[_local2]] = GlobalVars.getTweenFunction(String(this._xml.tweenOver.attribute(this._copyList[_local2]))));
                                };
                                if (this._xml.tweenSelected.attribute(this._copyList[_local2]) != undefined){
                                    (this._tweenSelected[this._copyList[_local2]] = parseInt(String(this._xml.tweenSelected.attribute(this._copyList[_local2])), 16));
                                };
                            } else {
                                if (this._xml.tweenShow.attribute(this._copyList[_local2]) != undefined){
                                    (this._tweenShow[this._copyList[_local2]] = Number(this._xml.tweenShow.attribute(this._copyList[_local2])));
                                };
                                if (this._xml.tweenHide.attribute(this._copyList[_local2]) != undefined){
                                    (this._tweenHide[this._copyList[_local2]] = Number(this._xml.tweenHide.attribute(this._copyList[_local2])));
                                };
                                if (this._xml.tweenOver.attribute(this._copyList[_local2]) != undefined){
                                    (this._tweenOver[this._copyList[_local2]] = Number(this._xml.tweenOver.attribute(this._copyList[_local2])));
                                };
                                if (this._xml.tweenSelected.attribute(this._copyList[_local2]) != undefined){
                                    (this._tweenSelected[this._copyList[_local2]] = Number(this._xml.tweenSelected.attribute(this._copyList[_local2])));
                                };
                            };
                        };
                    };
                };
                _local2 = (_local2 + 1);
            };
            (this._alphaShow = this._tweenShow.alpha);
            (this._alphaHide = this._tweenHide.alpha);
            (this._alphaOver = this._tweenOver.alpha);
            (this._alphaSelected = this._tweenSelected.alpha);
            (this._timeShow = this._tweenShow.time);
            (this._timeHide = this._tweenHide.time);
            (this._timeOver = this._tweenOver.time);
            (this._timeSelected = this._tweenSelected.time);
        }
        public function get tweenShow():Object{
            return (this._tweenShow);
        }
        public function set tweenShow(_arg1:Object):void{
            (this._tweenShow = _arg1);
        }
        public function get tweenOver():Object{
            return (this._tweenOver);
        }
        public function set tweenOver(_arg1:Object):void{
            (this._tweenOver = _arg1);
        }
        public function get tweenHide():Object{
            return (this._tweenHide);
        }
        public function set tweenHide(_arg1:Object):void{
            (this._tweenHide = _arg1);
        }
        public function get copyList():Array{
            return (this._copyList);
        }
        public function set copyList(_arg1:Array):void{
            (this._copyList = _arg1);
        }
        public function get alphaShow():Number{
            return (this._alphaShow);
        }
        public function set alphaShow(_arg1:Number):void{
            (this._alphaShow = _arg1);
        }
        public function get alphaHide():Number{
            return (this._alphaHide);
        }
        public function set alphaHide(_arg1:Number):void{
            (this._alphaHide = _arg1);
        }
        public function get alphaOver():Number{
            return (this._alphaOver);
        }
        public function set alphaOver(_arg1:Number):void{
            (this._alphaOver = _arg1);
        }
        public function get timeShow():Number{
            return (this._timeShow);
        }
        public function set timeShow(_arg1:Number):void{
            (this._timeShow = _arg1);
        }
        public function get timeHide():Number{
            return (this._timeHide);
        }
        public function set timeHide(_arg1:Number):void{
            (this._timeHide = _arg1);
        }
        public function get timeOver():Number{
            return (this._timeOver);
        }
        public function set timeOver(_arg1:Number):void{
            (this._timeOver = _arg1);
        }
        public function get timeSelected():Number{
            return (this._timeSelected);
        }
        public function set timeSelected(_arg1:Number):void{
            (this._timeSelected = _arg1);
        }
        public function get alphaSelected():Number{
            return (this._alphaSelected);
        }
        public function set alphaSelected(_arg1:Number):void{
            (this._alphaSelected = _arg1);
        }
        public function get tweenSelected():Object{
            return (this._tweenSelected);
        }
        public function set tweenSelected(_arg1:Object):void{
            (this._tweenSelected = _arg1);
        }

    }
}//package com.madebyplay.CU3ER.model 
