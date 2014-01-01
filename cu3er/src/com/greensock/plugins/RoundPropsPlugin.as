//Created by Action Script Viewer - http://www.buraks.com/asv
package com.greensock.plugins {
    import com.greensock.*;
    import com.greensock.core.*;

    public class RoundPropsPlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected var _tween:TweenLite;

        public function RoundPropsPlugin(){
            this.propName = "roundProps";
            this.overwriteProps = ["roundProps"];
            this.round = true;
            this.priority = -1;
            this.onInitAllProps = this._initAllProps;
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            this._tween = _arg3;
            this.overwriteProps = this.overwriteProps.concat((_arg2 as Array));
            return (true);
        }
        protected function _initAllProps():void{
            var _local1:String;
            var _local2:String;
            var _local4:PropTween;
            var _local3:Array = this._tween.vars.roundProps;
            var _local5:int = _local3.length;
            while (--_local5 > -1) {
                _local1 = _local3[_local5];
                _local4 = this._tween.cachedPT1;
                while (_local4) {
                    if (_local4.name == _local1){
                        if (_local4.isPlugin){
                            _local4.target.round = true;
                        } else {
                            this.add(_local4.target, _local1, _local4.start, _local4.change);
                            this._removePropTween(_local4);
                            this._tween.propTweenLookup[_local1] = this._tween.propTweenLookup.roundProps;
                        };
                    } else {
                        if (((((_local4.isPlugin) && ((_local4.name == "_MULTIPLE_")))) && (!(_local4.target.round)))){
                            _local2 = ((" " + _local4.target.overwriteProps.join(" ")) + " ");
                            if (_local2.indexOf(((" " + _local1) + " ")) != -1){
                                _local4.target.round = true;
                            };
                        };
                    };
                    _local4 = _local4.nextNode;
                };
            };
        }
        protected function _removePropTween(_arg1:PropTween):void{
            if (_arg1.nextNode){
                _arg1.nextNode.prevNode = _arg1.prevNode;
            };
            if (_arg1.prevNode){
                _arg1.prevNode.nextNode = _arg1.nextNode;
            } else {
                if (this._tween.cachedPT1 == _arg1){
                    this._tween.cachedPT1 = _arg1.nextNode;
                };
            };
            if (((_arg1.isPlugin) && (_arg1.target.onDisable))){
                _arg1.target.onDisable();
            };
        }
        public function add(_arg1:Object, _arg2:String, _arg3:Number, _arg4:Number):void{
            addTween(_arg1, _arg2, _arg3, (_arg3 + _arg4), _arg2);
            this.overwriteProps[this.overwriteProps.length] = _arg2;
        }

    }
}//package com.greensock.plugins 
