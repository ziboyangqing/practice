package com.madebyplay.CU3ER.controller.transitions 
{
    import com.greensock.*;
    import com.greensock.events.*;
    import com.madebyplay.CU3ER.controller.*;
    import com.madebyplay.CU3ER.events.*;
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.CU3ER.view.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.net.*;
    import org.flashsandy.display.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.materials.shadematerials.*;
    import org.papervision3d.materials.shaders.*;
    import org.papervision3d.materials.utils.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.objects.primitives.*;
    
    public class Transition3D extends com.madebyplay.CU3ER.controller.Transition
    {
        public function Transition3D(arg1:com.madebyplay.CU3ER.controller.Player, arg2:int, arg3:int, arg4:com.madebyplay.CU3ER.model.TransitionData, arg5:int)
        {
            super(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        internal function _createCubes():void
        {
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=0;
            var loc10:*=null;
            var loc11:*=null;
            var loc13:*=0;
            var loc18:*=undefined;
            var loc28:*=NaN;
            var loc29:*=0;
            var loc30:*=0;
            var loc31:*=0;
            var loc33:*=null;
            var loc34:*=NaN;
            var loc35:*=NaN;
            var loc36:*=null;
            var loc37:*=null;
            var loc38:*=0;
            var loc39:*=0;
            var loc40:*=NaN;
            var loc41:*=NaN;
            var loc42:*=NaN;
            var loc43:*=NaN;
            var loc44:*=NaN;
            var loc45:*=null;
            var loc46:*=null;
            var loc47:*=null;
            var loc48:*=null;
            var loc49:*=null;
            var loc50:*=null;
            var loc51:*=null;
            var loc52:*=null;
            var loc53:*=null;
            var loc54:*=NaN;
            var loc55:*=NaN;
            var loc56:*=0;
            var loc57:*=NaN;
            var loc58:*=0;
            var loc59:*=NaN;
            var loc60:*=NaN;
            var loc61:*=null;
            var loc1:*=1000000;
            var loc2:*=0;
            this._display3D = new org.papervision3d.objects.DisplayObject3D();
            this._scene.scene.addChild(this._display3D);
            this._tgCubes = new com.greensock.TimelineMax();
            this._mapFace = new Array();
            var loc3:*=new Array();
            var loc4:*=this._scene.light;
            this._boxes = new Array();
            this._rotations = new Array();
            this._shadows = new Array();
            var loc12:*=1;
            if (data.flipAngle != 90) 
            {
                loc13 = 1;
            }
            else 
            {
                loc13 = 1;
            }
            var loc14:*=1;
            var loc15:*=data.flipEasing;
            var loc16:*=data.flipDuration;
            var loc17:*=data.flipDepth;
            var loc19:*=data.flipColor;
            var loc20:*=1;
            if (com.madebyplay.CU3ER.model.SlideData(player.data.slides[_srcNo]).transparent || com.madebyplay.CU3ER.model.SlideData(player.data.slides[_destNo]).transparent) 
            {
                loc20 = 0;
            }
            if (data.flipShader == "none" || loc20 == 0) 
            {
                loc18 = new org.papervision3d.materials.ColorMaterial(loc19, loc20, false);
            }
            else 
            {
                loc18 = new org.papervision3d.materials.shadematerials.FlatShadeMaterial(loc4, loc19, data.flipShaderColor, 0);
            }
            var loc21:*=Math.cos(player.data.cameraAngleX * Math.PI / 180);
            var loc22:*=Math.cos((player.data.cameraAngleX - 90) * Math.PI / 180);
            var loc23:*=new Array(com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT, com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT, com.madebyplay.CU3ER.model.TransitionData.DIRECTION_UP, com.madebyplay.CU3ER.model.TransitionData.DIRECTION_DOWN);
            var loc24:*=new Array();
            var loc25:*=new Array();
            var loc26:*=0;
            var loc27:*=0;
            var loc32:*=data.flipOrder;
            if (_direction == -1) 
            {
                var loc62:*=loc32;
                switch (loc62) 
                {
                    case 0:
                    {
                        loc32 = 180;
                        break;
                    }
                    case 45:
                    {
                        loc32 = 225;
                        break;
                    }
                    case 90:
                    {
                        loc32 = 270;
                        break;
                    }
                    case 135:
                    {
                        loc32 = 315;
                        break;
                    }
                    case 180:
                    {
                        loc32 = 0;
                        break;
                    }
                    case 225:
                    {
                        loc32 = 45;
                        break;
                    }
                    case 270:
                    {
                        loc32 = 90;
                        break;
                    }
                    case 315:
                    {
                        loc32 = 135;
                        break;
                    }
                }
            }
            loc29 = 0;
            while (loc29 < data.rows) 
            {
                loc30 = 0;
                while (loc30 < data.columns) 
                {
                    loc27 = 0;
                    if (data.flipOrderFromCenter) 
                    {
                        loc62 = loc32;
                        switch (loc62) 
                        {
                            case 0:
                            case 180:
                            {
                                loc28 = loc27 + Math.abs(Math.floor((data.columns - 1) / 2 - loc30)) * data.flipDelay;
                                loc31 = Math.abs(Math.floor((data.columns - 1) / 2 - loc30));
                                break;
                            }
                            case 90:
                            case 270:
                            {
                                loc28 = loc27 + Math.abs(Math.floor((data.rows - 1) / 2 - loc29)) * data.flipDelay;
                                loc31 = Math.abs(Math.floor((data.rows - 1) / 2 - loc29));
                                break;
                            }
                            case 135:
                            case 315:
                            {
                                loc28 = loc27 + Math.abs(loc29 + loc30 - Math.floor((data.rows + data.columns - 2) / 2)) * data.flipDelay;
                                loc31 = Math.abs(loc29 + loc30 - Math.floor((data.rows + data.columns - 2) / 2));
                                break;
                            }
                            case 45:
                            case 225:
                            {
                                loc28 = loc27 + Math.abs(loc29 + (data.columns - loc30) - Math.floor((data.rows + data.columns - 2) / 2)) * data.flipDelay;
                                loc31 = Math.abs(loc29 + (data.columns - loc30) - Math.floor((data.rows + data.columns - 2) / 2));
                                break;
                            }
                        }
                    }
                    else 
                    {
                        loc62 = loc32;
                        switch (loc62) 
                        {
                            case 0:
                            {
                                loc28 = loc27 + loc30 * data.flipDelay;
                                loc31 = loc30;
                                break;
                            }
                            case 45:
                            {
                                loc28 = loc27 + ((data.rows - 1) - loc29 + loc30) * data.flipDelay;
                                loc31 = (data.rows - 1) - loc29 + loc30;
                                break;
                            }
                            case 90:
                            {
                                loc28 = loc27 + ((data.rows - 1) - loc29) * data.flipDelay;
                                loc31 = (data.rows - 1) - loc29;
                                break;
                            }
                            case 135:
                            {
                                loc28 = loc27 + (((data.rows - 1) - loc29 + data.columns - 1) - loc30) * data.flipDelay;
                                loc31 = ((data.rows - 1) - loc29 + data.columns - 1) - loc30;
                                break;
                            }
                            case 180:
                            {
                                loc28 = loc27 + ((data.columns - 1) - loc30) * data.flipDelay;
                                loc31 = (data.columns - 1) - loc30;
                                break;
                            }
                            case 225:
                            {
                                loc28 = loc27 + ((data.columns - 1) - loc30 + loc29) * data.flipDelay;
                                loc31 = (data.columns - 1) - loc30 + loc29;
                                break;
                            }
                            case 270:
                            {
                                loc28 = loc27 + loc29 * data.flipDelay;
                                loc31 = loc29;
                                break;
                            }
                            case 315:
                            {
                                loc28 = loc27 + (loc29 + loc30) * data.flipDelay;
                                loc31 = loc29 + loc30;
                                break;
                            }
                        }
                    }
                    loc24[loc30 + loc29 * data.columns] = loc31;
                    loc25[loc30 + loc29 * data.columns] = -1;
                    loc26 = Math.max(Math.round(loc24[loc30 + loc29 * data.columns]));
                    loc30 = loc30 + 1;
                }
                loc29 = loc29 + 1;
            }
            loc29 = 0;
            while (loc29 < data.rows) 
            {
                loc30 = 0;
                while (loc30 < data.columns) 
                {
                    loc9 = loc30 + loc29 * data.columns;
                    loc8 = rectangles[loc9];
                    loc6 = arrBmpSrc[loc9];
                    loc7 = arrBmpDest[loc9];
                    (loc5 = new org.papervision3d.materials.utils.MaterialsList()).addMaterial(loc18, "left");
                    loc5.addMaterial(loc18, "right");
                    loc5.addMaterial(loc18, "bottom");
                    loc5.addMaterial(loc18, "top");
                    loc5.addMaterial(loc18, "front");
                    loc5.addMaterial(loc18, "back");
                    loc5.removeMaterial(loc5.getMaterialByName("back"));
                    if (data.flipShader != com.madebyplay.CU3ER.model.TransitionData.SHADER_NONE) 
                    {
                        (loc47 = new org.papervision3d.materials.BitmapMaterial(loc6, true)).smooth = true;
                        loc48 = new org.papervision3d.materials.shaders.FlatShader(loc4, 16777215, _data.flipShaderColor, 10);
                        (loc49 = new org.papervision3d.materials.shaders.ShadedMaterial(loc47, loc48, 0)).smooth = true;
                        loc5.addMaterial(loc49, "back");
                    }
                    else 
                    {
                        (loc46 = new org.papervision3d.materials.BitmapMaterial(loc6, true)).smooth = true;
                        loc5.addMaterial(loc46, "back");
                    }
                    if ((loc23 = data.flipDirection.split(",")).length > 1) 
                    {
                        loc36 = loc23[Math.floor(Math.random() * loc23.length)];
                    }
                    else 
                    {
                        loc36 = data.flipDirection;
                    }
                    if (_direction == -1) 
                    {
                        loc62 = loc36;
                        switch (loc62) 
                        {
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT:
                            {
                                loc36 = com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT;
                                break;
                            }
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT:
                            {
                                loc36 = com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT;
                                break;
                            }
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_UP:
                            {
                                loc36 = com.madebyplay.CU3ER.model.TransitionData.DIRECTION_DOWN;
                                break;
                            }
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_DOWN:
                            {
                                loc36 = com.madebyplay.CU3ER.model.TransitionData.DIRECTION_UP;
                                break;
                            }
                        }
                    }
                    if (data.flipAngle != 180) 
                    {
                        if (data.flipAngle == 90) 
                        {
                            loc62 = loc36;
                            switch (loc62) 
                            {
                                case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT:
                                {
                                    loc35 = -90;
                                    loc34 = 0;
                                    loc37 = "left";
                                    break;
                                }
                                case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT:
                                {
                                    loc35 = 90;
                                    loc34 = 0;
                                    loc37 = "right";
                                    break;
                                }
                                case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_UP:
                                {
                                    loc34 = 90;
                                    loc35 = 0;
                                    loc37 = "bottom";
                                    mirrorBitmapY(loc7);
                                    mirrorBitmapX(loc7);
                                    break;
                                }
                                case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_DOWN:
                                {
                                    loc34 = -90;
                                    loc35 = 0;
                                    loc37 = "top";
                                    break;
                                }
                            }
                        }
                    }
                    else 
                    {
                        loc37 = "front";
                        loc62 = loc36;
                        switch (loc62) 
                        {
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT:
                            {
                                loc35 = 180;
                                loc34 = 0;
                                break;
                            }
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT:
                            {
                                loc35 = -180;
                                loc34 = 0;
                                break;
                            }
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_DOWN:
                            {
                                loc34 = -180;
                                loc35 = 0;
                                mirrorBitmapY(loc7);
                                mirrorBitmapX(loc7);
                                break;
                            }
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_UP:
                            {
                                loc34 = 180;
                                loc35 = 0;
                                mirrorBitmapY(loc7);
                                mirrorBitmapX(loc7);
                                break;
                            }
                        }
                    }
                    this._mapFace[loc9] = loc37;
                    loc5.removeMaterial(loc5.getMaterialByName(loc37));
                    if (data.flipShader != com.madebyplay.CU3ER.model.TransitionData.SHADER_NONE) 
                    {
                        (loc51 = new org.papervision3d.materials.BitmapMaterial(loc7, true)).smooth = true;
                        loc52 = new org.papervision3d.materials.shaders.FlatShader(loc4, 16777215, _data.flipShaderColor, 10);
                        (loc53 = new org.papervision3d.materials.shaders.ShadedMaterial(loc51, loc52, 0)).smooth = true;
                        loc5.addMaterial(loc53, loc37);
                    }
                    else 
                    {
                        (loc50 = new org.papervision3d.materials.BitmapMaterial(loc7, true)).smooth = true;
                        loc5.addMaterial(loc50, loc37);
                    }
                    loc38 = 0;
                    loc39 = 0;
                    if (data.columns > data.rows) 
                    {
                        loc39 = Math.round((data.columns - data.rows) / 2);
                    }
                    else if (data.rows > data.columns) 
                    {
                        loc38 = Math.round((data.rows - data.columns) / 2);
                    }
                    if (data.hasFlipRandomizeNew) 
                    {
                        if (loc25[loc30 + loc29 * data.columns] != -1) 
                        {
                            loc40 = loc24[loc25[loc30 + loc29 * data.columns]];
                        }
                        else 
                        {
                            loc55 = Math.max(data.columns - loc30, loc30);
                            loc56 = Math.round(loc30 + loc55 * (Math.random() * 2 * data.flipRandomize - data.flipRandomize));
                            loc56 = Math.max(0, Math.min((data.columns - 1), loc56));
                            loc57 = Math.max(data.rows - loc29, loc29);
                            loc58 = Math.round(loc29 + loc57 * (Math.random() * 2 * data.flipRandomize - data.flipRandomize));
                            loc58 = Math.max(0, Math.min((data.rows - 1), loc58));
                            loc40 = loc24[loc56 + loc58 * data.columns];
                            loc25[loc56 + loc58 * data.columns] = loc30 + loc29 * data.columns;
                        }
                        loc54 = Math.min(1, 2 * data.flipRandomize) * Math.max(0, 2 * data.flipDelay * Math.random() - data.flipDelay);
                        loc28 = loc27 + loc40 * data.flipDelay + loc54;
                    }
                    else 
                    {
                        loc40 = loc24[loc30 + loc29 * data.columns];
                        loc28 = loc27 + loc40 * data.flipDelay * (1 - data.flipDelayRandomize);
                    }
                    loc2 = Math.max(loc28 + data.flipDuration, loc2);
                    loc1 = Math.min(loc28, loc1);
                    if (data.flipAngle != 180) 
                    {
                        if (loc36 == com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT || loc36 == com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT) 
                        {
                            loc10 = new org.papervision3d.objects.primitives.Cube(loc5, loc8.width, loc8.width, loc8.height, loc12, loc12, loc14);
                            loc41 = loc8.width;
                        }
                        else 
                        {
                            loc10 = new org.papervision3d.objects.primitives.Cube(loc5, loc8.width, loc8.height, loc8.height, loc12, loc12, loc14);
                            loc41 = loc8.height;
                        }
                    }
                    else 
                    {
                        loc10 = new org.papervision3d.objects.primitives.Cube(loc5, loc8.width, data.flipBoxDepth, loc8.height, loc12, loc13, loc14);
                        loc41 = data.flipBoxDepth;
                    }
                    this._boxes.push(loc10);
                    this._rotations.push({"x":loc34, "y":loc35});
                    loc10.x = loc8.x - player.data.width / 2 + loc8.width / 2;
                    loc10.y = -loc8.y + player.data.height / 2 - loc8.height / 2;
                    loc10.z = loc41 / 2;
                    this._display3D.addChild(loc10);
                    loc43 = loc10.x;
                    loc44 = loc10.x;
                    loc45 = new Array();
                    com.greensock.TweenMax.to(loc10, loc16, {"delay":loc28, "rotationX":loc34, "rotationY":loc35, "x":loc44, "z":loc41 / 2, "bezierThrough":[{"z":loc17, "x":loc43}], "ease":loc15});
                    if (player.data.shadowShow && !player.data.shadowUseImage) 
                    {
                        loc59 = loc8.y * loc22;
                        loc60 = player.data.shadowScale;
                        (loc61 = new com.madebyplay.CU3ER.view.Shadow(loc10, new flash.geom.Rectangle(0, 0, loc8.width, loc41 * loc21 + loc8.height * loc22), player.data.shadowColor, player.data.shadowStrength, loc60)).y = loc59;
                        com.greensock.TweenMax.to(loc61, loc16, {"delay":loc28, "rotation":loc35, "y":loc59, "bezierThrough":[{"y":loc59 - data.flipDepth * loc60}], "ease":loc15});
                        this._shadows.push(loc61);
                    }
                    loc30 = loc30 + 1;
                }
                loc29 = loc29 + 1;
            }
            if (data.flipShader == com.madebyplay.CU3ER.model.TransitionData.SHADER_FLAT) 
            {
                this._scene.scene.addChild(loc4);
            }
            com.greensock.TweenLite.delayedCall(loc2 + 5 / player.holder.stage.frameRate, this._onCubeAnimComplete);
            if (player.data.shadowShow) 
            {
                this._createShadows();
            }
            this._display3D.rotationX = player.data.cameraAngleX;
            this._display3D.rotationY = player.data.cameraAngleY;
            this._display3D.rotationZ = player.data.cameraAngleZ;
            this._display3D.x = player.data.cameraX;
            this._display3D.y = player.data.cameraY;
            this._scene.light.x = 0;
            this._scene.light.y = 0;
            this._scene.light.z = 0;
            this._scene.light.rotationX = player.data.cameraAngleX;
            this._scene.light.rotationY = player.data.cameraAngleY;
            this._scene.light.rotationZ = player.data.cameraAngleZ;
            this._scene.light.moveBackward(10000);
            this._scene.light.showLight = true;
            this._scene.addEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_START, this._dispatchStart);
            this._scene.render();
            return;
        }

        internal function _dispatchStart(arg1:flash.events.Event):void
        {
            if (!(this._scene == null) && this._scene.hasEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_START)) 
            {
                this._scene.removeEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_START, this._dispatchStart);
            }
            dispatchStart();
            return;
        }

        internal function _stopQuad(arg1:org.papervision3d.objects.primitives.Cube):void
        {
            return;
        }

        internal function _createShadows():void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            this._shadow = new flash.display.Sprite();
            this._shadow.name = "shadow";
            var loc1:*=new flash.geom.Rectangle();
            if (player.data.shadowUseImage) 
            {
                if (com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().loader.get("shadow") == null) 
                {
                    this._shadow.addChild(new flash.display.Bitmap(new flash.display.BitmapData(100, 100, true, 4294967295)));
                }
                else 
                {
                    this._shadow.addChild(new flash.display.Bitmap(com.madebyplay.CU3ER.controller.PreloadControllerPlayer.getInstance().loader.getBitmapData("shadow").clone()));
                }
                this._shadowRect = new flash.geom.Rectangle(0, 0, this._shadow.width, this._shadow.height);
            }
            else 
            {
                loc3 = 0;
                while (loc3 < this._shadows.length) 
                {
                    this._shadow.addChild(this._shadows[loc3]);
                    ++loc3;
                }
                loc4 = new flash.filters.BlurFilter(player.data.shadowBlur, player.data.shadowBlur, 2);
                (loc5 = new Array()).push(loc4);
                this._shadow.filters = loc5;
                loc1 = this._shadow.getBounds(this._shadow);
                loc6 = 450;
                loc7 = 100;
                this._shadowRect = new flash.geom.Rectangle(loc1.x - loc7, loc1.y - loc6 - loc7, loc1.width + loc7 * 2, loc6 + loc7 * 2);
            }
            this._shadow.x = this._shadow.width / 2;
            this._shadow.y = this._shadow.height / 2;
            this._distortion = new org.flashsandy.display.DistortImage(this._shadowRect.width, this._shadowRect.height, Math.round(this._shadowRect.width / 100), Math.round(this._shadowRect.width / 100));
            this._shadowTL = player.data.shadowCornerTL;
            this._shadowTR = player.data.shadowCornerTR;
            this._shadowBL = player.data.shadowCornerBL;
            this._shadowBR = player.data.shadowCornerBR;
            this._shadowRender = new flash.display.Shape();
            this._shadowRender.visible = false;
            player.holder.addChildAt(this._shadowRender, 0);
            this._shadowMatrix = new flash.geom.Matrix();
            if (player.data.shadowUseImage) 
            {
                this._shadowMatrix.translate(-this._shadowRect.x, -this._shadowRect.y);
            }
            else 
            {
                this._shadowMatrix.translate(-this._shadowRect.x, loc1.y + 450);
            }
            if (this._shadow.hasEventListener(flash.events.Event.ENTER_FRAME)) 
            {
                this._shadow.removeEventListener(flash.events.Event.ENTER_FRAME, this._updateShadow);
            }
            this._shadow.addEventListener(flash.events.Event.ENTER_FRAME, this._updateShadow, false, 0, true);
            this._shadowRender.graphics.clear();
            var loc2:*=new flash.display.BitmapData(this._shadowRect.width, this._shadowRect.height, true, 0);
            loc2.draw(this._shadow, this._shadowMatrix);
            this._distortion.setTransform(this._shadowRender.graphics, loc2, this._shadowTL, this._shadowTR, this._shadowBR, this._shadowBL);
            return;
        }

        internal function _getSceneBounds2D():flash.geom.Rectangle
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc9:*=0;
            var loc3:*=new org.papervision3d.objects.primitives.Plane();
            var loc4:*=new org.papervision3d.objects.primitives.Plane();
            var loc5:*=new flash.geom.Point(10000, 10000);
            var loc6:*=new flash.geom.Point(-10000, -10000);
            var loc7:*=new flash.display.Sprite();
            player.holder.addChild(loc7);
            var loc8:*=0;
            while (loc8 < this._boxes.length) 
            {
                loc1 = this._boxes[loc8];
                loc9 = 0;
                while (loc9 < loc1.faces.length) 
                {
                    loc9 = loc9 + 1;
                }
                loc2 = loc1.boundingBox();
                loc3 = new org.papervision3d.objects.primitives.Plane(null, 1, 1);
                loc4 = new org.papervision3d.objects.primitives.Plane(null, 1, 1);
                loc1.calculateScreenCoords(this._scene.camera);
                this._scene.scene.addChild(loc3);
                this._scene.scene.addChild(loc4);
                loc3.x = loc2.min.x + loc1.x;
                loc3.y = loc2.min.y + loc1.y;
                loc3.z = loc2.min.z + loc1.z;
                loc4.x = loc2.max.x + loc1.x;
                loc4.y = loc2.max.y + loc1.y;
                loc4.z = loc2.max.z + loc1.z;
                loc3.calculateScreenCoords(this._scene.camera);
                loc4.calculateScreenCoords(this._scene.camera);
                loc7.graphics.beginFill(16711680);
                loc7.graphics.drawCircle(loc3.screen.x + player.data.width / 2 + player.holder.x, loc3.screen.y + player.data.height / 2 + player.holder.y, 3);
                loc7.graphics.drawCircle(loc4.screen.x + player.data.width / 2 + player.holder.x, loc4.screen.y + player.data.height / 2 + player.holder.y, 3);
                loc5.x = Math.min(loc3.screen.x, loc5.x);
                loc5.y = Math.min(loc3.screen.y, loc5.y);
                loc6.x = Math.max(loc4.screen.x, loc6.x);
                loc6.y = Math.max(loc4.screen.y, loc6.y);
                loc8 = loc8 + 1;
            }
            return new flash.geom.Rectangle(loc5.x, loc5.y, loc6.x - loc5.x, loc6.y - loc5.y);
        }

        protected override function onTransitionStart():void
        {
            super.onTransitionStart();
            if (this._shadowRender != null) 
            {
                this._shadowRender.visible = true;
            }
            return;
        }

        internal function _updateShadow(arg1:flash.events.Event):void
        {
            this._shadowRender.graphics.clear();
            var loc1:*=new flash.display.BitmapData(this._shadowRect.width, this._shadowRect.height, true, 0);
            loc1.draw(this._shadow, this._shadowMatrix);
            this._distortion.update(this._shadowRender.graphics, loc1);
            return;
        }

        internal function _onCubeAnimUpdate(arg1:com.greensock.events.TweenEvent):void
        {
            return;
        }

        internal function _onCubeAnimComplete(arg1:flash.events.Event=null):void
        {
            if (srcBmp != null) 
            {
                this._destroyCubes();
                this._createFirstSlide(true);
            }
            var loc1:*=0;
            while (loc1 < this._shadows.length) 
            {
                this._shadows[loc1].rotation = 0;
                ++loc1;
            }
            this._scene.addEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_STOP, this._dipatchComplete);
            this._scene.renderOnce();
            return;
        }

        internal function _dipatchComplete(arg1:flash.events.Event=null):void
        {
            this._scene.removeEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_STOP, this._dipatchComplete);
            if (!(this._shadow == null) && this._shadow.hasEventListener(flash.events.Event.ENTER_FRAME)) 
            {
                this._shadow.removeEventListener(flash.events.Event.ENTER_FRAME, this._updateShadow);
            }
            this._scene.stopRender();
            com.madebyplay.CU3ER.model.GlobalVars.SCENE_WIDTH = com.madebyplay.CU3ER.model.GlobalVars.STAGE_WIDTH;
            com.madebyplay.CU3ER.model.GlobalVars.SCENE_HEIGHT = com.madebyplay.CU3ER.model.GlobalVars.STAGE_HEIGHT;
            var loc1:*=com.madebyplay.CU3ER.model.GlobalVars.SCENE_WIDTH;
            var loc2:*=com.madebyplay.CU3ER.model.GlobalVars.SCENE_HEIGHT;
            if (loc1 == 0 || loc2 == 0) 
            {
                loc1 = _player.CU3ER.stage.width;
                loc2 = _player.CU3ER.stage.height;
            }
            finalBmp = new flash.display.BitmapData(loc1, loc2, true, 0);
            var loc3:*=new flash.geom.Matrix();
            var loc4:*=new flash.geom.Rectangle(0, 0, this._scene.stage.stageWidth, this._scene.stage.stageHeight);
            var loc5:*=new flash.geom.ColorTransform();
            loc3.translate(player.holder.x, player.holder.y);
            if (player.data.shadowShow) 
            {
                finalBmp.draw(this._shadowRender, loc3, null, null, loc4, true);
            }
            (loc3 = new flash.geom.Matrix()).translate(player.holder.x, player.holder.y);
            finalBmp.draw(this._scene, loc3);
            dispatchEvent(new com.madebyplay.CU3ER.events.TransitionEvent(com.madebyplay.CU3ER.events.TransitionEvent.COMPLETE));
            this.destroy();
            return;
        }

        internal function _removeSideFaces():void
        {
            var loc1:*=null;
            var loc3:*=0;
            var loc4:*=0;
            var loc2:*=new org.papervision3d.materials.ColorMaterial(16777215, 0);
            var loc5:*=["top", "bottom", "front", "back", "left", "right"];
            loc3 = 0;
            while (loc3 < this._boxes.length) 
            {
                loc1 = this._boxes[loc3] as org.papervision3d.objects.primitives.Cube;
                loc4 = 0;
                while (loc4 < loc5.length) 
                {
                    if (loc5[loc4] != this._mapFace[loc3]) 
                    {
                        loc1.replaceMaterialByName(loc2, loc5[loc4]);
                    }
                    ++loc4;
                }
                loc3 = loc3 + 1;
            }
            return;
        }

        internal function _restart():void
        {
            this._scene.render();
            if (!(this._shadow == null) && this._shadow.hasEventListener(flash.events.Event.ENTER_FRAME)) 
            {
                this._shadow.removeEventListener(flash.events.Event.ENTER_FRAME, this._updateShadow);
            }
            this._shadow.addEventListener(flash.events.Event.ENTER_FRAME, this._updateShadow, false, 0, true);
            com.greensock.TweenLite.delayedCall(2, this._tgCubes.restart);
            return;
        }

        internal function _stopRender():void
        {
            this._scene.stopRender();
            return;
        }

        public function get shadowRender():flash.display.Shape
        {
            return this._shadowRender;
        }

        internal function _destroyCubes(arg1:Boolean=false):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            if (player.data.shadowShow && arg1) 
            {
                loc2 = 0;
                while (loc2 < this._shadows.length) 
                {
                    if (this._shadows[loc2] != null) 
                    {
                        if (this._shadows[loc2].parent != null) 
                        {
                            this._shadows[loc2].parent.removeChild(this._shadows[loc2]);
                        }
                        this._shadows[loc2].destroy();
                        this._shadows[loc2] = null;
                        com.greensock.TweenMax.killTweensOf(this._shadows[loc2]);
                    }
                    ++loc2;
                }
                if (this._shadow.hasEventListener(flash.events.Event.ENTER_FRAME)) 
                {
                    this._shadow.removeEventListener(flash.events.Event.ENTER_FRAME, this._updateShadow);
                }
                if (!(this._shadowRender == null) && !(this._shadowRender.parent == null)) 
                {
                    player.holder.removeChild(this._shadowRender);
                }
            }
            loc2 = 0;
            while (loc2 < this._boxes.length) 
            {
                com.greensock.TweenMax.killTweensOf(loc1);
                loc1 = this._boxes[loc2] as org.papervision3d.objects.primitives.Cube;
                loc1.materials.getMaterialByName("top").destroy();
                loc1.materials.getMaterialByName("bottom").destroy();
                loc1.materials.getMaterialByName("front").destroy();
                loc1.materials.getMaterialByName("back").destroy();
                loc1.materials.getMaterialByName("left").destroy();
                loc1.materials.getMaterialByName("right").destroy();
                loc1.material.destroy();
                loc1.destroy();
                this._display3D.removeChild(loc1);
                this._boxes[loc2] = null;
                loc1 = null;
                loc2 = loc2 + 1;
            }
            this._boxes = new Array();
            this._rotations = new Array();
            if (arg1) 
            {
                if (srcBmp != null) 
                {
                    loc2 = 0;
                    while (loc2 < arrBmpSrc.length) 
                    {
                        (arrBmpSrc[loc2] as flash.display.BitmapData).dispose();
                        arrBmpSrc[loc2] = null;
                        (arrBmpDest[loc2] as flash.display.BitmapData).dispose();
                        arrBmpDest[loc2] = null;
                        loc2 = loc2 + 1;
                    }
                }
                arrBmpSrc = new Array();
                arrBmpDest = new Array();
            }
            return;
        }

        internal function _create3D():void
        {
            this._scene = new com.madebyplay.CU3ER.view.Scene(this.player);
            player.holder.addChildAt(this._scene, 0);
            if (srcBmp == null) 
            {
                this._scene.visible = false;
                this._createFirstSlide();
            }
            else 
            {
                createRectangles();
                createBitmaps();
                this._createCubes();
            }
            return;
        }

        public override function destroy():void
        {
            super.destroy();
            if (this._tgCubes != null) 
            {
                this._tgCubes.kill();
                this._tgCubes.clear();
            }
            this._destroyCubes(true);
            this._scene.scene.removeChild(this._display3D);
            this._display3D = null;
            if (this._scene.hasEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_START)) 
            {
                this._scene.removeEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_START, this._dispatchStart);
            }
            this._scene.destroy();
            this._scene = null;
            try 
            {
                new flash.net.LocalConnection().connect("foo");
                new flash.net.LocalConnection().connect("foo");
            }
            catch (e:*)
            {
            };
            return;
        }

        public static function mirrorBitmapX(arg1:flash.display.BitmapData):void
        {
            var loc1:*=new flash.display.Bitmap(arg1.clone());
            loc1.scaleX = -1;
            loc1.x = arg1.width;
            arg1.fillRect(arg1.rect, 0);
            arg1.draw(loc1, loc1.transform.matrix, null, null, null, true);
            loc1.bitmapData.dispose();
            return;
        }

        public static function mirrorBitmapY(arg1:flash.display.BitmapData):void
        {
            var loc1:*=new flash.display.Bitmap(arg1.clone());
            loc1.scaleY = -1;
            loc1.y = arg1.height;
            arg1.fillRect(arg1.rect, 0);
            arg1.draw(loc1, loc1.transform.matrix, null, null, null, true);
            loc1.bitmapData.dispose();
            return;
        }

        public override function start():void
        {
            super.start();
            this._create3D();
            return;
        }

        internal function _createRectangles():void
        {
            var loc6:*=0;
            rectangles = new Array();
            var loc1:*=player.data.width / data.columns;
            var loc2:*=player.data.height / data.rows;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            while (loc5 < data.rows) 
            {
                loc6 = 0;
                while (loc6 < data.columns) 
                {
                    rectangles.push(new flash.geom.Rectangle(loc3, loc4, Math.round(loc3 + loc1) - loc3, Math.round(loc4 + loc2) - loc4));
                    loc3 = Math.round(loc3 + loc1);
                    loc6 = loc6 + 1;
                }
                loc3 = 0;
                loc4 = Math.round(loc4 + loc2);
                loc5 = loc5 + 1;
            }
            return;
        }

        internal function _createFirstSlide(arg1:Boolean=false):void
        {
            var loc2:*=undefined;
            var loc8:*=null;
            var loc9:*=null;
            var loc14:*=null;
            var loc15:*=NaN;
            var loc16:*=null;
            var loc22:*=null;
            var loc23:*=null;
            var loc24:*=null;
            var loc25:*=NaN;
            var loc26:*=NaN;
            var loc27:*=NaN;
            var loc28:*=NaN;
            var loc29:*=null;
            this._mapFace = new Array();
            this._boxes = new Array();
            this._rotations = new Array();
            this._shadows = new Array();
            var loc1:*=this._scene.light;
            if (!arg1) 
            {
                this._display3D = new org.papervision3d.objects.DisplayObject3D();
                this._scene.scene.addChild(this._display3D);
            }
            if (data.flipShader != "none") 
            {
                loc2 = new org.papervision3d.materials.shadematerials.FlatShadeMaterial(loc1, data.flipColor, _data.flipShaderColor, 0);
            }
            else 
            {
                loc2 = new org.papervision3d.materials.ColorMaterial(data.flipColor, 1, false);
            }
            var loc3:*=data.flipEasing;
            var loc4:*=data.flipDuration;
            var loc5:*=data.flipDepth;
            var loc6:*=player.data.width / data.columns;
            var loc7:*=player.data.height / data.rows;
            if ((loc8 = data.flipDirection.split(",")).length > 1) 
            {
                loc9 = loc8[Math.floor(Math.random() * loc8.length)];
            }
            else 
            {
                loc9 = data.flipDirection;
            }
            var loc10:*=1;
            var loc11:*=1;
            var loc12:*=1;
            var loc13:*;
            (loc13 = new org.papervision3d.materials.utils.MaterialsList()).addMaterial(loc2, "left");
            loc13.addMaterial(loc2, "right");
            loc13.addMaterial(loc2, "bottom");
            loc13.addMaterial(loc2, "top");
            loc13.addMaterial(loc2, "front");
            loc13.addMaterial(loc2, "back");
            if (arg1) 
            {
                if ((player.slides[_destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc == null) 
                {
                    destBmp = (player.slides[_destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData.clone();
                }
                else 
                {
                    destBmp = (player.slides[_destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc.clone();
                }
            }
			//trace("Transition3D_destBmp",destBmp.width,destBmp.height);
            loc13.removeMaterial(loc13.getMaterialByName("back"));
            if (data.flipShader != com.madebyplay.CU3ER.model.TransitionData.SHADER_NONE) 
            {
                (loc22 = new org.papervision3d.materials.BitmapMaterial(destBmp, true)).smooth = true;
                if (arg1) 
                {
                    loc22.precise = true;
                    loc22.precision = 1;
                    loc22.precisionMode = org.papervision3d.materials.utils.PrecisionMode.STABLE;
                }
                loc23 = new org.papervision3d.materials.shaders.FlatShader(loc1, 16777215, _data.flipShaderColor, 10);
                (loc24 = new org.papervision3d.materials.shaders.ShadedMaterial(loc22, loc23, 0)).smooth = true;
                loc13.addMaterial(loc24, "back");
            }
            else 
            {
                (loc14 = new org.papervision3d.materials.BitmapMaterial(destBmp, true)).smooth = true;
                if (arg1) 
                {
                    loc14.precise = true;
                    loc14.precision = 1;
                    loc14.precisionMode = org.papervision3d.materials.utils.PrecisionMode.STABLE;
                }
                loc13.addMaterial(loc14, "back");
            }
            if (data.flipAngle != 180) 
            {
                if (loc9 == com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT || loc9 == com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT) 
                {
                    loc16 = new org.papervision3d.objects.primitives.Cube(loc13, player.data.width, loc6, player.data.height, loc10, loc10, loc12);
                    loc15 = loc6;
                }
                else 
                {
                    loc16 = new org.papervision3d.objects.primitives.Cube(loc13, player.data.width, loc7, player.data.height, loc10, loc10, loc12);
                    loc15 = loc7;
                }
            }
            else 
            {
                loc16 = new org.papervision3d.objects.primitives.Cube(loc13, player.data.width, data.flipBoxDepth, player.data.height, loc10, loc11, loc12);
                loc15 = data.flipBoxDepth;
            }
            this._boxes.push(loc16);
            this._rotations.push({"x":0, "y":0});
            this._mapFace[0] = "back";
            loc16.x = 0;
            loc16.y = 0;
            loc16.z = loc15 / 2;
            this._display3D.addChild(loc16);
            var loc17:*=new flash.display.MovieClip();
            var loc18:*=loc16.x * 1.15;
            var loc19:*=loc16.x;
            if (player.data.shadowShow && !player.data.shadowUseImage) 
            {
                loc25 = Math.cos(player.data.cameraAngleX * Math.PI / 180);
                loc26 = Math.cos((player.data.cameraAngleX - 90) * Math.PI / 180);
                loc27 = 0 * loc26;
                loc28 = player.data.shadowScale;
                (loc29 = new com.madebyplay.CU3ER.view.Shadow(loc16, new flash.geom.Rectangle(0, 0, player.data.width, loc15 * loc25 + player.data.height * loc26), player.data.shadowColor, player.data.shadowStrength, loc28)).y = loc27;
                this._shadows.push(loc29);
            }
            if (player.data.shadowShow && !arg1) 
            {
                this._createShadows();
            }
            var loc20:*=0;
            var loc21:*=0;
            this._display3D.rotationX = player.data.cameraAngleX;
            this._display3D.rotationY = player.data.cameraAngleY;
            this._display3D.rotationZ = player.data.cameraAngleZ;
            this._display3D.x = player.data.cameraX;
            this._display3D.y = player.data.cameraY;
            this._scene.light.x = 0;
            this._scene.light.y = 0;
            this._scene.light.z = 0;
            this._scene.light.rotationX = player.data.cameraAngleX;
            this._scene.light.rotationY = player.data.cameraAngleY;
            this._scene.light.rotationZ = player.data.cameraAngleZ;
            this._scene.light.moveBackward(10000);
            this._scene.light.showLight = true;
            if (!arg1) 
            {
                com.greensock.TweenLite.delayedCall(loc21 + 2 / player.holder.stage.frameRate, this._onCubeAnimComplete);
                this._scene.addEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_START, this._dispatchStart);
                this._scene.render();
                this._scene.visible = false;
            }
            return;
        }

        internal var _scene:com.madebyplay.CU3ER.view.Scene;

        internal var _display3D:org.papervision3d.objects.DisplayObject3D;

        internal var _tgCubes:com.greensock.TimelineMax;

        internal var _shadows:Array;

        internal var _rotations:Array;

        internal var _distortion:org.flashsandy.display.DistortImage;

        internal var _shadowTL:flash.geom.Point;

        internal var _shadowTR:flash.geom.Point;

        internal var _shadowBL:flash.geom.Point;

        internal var _shadowBR:flash.geom.Point;

        internal var _shadow:flash.display.Sprite;

        internal var _shadowRender:flash.display.Shape;

        internal var _shadowRect:flash.geom.Rectangle;

        internal var _shadowMatrix:flash.geom.Matrix;

        internal var _tweenCubes:Array;

        internal var _smoothedMaterials:Array;

        internal var _mapFace:Array;

        internal var _boxes:Array;

        internal var _shadowTestBitmap:flash.display.Bitmap;
    }
}
