package com.madebyplay.CU3ER.view 
{
    import com.madebyplay.CU3ER.controller.*;
    import com.madebyplay.CU3ER.interfaces.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import org.papervision3d.cameras.*;
    import org.papervision3d.core.math.*;
    import org.papervision3d.lights.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.objects.primitives.*;
    import org.papervision3d.render.*;
    import org.papervision3d.scenes.*;
    import org.papervision3d.view.*;
    
    public class Scene extends flash.display.MovieClip implements com.madebyplay.CU3ER.interfaces.IDisplayObject
    {
        public function Scene(arg1:com.madebyplay.CU3ER.controller.Player=null, arg2:String="quadratic")
        {
            var loc1:*=NaN;
            super();
            this._player = arg1;
            this._viewport = new org.papervision3d.view.Viewport3D(Math.round(this._player.data.width), Math.round(this._player.data.height));
            this.addChild(this._viewport);
            this._scene = new org.papervision3d.scenes.Scene3D();
            this._renderer = new org.papervision3d.render.QuadrantRenderEngine(org.papervision3d.render.QuadrantRenderEngine.CORRECT_Z_FILTER);
            this._camera = new org.papervision3d.cameras.Camera3D();
            this._camera.ortho = false;
            this._camera.focus = 100;
            if (this._player.data.cameraLens > 20) 
            {
                this._camera.zoom = 20;
            }
            else if (this._player.data.cameraLens < 1) 
            {
                this._camera.zoom = 1;
            }
            else 
            {
                this._camera.zoom = this._player.data.cameraLens;
            }
            this._camera.z = this._player.data.cameraZ - this._camera.focus * this._camera.zoom;
            this._light = new org.papervision3d.lights.PointLight3D();
            this._light.position = new org.papervision3d.core.math.Number3D(0, 0, -15000);
            this._scene.addChild(this._light);
            return;
        }

        public function stopRender():void
        {
            if (hasEventListener(flash.events.Event.ENTER_FRAME)) 
            {
                removeEventListener(flash.events.Event.ENTER_FRAME, this._render);
            }
            dispatchEvent(new flash.events.Event(RENDER_STOP));
            this._renderOnce = false;
            return;
        }

        public function renderOnce():void
        {
            this._renderOnce = true;
            this._renderStart = true;
            this.render();
            return;
        }

        internal function _render(arg1:flash.events.Event):void
        {
            this._renderer.renderScene(this._scene, this._camera, this._viewport);
            if (this._renderOnce) 
            {
                this.stopRender();
            }
            if (this._renderStart) 
            {
                dispatchEvent(new flash.events.Event(RENDER_START));
                this._renderStart = false;
            }
            return;
        }

        public function createCube():void
        {
            return;
        }

        public function destroy():void
        {
            this.stopRender();
            this._viewport.destroy();
            this._renderer.destroy();
            this.removeChild(this._viewport);
            this._viewport = null;
            this._renderer = null;
            this._light = null;
            this.parent.removeChild(this);
            delete this;
            return;
        }

        public function get player():com.madebyplay.CU3ER.controller.Player
        {
            return this._player;
        }

        public function set player(arg1:com.madebyplay.CU3ER.controller.Player):void
        {
            this._player = arg1;
            this._deltaPos = new flash.geom.Point();
            return;
        }

        public function get scene():org.papervision3d.scenes.Scene3D
        {
            return this._scene;
        }

        public function set scene(arg1:org.papervision3d.scenes.Scene3D):void
        {
            this._scene = arg1;
            return;
        }

        public function get deltaPos():flash.geom.Point
        {
            return this._deltaPos;
        }

        public function get container():org.papervision3d.objects.DisplayObject3D
        {
            return this._container;
        }

        public function set container(arg1:org.papervision3d.objects.DisplayObject3D):void
        {
            this._container = arg1;
            return;
        }

        public function get camera():org.papervision3d.cameras.Camera3D
        {
            return this._camera;
        }

        public function get light():org.papervision3d.lights.PointLight3D
        {
            return this._light;
        }

        public function set light(arg1:org.papervision3d.lights.PointLight3D):void
        {
            this._light = arg1;
            return;
        }

        
        {
            RENDER_START = "renderStart";
            RENDER_STOP = "renderStop";
        }

        public function moveCamera(arg1:org.papervision3d.core.math.Number3D):void
        {
            this._camera.x = arg1.x;
            this._camera.y = arg1.y;
            this._camera.z = arg1.z;
            this._camera.lookAt(new org.papervision3d.objects.DisplayObject3D("empty"));
            return;
        }

        public function render():void
        {
            if (!hasEventListener(flash.events.Event.ENTER_FRAME)) 
            {
                this._renderStart = true;
                addEventListener(flash.events.Event.ENTER_FRAME, this._render, false, 0, true);
            }
            return;
        }

        internal var _viewport:org.papervision3d.view.Viewport3D;

        internal var _scene:org.papervision3d.scenes.Scene3D;

        internal var _camera:org.papervision3d.cameras.Camera3D;

        internal var _material:org.papervision3d.materials.BitmapMaterial;

        internal var _primitive:org.papervision3d.objects.primitives.Plane;

        internal var _renderer:org.papervision3d.render.QuadrantRenderEngine;

        internal var _player:com.madebyplay.CU3ER.controller.Player;

        internal var _deltaPos:flash.geom.Point;

        internal var _white:org.papervision3d.materials.ColorMaterial;

        internal var _black:org.papervision3d.materials.ColorMaterial;

        internal var _floor:org.papervision3d.objects.primitives.Plane;

        public var _camera_shadow:org.papervision3d.cameras.Camera3D;

        internal var _light:org.papervision3d.lights.PointLight3D;

        internal var _container:org.papervision3d.objects.DisplayObject3D;

        internal var _renderOnce:Boolean=false;

        internal var _renderStart:Boolean=false;

        public static var RENDER_STOP:String="renderStop";

        public static var RENDER_START:String="renderStart";
    }
}
