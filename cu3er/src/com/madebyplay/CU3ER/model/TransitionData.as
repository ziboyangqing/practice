package com.madebyplay.CU3ER.model 
{
    import com.greensock.easing.*;
    
    public class TransitionData extends Object
    {
        public function TransitionData(arg1:XML, arg2:XML)
        {
            this._type = TYPE_3D;
            this._type2D = TYPE2D_FADE;
            this._flipShader = SHADER_FLAT;
            this._flipDirection = DIRECTION_RIGHT;
            this._flipAngle = ANGLE_180;
            this._flipEasing = com.greensock.easing.Sine.easeInOut;
            super();
            this._globalXML = arg2;
            this._xml = arg1;
			//trace("TransitionData:1-----"+this._xml);
            this.getFromXML();
            return;
        }

        public function get flipBoxDepth():Number
        {
            return this._flipBoxDepth;
        }

        public function set flipBoxDepth(arg1:Number):void
        {
            this._flipBoxDepth = arg1;
            return;
        }

        public function get flipDepth():Number
        {
            return this._flipDepth;
        }

        public function set flipDepth(arg1:Number):void
        {
            this._flipDepth = arg1;
            return;
        }

        public function get flipDirection():String
        {
            return this._flipDirection;
        }

        public function set flipDirection(arg1:String):void
        {
            this._flipDirection = arg1;
            return;
        }

        public function get flipColor():Number
        {
            return this._flipColor;
        }

        public function set flipColor(arg1:Number):void
        {
            this._flipColor = arg1;
            return;
        }

        public function get flipShader():String
        {
            return this._flipShader;
        }

        public function get flipDelay():Number
        {
            return this._flipDelay;
        }

        public function set flipShader(arg1:String):void
        {
            this._flipShader = arg1;
            return;
        }

        public function get flipDelayRandomize():Number
        {
            return this._flipDelayRandomize;
        }

        public function set flipDelayRandomize(arg1:Number):void
        {
            this._flipDelayRandomize = arg1;
            return;
        }

        public function get flipOrderFromCenter():Boolean
        {
            return this._flipOrderFromCenter;
        }

        public function set flipOrderFromCenter(arg1:Boolean):void
        {
            this._flipOrderFromCenter = arg1;
            return;
        }

        public function get type2D():String
        {
            return this._type2D;
        }

        public function set type2D(arg1:String):void
        {
            this._type2D = arg1;
            return;
        }

        public function get flipShaderColor():Number
        {
            return this._flipShaderColor;
        }

        public function set flipShaderColor(arg1:Number):void
        {
            this._flipShaderColor = arg1;
            return;
        }

        public function get flipRandomize():Number
        {
            return this._flipRandomize;
        }

        public function set flipRandomize(arg1:Number):void
        {
            this._flipRandomize = arg1;
            return;
        }

        public function get hasFlipRandomizeNew():Boolean
        {
            return this._hasFlipRandomizeNew;
        }

        public function getFromXML():void
        {
            if ("@emptyType" in this._xml) 
            {
                delete this._xml.@type;
                delete this._xml.@emptyType;
            }
            if (String(this._xml.@type) == "") 
            {
                if (String(this._globalXML.defaults.transition.@type) != "") 
                {
                    this._type = this._globalXML.defaults.transition.@type;
                    this._xml.@type = this._type;
                    this._xml.@emptyType = "true";
                }
            }
            else 
            {
                this._type = this._xml.@type;
            }
            if ("@emptyType2D" in this._xml) 
            {
                delete this._xml.@type2D;
                delete this._xml.@emptyType2D;
            }
            if (String(this._xml.@type2D) == "") 
            {
                if (String(this._globalXML.defaults.transition.@type2D) != "") 
                {
                    this._type2D = this._globalXML.defaults.transition.@type2D;
                    this._xml.@type2D = this._type2D;
                    this._xml.@emptyType2D = "true";
                }
            }
            else 
            {
                this._type2D = String(this._xml.@type2D);
            }
            if ("@emptyTime" in this._xml) 
            {
                delete this._xml.@time;
                delete this._xml.@emptyTime;
            }
            if (String(this._xml.@time) == "") 
            {
                if (String(this._globalXML.defaults.transition.@time) != "") 
                {
                    this._time = Number(this._globalXML.defaults.transition.@time);
                    this._xml.@time = this._time;
                    this._xml.@emptyTime = "true";
                }
            }
            else 
            {
                this._time = Number(this._xml.@time);
            }
            if ("@emptyColsRows" in this._xml) 
            {
                delete this._xml.@rows;
                delete this._xml.@columns;
                delete this._xml.@emptyColsRows;
            }
            var loc1:*=true;
            if (String(this._xml.@rows) == "") 
            {
                if (String(this._globalXML.defaults.transition.@rows) != "") 
                {
                    this._rows = Number(this._globalXML.defaults.transition.@rows);
                    this._xml.@rows = this._rows;
                }
            }
            else 
            {
                this._rows = Number(this._xml.@rows);
                loc1 = false;
            }
            if (String(this._xml.@columns) == "") 
            {
                if (String(this._globalXML.defaults.transition.@columns) != "") 
                {
                    this._columns = Number(this._globalXML.defaults.transition.@columns);
                    this._xml.@columns = this._columns;
                }
            }
            else 
            {
                this._columns = Number(this._xml.@columns);
                loc1 = false;
            }
            if (loc1) 
            {
                this._xml.@emptyColsRows = "true";
            }
            var loc2:*=true;
            if ("@emptyFlipColorShade" in this._xml) 
            {
                delete this._xml.@emptyFlipColorShade;
                delete this._xml.@flipColor;
                delete this._xml.@flipShader;
            }
            if (String(this._xml.@flipColor) == "") 
            {
                if (String(this._globalXML.defaults.transition.@flipColor) != "") 
                {
                    this._flipColor = parseInt(String(this._globalXML.defaults.transition.@flipColor), 16);
                    this._xml.@flipColor = this._globalXML.defaults.transition.@flipColor;
                }
            }
            else 
            {
                this._flipColor = parseInt(String(this._xml.@flipColor), 16);
                loc2 = false;
            }
            var loc3:*=String(this._xml.@flipShader).toLowerCase();
            var loc4:*=String(this._globalXML.defaults.transition.@flipShader);
            if (!(loc3 == "") && (loc3 == "none" || loc3 == "flat")) 
            {
                this._flipShader = String(this._xml.@flipShader);
                loc2 = false;
            }
            else if (!(loc4 == "") && (loc4 == "none" || loc4 == "flat")) 
            {
                this._flipShader = loc4;
                this._xml.@flipShader = this._flipShader;
            }
            if (loc2) 
            {
                this._xml.@emptyFlipColorShade = "true";
            }
            if ("@emptyFlipBoxDepth" in this._xml) 
            {
                delete this._xml.@emptyFlipBoxDepth;
                delete this._xml.@flipBoxDepth;
            }
            if (String(this._xml.@flipBoxDepth) == "") 
            {
                if (String(this._globalXML.defaults.transition.@flipBoxDepth) != "") 
                {
                    this._flipBoxDepth = Number(this._globalXML.defaults.transition.@flipBoxDepth);
                    this._xml.@flipBoxDepth = this._flipBoxDepth;
                    this._xml.@emptyFlipBoxDepth = "true";
                }
            }
            else 
            {
                this._flipBoxDepth = Number(this._xml.@flipBoxDepth);
            }
            if ("@emptyFlipDepth" in this._xml) 
            {
                delete this._xml.@emptyFlipDepth;
                delete this._xml.@flipDepth;
            }
            if (String(this._xml.@flipDepth) == "") 
            {
                if (String(this._globalXML.defaults.transition.@flipDepth) != "") 
                {
                    this._flipDepth = Number(this._globalXML.defaults.transition.@flipDepth);
                    this._xml.@flipDepth = this._flipDepth;
                    this._xml.@emptyFlipDepth = "true";
                }
            }
            else 
            {
                this._flipDepth = Number(this._xml.@flipDepth);
            }
            var loc5:*=true;
            if ("@emptyFlipOrder" in this._xml) 
            {
                delete this._xml.@emptyFlipOrder;
                delete this._xml.@flipOrderFromCenter;
                delete this._xml.@flipOrder;
            }
            if (String(this._xml.@flipOrder) == "") 
            {
                if (String(this._globalXML.defaults.transition.@flipOrder) != "") 
                {
                    this._flipOrder = Number(this._globalXML.defaults.transition.@flipOrder);
                    this._flipOrder = Math.floor(this._flipOrder / 45) * 45;
                    this._xml.@flipOrder = String(this._globalXML.defaults.transition.@flipOrder);
                }
            }
            else 
            {
                this._flipOrder = Number(this._xml.@flipOrder);
                this._flipOrder = Math.floor(this._flipOrder / 45) * 45;
                loc5 = false;
            }
            if ("@flipOrderFromCenter" in this._xml) 
            {
                if (String(this._xml.@flipOrderFromCenter) != "true") 
                {
                    this._flipOrderFromCenter = false;
                }
                else 
                {
                    this._flipOrderFromCenter = true;
                }
                loc5 = false;
            }
            else if (String(this._globalXML.defaults.transition.@flipOrderFromCenter) != "true") 
            {
                this._xml.@flipOrderFromCenter = "false";
                this._flipOrderFromCenter = false;
            }
            else 
            {
                this._flipOrderFromCenter = true;
                this._xml.@flipOrderFromCenter = "true";
            }
            if (loc5) 
            {
                this._xml.@emptyFlipOrder = "true";
            }
            if ("@emptyFlipDirection" in this._xml) 
            {
                delete this._xml.@emptyFlipDirection;
               // delete this._xml.@flipDirection;
            }
            if (String(this._xml.@flipDirection) == "") 
            {
                if (String(this._globalXML.defaults.transition.@flipDirection) != "") 
                {
                    this._flipDirection = String(this._globalXML.defaults.transition.@flipDirection);
                    this._xml.@emptyFlipDirection = "true";
                    this._xml.@flipDirection = this._flipDirection;
                }
            }
            else 
            {
                this._flipDirection = String(this._xml.@flipDirection);
            }
            if (this._flipDirection == "random") 
            {
                this._flipDirection = "left,right,up,down";
            }
            if ("@emptyFlipAngle" in this._xml) 
            {
                delete this._xml.@emptyFlipAngle;
                delete this._xml.@flipAngle;
            }
            var loc6:*=String(this._xml.@flipAngle).toLowerCase();
            var loc7:*=String(this._globalXML.defaults.transition.@flipAngle);
            if (!(loc6 == "") && (loc6 == "90" || loc6 == "180")) 
            {
                this._flipAngle = Number(loc6);
            }
            else if (!(loc7 == "") && (loc7 == "90" || loc7 == "180")) 
            {
                this._flipAngle = Number(loc7);
                this._xml.@emptyFlipAngle = "true";
                this._xml.@flipAngle = this._flipAngle;
            }
            if ("@emptyFlipDuration" in this._xml) 
            {
                delete this._xml.@emptyFlipDuration;
                delete this._xml.@flipDuration;
            }
            if (String(this._xml.@flipDuration) == "") 
            {
                if (String(this._globalXML.defaults.transition.@flipDuration) != "") 
                {
                    this._flipDuration = Number(this._globalXML.defaults.transition.@flipDuration);
                    this._xml.@emptyFlipDuration = "true";
                    this._xml.@flipDuration = this._flipDuration;
                }
            }
            else 
            {
                this._flipDuration = Number(this._xml.@flipDuration);
            }
            if ("@emptyFlipDelay" in this._xml) 
            {
                delete this._xml.@emptyFlipDelay;
                delete this._xml.@flipDelay;
            }
            if (String(this._xml.@flipDelay) == "") 
            {
                if (String(this._globalXML.defaults.transition.@flipDelay) != "") 
                {
                    this._flipDelay = Number(this._globalXML.defaults.transition.@flipDelay);
                    this._xml.@emptyFlipDelay = "true";
                    this._xml.@flipDelay = this._flipDelay;
                }
            }
            else 
            {
                this._flipDelay = Number(this._xml.@flipDelay);
            }
            if ("@emptyFlipEasing" in this._xml) 
            {
                delete this._xml.@emptyFlipEasing;
                delete this._xml.@flipEasing;
            }
            var loc8:*=String(this._xml.@flipEasing);
            var loc9:*=String(this._globalXML.defaults.transition.@flipEasing);
            if (loc8 == "" && !(loc9 == "")) 
            {
                loc8 = loc9;
                this._xml.@flipEasing = loc8;
                this._xml.@emptyFlipEasing = "true";
            }
            var loc10:*=loc8;
            switch (loc10) 
            {
                case "Sine.easeOut":
                {
                    this._flipEasing = com.greensock.easing.Sine.easeOut;
                    break;
                }
                case "Sine.easeInOut":
                {
                    this._flipEasing = com.greensock.easing.Sine.easeInOut;
                    break;
                }
                case "Sine.easeIn":
                {
                    this._flipEasing = com.greensock.easing.Sine.easeIn;
                    break;
                }
                case "Bounce.easeInOut":
                {
                    this._flipEasing = com.greensock.easing.Bounce.easeInOut;
                    break;
                }
                case "Bounce.easeOut":
                {
                    this._flipEasing = com.greensock.easing.Bounce.easeOut;
                    break;
                }
                case "Bounce.easeIn":
                {
                    this._flipEasing = com.greensock.easing.Bounce.easeIn;
                    break;
                }
                case "Elastic.easeInOut":
                {
                    this._flipEasing = com.greensock.easing.Elastic.easeInOut;
                    break;
                }
                case "Elastic.easeOut":
                {
                    this._flipEasing = com.greensock.easing.Elastic.easeOut;
                    break;
                }
                case "Elastic.easeIn":
                {
                    this._flipEasing = com.greensock.easing.Elastic.easeIn;
                    break;
                }
                case "Expo.easeInOut":
                {
                    this._flipEasing = com.greensock.easing.Expo.easeInOut;
                    break;
                }
                case "Expo.easeOut":
                {
                    this._flipEasing = com.greensock.easing.Expo.easeOut;
                    break;
                }
                case "Expo.easeIn":
                {
                    this._flipEasing = com.greensock.easing.Expo.easeIn;
                    break;
                }
            }
            if ("@emptyFlipDelayRandomize" in this._xml) 
            {
                delete this._xml.@emptyFlipDelayRandomize;
                delete this._xml.@flipDelayRandomize;
            }
            if (String(this._xml.@flipDelayRandomize) == "") 
            {
                if (String(this._globalXML.defaults.transition.@flipDelayRandomize) != "") 
                {
                    this._flipDelayRandomize = Number(this._globalXML.defaults.transition.@flipDelayRandomize);
                    this._xml.@emptyFlipDelayRandomize = "true";
                    this._xml.@flipDelayRandomize = this._flipDelayRandomize;
                }
            }
            else 
            {
                this._flipDelayRandomize = Number(this._xml.@flipDelayRandomize);
            }
            if ("@emptyFlipRandomize" in this._xml) 
            {
                delete this._xml.@emptyFlipRandomize;
                delete this._xml.@flipRandomize;
            }
            if (String(this._xml.@flipRandomize) == "") 
            {
                if (String(this._globalXML.defaults.transition.@flipRandomize) != "") 
                {
                    this._flipRandomize = Number(this._globalXML.defaults.transition.@flipRandomize);
                    this._xml.@emptyFlipRandomize = "true";
                    this._xml.@flipRandomize = this._flipRandomize;
                    this._hasFlipRandomizeNew = true;
                }
            }
            else 
            {
                this._flipRandomize = Number(this._xml.@flipRandomize);
                this._hasFlipRandomizeNew = true;
            }
            if (this._flipOrderFromCenter && this._rows == 1) 
            {
                this._flipOrder = 0;
            }
            if (this._flipOrderFromCenter && this._columns == 1) 
            {
                this._flipOrder = 90;
            }
			//trace("TransitionData:2---------",this._xml);
			
            return;
        }

        public function get xml():XML
        {
            return this._xml;
        }

        public function set xml(arg1:XML):void
        {
            this._xml = arg1;
            this.getFromXML();
            return;
        }

        public function get type():String
        {
            return this._type;
        }

        public function set type(arg1:String):void
        {
            this._type = arg1;
            return;
        }

        public function get time():Number
        {
            return this._time;
        }

        public function set time(arg1:Number):void
        {
            this._time = arg1;
            return;
        }

        public function get rows():uint
        {
            return this._rows;
        }

        public function set rows(arg1:uint):void
        {
            this._rows = arg1;
            return;
        }

        public function get columns():uint
        {
            return this._columns;
        }

        public function set columns(arg1:uint):void
        {
            this._columns = arg1;
            return;
        }

        public function get flipOrder():Number
        {
            return this._flipOrder;
        }

        public function set flipOrder(arg1:Number):void
        {
            this._flipOrder = arg1;
            return;
        }

        public function get flipAngle():Number
        {
            return this._flipAngle;
        }

        public function set flipAngle(arg1:Number):void
        {
            this._flipAngle = arg1;
            return;
        }

        public function get flipDuration():Number
        {
            return this._flipDuration;
        }

        public function set flipDuration(arg1:Number):void
        {
            this._flipDuration = arg1;
            return;
        }

        
        {
            EASINGS = new Array("Sine.easeOut", "Sine.easeInOut", "Sine.easeIn", "Bounce.easeInOut", "Bounce.easeOut", "Bounce.easeIn", "Elastic.easeInOut", "Elastic.easeOut", "Elastic.easeIn", "Expo.easeInOut", "Expo.easeOut", "Expo.easeIn");
            TYPE_3D = "3D";
            TYPE_2D = "2D";
            TYPE2D_FADE = "fade";
            TYPE2D_SLIDE = "slide";
            ANGLE_90 = 90;
            ANGLE_180 = 180;
            DIRECTION_UP = "up";
            DIRECTION_DOWN = "down";
            DIRECTION_LEFT = "left";
            DIRECTION_RIGHT = "right";
            DIRECTION_RANDOM = "random";
            SHADER_NONE = "none";
            SHADER_FLAT = "flat";
        }

        public function set flipDelay(arg1:Number):void
        {
            this._flipDelay = arg1;
            return;
        }

        public function get flipEasing():Function
        {
            return this._flipEasing;
        }

        public function set flipEasing(arg1:Function):void
        {
            this._flipEasing = arg1;
            return;
        }

        internal var _xml:XML;

        internal var _type:String;

        internal var _type2D:String;

        internal var _time:Number=3;

        internal var _rows:uint=5;

        internal var _columns:uint=5;

        internal var _flipColor:Number=16711680;

        internal var _flipShader:String;

        internal var _flipShaderColor:Number=0;

        internal var _flipOrder:Number=90;

        internal var _flipOrderFromCenter:Boolean=false;

        internal var _flipDirection:String;

        internal var _flipAngle:Number;

        internal var _flipDuration:Number=0.8;

        internal var _flipDelay:Number=0.15;

        internal var _flipEasing:Function;

        internal var _flipDepth:Number=300;

        internal var _flipDelayRandomize:Number=0;

        internal var _flipRandomize:Number=0;

        internal var _hasFlipRandomizeNew:Boolean=false;

        internal var _globalXML:XML;

        public static var EASINGS:Array;

        public static var TYPE_3D:String="3D";

        public static var TYPE_2D:String="2D";

        public static var TYPE2D_FADE:String="fade";

        internal var _flipBoxDepth:Number=500;

        public static var ANGLE_90:Number=90;

        public static var ANGLE_180:Number=180;

        public static var DIRECTION_UP:String="up";

        public static var DIRECTION_DOWN:String="down";

        public static var DIRECTION_LEFT:String="left";

        public static var DIRECTION_RIGHT:String="right";

        public static var DIRECTION_RANDOM:String="random";

        public static var SHADER_NONE:String="none";

        public static var SHADER_FLAT:String="flat";

        public static var TYPE2D_SLIDE:String="slide";
    }
}
