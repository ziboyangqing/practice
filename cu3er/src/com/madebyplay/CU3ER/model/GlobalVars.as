package com.madebyplay.CU3ER.model 
{
    import com.greensock.easing.*;
    import com.madebyplay.common.view.*;
    import flash.display.*;
    
    public class GlobalVars extends Object
    {
        public function GlobalVars()
        {
            super();
            return;
        }

        
        {
            FLASH_ID = "CU3ER";
            LICENCE_OK = false;
            TEMPLATE_LICENCE_OK = true;
            PRELOADER_ON_STAGE = false;
            VERSION = "v1.24";
            REFERRAL = "";
            REVERSE_ORDER = false;
            LOAD_PREFIX = "";
            START_SLIDE = -1;
            SCENE_WIDTH = 960;
            SCENE_HEIGHT = 560;
            STAGE_FORCE = false;
            FLASHVAR_IMAGES = new Array();
            DO_LOAD_XML = false;
            DO_OVERWRITE_XML = false;
            PRELOADER_PERC_SWF = 0.25;
            PRELOADER_PERC_XML = 0.05;
            PRELOADER_PERC_BG_IMAGE = 0.1;
            PRELOADER_PERC_FONT = 0.2;
            PRELOADER_PERC_SLIDESHOW = 0.4;
            CONTROLS_BLOCKED = true;
            KEYBOARD_CONTROLS = true;
            ALIGN_POS_VALUES = {"TL":1, "TC":1, "TR":1, "ML":1, "MC":1, "MR":1, "BL":1, "BC":1, "BR":1};
        }

        public static function getValue(arg1:*, arg2:Number=0):Number
        {
            if (String(arg1) != "") 
            {
                return Number(arg1);
            }
            return arg2;
        }

        public static function getStringValue(arg1:*, arg2:String=""):String
        {
            if (String(arg1) != "") 
            {
                return String(arg1);
            }
            return arg2;
        }

        public static function getTweenFunction(arg1:String):Function
        {
            var loc1:*=new Function();
            var loc2:*=arg1;
            switch (loc2) 
            {
                case "Sine.easeOut":
                {
                    loc1 = com.greensock.easing.Sine.easeOut;
                    break;
                }
                case "Sine.easeInOut":
                {
                    loc1 = com.greensock.easing.Sine.easeInOut;
                    break;
                }
                case "Sine.easeIn":
                {
                    loc1 = com.greensock.easing.Sine.easeIn;
                    break;
                }
                case "Bounce.easeInOut":
                {
                    loc1 = com.greensock.easing.Bounce.easeInOut;
                    break;
                }
                case "Bounce.easeOut":
                {
                    loc1 = com.greensock.easing.Bounce.easeOut;
                    break;
                }
                case "Bounce.easeIn":
                {
                    loc1 = com.greensock.easing.Bounce.easeIn;
                    break;
                }
                case "Elastic.easeInOut":
                {
                    loc1 = com.greensock.easing.Elastic.easeInOut;
                    break;
                }
                case "Elastic.easeOut":
                {
                    loc1 = com.greensock.easing.Elastic.easeOut;
                    break;
                }
                case "Elastic.easeIn":
                {
                    loc1 = com.greensock.easing.Elastic.easeIn;
                    break;
                }
                case "Expo.easeInOut":
                {
                    loc1 = com.greensock.easing.Expo.easeIn;
                    break;
                }
                case "Expo.easeOut":
                {
                    loc1 = com.greensock.easing.Expo.easeOut;
                    break;
                }
                case "Expo.easeIn":
                {
                    loc1 = com.greensock.easing.Expo.easeIn;
                    break;
                }
            }
            return loc1;
        }

        public static var VERSION:String="v1.24";

        public static var REFERRAL:String="";

        public static var CU3ER:flash.display.DisplayObjectContainer;

        public static var CU3ER_MAIN:flash.display.DisplayObjectContainer;

        public static var REVERSE_ORDER:Boolean=false;

        public static var BRANDING:flash.display.MovieClip;

        public static var TOP_LAYER:flash.display.Sprite;

        public static var LOAD_PREFIX:String="";

        public static var FOLDER_IMAGES:String;

        public static var FOLDER_FONTS:String;

        public static var FOLDER_PROJECT:String;

        public static var ALIGN_STAGE:com.madebyplay.common.view.AlignUtil;

        public static var ALIGN_SLIDE:com.madebyplay.common.view.AlignUtil;

        public static var START_SLIDE:int=-1;

        public static var SCENE_WIDTH:Number=960;

        public static var SCENE_HEIGHT:Number=560;

        public static var STAGE_WIDTH:Number;

        public static var STAGE_HEIGHT:Number;

        public static var STAGE_FORCE:Boolean=false;

        public static var FLASHVAR_IMAGES:Array;

        public static var XML_CONFIG:XML;

        public static var DO_LOAD_XML:Boolean=false;

        public static var DO_OVERWRITE_XML:Boolean=false;

        public static var XML_OVERWRITE:XML;

        public static var CONFIG_XML_PATH:String;

        public static var PRELOADER_PERC_SWF:Number=0.25;

        public static var FLASH_ID:String="CU3ER";

        public static var PRELOADER_PERC_BG_IMAGE:Number=0.1;

        public static var PRELOADER_PERC_FONT:Number=0.2;

        public static var PRELOADER_PERC_SLIDESHOW:Number=0.4;

        public static var CONTROLS_BLOCKED:Boolean=true;

        public static var PRELOADER_PERC_XML:Number=0.05;

        public static var ALIGN_POS_VALUES:Object;

        public static var LICENCE_OK:Boolean=false;

        public static var TEMPLATE_LICENCE_OK:Boolean=true;

        public static var PRELOADER_ON_STAGE:Boolean=false;

        public static var KEYBOARD_CONTROLS:Boolean=true;
    }
}
