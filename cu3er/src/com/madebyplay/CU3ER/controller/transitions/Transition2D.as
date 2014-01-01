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
    import org.flashsandy.display.*;
    import org.papervision3d.core.proto.*;
    import org.papervision3d.materials.*;
    import org.papervision3d.materials.shadematerials.*;
    import org.papervision3d.materials.shaders.*;
    import org.papervision3d.materials.utils.*;
    import org.papervision3d.objects.*;
    import org.papervision3d.objects.primitives.*;
    
    public class Transition2D extends com.madebyplay.CU3ER.controller.Transition
    {
        public function Transition2D(arg1:com.madebyplay.CU3ER.controller.Player, arg2:int, arg3:int, arg4:com.madebyplay.CU3ER.model.TransitionData, arg5:int)
        {
            trace("Transition2D");
			super(arg1, arg2, arg3, arg4, arg5);
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

        internal function _createFirstSlide(arg1:Boolean=false):void
        {
            var loc1:*=undefined;
            var loc5:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc15:*=null;
            var loc16:*=NaN;
            var loc17:*=null;
            var loc20:*=null;
            var loc21:*=null;
            var loc22:*=null;
            var loc23:*=NaN;
            var loc24:*=NaN;
            var loc25:*=NaN;
            var loc26:*=NaN;
            var loc27:*=null;
            this._boxes = new Array();
            this._shadows = new Array();
            if (!arg1) 
            {
                this._display3D = new org.papervision3d.objects.DisplayObject3D();
                this._scene.scene.addChild(this._display3D);
            }
            var loc2:*=1;
            if (data.flipShader == "none" || loc2 == 0) 
            {
                loc1 = new org.papervision3d.materials.ColorMaterial(data.flipColor, loc2, false);
            }
            else 
            {
                loc1 = new org.papervision3d.materials.shadematerials.FlatShadeMaterial(loc5, data.flipColor, 0, 0);
            }
            var loc3:*=data.flipEasing;
            var loc4:*=data.flipDuration;
            loc5 = this._scene.light;
            var loc6:*=data.flipDepth;
            var loc7:*=player.data.width / data.columns;
            var loc8:*=player.data.height / data.rows;
            if ((loc9 = data.flipDirection.split(",")).length > 1) 
            {
                loc10 = loc9[Math.floor(Math.random() * loc9.length)];
            }
            else 
            {
                loc10 = data.flipDirection;
            }
            var loc11:*=1;
            var loc12:*=1;
            var loc13:*=1;
            if (data.flipShader == com.madebyplay.CU3ER.model.TransitionData.SHADER_FLAT && !arg1) 
            {
                this._scene.scene.addChild(loc5);
            }
            var loc14:*;
            (loc14 = new org.papervision3d.materials.utils.MaterialsList()).addMaterial(loc1, "left");
            loc14.addMaterial(loc1, "right");
            loc14.addMaterial(loc1, "bottom");
            loc14.addMaterial(loc1, "top");
            loc14.addMaterial(loc1, "front");
            loc14.addMaterial(loc1, "back");
            loc14.removeMaterial(loc14.getMaterialByName("back"));
            if (data.flipShader != com.madebyplay.CU3ER.model.TransitionData.SHADER_NONE) 
            {
                (loc20 = new org.papervision3d.materials.BitmapMaterial(destBmp)).smooth = true;
                loc20.precise = true;
                loc20.precision = 1;
                loc20.precisionMode = org.papervision3d.materials.utils.PrecisionMode.STABLE;
                loc21 = new org.papervision3d.materials.shaders.FlatShader(loc5, 16777215, _data.flipShaderColor, 10);
                (loc22 = new org.papervision3d.materials.shaders.ShadedMaterial(loc20, loc21)).smooth = true;
                loc14.addMaterial(loc22, "back");
            }
            else 
            {
                (loc15 = new org.papervision3d.materials.BitmapMaterial(destBmp)).smooth = true;
                loc15.precise = true;
                loc15.precision = 1;
                loc15.precisionMode = org.papervision3d.materials.utils.PrecisionMode.STABLE;
                loc14.addMaterial(loc15, "back");
            }
            if (data.flipAngle != 180) 
            {
                if (loc10 == com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT || loc10 == com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT) 
                {
                    loc17 = new org.papervision3d.objects.primitives.Cube(loc14, player.data.width, loc7, player.data.height, loc11, loc11, loc13);
                    loc16 = loc7;
                }
                else 
                {
                    loc17 = new org.papervision3d.objects.primitives.Cube(loc14, player.data.width, loc8, player.data.height, loc11, loc11, loc13);
                    loc16 = loc8;
                }
            }
            else 
            {
                loc17 = new org.papervision3d.objects.primitives.Cube(loc14, player.data.width, data.flipBoxDepth, player.data.height, loc11, loc12, loc13);
                loc16 = data.flipBoxDepth;
            }
            this._boxes.push(loc17);
            loc17.x = 0;
            loc17.y = 0;
            loc17.z = loc16 / 2;
            this._display3D.addChild(loc17);
            if (player.data.shadowShow && !player.data.shadowUseImage) 
            {
                loc23 = Math.cos(player.data.cameraAngleX * Math.PI / 180);
                loc24 = Math.cos((player.data.cameraAngleX - 90) * Math.PI / 180);
                loc25 = 0 * loc24;
                loc26 = player.data.shadowScale;
                (loc27 = new com.madebyplay.CU3ER.view.Shadow(loc17, new flash.geom.Rectangle(0, 0, player.data.width, loc16 * loc23 + player.data.height * loc24), player.data.shadowColor, player.data.shadowStrength, loc26)).y = loc25;
                this._shadows.push(loc27);
            }
            if (player.data.shadowShow && !arg1) 
            {
                this._createShadows();
            }
            var loc18:*=0;
            var loc19:*=0;
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
                com.greensock.TweenLite.delayedCall(loc19 + 0.1, this._onCubeAnimComplete);
                this._scene.addEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_START, this._dispatchStart);
                this._scene.render();
            }
            return;
        }

        internal function _dispatchStart(arg1:flash.events.Event):void
        {
            dispatchStart();
            return;
        }

        internal function _createCubes():void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc16:*=undefined;
            var loc19:*=null;
            var loc21:*=null;
            var loc22:*=null;
            var loc23:*=null;
            var loc24:*=null;
            var loc29:*=NaN;
            var loc30:*=0;
            var loc31:*=0;
            var loc34:*=NaN;
            var loc35:*=NaN;
            var loc36:*=NaN;
            var loc37:*=NaN;
            var loc38:*=NaN;
            var loc39:*=0;
            var loc40:*=NaN;
            var loc41:*=0;
            var loc42:*=null;
            var loc43:*=null;
            var loc44:*=null;
            var loc45:*=null;
            var loc46:*=null;
            var loc47:*=null;
            var loc48:*=NaN;
            var loc49:*=NaN;
            var loc50:*=NaN;
            var loc51:*=NaN;
            var loc52:*=null;
            var loc1:*=1000000;
            var loc2:*=0;
            this._display3D = new org.papervision3d.objects.DisplayObject3D();
            this._scene.scene.addChild(this._display3D);
            this._tgCubes = new com.greensock.TimelineMax();
            var loc3:*=new Array();
            this._boxes = new Array();
            this._shadows = new Array();
            var loc9:*=1;
            var loc10:*=1;
            var loc11:*=1;
            var loc12:*=data.flipEasing;
            var loc13:*=data.flipDuration;
            var loc14:*=this._scene.light;
            var loc15:*=data.flipDepth;
            var loc17:*=1;
            if (com.madebyplay.CU3ER.model.SlideData(player.data.slides[_srcNo]).transparent || com.madebyplay.CU3ER.model.SlideData(player.data.slides[_destNo]).transparent) 
            {
                loc17 = 0;
            }
            if (data.flipShader == "none" || loc17 == 0) 
            {
                loc16 = new org.papervision3d.materials.ColorMaterial(data.flipColor, loc17, false);
            }
            else 
            {
                loc16 = new org.papervision3d.materials.shadematerials.FlatShadeMaterial(loc14, data.flipColor, 0, 0);
            }
            var loc18:*=new Array(com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT, com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT, com.madebyplay.CU3ER.model.TransitionData.DIRECTION_UP, com.madebyplay.CU3ER.model.TransitionData.DIRECTION_DOWN);
            if (data.flipShader == com.madebyplay.CU3ER.model.TransitionData.SHADER_FLAT) 
            {
                this._scene.scene.addChild(loc14);
            }
            (loc4 = new org.papervision3d.materials.utils.MaterialsList()).addMaterial(loc16, "left");
            loc4.addMaterial(loc16, "right");
            loc4.addMaterial(loc16, "bottom");
            loc4.addMaterial(loc16, "top");
            loc4.addMaterial(loc16, "front");
            loc4.addMaterial(loc16, "back");
            var loc20:*;
            (loc20 = new flash.display.MovieClip()).scaleX = 1;
            loc20.scaleY = 1;
            var loc25:*=new Array();
            var loc26:*=new Array();
            var loc27:*=0;
            var loc28:*=0;
            loc30 = 0;
            while (loc30 < data.rows) 
            {
                loc31 = 0;
                while (loc31 < data.columns) 
                {
                    loc28 = 0;
                    loc35 = data.flipOrder;
                    if (_direction == -1) 
                    {
                        var loc53:*=loc35;
                        switch (loc53) 
                        {
                            case 0:
                            {
                                loc35 = 180;
                                break;
                            }
                            case 45:
                            {
                                loc35 = 225;
                                break;
                            }
                            case 90:
                            {
                                loc35 = 270;
                                break;
                            }
                            case 135:
                            {
                                loc35 = 315;
                                break;
                            }
                            case 180:
                            {
                                loc35 = 0;
                                break;
                            }
                            case 225:
                            {
                                loc35 = 45;
                                break;
                            }
                            case 270:
                            {
                                loc35 = 90;
                                break;
                            }
                            case 315:
                            {
                                loc35 = 135;
                                break;
                            }
                        }
                    }
                    if (data.flipOrderFromCenter) 
                    {
                        loc53 = loc35;
                        switch (loc53) 
                        {
                            case 0:
                            case 180:
                            {
                                loc29 = loc28 + Math.abs(Math.floor((data.columns - 1) / 2 - loc31)) * data.flipDelay;
                                break;
                            }
                            case 90:
                            case 270:
                            {
                                loc29 = loc28 + Math.abs(Math.floor((data.rows - 1) / 2 - loc30)) * data.flipDelay;
                                break;
                            }
                            case 135:
                            case 315:
                            {
                                loc29 = loc28 + Math.abs(loc30 + loc31 - Math.floor((data.rows + data.columns - 2) / 2)) * data.flipDelay;
                                break;
                            }
                            case 45:
                            case 225:
                            {
                                loc29 = loc28 + Math.abs(loc30 + (data.columns - loc31) - Math.floor((data.rows + data.columns - 2) / 2)) * data.flipDelay;
                                break;
                            }
                        }
                    }
                    else 
                    {
                        loc53 = loc35;
                        switch (loc53) 
                        {
                            case 0:
                            {
                                loc29 = loc28 + loc31 * data.flipDelay;
                                break;
                            }
                            case 45:
                            {
                                loc29 = loc28 + ((data.rows - 1) - loc30 + loc31) * data.flipDelay;
                                break;
                            }
                            case 90:
                            {
                                loc29 = loc28 + ((data.rows - 1) - loc30) * data.flipDelay;
                                break;
                            }
                            case 135:
                            {
                                loc29 = loc28 + (((data.rows - 1) - loc30 + data.columns - 1) - loc31) * data.flipDelay;
                                break;
                            }
                            case 180:
                            {
                                loc29 = loc28 + ((data.columns - 1) - loc31) * data.flipDelay;
                                break;
                            }
                            case 225:
                            {
                                loc29 = loc28 + ((data.columns - 1) - loc31 + loc30) * data.flipDelay;
                                break;
                            }
                            case 270:
                            {
                                loc29 = loc28 + loc30 * data.flipDelay;
                                break;
                            }
                            case 315:
                            {
                                loc29 = loc28 + (loc30 + loc31) * data.flipDelay;
                                break;
                            }
                        }
                    }
                    loc25[loc31 + loc30 * data.columns] = Math.round((loc29 - loc28) / data.flipDelay);
                    loc26[loc31 + loc30 * data.columns] = -1;
                    loc27 = Math.max(Math.round(loc25[loc31 + loc30 * data.columns]));
                    loc31 = loc31 + 1;
                }
                loc30 = loc30 + 1;
            }
            loc30 = 0;
            while (loc30 < data.rows) 
            {
                loc31 = 0;
                while (loc31 < data.columns) 
                {
                    loc6 = loc31 + loc30 * data.columns;
                    loc5 = rectangles[loc6];
                    srcBmp = arrBmpSrc[loc6];
                    destBmp = arrBmpDest[loc6];
                    loc21 = new flash.display.Sprite();
                    loc22 = new flash.display.Bitmap(srcBmp);
                    loc23 = new flash.display.Bitmap(destBmp);
                    loc22.smoothing = true;
                    loc23.smoothing = true;
                    loc20.addChild(loc21);
                    loc21.x = loc5.x;
                    loc21.y = loc5.y;
                    if (data.hasFlipRandomizeNew) 
                    {
                        if (loc26[loc31 + loc30 * data.columns] != -1) 
                        {
                            loc36 = loc25[loc26[loc31 + loc30 * data.columns]];
                        }
                        else 
                        {
                            loc38 = Math.max(data.columns - loc31, (loc31 - 1));
                            loc39 = Math.round(loc31 + loc38 * Math.random() * data.flipRandomize);
                            loc39 = Math.max(0, Math.min((data.columns - 1), loc39));
                            loc40 = Math.max(data.rows - loc30, (loc30 - 1));
                            loc41 = Math.round(loc30 + loc40 * Math.random() * data.flipRandomize);
                            loc41 = Math.max(0, Math.min((data.rows - 1), loc41));
                            loc36 = loc25[loc39 + loc41 * data.columns];
                            loc26[loc39 + loc41 * data.columns] = loc31 + loc30 * data.columns;
                        }
                        loc37 = Math.min(1, 2 * data.flipRandomize) * Math.max(0, 2 * data.flipDelay * Math.random() - data.flipDelay);
                        loc29 = loc28 + loc36 * data.flipDelay + loc37;
                    }
                    else 
                    {
                        loc36 = loc25[loc31 + loc30 * data.columns];
                        loc29 = loc28 + loc36 * data.flipDelay * (1 - data.flipDelayRandomize);
                    }
                    loc2 = Math.max(loc29 + data.flipDuration, loc2);
                    loc1 = Math.min(loc29, loc1);
                    if (data.type2D != com.madebyplay.CU3ER.model.TransitionData.TYPE2D_FADE) 
                    {
                        if ((loc18 = data.flipDirection.split(",")).length > 1) 
                        {
                            loc42 = loc18[Math.floor(Math.random() * loc18.length)];
                        }
                        else 
                        {
                            loc42 = data.flipDirection;
                        }
                        if (_direction == -1) 
                        {
                            loc53 = loc42;
                            switch (loc53) 
                            {
                                case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT:
                                {
                                    loc42 = com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT;
                                    break;
                                }
                                case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT:
                                {
                                    loc42 = com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT;
                                    break;
                                }
                                case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_UP:
                                {
                                    loc42 = com.madebyplay.CU3ER.model.TransitionData.DIRECTION_DOWN;
                                    break;
                                }
                                case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_DOWN:
                                {
                                    loc42 = com.madebyplay.CU3ER.model.TransitionData.DIRECTION_UP;
                                    break;
                                }
                            }
                        }
                        loc21.scrollRect = new flash.geom.Rectangle(0, 0, loc22.width, loc22.height);
                        loc53 = loc42;
                        switch (loc53) 
                        {
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_LEFT:
                            {
                                loc44 = new flash.display.BitmapData(loc22.width * 2, loc22.height, true, 0);
                                (loc45 = new flash.geom.Matrix()).translate(loc22.width, 0);
                                loc44.draw(loc23, loc45);
                                loc44.draw(loc22);
                                loc43 = new flash.display.Bitmap(loc44);
                                com.greensock.TweenMax.to(loc43, loc13, {"delay":loc29, "x":-loc22.width, "ease":loc12});
                                break;
                            }
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_RIGHT:
                            {
                                loc44 = new flash.display.BitmapData(loc22.width * 2, loc22.height, true, 0);
                                (loc45 = new flash.geom.Matrix()).translate(loc22.width, 0);
                                loc44.draw(loc22, loc45);
                                loc44.draw(loc23);
                                (loc43 = new flash.display.Bitmap(loc44)).x = -loc22.width;
                                com.greensock.TweenMax.to(loc43, loc13, {"delay":loc29, "x":0, "ease":loc12});
                                break;
                            }
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_DOWN:
                            {
                                loc44 = new flash.display.BitmapData(loc22.width, loc22.height * 2, true, 0);
                                (loc45 = new flash.geom.Matrix()).translate(0, loc22.height);
                                loc44.draw(loc22, loc45);
                                loc44.draw(loc23);
                                (loc43 = new flash.display.Bitmap(loc44)).y = -loc22.height;
                                com.greensock.TweenMax.to(loc43, loc13, {"delay":loc29, "y":0, "ease":loc12});
                                break;
                            }
                            case com.madebyplay.CU3ER.model.TransitionData.DIRECTION_UP:
                            {
                                loc44 = new flash.display.BitmapData(loc22.width, loc22.height * 2, true, 0);
                                (loc45 = new flash.geom.Matrix()).translate(0, loc22.height);
                                loc44.draw(loc23, loc45);
                                loc44.draw(loc22);
                                loc43 = new flash.display.Bitmap(loc44);
                                com.greensock.TweenMax.to(loc43, loc13, {"delay":loc29, "y":-loc22.height, "ease":loc12});
                                break;
                            }
                        }
                        loc43.smoothing = true;
                        loc21.addChild(loc43);
                        loc22.bitmapData.dispose();
                        loc23.bitmapData.dispose();
                        loc22 = null;
                        loc23 = null;
                    }
                    else 
                    {
                        loc21.addChild(loc22);
                        loc21.addChild(loc23);
                        loc23.alpha = 0;
                        com.greensock.TweenMax.to(loc23, loc13, {"delay":loc29, "alpha":1, "ease":loc12});
                    }
                    loc31 = loc31 + 1;
                }
                loc30 = loc30 + 1;
            }
            var loc32:*=false;
            if (loc17 == 0) 
            {
                loc32 = true;
            }
            var loc33:*;
            (loc33 = new org.papervision3d.materials.MovieMaterial(loc20, loc32, true, true, new flash.geom.Rectangle(0, 0, player.data.width, player.data.height))).smooth = true;
            if (data.flipShader != com.madebyplay.CU3ER.model.TransitionData.SHADER_NONE) 
            {
                loc46 = new org.papervision3d.materials.shaders.FlatShader(loc14, 16777215, _data.flipShaderColor, 10);
                (loc47 = new org.papervision3d.materials.shaders.ShadedMaterial(loc33, loc46)).smooth = true;
                loc4.addMaterial(loc47, "back");
            }
            else 
            {
                loc4.addMaterial(loc33, "back");
            }
            loc7 = new org.papervision3d.objects.primitives.Cube(loc4, player.data.width, data.flipBoxDepth, player.data.height, loc9, loc10, loc11);
            loc34 = data.flipBoxDepth;
            this._boxes.push(loc7);
            this._boxes.push(loc7);
            loc7.x = 0;
            loc7.y = 0;
            loc7.z = loc34 / 2;
            this._display3D.addChild(loc7);
            com.greensock.TweenLite.delayedCall(loc2 + 0.1, this._onCubeAnimComplete);
            if (player.data.shadowShow && !player.data.shadowUseImage) 
            {
                loc48 = Math.cos(player.data.cameraAngleX * Math.PI / 180);
                loc49 = Math.cos((player.data.cameraAngleX - 90) * Math.PI / 180);
                loc50 = 0 * loc49;
                loc51 = player.data.shadowScale;
                (loc52 = new com.madebyplay.CU3ER.view.Shadow(loc7, new flash.geom.Rectangle(0, 0, player.data.width, loc34 * loc48 + player.data.height * loc49), player.data.shadowColor, player.data.shadowStrength, loc51)).y = loc50;
                this._shadows.push(loc52);
            }
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

        internal function _createShadows():void
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=NaN;
            var loc7:*=NaN;
            this._shadow = new flash.display.Sprite();
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
            this._shadowRender.graphics.clear();
            var loc2:*=new flash.display.BitmapData(this._shadowRect.width, this._shadowRect.height, true, 0);
            loc2.draw(this._shadow, this._shadowMatrix);
            this._distortion.setTransform(this._shadowRender.graphics, loc2, this._shadowTL, this._shadowTR, this._shadowBR, this._shadowBL);
            return;
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
            loc1.dispose();
            return;
        }

        internal function _onCubeAnimUpdate(arg1:com.greensock.events.TweenEvent):void
        {
            return;
        }

        internal function _onCubeAnimComplete(arg1:flash.events.Event=null):void
        {
            this._updateFinal();
            return;
        }

        internal function _updateFinal(arg1:flash.events.Event=null):void
        {
            var loc1:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if ((player.slides[_destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc == null) 
            {
                loc1 = new org.papervision3d.materials.BitmapMaterial((player.slides[_destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData.clone(), true);
            }
            else 
            {
                loc1 = new org.papervision3d.materials.BitmapMaterial((player.slides[_destNo] as com.madebyplay.CU3ER.controller.Slide).bitmapData_noDesc.clone(), true);
            }
            loc1.smooth = true;
            loc1.precise = true;
            loc1.precision = 1;
            var loc2:*=this._boxes[0];
            if (data.flipShader != com.madebyplay.CU3ER.model.TransitionData.SHADER_NONE) 
            {
                loc3 = new org.papervision3d.materials.shaders.FlatShader(this._scene.light, 16777215, _data.flipShaderColor, 10);
                (loc4 = new org.papervision3d.materials.shaders.ShadedMaterial(loc1, loc3)).smooth = true;
                loc2.replaceMaterialByName(loc4, "back");
            }
            else 
            {
                loc2.replaceMaterialByName(loc1, "back");
            }
            this._scene.addEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_STOP, this._dipatchComplete);
            this._scene.renderOnce();
            return;
        }

        internal function _dipatchComplete(arg1:flash.events.Event=null):void
        {
            if (this._scene.hasEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_STOP)) 
            {
                this._scene.removeEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_STOP, this._dipatchComplete);
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
            var loc4:*=new flash.geom.Rectangle(0, 0, loc1, loc2);
            loc3.translate(player.holder.x, player.holder.y);
            if (player.data.shadowShow) 
            {
                finalBmp.draw(this._shadowRender, loc3, null, null, loc4);
            }
            (loc3 = new flash.geom.Matrix()).translate(player.holder.x, player.holder.y);
            finalBmp.draw(this._scene, loc3);
            dispatchEvent(new com.madebyplay.CU3ER.events.TransitionEvent(com.madebyplay.CU3ER.events.TransitionEvent.COMPLETE));
            this.destroy();
            return;
        }

        internal function _restart():void
        {
            this._scene.render();
            this.addEventListener(flash.events.Event.ENTER_FRAME, this._updateShadow, false, 0, true);
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

        public override function destroy():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            super.destroy();
            if (this._tgCubes != null) 
            {
                this._tgCubes.kill();
                this._tgCubes.clear();
            }
            if (player.data.shadowShow) 
            {
                loc2 = 0;
                while (loc2 < this._shadows.length) 
                {
                    this._shadow.removeChild(this._shadows[loc2]);
                    this._shadows[loc2].destroy();
                    this._shadows[loc2] = null;
                    ++loc2;
                }
                if (this._shadow.hasEventListener(flash.events.Event.ENTER_FRAME)) 
                {
                    this._shadow.removeEventListener(flash.events.Event.ENTER_FRAME, this._updateShadow);
                }
                if (this._shadowRender != null) 
                {
                    player.holder.removeChild(this._shadowRender);
                }
            }
            loc2 = 0;
            while (loc2 < this._boxes.length) 
            {
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
            if (data.flipShader == com.madebyplay.CU3ER.model.TransitionData.SHADER_FLAT) 
            {
                this._scene.scene.removeChild(this._scene.light);
            }
            if (this._scene.hasEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_START)) 
            {
                this._scene.removeEventListener(com.madebyplay.CU3ER.view.Scene.RENDER_START, this._dispatchStart);
            }
            this._scene.scene.removeChild(this._display3D);
            this._display3D = null;
            this._scene.destroy();
            this._scene = null;
            return;
        }

        public override function start():void
        {
            this._create3D();
            return;
        }

        internal var _scene:com.madebyplay.CU3ER.view.Scene;

        internal var _display3D:org.papervision3d.objects.DisplayObject3D;

        internal var _tgCubes:com.greensock.TimelineMax;

        internal var _boxes:Array;

        internal var _shadowPlane:org.papervision3d.objects.primitives.Plane;

        internal var _shadows:Array;

        internal var _distortion:org.flashsandy.display.DistortImage;

        internal var _shadowTL:flash.geom.Point;

        internal var _shadowTR:flash.geom.Point;

        internal var _shadowBL:flash.geom.Point;

        internal var _shadowBR:flash.geom.Point;

        internal var _shadow:flash.display.Sprite;

        internal var _shadowRender:flash.display.Shape;

        internal var _shadowRect:flash.geom.Rectangle;

        internal var _shadowMatrix:flash.geom.Matrix;

        internal var _shadowTestBitmap:flash.display.Bitmap;
    }
}
