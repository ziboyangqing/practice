package milkmidi.papervision3d.view {
    import flash.events.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.objects.primitives.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.view.*;
    import flash.utils.*;
    import org.papervision3d.materials.*;

    public class BasicViewX extends BasicView {

        private namespace milkmidi = "milkmidi.papervision3d.view:BasicViewX/private:milkmidi";

        protected var rootNode:DisplayObject3D;
        private var _destroyed:Boolean = false;
        private var _isRemovingFromStage:Boolean = false;
        private var _isActive:Boolean = true;
        private var _isRender:Boolean = false;

        public function BasicViewX(_arg1:Number=0, _arg2:Number=0, _arg3:Boolean=true, _arg4:Boolean=false, _arg5:String="Target", _arg6:Boolean=true):void{
            this.rootNode = new DisplayObject3D();
            super(_arg1, _arg2, _arg3, _arg4, _arg5);
            trace((this + ".Consturctor()"), (" cameraType:" + _arg5));
            this.addEventListener(Event.ADDED_TO_STAGE, this.addToStageHandler, false, 0, true);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageHandler, false, 0, true);
            scene.addChild(this.rootNode, "rootNode");
            if (_arg6){
                startRendering();
            };
        }
        protected function createPlane(_arg1:MaterialObject3D=null, _arg2:int=400, _arg3:int=400):Plane{
            var _local4:MaterialObject3D = ((_arg1 == null)) ? new ColorMaterial(14548974) : _arg1;
            _local4.doubleSided = true;
            var _local5:Plane = new Plane(_local4, _arg2, _arg3);
            return (_local5);
        }
        public function destroy():void{
            if (this._isRemovingFromStage){
                return;
            };
            this.milkmidi::destroy();
            if (this.parent){
                this.removeEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
                this.parent.removeChild(this);
            };
        }
        private function addToStageHandler(_arg1:Event):void{
            this.init();
            this._isRender = true;
            this.removeEventListener(Event.ADDED_TO_STAGE, this.addToStageHandler);
            stage.addEventListener(Event.ACTIVATE, this.activateHandler);
            stage.addEventListener(Event.DEACTIVATE, this.deactivateHandler);
        }
        protected function init():void{
        }
        override protected function onRenderTick(_arg1:Event=null):void{
            if (!this._isActive){
                return;
            };
            if (!this._isRender){
                return;
            };
            this.extraRender3D();
            super.onRenderTick(_arg1);
        }
        public function get render():Boolean{
            return (this._isRender);
        }
        private function activateHandler(_arg1:Event):void{
            this._isActive = true;
        }
        public function get destroyed():Boolean{
            return (this._destroyed);
        }
        protected function getOnePercentPositionZ():int{
            return (((camera.focus * camera.zoom) - Math.abs(camera.z)));
        }
        public function get mouseXHalf():Number{
            if (!stage){
                return (0);
            };
            return (((stage.stageWidth / 2) - stage.mouseX));
        }
        public function get mouseYHalf():Number{
            if (!stage){
                return (0);
            };
            return (((stage.stageHeight / 2) - stage.mouseY));
        }
        public function set render(_arg1:Boolean):void{
            this._isRender = _arg1;
        }
        private function deactivateHandler(_arg1:Event):void{
            this._isActive = false;
        }
        protected function extraRender3D():void{
        }
        milkmidi function destroy():void{
            if (this._destroyed){
                trace((this + " Destroyed!"));
                return;
            };
            this.removeEventListener(Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            stage.removeEventListener(Event.ACTIVATE, this.activateHandler);
            stage.removeEventListener(Event.DEACTIVATE, this.deactivateHandler);
            this.render = false;
            stopRendering();
            viewport.destroy();
            this._destroyed = true;
        }
        override public function toString():String{
            return (getQualifiedClassName(this));
        }
        private function removedFromStageHandler(_arg1:Event=null):void{
            this._isRemovingFromStage = true;
            this.destroy();
            this.milkmidi::destroy();
        }

    }
}//package milkmidi.papervision3d.view 
