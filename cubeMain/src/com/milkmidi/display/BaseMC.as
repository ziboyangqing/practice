//Created by Action Script Viewer - http://www.buraks.com/asv
package com.milkmidi.display {
    import flash.events.*;
    import flash.display.*;
    import flash.utils.*;

    public class BaseMC extends MovieClip {

        public function BaseMC(){
            if (this.loaderInfo && root){
                this.loaderInfo.addEventListener(Event.COMPLETE, onLoaderInfoInit);
            };
            this.addEventListener(Event.ADDED_TO_STAGE, onAdd2Stage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
        }
        public function destroy():void{
            if ((this.parent as Loader)){
                Loader(this.parent).unload();
            } else {
                if (this.parent){
                    this.parent.removeChild(this);
                };
            };
        }
        protected function onStageResize(_arg1:Event=null):void{
        }
        override public function toString():String{
            return (getQualifiedClassName(this));
        }
        protected function onRemoveFromStage(_arg1:Event=null):void{
            this.stop();
            this.removeEventListener(Event.ADDED_TO_STAGE, onAdd2Stage);
            this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
            if (stage){
                stage.removeEventListener(Event.RESIZE, onStageResize);
            };
        }
        protected function onAdd2Stage(_arg1:Event=null):void{
            if (stage){
                stage.addEventListener(Event.RESIZE, onStageResize);
            };
        }
        protected function onLoaderInfoInit(_arg1:Event):void{
            if (((this.loaderInfo) && (root))){
                this.loaderInfo.removeEventListener(Event.COMPLETE, onLoaderInfoInit);
            };
            trace((("**   " + this) + "   **  onLoaderInfoInit()"));
        }
        override public function set y(_arg1:Number):void{
            super.y = int(_arg1);
        }
        override public function set x(_arg1:Number):void{
            super.x = int(_arg1);
        }

    }
}//package com.milkmidi.display 
