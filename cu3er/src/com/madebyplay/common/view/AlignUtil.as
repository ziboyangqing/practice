package com.madebyplay.common.view 
{
    import flash.display.*;
    import flash.geom.*;
    
    public class AlignUtil extends Object
    {
        public function AlignUtil(arg1:flash.geom.Rectangle)
        {
            super();
            this._area = arg1;
            this._items = new Array();
            return;
        }

        public function addItem(arg1:flash.display.DisplayObject, arg2:String, arg3:Number=0, arg4:Number=0, arg5:Number=undefined, arg6:Number=undefined):void
        {
            this.removeItem(arg1);
            var loc1:*;
            (loc1 = new Object()).dobj = arg1;
            loc1.position = arg2;
            loc1.x = arg3;
            loc1.y = arg4;
            if (!isNaN(arg5)) 
            {
                loc1.width = arg5;
            }
            if (!isNaN(arg6)) 
            {
                loc1.height = arg6;
            }
            this._items.push(loc1);
            this.alignItem(loc1);
            return;
        }

        public function removeItem(arg1:flash.display.DisplayObject):void
        {
            var loc1:*=0;
            while (loc1 < this._items.length) 
            {
                if (this._items[loc1].dobj == arg1) 
                {
                    this._items.splice(loc1, 1);
                }
                ++loc1;
            }
            return;
        }

        public function updateItem(arg1:flash.display.DisplayObject, arg2:String, arg3:*="0", arg4:*="0", arg5:Number=undefined, arg6:Number=undefined):void
        {
            this.addItem(arg1, arg2, arg3, arg4, arg5, arg6);
            return;
        }

        public function getItemPos(arg1:flash.display.DisplayObject, arg2:Number=NaN, arg3:Number=NaN):flash.geom.Point
        {
            var loc3:*=null;
            var loc1:*=new flash.geom.Point();
            var loc2:*=0;
            while (loc2 < this._items.length) 
            {
                if (this._items[loc2].dobj == arg1) 
                {
                    loc3 = this._items[loc2];
                    if (!isNaN(arg2)) 
                    {
                        loc3.width = arg2;
                    }
                    if (!isNaN(arg3)) 
                    {
                        loc3.height = arg3;
                    }
                    var loc4:*=loc3.position;
                    switch (loc4) 
                    {
                        case "TL":
                        {
                            loc1.x = loc3.dobj.x - this._area.x;
                            loc1.y = loc3.dobj.y - this._area.y;
                            break;
                        }
                        case "TC":
                        {
                            if (loc3.width == undefined) 
                            {
                                loc1.x = loc3.dobj.x - (this._area.x + this._area.width / 2 - loc3.dobj.width / 2);
                            }
                            else 
                            {
                                loc1.x = loc3.dobj.x - (this._area.x + this._area.width / 2 - loc3.width / 2);
                            }
                            loc1.y = loc3.dobj.y - this._area.y;
                            break;
                        }
                        case "TR":
                        {
                            if (loc3.width == undefined) 
                            {
                                loc1.x = loc3.dobj.width + loc3.dobj.x - (this._area.x + this._area.width);
                            }
                            else 
                            {
                                loc1.x = loc3.width + loc3.dobj.x - (this._area.x + this._area.width);
                            }
                            loc1.y = loc3.dobj.y - this._area.y;
                            break;
                        }
                        case "ML":
                        {
                            loc1.x = loc3.dobj.x - this._area.x;
                            if (loc3.height == undefined) 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height / 2 - loc3.dobj.height / 2);
                            }
                            else 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height / 2 - loc3.height / 2);
                            }
                            break;
                        }
                        case "MC":
                        {
                            if (loc3.width == undefined) 
                            {
                                loc1.x = loc3.dobj.x - (this._area.x + this._area.width / 2 - loc3.dobj.width / 2);
                            }
                            else 
                            {
                                loc1.x = loc3.dobj.x - (this._area.x + this._area.width / 2 - loc3.width / 2);
                            }
                            if (loc3.height == undefined) 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height / 2 - loc3.dobj.height / 2);
                            }
                            else 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height / 2 - loc3.height / 2);
                            }
                            break;
                        }
                        case "MR":
                        {
                            if (loc3.width == undefined) 
                            {
                                loc1.x = loc3.dobj.width + loc3.dobj.x - (this._area.x + this._area.width);
                            }
                            else 
                            {
                                loc1.x = loc3.width + loc3.dobj.x - (this._area.x + this._area.width);
                            }
                            if (loc3.height == undefined) 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height / 2 - loc3.dobj.height / 2);
                            }
                            else 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height / 2 - loc3.height / 2);
                            }
                            break;
                        }
                        case "BL":
                        {
                            loc1.x = loc3.dobj.x - this._area.x;
                            if (loc3.height == undefined) 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height - loc3.dobj.height);
                            }
                            else 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height - loc3.height);
                            }
                            break;
                        }
                        case "BC":
                        {
                            if (loc3.width == undefined) 
                            {
                                loc1.x = loc3.dobj.x - (this._area.x + this._area.width / 2 - loc3.dobj.width / 2);
                            }
                            else 
                            {
                                loc1.x = loc3.dobj.x - (this._area.x + this._area.width / 2 - loc3.width / 2);
                            }
                            if (loc3.height == undefined) 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height - loc3.dobj.height);
                            }
                            else 
                            {
                                loc1.y = loc3.dobj.y - (this._area.y + this._area.height - loc3.height);
                            }
                            break;
                        }
                        case "BR":
                        {
                            if (loc3.width == undefined) 
                            {
                                loc1.x = loc3.dobj.width + loc3.dobj.x - (this._area.x + this._area.width);
                            }
                            else 
                            {
                                loc1.x = loc3.width + loc3.dobj.x - (this._area.x + this._area.width);
                            }
                            if (loc3.height == undefined) 
                            {
                                loc1.y = arg1.y - (this._area.y + this._area.height - arg1.height);
                            }
                            else 
                            {
                                loc1.y = arg1.y - (this._area.y + this._area.height - loc3.height);
                            }
                            break;
                        }
                    }
                }
                ++loc2;
            }
            return loc1;
        }

        public function update(arg1:flash.geom.Rectangle=null):void
        {
            if (this._area != null) 
            {
                this._area = arg1;
            }
            this._updatePositions();
            return;
        }

        internal function _updatePositions():void
        {
            var loc1:*=0;
            if (this._enabled) 
            {
                loc1 = 0;
                while (loc1 < this._items.length) 
                {
                    this.alignItem(this._items[loc1]);
                    ++loc1;
                }
            }
            return;
        }

        public function alignItem(arg1:Object):void
        {
            var loc1:*=String(arg1.x);
            var loc2:*=String(arg1.y);
            if (String(arg1.x).indexOf("%") > -1) 
            {
                arg1.x = Number(String(arg1.x).split("%").join("")) / 100 * this._area.width;
            }
            else 
            {
                arg1.x = Number(arg1.x);
            }
            if (String(arg1.y).indexOf("%") > -1) 
            {
                arg1.y = Number(String(arg1.y).split("%").join("")) / 100 * this._area.height;
            }
            else 
            {
                arg1.y = Number(arg1.y);
            }
            var loc3:*=arg1.position;
            switch (loc3) 
            {
                case "TL":
                {
                    arg1.dobj.x = this._area.x + arg1.x;
                    arg1.dobj.y = this._area.y + arg1.y;
                    break;
                }
                case "TC":
                {
                    if (arg1.width == undefined) 
                    {
                        arg1.dobj.x = this._area.x + this._area.width / 2 - arg1.dobj.width / 2 + arg1.x;
                    }
                    else 
                    {
                        arg1.dobj.x = this._area.x + this._area.width / 2 - arg1.width / 2 + arg1.x;
                    }
                    arg1.dobj.y = this._area.y + arg1.y;
                    break;
                }
                case "TR":
                {
                    if (arg1.width == undefined) 
                    {
                        arg1.dobj.x = this._area.x + this._area.width - arg1.dobj.width + arg1.x;
                    }
                    else 
                    {
                        arg1.dobj.x = this._area.x + this._area.width - arg1.width + arg1.x;
                    }
                    arg1.dobj.y = this._area.y + arg1.y;
                    break;
                }
                case "ML":
                {
                    arg1.dobj.x = this._area.x + arg1.x;
                    if (arg1.height == undefined) 
                    {
                        arg1.dobj.y = this._area.y + this._area.height / 2 - arg1.dobj.height / 2 + arg1.y;
                    }
                    else 
                    {
                        arg1.dobj.y = this._area.y + this._area.height / 2 - arg1.height / 2 + arg1.y;
                    }
                    break;
                }
                case "MC":
                {
                    if (arg1.width == undefined) 
                    {
                        arg1.dobj.x = this._area.x + this._area.width / 2 - arg1.dobj.width / 2 + arg1.x;
                    }
                    else 
                    {
                        arg1.dobj.x = this._area.x + this._area.width / 2 - arg1.width / 2 + arg1.x;
                    }
                    if (arg1.height == undefined) 
                    {
                        arg1.dobj.y = this._area.y + this._area.height / 2 - arg1.dobj.height / 2 + arg1.y;
                    }
                    else 
                    {
                        arg1.dobj.y = this._area.y + this._area.height / 2 - arg1.height / 2 + arg1.y;
                    }
                    break;
                }
                case "MR":
                {
                    if (arg1.width == undefined) 
                    {
                        arg1.dobj.x = this._area.x + this._area.width - arg1.dobj.width + arg1.x;
                    }
                    else 
                    {
                        arg1.dobj.x = this._area.x + this._area.width - arg1.width + arg1.x;
                    }
                    if (arg1.height == undefined) 
                    {
                        arg1.dobj.y = this._area.y + this._area.height / 2 - arg1.dobj.height / 2 + arg1.y;
                    }
                    else 
                    {
                        arg1.dobj.y = this._area.y + this._area.height / 2 - arg1.height / 2 + arg1.y;
                    }
                    break;
                }
                case "BL":
                {
                    arg1.dobj.x = this._area.x + arg1.x;
                    if (arg1.height == undefined) 
                    {
                        arg1.dobj.y = this._area.y + this._area.height - arg1.dobj.height + arg1.y;
                    }
                    else 
                    {
                        arg1.dobj.y = this._area.y + this._area.height - arg1.height + arg1.y;
                    }
                    break;
                }
                case "BC":
                {
                    if (arg1.width == undefined) 
                    {
                        arg1.dobj.x = this._area.x + this._area.width / 2 - arg1.dobj.width / 2 + arg1.x;
                    }
                    else 
                    {
                        arg1.dobj.x = this._area.x + this._area.width / 2 - arg1.width / 2 + arg1.x;
                    }
                    if (arg1.height == undefined) 
                    {
                        arg1.dobj.y = this._area.y + this._area.height - arg1.dobj.height + arg1.y;
                    }
                    else 
                    {
                        arg1.dobj.y = this._area.y + this._area.height - arg1.height + arg1.y;
                    }
                    break;
                }
                case "BR":
                {
                    if (arg1.width == undefined) 
                    {
                        arg1.dobj.x = this._area.x + this._area.width - arg1.dobj.width + arg1.x;
                    }
                    else 
                    {
                        arg1.dobj.x = this._area.x + this._area.width - arg1.width + arg1.x;
                    }
                    if (arg1.height == undefined) 
                    {
                        arg1.dobj.y = this._area.y + this._area.height - arg1.dobj.height + arg1.y;
                    }
                    else 
                    {
                        arg1.dobj.y = this._area.y + this._area.height - arg1.height + arg1.y;
                    }
                    break;
                }
            }
            arg1.dobj.x = Math.round(arg1.dobj.x);
            arg1.dobj.y = Math.round(arg1.dobj.y);
            arg1.x = loc1;
            arg1.y = loc2;
            return;
        }

        public function getItem(arg1:flash.display.DisplayObject):Object
        {
            var loc1:*=0;
            while (loc1 < this._items.length) 
            {
                if (this._items[loc1].dobj == arg1) 
                {
                    return arg1;
                }
                ++loc1;
            }
            return null;
        }

        public function get enabled():Boolean
        {
            return this._enabled;
        }

        public function set enabled(arg1:Boolean):void
        {
            this._enabled = arg1;
            return;
        }

        public function get id():String
        {
            return this._id;
        }

        public function set id(arg1:String):void
        {
            this._id = arg1;
            return;
        }

        public function get area():flash.geom.Rectangle
        {
            return this._area;
        }

        internal var _area:flash.geom.Rectangle;

        internal var _items:Array;

        internal var _enabled:Boolean=true;

        internal var _id:String="";
    }
}
