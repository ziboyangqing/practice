//Created by Action Script Viewer - http://www.buraks.com/asv
package com.milkmidi.display {
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;
    import flash.text.*;
    import flash.system.*;

    public class FPS extends BaseMC {

        private var _secondTime:Number;
        private var _prevSecondTime:Number;
        private var _updateStr:String = "";
        private var _fps:String = "...";
        private var _frameTime:Number;
        private var _shape:Shape;
        private var _time:Number;
        private var _txt:TextField;
        private var _frames:Number = 0;
        private var _fmt:TextFormat;
        private var _prevFrameTime:Number;

        public function FPS(_arg1:uint=0, _arg2:uint=0):void{
            _fps = "...";
            _frames = 0;
            _updateStr = "";
            super();
            _fmt = new TextFormat();
            _fmt.bold = true;
            _fmt.font = "Arial";
            _fmt.size = 10;
            _fmt.color = 0xFFFFFF;
            _txt = new TextField();
            _txt.autoSize = "left";
            _txt.text = "loading";
            _txt.defaultTextFormat = _fmt;
            _txt.selectable = false;
            doDrawRect();
            addChild(_txt);
            _prevFrameTime = getTimer();
            _prevSecondTime = getTimer();
            this.x = _arg1;
            this.y = _arg2;
            this.name = "FPS";
        }
        private function doDrawRect():void{
            _shape = new Shape();
            _shape.graphics.beginFill(0xFF0000, 0.75);
            _shape.graphics.drawRect(0, 0, 100, 15);
            _shape.graphics.endFill();
            addChild(_shape);
        }
        private function onUpdateFPS(_arg1:Event):void{
            _time = getTimer();
            _frameTime = (_time - _prevFrameTime);
            _secondTime = (_time - _prevSecondTime);
            if (_secondTime >= 1000){
                _fps = _frames.toString();
                _frames = 0;
                _prevSecondTime = _time;
            } else {
                _frames++;
            };
            _prevFrameTime = _time;
            _txt.text = (((_fps + " FPS / ") + _frameTime) + " MS");
            _txt.appendText(((("   " + ((System.totalMemory * 0.001) << 0)) + "KB   ") + _updateStr));
            _shape.scaleX = (_shape.scaleX - ((_shape.scaleX - (_frameTime / 10)) / 5));
        }
        override protected function onRemoveFromStage(_arg1:Event=null):void{
            super.onRemoveFromStage(_arg1);
            this.removeEventListener(Event.ENTER_FRAME, onUpdateFPS);
            _shape.graphics.endFill();
            this.removeChild(_shape);
        }
        override protected function onAdd2Stage(_arg1:Event=null):void{
            super.onAdd2Stage(_arg1);
            this.addEventListener(Event.ENTER_FRAME, onUpdateFPS);
        }
        public function update(_arg1:String):void{
            _updateStr = _arg1;
        }

    }
}//package com.milkmidi.display 
