package {
	import adobe.utils.*;

	import com.greensock.*;
	import com.greensock.easing.*;

	import fl.motion.*;

	import flash.display.*;
	import flash.events.*;
	import flash.geom.Matrix3D;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.utils.Timer;

	import zzl.image.imageArray;
	import zzl.image.imageParts;

	[SWF(width="1000", height="400")]
	public dynamic class imgParts extends MovieClip {

		private var parts:imageParts;
		private var alphaBMP:Bitmap;
		private var timer:Timer;
		private var counter:int;
		private var rowcount:int;
		private var currImage:int;
		private var images:Vector.<Bitmap>;
		private var totalImages:Number;
		private var frc:Rectangle;
		private var animFactory:AnimatorFactory3D;
		private var animArray:Array;
		private var martix3DVec:Vector.<Number>;
		private var matArray:Array;
		private var motion:MotionBase;
		private var imageW:Number   =360;
		private var imageH:Number   =260;
		private var gap:int         =2;
		private var appZ:int        =-50;
		private var appRotationY:int=25;
		private var containerSp:Sprite;
		private var content:Sprite;
		private var pics:imageArray;

		public function imgParts() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event=null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			animArray=new Array();
			motion=new MotionBase();
			motion.duration=1;
			motion.overrideTargetTransform();
			motion.addPropertyArray("visible", [true]);
			motion.addPropertyArray("cacheAsBitmap", [false]);
			motion.addPropertyArray("blendMode", ["normal"]);
			motion.addPropertyArray("opaqueBackground", [null]);
			motion.is3D=true;
			motion.motion_internal::spanStart=0;
			matArray=new Array();
			martix3DVec=new Vector.<Number>(16);
			martix3DVec[0]=1;
			martix3DVec[1]=0;
			martix3DVec[2]=0;
			martix3DVec[3]=0;
			martix3DVec[4]=0;
			martix3DVec[5]=1;
			martix3DVec[6]=0;
			martix3DVec[7]=0;
			martix3DVec[8]=0;
			martix3DVec[9]=0;
			martix3DVec[10]=1;
			martix3DVec[11]=0;
			martix3DVec[12]=840;
			martix3DVec[13]=100;
			martix3DVec[14]=0;
			martix3DVec[15]=1;
			matArray.push(new Matrix3D(martix3DVec));
			motion.addPropertyArray("matrix3D", matArray);
			animArray.push(motion);
			animFactory=new AnimatorFactory3D(null, animArray);
			animFactory.addTargetInfo(this, "containerSp", 0, true, 0, true, null, -1);

			stage.scaleMode=StageScaleMode.EXACT_FIT;
			containerSp=new Sprite();
			content=new Sprite();
			containerSp.addChild(content);
			containerSp.visible=false;
			addChild(containerSp);
			parts=new imageParts(10, 10);
			timer=new Timer(2000, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, nextImage);
			counter=0;
			rowcount=8;
			currImage=rowcount;

			containerSp.z=appZ;
			containerSp.rotationY=appRotationY;
			containerSp.x=stage.stageWidth*1;
			containerSp.y=stage.stageHeight;

			parts.init(imageW, imageH);
			parts.x=0;
			parts.y=-imageH;
			content.addChild(parts);
			transform.perspectiveProjection.fieldOfView=90;
			transform.perspectiveProjection.projectionCenter=new Point(500, 400);
			transform.perspectiveProjection.focalLength=400;
			var pictures:Array=[];
			for (var i:int=1; i < 11; i++) {
				pictures.push("image/image" + i + ".png");
			}
			pics=new imageArray(pictures);
			pics.addEventListener("imageLoaded", imagesLoaded);
		}

		private function imagesLoaded(e:Event):void {
			trace("loadOk");
			images=new Vector.<Bitmap>();
			for (var i:int=0; i < pics.images.length; i++) {
				images.push(pics.images[i]);
			}
			totalImages=images.length;
			i=0;
			var j:int=0;
			while (i < rowcount) {
				images[i].x=(i * imageW) - (rowcount * imageW);
				images[i].y=-imageH;
				images[i].smoothing=true;
				content.addChild(images[i]);
				i++;
			};
			frc=new Rectangle(imageW - gap, 0, gap, imageH);
			j=0;
			i=0;
			while (i < totalImages) {
				frc.x=imageW - gap;
				frc.y=0;
				frc.height=imageH;
				frc.width=gap;
				images[i].bitmapData.fillRect(frc, 0xFFFFFF);
				frc.width=1;
				j=0;
				while (j < gap) {
					frc.y=(frc.y + gap);
					frc.height=(frc.height - gap);
					images[i].bitmapData.fillRect(frc, 0x222222);
					frc.x++;
					j++;
				};
				i++;
			};
			containerSp.visible=true;
			parts.restart(images[currImage].bitmapData);
			TweenLite.to(content, 1, {x: -imageW, ease: Quad.easeOut, onComplete: onComp, overwrite: 0});

		}

		public function nextImage(_arg1:TimerEvent):void {
			currImage++;
			if (currImage >= totalImages) {
				currImage=0;
			};
			content.x=0;
			var i:int;
			while (i < totalImages) {
				images[i].x=images[i].x - imageW;
				i++;
			};
			content.setChildIndex(parts, (content.numChildren - 1));
			alphaBMP=content.getChildAt(0) as Bitmap;
			TweenLite.to(alphaBMP, 0.5, {alpha: 0, ease: Linear.easeNone, onComplete: onAlphaComp, overwrite: 0});
			parts.x=0;
			parts.restart(images[currImage].bitmapData);
			//parts.visible=true;
			TweenLite.to(content, 1, {x: -imageW, ease: Quad.easeOut, onComplete: onComp, overwrite: 0});
		}
		public function onComp():void {
			images[currImage].x=0;
			images[currImage].y=-imageH;
			images[currImage].alpha=0;
			content.addChild(images[currImage]);
			TweenLite.to(images[currImage], 0.6, {alpha: 1, ease: Cubic.easeOut, onComplete: onAlphaCompIn, overwrite: 0});
			timer.reset();
			timer.start();
		}
		public function onAlphaCompIn():void {
			//parts.visible=false;
		}
		public function onAlphaComp():void {
			content.removeChild(alphaBMP);
			alphaBMP.alpha=1;
		}
	}
}

