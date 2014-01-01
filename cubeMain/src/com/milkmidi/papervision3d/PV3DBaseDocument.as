package com.milkmidi.papervision3d {
    import flash.events.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.view.*;
    import flash.display.*;
    import org.papervision3d.render.*;
    import flash.utils.*;
    //import org.papervision3d.*;
    import org.papervision3d.scenes.*;
    import org.papervision3d.cameras.*;

    public class PV3DBaseDocument extends Sprite {

        public static var debug:Boolean = false;

        private var qualityTimerMax:uint = 50;
        protected var camera:CameraObject3D;
        private var _debug:Boolean = false;
        protected var scene:Scene3D;
        protected var viewport:Viewport3D;
        private var qualityTimer:uint = 0;
        protected var renderer:BasicRenderEngine;
        private var _isRender:Boolean = true;
        private var isActive:Boolean = true;

        public function PV3DBaseDocument(){
            _isRender = true;
            isActive = true;
            _debug = false;
            qualityTimer = 0;
            qualityTimerMax = 50;
            super();
            this.addEventListener(Event.ADDED_TO_STAGE, onAdd2Stage);
            this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
            //Papervision3D.VERBOSE = false;
        }
        public function set render(_arg1:Boolean):void{
            _isRender = _arg1;
            if (debug){
                trace(("PV3DBaseDocument.render: " + _arg1));
            };
        }
        public function setQuality(_arg1:Boolean):void{
            if (stage == null){
                return;
            };
            if (!_arg1){
                stage.quality = StageQuality.LOW;
            } else {
                stage.quality = StageQuality.HIGH;
            };
        }
        protected function onRemoveFromStage(_arg1:Event):void{
            this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
            this.removeEventListener(Event.ENTER_FRAME, onRender3D);
            stage.removeEventListener(Event.ACTIVATE, onActivate);
            stage.removeEventListener(Event.DEACTIVATE, onDeActivate);
        }
        override public function toString():String{
            return (getQualifiedClassName(this));
        }
        protected function render3D():void{
            renderer.renderScene(scene, camera, viewport);
        }
        protected function init3D(_arg1:Number=0, _arg2:Number=0, _arg3:Boolean=true, _arg4:Boolean=false):void{
            viewport = new Viewport3D(_arg1, _arg2, _arg3, _arg4);
            this.addChild(viewport);
            renderer = new BasicRenderEngine();
            scene = new Scene3D();
            camera = new Camera3D();
            camera.z = -300;
            this.addEventListener(Event.ENTER_FRAME, onRender3D);
        }
        public function get render():Boolean{
            return (_isRender);
        }
        protected function onAdd2Stage(_arg1:Event=null):void{
            this.removeEventListener(Event.ADDED_TO_STAGE, onAdd2Stage);
            stage.addEventListener(Event.ACTIVATE, onActivate);
            stage.addEventListener(Event.DEACTIVATE, onDeActivate);
        }
        protected function extraRender3D():void{
        }
        private function onRender3D(_arg1:Event):void{
            if (!isActive){
                return;
            };
            if (!_isRender){
                return;
            };
            extraRender3D();
            renderer.renderScene(scene, camera, viewport);
        }
        private function onDeActivate(_arg1:Event):void{
            isActive = false;
            if (debug){
                trace(("PV3DBaseDocument.isActive: " + isActive));
            };
        }
        private function onActivate(_arg1:Event):void{
            isActive = true;
            if (debug){
                trace(("PV3DBaseDocument.isActive: " + isActive));
            };
        }
        public function destroy():void{
            if (this.parent){
                this.parent.removeChild(this);
            };
        }

    }
}
