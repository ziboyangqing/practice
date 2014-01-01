package org.papervision3d.materials.special {
    import org.papervision3d.core.proto.*;
    import org.papervision3d.core.render.data.*;
    import flash.geom.*;
    import org.papervision3d.core.render.command.*;
    import flash.display.*;
    import org.papervision3d.core.geom.renderables.*;
    import org.papervision3d.core.render.draw.*;
    import org.papervision3d.core.material.*;

    public class DoubleSidedCompositeMaterial extends TriangleMaterial implements ITriangleDrawer {

        protected var materials:Array;

        public function DoubleSidedCompositeMaterial(_arg1:MaterialObject3D, _arg2:MaterialObject3D){
            this._initialize();
            if (_arg1){
                this.addMaterial(_arg1);
            };
            if (_arg2){
                _arg2.opposite = true;
                this.addMaterial(_arg2);
            };
            this.doubleSided = true;
        }
        private function _initialize():void{
            this.materials = new Array();
        }
        override public function drawTriangle(_arg1:RenderTriangle, _arg2:Graphics, _arg3:RenderSessionData, _arg4:BitmapData=null, _arg5:Matrix=null):void{
            var _local6:Vertex3DInstance;
            var _local7:Vertex3DInstance;
            var _local8:Vertex3DInstance;
            var _local9:Number;
            var _local10:Number;
            var _local11:Number;
            var _local12:Number;
            var _local13:Number;
            var _local14:Number;
            var _local15:Boolean;
            var _local16:MaterialObject3D;
            for each (_local16 in this.materials) {
                _local15 = true;
                _local6 = _arg1.v0.clone();
                _local7 = _arg1.v1.clone();
                _local8 = _arg1.v2.clone();
                _local9 = _local6.x;
                _local10 = _local6.y;
                _local11 = _local7.x;
                _local12 = _local7.y;
                _local13 = _local8.x;
                _local14 = _local8.y;
                if (_local16.opposite){
                    if ((((_local13 - _local9) * (_local12 - _local10)) - ((_local14 - _local10) * (_local11 - _local9))) > 0){
                        _local15 = false;
                    };
                } else {
                    if ((((_local13 - _local9) * (_local12 - _local10)) - ((_local14 - _local10) * (_local11 - _local9))) < 0){
                        _local15 = false;
                    };
                };
                if (((_local15) && (!((_local16 == null))))){
                    _local16.drawTriangle(_arg1, _arg2, _arg3);
                };
            };
        }
        private function addMaterial(_arg1:MaterialObject3D):void{
            this.materials.push(_arg1);
        }

    }
}//package org.papervision3d.materials.special 