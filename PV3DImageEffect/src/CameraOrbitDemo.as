package{
	import flash.display.*;
	import flash.events.Event;
	import flash.geom.*;
	import flash.net.URLRequest;

	import gs.*;
	import gs.easing.*;

	import milkmidi.papervision3d.view.*;
	import milkmidi.utils.*;

	import org.papervision3d.cameras.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.materials.special.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;
	[SWF(width="600",height="350",backgroundColor="0xFF6600",frameRate="30")]
	public class CameraOrbitDemo extends milkmidi.papervision3d.view.BasicViewX{
		private var nuMs:int=7;
		private var idx:int=1;
		private var loader:Loader;
		internal var _offsetX:Number=0;
		internal var _offsetY:Number=0;
		internal const _cols:int=10;
		internal const _rows:int=10;
		internal var total:int=0;
		internal var curidx:int=0;
		internal var idx1:int=0;
		internal var idx2:int=0;
		internal var _isFront:Boolean=false;
		internal var _sourceBmp:flash.display.BitmapData;
		internal var _bitmapArray:Array;
		internal var _planeArray:Array;
		public var camOrbitY:Number=270;

		public function CameraOrbitDemo(){
			super(0, 0, true, true,org.papervision3d.cameras.CameraType.TARGET);
			if(stage){
				this.initApp(null);
			}else{
				this.addEventListener(Event.ADDED_TO_STAGE,initApp);
			}
		}

		private function initApp(e:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE,initApp);
			this._planeArray = new Array();
			this._bitmapArray = new Array();
			loader=new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,itemLoaded);
			loader.load(new URLRequest("assets/"+idx+".jpg"));

			_offsetX=stage.stageWidth/_cols;
			_offsetY=stage.stageHeight/_rows;
			//_col = stage.stageWidth / _offsetX;
			//_row = stage.stageHeight / _offsetY;

		}
		private function itemLoaded(e:Event):void{
			this._sourceBmp = milkmidi.utils.BitmapUtil.getBitmapData(loader.content);
			this._bitmapArray.push(_sourceBmp);
			idx++;
			if(idx<=nuMs){
				loader.load(new URLRequest("assets/"+idx+".jpg"));
			}else{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,itemLoaded);
				loader.unloadAndStop(true);
				loader=null;
				this.total=this._bitmapArray.length;
				this.init3DObjects();
			}

		}
		internal function pv3dObjectTweenComplete(arg1:org.papervision3d.objects.DisplayObject3D):void{
			gs.TweenMax.to(arg1, 1.2, {"x":arg1.extra.x, "y":arg1.extra.y, "z":arg1.extra.z * -1, "rotationX":0, "rotationY":0, "rotationZ":0, "ease":gs.easing.Cubic.easeInOut});
			return;
		}
		protected override function extraRender3D():void{
			return;
		}
		private function init3DObjects() : void {

			var _frontMat:BitmapMaterial;
			var _backMat:BitmapMaterial;
			var i:int;
			var j:int;
			var _bmp1:BitmapData;
			var _matrix1:Matrix;
			var _bmp2:BitmapData;
			var _matrix2:Matrix;
			var _dMat:DoubleSidedCompositeMaterial;
			var _d3d:DisplayObject3D;
			for each (var _loc_4:Plane in this._planeArray){
				rootNode.removeChild(_loc_4);
			}
			this._planeArray = new Array();
			SystemUtil.clearMemory();
			this.camOrbitY=270;//还原视角
			camera.orbit(90, this.camOrbitY);
			//反转两面
			if(curidx==total)curidx=0;
			idx1=curidx;
			curidx+=1;
			if(curidx==total)curidx=0;
			idx2=curidx;
			i=0;
			while (i < _cols){                
				j=0;
				while (j < _rows){                    
					_bmp1 = new BitmapData(_offsetX, _offsetY, false, 0);
					_matrix1 = new Matrix();
					_matrix1.translate(i * (-_offsetX), (_rows - j - 1) * (-_offsetY));
					_bmp2 = new BitmapData(_offsetX, _offsetY, false, 0);
					_matrix2 = new Matrix();
					_matrix2.translate((_cols - i) * (-_offsetX), (_rows - j - 1) * (-_offsetY));
					_matrix2.scale(-1, 1);
					_bmp1.draw(this._bitmapArray[idx1], _matrix1);

					_bmp2.draw(this._bitmapArray[idx2], _matrix2);

					_frontMat = new BitmapMaterial(_bmp1);
					_backMat = new BitmapMaterial(_bmp2);

					_dMat = new DoubleSidedCompositeMaterial(_frontMat, _backMat);
					_d3d = rootNode.addChild(new Plane(_dMat, _offsetX, _offsetY));
					this._planeArray.push(_d3d);
					_d3d.x = i * _offsetX - _cols / 2 * _offsetX + _offsetX / 2;
					_d3d.y = j * _offsetY - _rows / 2 * _offsetY + _offsetY / 2;
					_d3d.z = getOnePercentPositionZ();
					_d3d.extra = {x:_d3d.x, y:_d3d.y, z:_d3d.z};
					TweenMax.to(_d3d, 1.6, {x:Math.floor(Math.random() * (stage.stageWidth * 5)) - stage.stageWidth * 3, y:Math.floor(Math.random() * (stage.stageHeight * 5)) - stage.stageHeight * 3, z:NumberUtil.random(-4000, 3000), rotationX:NumberUtil.random(-360, 360), rotationY:NumberUtil.random(-360, 360), rotationZ:NumberUtil.random(-360, 360), delay:0.06 * i + 1, ease:Cubic.easeInOut, onComplete:this.pv3dObjectTweenComplete, onCompleteParams:[_d3d]});
					j = (j + 1);
				}
				i = (i + 1);
			}

			TweenMax.to(this, 2.8, {camOrbitY:630 + 180 - 360, delay:1.8, ease:Quad.easeOut, onUpdate:function () : void {
				camera.orbit(90, camOrbitY);
				return;
			}
					, onComplete:function () : void
					{
						TweenMax.delayedCall(1, init3DObjects);
						return;
					}
				});
			return;
		}

	}
}

