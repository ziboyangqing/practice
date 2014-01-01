package {
	import caurina.transitions.*;

	import com.milkmidi.method.*;
	import com.milkmidi.papervision3d.*;

	import flash.display.*;
	import flash.events.*;
	import flash.filters.*;
	import flash.utils.*;

	import myevents.MyEvent;

	import org.papervision3d.events.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.materials.utils.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;

	public class CubeMain3DWorld extends PV3DBaseDocument {
		private var rootNode:DisplayObject3D;
		private var isOutro:Boolean=false;
		private var cube:Cube;
		private var cursor_old_x:Number=0;
		private var cursor_old_y:Number=0;
		private var isIntro:Boolean=true;
		private var cursor_new_x:Number=0;
		public var currentFace:int=0;
		private var planeSize:int=200;
		private var matrialArray:Array;
		private var decay:Number=0.98;
		private var vx:Number=0;
		private var cursor_new_y:Number=0;
		private var isRotation:Boolean=false;
		private var vy:Number=0;
		private var cubeSize:int=400;
		private var isMouseDown:Boolean=false;
		private var _lastTime:Number=0;

		public function CubeMain3DWorld() {
			rootNode=new DisplayObject3D();
			cubeSize=400;
			planeSize=200;
			vx=0;
			vy=0;
			decay=0.98;
			cursor_old_x=0;
			cursor_new_x=0;
			cursor_old_y=0;
			cursor_new_y=0;
			isMouseDown=false;
			isOutro=false;
			isIntro=true;
			isRotation=false;
			matrialArray=new Array();
			_lastTime=0;
			currentFace=0;
			super.init3D(0, 0, true, true);
			camera.z=-1500;
			camera.y=110;
			camera.focus=10;
			initObject();
			return;
		}

		protected function on3DClick(event:InteractiveScene3DEvent):void {
			var _loc_2:MovieClip=null;
			_loc_2=(event.face3d.material as MovieMaterial).movie as MovieClip;
			trace("face3d.material.movie.id:" + _loc_2.id);
			if (getTimer() - _lastTime < 300) {
				setFace(_loc_2.id, true);
			} else if (Tweener.isTweening(rootNode)) {
				Tweener.removeTweens(rootNode);
			}
			_lastTime=getTimer();
			return;
		}

		private function onIntroComplete():void {
			viewport.filters=[];
			isIntro=false;
			this.dispatchEvent(new MyEvent(MyEvent.INTRO_COMPLETE));
			return;
		}

		private function onEventMouseDown(event:MouseEvent=null):void {
			isMouseDown=true;
			super.render=true;
			setQuality(false);
			setMaterialSmooth(false);
			return;
		}

		public function startAnimation():void {
			cube.scaleX=0.2;
			cube.scaleY=0.2;
			cube.scaleZ=0.2;
			cube.rotationX=NumberUtil.random(-360, 360);
			cube.rotationY=NumberUtil.random(-360, 360);
			cube.rotationZ=NumberUtil.random(-360, 360);
			Tweener.addTween(cube, {scaleX: 1, scaleY: 1, scaleZ: 1, rotationX: 0, rotationY: 0, rotationZ: 0, time: 1, transition: "easeOutBack"});
			viewport.filters=[new BlurFilter(64, 64, 1)];
			Tweener.addTween(viewport, {_blur_blurX: 0, _blur_blurY: 0, time: 1.1, transition: "easeoutexpo", onComplete: onIntroComplete});
			return;
		}

		protected function initObject():void {
			var _loc_1:MaterialsList=null;
			_loc_1=new MaterialsList({front: getMCMaterial(1), back: getMCMaterial(2), left: getMCMaterial(3), right: getMCMaterial(4), top: getMCMaterial(5), bottom: getMCMaterial(6)});
			cube=new Cube(_loc_1, cubeSize, cubeSize, cubeSize, 8, 8, 8);
			cube.addEventListener(InteractiveScene3DEvent.OBJECT_PRESS, on3DClick);
			rootNode.addChild(cube);
			scene.addChild(rootNode);
			return;
		}

		override protected function onRemoveFromStage(event:Event):void {
			super.onRemoveFromStage(event);
			ObjectController.getInstance().destroy();
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onEventMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onEventMouseUp);
			return;
		}

		private function onSetFaceTweenerComplete(param1:Boolean=false):void {
			if (param1) {
			}
			isRotation=false;
			setQuality(true);
			setMaterialSmooth(true);
			return;
		}

		protected function getMCMaterial(param1:int):MovieMaterial {
			var _loc_2:MovieClip=null;
			var _loc_3:MovieClip=null;
			var _loc_4:MovieMaterial=null;
			_loc_2=new MovieMaterialMC();
			_loc_2.name="a" + param1;
			_loc_2.id=param1;
			_loc_2.gotoAndStop(param1);
			_loc_3=_loc_2.getChildByName("title_mc") as MovieClip;
			_loc_3.gotoAndStop(param1);
			_loc_4=new MovieMaterial(_loc_2, false, false);
			_loc_4.interactive=true;
			matrialArray.push({titleMC: _loc_3, material: _loc_4});
			return _loc_4;
		}

		override protected function onAdd2Stage(event:Event=null):void {
			super.onAdd2Stage(event);
			ObjectController.getInstance().registerControlObject(rootNode, this.stage);
			ObjectController.getInstance().restrictInversion=true;
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onEventMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, onEventMouseUp);
			return;
		}

		override protected function extraRender3D():void {
			if (isOutro || isIntro || isRotation) {
				return;
			}
			if (!isMouseDown && Math.abs(vx) < 0.9 && Math.abs(vy) < 0.9) {
				setMaterialSmooth(true);
				super.render=false;
			}
			if (isMouseDown == true) {
				calVelocity();
			} else {
				vx=vx * decay;
				vy=vy * decay;
				rootNode.rotationY=rootNode.rotationY + vx;
				rootNode.rotationX=rootNode.rotationX + vy;
			}
			return;
		}

		public function outroAnimation(param1:int):void {
			var i:int;
			var _mat:MovieMaterial;
			var _titleMC:MovieClip;
			var _face:*=param1;
			this.dispatchEvent(new MyEvent(MyEvent.OUTRO_START));
			currentFace=_face;
			ObjectController.getInstance().destroy();
			isOutro=true;
			i=0;
			while (i < matrialArray.length) {

				_mat=matrialArray[i].material as MovieMaterial;
				_mat.animated=true;
				_titleMC=matrialArray[i].titleMC as MovieClip;
				Tweener.addTween(_titleMC, {alpha: 0, time: 0.8, onComplete: function(param1:MovieMaterial):void {
					param1.animated=false;
					param1.smooth=false;
					return;
				}, onCompleteParams: [_mat]});
				i=(i + 1);
			}
			Tweener.addTween(rootNode, {rotationX: 28, rotationY: -35, rotationZ: 15, time: 1, onComplete: onOutroAnimationComplete});
			return;
		}

		private function onEventMouseUp(event:MouseEvent=null):void {
			isMouseDown=false;
			setQuality(true);
			return;
		}

		private function setMaterialSmooth(param1:Boolean):void {
			cube.getMaterialByName("front").smooth=param1;
			cube.getMaterialByName("back").smooth=param1;
			cube.getMaterialByName("left").smooth=param1;
			cube.getMaterialByName("right").smooth=param1;
			cube.getMaterialByName("top").smooth=param1;
			cube.getMaterialByName("bottom").smooth=param1;
			return;
		}

		private function onOutroAnimationComplete():void {
			this.dispatchEvent(new MyEvent(MyEvent.OUTRO_COMPLETE, currentFace));
			return;
		}

		private function calVelocity():void {
			cursor_old_x=cursor_new_x;
			cursor_old_y=cursor_new_y;
			cursor_new_x=stage.mouseX;
			cursor_new_y=stage.mouseY;
			vx=(cursor_old_x - cursor_new_x) / 10;
			vy=(cursor_new_y - cursor_old_y) / 10;
			return;
		}

		public function setFace(param1:int, param2:Boolean=false):void {
			var _loc_3:Object=null;
			isRotation=true;
			super.render=true;
			setQuality(false);
			setMaterialSmooth(false);
			trace(this + " .setFace() " + param1);
			_loc_3=new Object();
			switch (param1) {
			case 1:  {
				_loc_3={rotationX: 0, rotationY: 180, rotationZ: 0};
				break;
			}
			case 2:  {
				_loc_3={rotationX: 0, rotationY: 0, rotationZ: 0};
				break;
			}
			case 3:  {
				_loc_3={rotationX: 0, rotationY: -90, rotationZ: 0};
				break;
			}
			case 4:  {
				_loc_3={rotationX: 0, rotationY: 90, rotationZ: 0};
				break;
			}
			case 5:  {
				_loc_3={rotationX: 90, rotationY: 0, rotationZ: 0};
				break;
			}
			case 6:  {
				_loc_3={rotationX: -90, rotationY: 0, rotationZ: 180};
				break;
			}
			default:  {
				break;
			}
			}
			_loc_3.time=1;
			_loc_3.transition="";
			_loc_3.onComplete=onSetFaceTweenerComplete;
			_loc_3.onCompleteParams=[param2];
			Tweener.addTween(rootNode, _loc_3);
			return;
		}

	}
}


