package com.madebyplay.CU3ER.model 
{
    import com.greensock.easing.*;
    import flash.text.*;
    
    public class DescriptionData extends Object
    {
        public function DescriptionData(arg1:XML)
        {
            this._background = {"round_corners":"0,0,0,0"};
            this._heading = {"x":5, "y":5, "width":90, "height":20, "font":"Georgia", "embed_fonts":false, "text_size":18, "text_bold":false, "text_italic":false, "text_color":16777215, "text_align":"left", "text_margin":"5,5,5,5", "text_leading":0, "text_letterSpacing":0};
            this._paragraph = {"x":5, "y":30, "width":90, "height":65, "font":"Arial", "embed_fonts":false, "text_bold":false, "text_italic":false, "text_size":12, "text_color":16777215, "text_align":"left", "text_margin":"0,5,5,5", "text_leading":0, "text_letterSpacing":0};
            this._tweenShow_bg = {"time":0.3, "delay":0, "alpha":0.85, "x":0, "y":0, "rotation":0, "alpha":0, "tint":16711680, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenOver_bg = {"time":0.3, "delay":0, "alpha":1, "x":0, "y":0, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenHide_bg = {"time":0.3, "delay":0, "alpha":0, "x":0, "y":0, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenShow_heading = {"time":0.3, "delay":0, "alpha":0.85, "x":0, "y":0, "rotation":0, "alpha":0, "tint":16777215, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenOver_heading = {"time":0.3, "delay":0, "x":0, "y":0, "tint":16777215, "scaleX":1, "scaleY":1, "alpha":1};
            this._tweenHide_heading = {"time":0.3, "delay":0, "alpha":0, "x":0, "y":0, "rotation":0, "tint":16777215, "scaleX":1, "scaleY":1, "visible":false};
            this._tweenShow_paragraph = {"time":0.3, "delay":0, "alpha":0.85, "x":0, "y":0, "rotation":0, "alpha":0, "tint":16777215, "scaleX":1, "scaleY":1, "ease":com.greensock.easing.Sine.easeOut};
            this._tweenOver_paragraph = {"time":0.3, "delay":0, "x":0, "y":0, "tint":16777215, "scaleX":1, "scaleY":1, "alpha":1};
            this._tweenHide_paragraph = {"time":0.3, "delay":0, "alpha":0, "x":0, "y":0, "rotation":0, "tint":16777215, "scaleX":1, "scaleY":1, "visible":false};
            this._copyList = new Array("time", "delay", "x", "y", "alpha", "rotation", "tint", "scaleX", "scaleY", "visible", "ease");
            super();
            this._xml = arg1;
            this.getFromXML();
            return;
        }

        public function set tweenOver_bg(arg1:Object):void
        {
            this._tweenOver_bg = arg1;
            return;
        }

        public function get tweenHide_bg():Object
        {
            return this._tweenHide_bg;
        }

        public function set tweenHide_bg(arg1:Object):void
        {
            this._tweenHide_bg = arg1;
            return;
        }

        public function get tweenShow_heading():Object
        {
            return this._tweenShow_heading;
        }

        public function set tweenShow_heading(arg1:Object):void
        {
            this._tweenShow_heading = arg1;
            return;
        }

        public function get tweenOver_heading():Object
        {
            return this._tweenOver_heading;
        }

        public function set tweenOver_heading(arg1:Object):void
        {
            this._tweenOver_heading = arg1;
            return;
        }

        public function get tweenHide_heading():Object
        {
            return this._tweenHide_heading;
        }

        public function set heading(arg1:Object):void
        {
            this._heading = arg1;
            return;
        }

        public function set tweenHide_heading(arg1:Object):void
        {
            this._tweenHide_heading = arg1;
            return;
        }

        public function get tweenShow_paragraph():Object
        {
            return this._tweenShow_paragraph;
        }

        public function set tweenShow_paragraph(arg1:Object):void
        {
            this._tweenShow_paragraph = arg1;
            return;
        }

        public function get tweenOver_paragraph():Object
        {
            return this._tweenOver_paragraph;
        }

        public function set tweenOver_paragraph(arg1:Object):void
        {
            this._tweenOver_paragraph = arg1;
            return;
        }

        public function get tweenHide_paragraph():Object
        {
            return this._tweenHide_paragraph;
        }

        public function set tweenHide_paragraph(arg1:Object):void
        {
            this._tweenHide_paragraph = arg1;
            return;
        }

        public function get hideOnTransition():Boolean
        {
            return this._hideOnTransition;
        }

        public function set hideOnTransition(arg1:Boolean):void
        {
            this._hideOnTransition = arg1;
            return;
        }

        public function set bakeOnTransition(arg1:Boolean):void
        {
            this._bakeOnTransition = arg1;
            return;
        }

        public function get alignPos():String
        {
            return this._alignPos;
        }

        public function set alignPos(arg1:String):void
        {
            this._alignPos = arg1;
            return;
        }

        public function get alignTo():String
        {
            return this._alignTo;
        }

        public function set alignTo(arg1:String):void
        {
            this._alignTo = arg1;
            return;
        }

        public function get autoHideTime():Number
        {
            return this._autoHideTime;
        }

        public function set autoHideTime(arg1:Number):void
        {
            this._autoHideTime = arg1;
            return;
        }

        public function get autoHide():Boolean
        {
            return this._autoHide;
        }

        public function set autoHide(arg1:Boolean):void
        {
            this._autoHide = arg1;
            return;
        }

        public function refresh():void
        {
            this.getFromXML();
            return;
        }

        internal function getFromXML():void
        {
            var loc1:*=0;
            var loc2:*=null;
            var loc3:*=false;
            if (String(this._xml.@x) != "") 
            {
                this._x = Number(this._xml.@x);
            }
            if (String(this._xml.@y) != "") 
            {
                this._y = Number(this._xml.@y);
            }
            if (String(this._xml.@width) != "") 
            {
                this._width = Number(this._xml.@width);
            }
            if (String(this._xml.@height) != "") 
            {
                this._height = Number(this._xml.@height);
            }
            if (String(this._xml.hide_on_transition) == "false") 
            {
                this._hideOnTransition = false;
            }
            if (String(this._xml.auto_hide) == "true") 
            {
                this._autoHide = true;
            }
            if (String(this._xml.auto_hide.@time) != "") 
            {
                this._autoHideTime = Number(this._xml.auto_hide.@time);
            }
            if (String(this._xml.@align_to) != "") 
            {
                this._alignTo = String(this._xml.@align_to);
            }
            if (String(this._xml.@align_pos) != "") 
            {
                this._alignPos = String(this._xml.@align_pos);
            }
            if (String(this._xml.bake_on_transition) == "true") 
            {
                this._bakeOnTransition = true;
            }
            if (String(this._xml.background.@round_corners) != "") 
            {
                this._background.round_corners = String(this._xml.background.@round_corners);
            }
            loc2 = decodeURIComponent(String(this._xml.heading.@font));
            var loc4:*=flash.text.Font.enumerateFonts();
            var loc5:*=false;
            loc1 = 0;
            while (loc1 < loc4.length) 
            {
                if (loc2 == flash.text.Font(loc4[loc1]).fontName) 
                {
                    this._heading.font = loc2;
                    this._heading.embed_fonts = true;
                    loc5 = true;
                }
                ++loc1;
            }
            if (!loc5) 
            {
                this._heading.font = loc2;
                this._heading.embed_fonts = false;
            }
            loc2 = decodeURIComponent(String(this._xml.paragraph.@font));
            loc5 = false;
            loc1 = 0;
            while (loc1 < loc4.length) 
            {
                if (loc2 == flash.text.Font(loc4[loc1]).fontName) 
                {
                    this._paragraph.font = loc2;
                    this._paragraph.embed_fonts = true;
                    loc5 = true;
                }
                ++loc1;
            }
            if (!loc5) 
            {
                this._paragraph.font = loc2;
                this._paragraph.embed_fonts = false;
            }
            var loc6:*=XML(this._xml.heading).attributes();
            var loc7:*=XML(this._xml.paragraph).attributes();
            if (String(this._xml.heading.@x) == "") 
            {
                this._xml.heading.@x = this._heading.x;
            }
            else 
            {
                this._heading.x = Number(this._xml.heading.@x);
            }
            if (String(this._xml.heading.@y) == "") 
            {
                this._xml.heading.@y = this._heading.y;
            }
            else 
            {
                this._heading.y = Number(this._xml.heading.@y);
            }
            if (String(this._xml.heading.@width) == "") 
            {
                this._xml.heading.@width = this._heading.width;
            }
            else 
            {
                this._heading.width = Number(this._xml.heading.@width);
            }
            if (String(this._xml.heading.@height) == "") 
            {
                this._xml.heading.@width = this._heading.width;
            }
            else 
            {
                this._heading.height = Number(this._xml.heading.@height);
            }
            if (String(this._xml.heading.@text_bold) == "true") 
            {
                this._heading.text_bold = true;
            }
            if (String(this._xml.heading.@text_italic) == "true") 
            {
                this._heading.text_italic = true;
            }
            if (String(this._xml.heading.@text_color) != "") 
            {
                this._heading.text_color = parseInt(String(this._xml.heading.@text_color), 16);
            }
            if (String(this._xml.heading.@text_size) == "") 
            {
                this._xml.heading.@text_size = this._heading.text_size;
            }
            else 
            {
                this._heading.text_size = Number(this._xml.heading.@text_size);
            }
            if (String(this._xml.heading.@text_align) != "") 
            {
                this._heading.text_align = String(this._xml.heading.@text_align);
            }
            if (String(this._xml.heading.@margin) == "") 
            {
                this._xml.heading.@margin = this._heading.text_margin;
            }
            else 
            {
                this._heading.text_margin = String(this._xml.heading.@margin);
            }
            if (String(this._xml.heading.@text_leading) == "") 
            {
                this._xml.heading.@text_leading = this._heading.text_leading;
            }
            else 
            {
                this._heading.text_leading = Number(this._xml.heading.@text_leading);
            }
            if (String(this._xml.heading.@text_letterSpacing) == "") 
            {
                this._xml.heading.@text_letterSpacing = this._heading.text_letterSpacing;
            }
            else 
            {
                this._heading.text_letterSpacing = Number(this._xml.heading.@text_letterSpacing);
            }
            if (String(this._xml.paragraph.@x) != "") 
            {
                this._paragraph.x = Number(this._xml.paragraph.@x);
            }
            if (String(this._xml.paragraph.@y) != "") 
            {
                this._paragraph.y = Number(this._xml.paragraph.@y);
            }
            if (String(this._xml.paragraph.@width) != "") 
            {
                this._paragraph.width = Number(this._xml.paragraph.@width);
            }
            if (String(this._xml.paragraph.@height) != "") 
            {
                this._paragraph.height = Number(this._xml.paragraph.@height);
            }
            if (String(this._xml.paragraph.@text_bold) == "true") 
            {
                this._paragraph.text_bold = true;
            }
            if (String(this._xml.paragraph.@text_italic) == "true") 
            {
                this._paragraph.text_italic = true;
            }
            if (String(this._xml.paragraph.@text_size) == "") 
            {
                this._xml.paragraph.@text_size = this._paragraph.text_size;
            }
            else 
            {
                this._paragraph.text_size = String(this._xml.paragraph.@text_size);
            }
            if (String(this._xml.paragraph.@text_color) != "") 
            {
                this._paragraph.text_color = parseInt(String(this._xml.paragraph.@text_color), 16);
            }
            if (String(this._xml.paragraph.@text_align) != "") 
            {
                this._paragraph.text_align = String(this._xml.paragraph.@text_align);
            }
            if (String(this._xml.paragraph.@margin) == "") 
            {
                this._xml.paragraph.@margin = this._paragraph.text_margin;
            }
            else 
            {
                this._paragraph.text_margin = String(this._xml.paragraph.@margin);
            }
            if (String(this._xml.paragraph.@text_leading) == "") 
            {
                this._xml.paragraph.@text_leading = this._paragraph.text_leading;
            }
            else 
            {
                this._paragraph.text_leading = Number(this._xml.paragraph.@text_leading);
            }
            if (String(this._xml.paragraph.@text_letterSpacing) != "") 
            {
                this._paragraph.text_letterSpacing = Number(this._xml.paragraph.@text_letterSpacing);
            }
            loc1 = 0;
            while (loc1 < this._copyList.length) 
            {
                if (this._copyList[loc1] != "delay") 
                {
                    if (this._copyList[loc1] != "tint") 
                    {
                        if (this._copyList[loc1] != "ease") 
                        {
                            if (this._xml.background.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenShow_bg[this._copyList[loc1]] = Number(this._xml.background.tweenShow.attribute(this._copyList[loc1]));
                            }
                            if (this._xml.background.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenHide_bg[this._copyList[loc1]] = Number(this._xml.background.tweenHide.attribute(this._copyList[loc1]));
                            }
                            if (this._xml.background.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenOver_bg[this._copyList[loc1]] = Number(this._xml.background.tweenOver.attribute(this._copyList[loc1]));
                            }
                            if (this._xml.heading.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenShow_heading[this._copyList[loc1]] = Number(this._xml.heading.tweenShow.attribute(this._copyList[loc1]));
                            }
                            if (this._xml.heading.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenHide_heading[this._copyList[loc1]] = Number(this._xml.heading.tweenHide.attribute(this._copyList[loc1]));
                            }
                            if (this._xml.heading.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenOver_heading[this._copyList[loc1]] = Number(this._xml.heading.tweenOver.attribute(this._copyList[loc1]));
                            }
                            if (this._xml.paragraph.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenShow_paragraph[this._copyList[loc1]] = Number(this._xml.paragraph.tweenShow.attribute(this._copyList[loc1]));
                            }
                            if (this._xml.paragraph.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenHide_paragraph[this._copyList[loc1]] = Number(this._xml.paragraph.tweenHide.attribute(this._copyList[loc1]));
                            }
                            if (this._xml.paragraph.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenOver_paragraph[this._copyList[loc1]] = Number(this._xml.paragraph.tweenOver.attribute(this._copyList[loc1]));
                            }
                        }
                        else 
                        {
                            if (this._xml.background.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenShow_bg[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._xml.background.tweenShow.attribute(this._copyList[loc1])));
                            }
                            if (this._xml.background.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenHide_bg[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._xml.background.tweenHide.attribute(this._copyList[loc1])));
                            }
                            if (this._xml.background.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenOver_bg[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._xml.background.tweenOver.attribute(this._copyList[loc1])));
                            }
                            if (this._xml.heading.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenShow_heading[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._xml.heading.tweenShow.attribute(this._copyList[loc1])));
                            }
                            if (this._xml.heading.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenHide_heading[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._xml.heading.tweenHide.attribute(this._copyList[loc1])));
                            }
                            if (this._xml.heading.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenOver_heading[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._xml.heading.tweenOver.attribute(this._copyList[loc1])));
                            }
                            if (this._xml.paragraph.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenShow_paragraph[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._xml.paragraph.tweenShow.attribute(this._copyList[loc1])));
                            }
                            if (this._xml.paragraph.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenHide_paragraph[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._xml.paragraph.tweenHide.attribute(this._copyList[loc1])));
                            }
                            if (this._xml.paragraph.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                            {
                                this._tweenOver_paragraph[this._copyList[loc1]] = com.madebyplay.CU3ER.model.GlobalVars.getTweenFunction(String(this._xml.paragraph.tweenOver.attribute(this._copyList[loc1])));
                            }
                        }
                    }
                    else 
                    {
                        if (this._xml.background.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenShow_bg[this._copyList[loc1]] = parseInt(String(this._xml.background.tweenShow.attribute(this._copyList[loc1])), 16);
                        }
                        if (this._xml.background.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenHide_bg[this._copyList[loc1]] = parseInt(String(this._xml.background.tweenHide.attribute(this._copyList[loc1])), 16);
                        }
                        if (this._xml.background.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenOver_bg[this._copyList[loc1]] = parseInt(String(this._xml.background.tweenOver.attribute(this._copyList[loc1])), 16);
                        }
                        if (this._xml.heading.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenShow_heading[this._copyList[loc1]] = parseInt(String(this._xml.heading.tweenShow.attribute(this._copyList[loc1])), 16);
                        }
                        if (this._xml.heading.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenHide_heading[this._copyList[loc1]] = parseInt(String(this._xml.heading.tweenHide.attribute(this._copyList[loc1])), 16);
                        }
                        if (this._xml.heading.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenOver_heading[this._copyList[loc1]] = parseInt(String(this._xml.heading.tweenOver.attribute(this._copyList[loc1])), 16);
                        }
                        if (this._xml.paragraph.tweenShow.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenShow_paragraph[this._copyList[loc1]] = parseInt(String(this._xml.paragraph.tweenShow.attribute(this._copyList[loc1])), 16);
                        }
                        if (this._xml.paragraph.tweenHide.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenHide_paragraph[this._copyList[loc1]] = parseInt(String(this._xml.paragraph.tweenHide.attribute(this._copyList[loc1])), 16);
                        }
                        if (this._xml.paragraph.tweenOver.attribute(this._copyList[loc1]) != undefined) 
                        {
                            this._tweenOver_paragraph[this._copyList[loc1]] = parseInt(String(this._xml.paragraph.tweenOver.attribute(this._copyList[loc1])), 16);
                        }
                    }
                }
                else 
                {
                    if (this._xml.background.tweenShow.@delay != undefined) 
                    {
                        this._tweenShow_bg["delay"] = Number(this._xml.background.tweenShow.@delay);
                    }
                    if (this._xml.background.tweenHide.@delay != undefined) 
                    {
                        this._tweenHide_bg["delay"] = Number(this._xml.background.tweenHide.@delay);
                    }
                    if (this._xml.background.tweenOver.@delay != undefined) 
                    {
                        this._tweenOver_bg["delay"] = Number(this._xml.background.tweenOver.@delay);
                    }
                    if (this._xml.heading.tweenShow.@delay != undefined) 
                    {
                        this._tweenShow_heading["delay"] = Number(this._xml.heading.tweenShow.@delay);
                    }
                    if (this._xml.heading.tweenShow.@delay != undefined) 
                    {
                        this._tweenShow_heading["delay"] = Number(this._xml.heading.tweenShow.@delay);
                    }
                    if (this._xml.heading.tweenHide.@delay != undefined) 
                    {
                        this._tweenHide_heading["delay"] = Number(this._xml.heading.tweenHide.@delay);
                    }
                    if (this._xml.heading.tweenOver.@delay != undefined) 
                    {
                        this._tweenOver_heading["delay"] = Number(this._xml.heading.tweenOver.@delay);
                    }
                    if (this._xml.paragraph.tweenShow.@delay != undefined) 
                    {
                        this._tweenShow_paragraph["delay"] = Number(this._xml.paragraph.tweenShow.@delay);
                    }
                    if (this._xml.paragraph.tweenHide.@delay != undefined) 
                    {
                        this._tweenHide_paragraph["delay"] = Number(this._xml.paragraph.tweenHide.@delay);
                    }
                    if (this._xml.paragraph.tweenOver.@delay != undefined) 
                    {
                        this._tweenOver_paragraph["delay"] = Number(this._xml.paragraph.tweenOver.@delay);
                    }
                }
                loc1 = loc1 + 1;
            }
            this._tweenShow_bg_alpha = this._tweenShow_bg.alpha;
            this._tweenHide_bg_alpha = this._tweenHide_bg.alpha;
            this._tweenOver_bg_alpha = this._tweenOver_bg.alpha;
            if (this._alignPos.indexOf("C") > -1) 
            {
                this._tweenOver_bg.x = this._tweenOver_bg.x - (this._tweenOver_bg.scaleX - 1) * this._width / 2;
                this._tweenHide_bg.x = this._tweenHide_bg.x - (this._tweenHide_bg.scaleX - 1) * this._width / 2;
            }
            else if (this._alignPos.indexOf("R") > -1) 
            {
                this._tweenOver_bg.x = this._tweenOver_bg.x - (this._tweenOver_bg.scaleX - 1) * this._width;
                this._tweenHide_bg.x = this._tweenHide_bg.x - (this._tweenHide_bg.scaleX - 1) * this._width;
            }
            if (this._alignPos.indexOf("M") > -1) 
            {
                this._tweenOver_bg.y = this._tweenOver_bg.y - (this._tweenOver_bg.scaleY - 1) * this._height / 2;
                this._tweenHide_bg.y = this._tweenHide_bg.y - (this._tweenHide_bg.scaleY - 1) * this._height / 2;
            }
            else if (this._alignPos.indexOf("B") > -1) 
            {
                this._tweenOver_bg.y = this._tweenOver_bg.y - (this._tweenOver_bg.scaleY - 1) * this._height;
                this._tweenHide_bg.y = this._tweenHide_bg.y - (this._tweenHide_bg.scaleY - 1) * this._height;
            }
            this._setTweens();
            return;
        }

        public function _setTweens():void
        {
            this._xml.background.tweenShow.@alpha = this._tweenShow_bg_alpha;
            this._xml.background.tweenHide.@alpha = this._tweenHide_bg_alpha;
            this._xml.background.tweenOver.@alpha = this._tweenOver_bg_alpha;
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

        public function get x():Number
        {
            return this._x;
        }

        public function set x(arg1:Number):void
        {
            this._x = arg1;
            return;
        }

        public function get background():Object
        {
            return this._background;
        }

        public function set background(arg1:Object):void
        {
            this._background = arg1;
            return;
        }

        public function get heading():Object
        {
            return this._heading;
        }

        public function get bakeOnTransition():Boolean
        {
            return this._bakeOnTransition;
        }

        public function get paragraph():Object
        {
            return this._paragraph;
        }

        public function set paragraph(arg1:Object):void
        {
            this._paragraph = arg1;
            return;
        }

        public function get y():Number
        {
            return this._y;
        }

        public function set y(arg1:Number):void
        {
            this._y = arg1;
            return;
        }

        public function get width():Number
        {
            return this._width;
        }

        public function set width(arg1:Number):void
        {
            this._width = arg1;
            return;
        }

        public function get height():Number
        {
            return this._height;
        }

        public function set height(arg1:Number):void
        {
            this._height = arg1;
            return;
        }

        public function get tweenShow_bg():Object
        {
            return this._tweenShow_bg;
        }

        public function set tweenShow_bg(arg1:Object):void
        {
            this._tweenShow_bg = arg1;
            return;
        }

        public function get tweenOver_bg():Object
        {
            return this._tweenOver_bg;
        }

        internal var _xml:XML;

        internal var _x:Number=0;

        internal var _y:Number=0;

        internal var _width:Number=400;

        internal var _height:Number=100;

        internal var _alignPos:String="TL";

        internal var _alignTo:String="";

        internal var _autoHide:Boolean=false;

        internal var _hideOnTransition:Boolean=true;

        internal var _bakeOnTransition:Boolean=false;

        internal var _background:Object;

        internal var _heading:Object;

        internal var _paragraph:Object;

        internal var _tweenShow_bg:Object;

        internal var _tweenOver_bg:Object;

        internal var _tweenHide_bg:Object;

        internal var _tweenShow_heading:Object;

        internal var _tweenOver_heading:Object;

        internal var _tweenHide_heading:Object;

        internal var _tweenShow_paragraph:Object;

        internal var _tweenOver_paragraph:Object;

        internal var _tweenHide_paragraph:Object;

        internal var _tweenShow_bg_alpha:Number=0.85;

        internal var _tweenHide_bg_alpha:Number=0;

        internal var _tweenOver_bg_alpha:Number=1;

        internal var _copyList:Array;

        internal var _autoHideTime:Number=5;
    }
}
