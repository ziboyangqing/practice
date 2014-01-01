//Created by Action Script Viewer - http://www.buraks.com/asv
package com.milkmidi.papervision3d {
    import flash.events.*;
    import org.papervision3d.core.proto.*;
    import flash.display.*;
    import org.papervision3d.objects.*;
    import flash.ui.*;

    public class ObjectController extends EventDispatcher {

        public static const RENDER:String = "render";

        private static var _instance:ObjectController = null;

        protected var lastX:Number;
        protected var lastY:Number;
        protected var currentObjOrigin:Object;
        private var stage:Stage;
        protected var rotateAmmount:int = 1;
        protected var difX:Number;
        protected var moveAmmount:int = 20;
        public var isMouseDown:Boolean = false;
        public var restrictInversion:Boolean = false;
        protected var currentObj:DisplayObject3D;
        protected var difY:Number;

        public function ObjectController(){
            isMouseDown = false;
            restrictInversion = false;
            currentObjOrigin = new Object();
            moveAmmount = 20;
            rotateAmmount = 1;
            super();
        }
        public static function getInstance():ObjectController{
            if (_instance == null){
                _instance = new (ObjectController)();
            };
            return (_instance);
        }

        public function destroy():void{
            currentObj = null;
            stage.removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
            stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, _onStageKeyDown);
        }
        protected function updateDif():void{
            difX = Number((stage.mouseX - lastX));
            difY = Number((stage.mouseY - lastY));
        }
        protected function updateLastRotation():void{
            lastX = stage.mouseX;
            lastY = stage.mouseY;
        }
        protected function _onMouseMove(_arg1:MouseEvent):void{
            updateMovements();
        }
        protected function updateMovements():void{
            var posx:* = NaN;
            var posy:* = NaN;
            var _ref:* = 0;
            updateDif();
            if (!isMouseDown){
                return;
            };
            try {
                posx = (difX / 7);
                posy = (difY / 7);
                posx = ((posx > 360)) ? (posx % 360) : posx;
                posy = ((posy > 360)) ? (posy % 360) : posy;
                _ref = (restrictInversion) ? -1 : 1;
                currentObj.rotationY = (currentObj.rotationY + (posx * _ref));
                currentObj.rotationX = (currentObj.rotationX - (posy * _ref));
                if (difX != 0){
                    lastX = stage.mouseX;
                };
                if (difY != 0){
                    lastY = stage.mouseY;
                };
            } catch(e:Error) {
                trace(e);
            };
            this.dispatchEvent(new Event(ObjectController.RENDER));
        }
        public function registerControlObject(_arg1:DisplayObject3D, _arg2:Stage):void{
            if (_arg2 == null){
                throw (new Error("stage is null!!!!!!!!!!!!!"));
            };
            currentObj = _arg1;
            currentObjOrigin.x = currentObj.x;
            currentObjOrigin.y = currentObj.y;
            currentObjOrigin.z = currentObj.z;
            currentObjOrigin.rotationX = currentObj.rotationX;
            currentObjOrigin.rotationY = currentObj.rotationY;
            currentObjOrigin.rotationZ = currentObj.rotationZ;
            stage = _arg2;
            stage.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
            stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMove);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, _onStageKeyDown);
            updateLastRotation();
            updateDif();
            trace(("ObjectController registerControlObject:" + _arg1));
        }
        protected function _onMouseDown(_arg1:MouseEvent):void{
            updateLastRotation();
            isMouseDown = true;
            stage.quality = StageQuality.MEDIUM;
        }
        protected function _onStageKeyDown(_arg1:KeyboardEvent):void{
            var _local2:CameraObject3D;
            switch (_arg1.keyCode){
                case Keyboard.PAGE_DOWN:
                    currentObj.moveUp(moveAmmount);
                    break;
                case Keyboard.PAGE_UP:
                    currentObj.moveDown(moveAmmount);
                    break;
                case "A".charCodeAt():
                    currentObj.moveLeft(moveAmmount);
                    break;
                case "D".charCodeAt():
                    currentObj.moveRight(moveAmmount);
                    break;
                case "W".charCodeAt():
                    currentObj.moveForward(moveAmmount);
                    break;
                case "S".charCodeAt():
                    currentObj.moveBackward(moveAmmount);
                    break;
                case Keyboard.UP:
                    currentObj.pitch(-(rotateAmmount));
                    break;
                case Keyboard.DOWN:
                    currentObj.pitch(rotateAmmount);
                    break;
                case Keyboard.LEFT:
                    currentObj.rotationY = (currentObj.rotationY - rotateAmmount);
                    break;
                case Keyboard.RIGHT:
                    currentObj.rotationY = (currentObj.rotationY + rotateAmmount);
                    break;
                case Keyboard.SPACE:
                    currentObj.x = currentObjOrigin.x;
                    currentObj.y = currentObjOrigin.y;
                    currentObj.z = currentObjOrigin.z;
                    currentObj.rotationX = currentObjOrigin.rotationX;
                    currentObj.rotationY = currentObjOrigin.rotationY;
                    currentObj.rotationZ = currentObjOrigin.rotationZ;
                    break;
                case "Z".charCodeAt():
                    trace("////////////// currentObj /////////");
                    trace(((((("x:" + currentObj.x) + ", y:") + currentObj.y) + ", z:") + currentObj.z));
                    trace(((((("rotationX:" + currentObj.rotationX) + ", rotationY:") + currentObj.rotationY) + ", rotationZ:") + currentObj.rotationZ));
                    _local2 = (currentObj as CameraObject3D);
                    if (_local2){
                        trace(((("zoom:" + _local2.zoom) + ", focus:") + _local2.focus));
                    };
                    trace("////////////// currentObj /////////");
                    break;
            };
            this.dispatchEvent(new Event(ObjectController.RENDER));
        }
        protected function _onMouseUp(_arg1:MouseEvent):void{
            isMouseDown = false;
            stage.quality = StageQuality.HIGH;
            updateLastRotation();
        }

    }
}//package com.milkmidi.papervision3d 
