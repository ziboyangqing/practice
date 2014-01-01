package com.madebyplay.CU3ER.view 
{
    import com.greensock.*;
    import com.madebyplay.CU3ER.controller.*;
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.CU3ER.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.stevensacks.utils.*;
    
    public class DescriptionView extends flash.display.MovieClip
    {
        public function DescriptionView(arg1:com.madebyplay.CU3ER.controller.Description, arg2:com.madebyplay.CU3ER.model.DescriptionData)
        {
            super();
            this._description = arg1;
            this._data = new com.madebyplay.CU3ER.model.DescriptionData(arg2.xml.copy());
            this._createFromData();
            this.mouseChildren = false;
            this.buttonMode = false;
            return;
        }

        internal function _createFromData():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            com.madebyplay.CU3ER.util.AlignXML.align(this, this._data.xml);
            this._roundedCorners = String(this._data.background.round_corners).split(",");
            this._bg = new flash.display.Shape();
            this._bg.graphics.beginFill(this._data.tweenHide_bg.tint);
            this._bg.graphics.drawRoundRectComplex(0, 0, this._data.width, this._data.height, this._roundedCorners[0], this._roundedCorners[1], this._roundedCorners[3], this._roundedCorners[2]);
            this._bg.graphics.endFill();
            this.addChild(this._bg);
            this._txtHeading = new flash.text.TextField();
            if (this._description.slide.data.descriptionHeading != null) 
            {
                loc1 = String(this._data.heading.text_margin).split(",");
                this._txtHeading.x = Math.round(Number(loc1[3]));
                this._txtHeading.y = Math.round(Number(loc1[0]));
                this._txtHeading.width = this._data.width - Number(loc1[1]) - Number(loc1[3]);
                this._txtHeading.height = this._data.heading.text_size;
                this._data.tweenShow_heading.x = this._data.tweenShow_bg.x + this._txtHeading.x;
                this._data.tweenShow_heading.y = this._data.tweenShow_bg.y + this._txtHeading.y;
                this._data.tweenOver_heading.x = this._data.tweenOver_bg.x + this._txtHeading.x;
                this._data.tweenOver_heading.y = this._data.tweenOver_bg.y + this._txtHeading.y;
                this._data.tweenHide_heading.x = this._data.tweenHide_bg.x + this._txtHeading.x;
                this._data.tweenHide_heading.y = this._data.tweenHide_bg.y + this._txtHeading.y;
                delete this._data.tweenShow_heading.width;
                delete this._data.tweenOver_heading.width;
                delete this._data.tweenHide_heading.width;
                delete this._data.tweenShow_heading.height;
                delete this._data.tweenOver_heading.height;
                delete this._data.tweenHide_heading.height;
                delete this._data.tweenShow_heading.scaleX;
                delete this._data.tweenOver_heading.scaleX;
                delete this._data.tweenHide_heading.scaleX;
                delete this._data.tweenShow_heading.scaleY;
                delete this._data.tweenOver_heading.scaleY;
                delete this._data.tweenHide_heading.scaleY;
                loc2 = new flash.text.TextFormat();
                loc2.font = this._data.heading.font;
                loc2.size = this._data.heading.text_size;
                loc2.bold = this._data.heading.text_bold;
                loc2.italic = this._data.heading.text_italic;
                loc2.align = this._data.heading.text_align;
                loc2.leading = this._data.heading.text_leading;
                loc2.letterSpacing = this._data.heading.text_letterSpacing;
                this._txtHeading.defaultTextFormat = loc2;
                this._txtHeading.embedFonts = this._data.heading.embed_fonts;
                this._txtHeading.textColor = this._data.heading.text_color;
                this._txtHeading.text = this._description.slide.data.descriptionHeading;
                this._txtHeading.wordWrap = true;
                this._txtHeading.selectable = false;
                this._txtHeading.autoSize = this._data.heading.text_align;
            }
            this.addChild(this._txtHeading);
            this._txtParagraph = new flash.text.TextField();
            if (this._description.slide.data.descriptionParagraph != null) 
            {
                loc3 = String(this._data.paragraph.text_margin).split(",");
                this._txtParagraph.x = Math.round(Number(loc3[3]));
                if (this._txtHeading.text == "") 
                {
                    this._txtParagraph.y = Math.round(Number(loc3[0]));
                }
                else 
                {
                    this._txtParagraph.y = Math.round(this._txtHeading.y + Number(loc1[2]) + Number(loc3[0]) + this._txtHeading.textHeight);
                }
                this._txtParagraph.width = this._data.width - Number(loc3[1]) - Number(loc3[3]);
                this._txtParagraph.height = this._data.height - this._txtParagraph.y - Number(loc3[2]);
                this._txtParagraph.height = this._data.height - this._txtParagraph.y - Number(loc3[2]);
                this._data.tweenShow_paragraph.x = this._data.tweenShow_bg.x + this._txtParagraph.x;
                this._data.tweenShow_paragraph.y = this._data.tweenShow_bg.y + this._txtParagraph.y;
                this._data.tweenOver_paragraph.x = this._data.tweenOver_bg.x + this._txtParagraph.x;
                this._data.tweenOver_paragraph.y = this._data.tweenOver_bg.y + this._txtParagraph.y;
                this._data.tweenHide_paragraph.x = this._data.tweenHide_bg.x + this._txtParagraph.x;
                this._data.tweenHide_paragraph.y = this._data.tweenHide_bg.y + this._txtParagraph.y;
                delete this._data.tweenShow_paragraph.width;
                delete this._data.tweenOver_paragraph.width;
                delete this._data.tweenHide_paragraph.width;
                delete this._data.tweenShow_paragraph.height;
                delete this._data.tweenOver_paragraph.height;
                delete this._data.tweenHide_paragraph.height;
                delete this._data.tweenShow_paragraph.scaleX;
                delete this._data.tweenOver_paragraph.scaleX;
                delete this._data.tweenHide_paragraph.scaleX;
                delete this._data.tweenShow_paragraph.scaleY;
                delete this._data.tweenOver_paragraph.scaleY;
                delete this._data.tweenHide_paragraph.scaleY;
                (loc4 = new flash.text.TextFormat()).font = this._data.paragraph.font;
                loc4.size = this._data.paragraph.text_size;
                loc4.bold = this._data.paragraph.text_bold;
                loc4.italic = this._data.paragraph.text_italic;
                loc4.color = this._data.paragraph.text_color;
                loc4.align = this._data.paragraph.text_align;
                loc4.leading = this._data.paragraph.text_leading;
                loc4.letterSpacing = this._data.paragraph.text_letterSpacing;
                this._txtParagraph.defaultTextFormat = loc4;
                this._txtParagraph.embedFonts = this._data.paragraph.embed_fonts;
                this._txtParagraph.text = this._description.slide.data.descriptionParagraph;
                this._txtParagraph.autoSize = this._data.paragraph.text_align;
                this._txtParagraph.wordWrap = true;
                this._txtParagraph.selectable = false;
            }
            this.addChild(this._txtParagraph);
            this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._data.tweenHide_bg);
            this._tweenHeading = com.greensock.TweenLite.to(this._txtHeading, 0, this._data.tweenHide_heading);
            if (this._description.player.data.bgTransparent && !this._data.heading.embed_fonts && "tint" in this._data.tweenHide_heading) 
            {
                this._txtHeading.textColor = this._data.tweenHide_heading.tint;
            }
            this._tweenParagraph = com.greensock.TweenLite.to(this._txtParagraph, 0, this._data.tweenHide_paragraph);
            if (this._description.player.data.bgTransparent && !this._data.paragraph.embed_fonts && "tint" in this._data.tweenHide_paragraph) 
            {
                this._txtParagraph.textColor = this._data.tweenHide_paragraph.tint;
            }
            this._bg.visible = true;
            this._txtHeading.visible = true;
            this._txtParagraph.visible = true;
            this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._data.tweenShow_bg);
            this._tweenHeading = com.greensock.TweenLite.to(this._txtHeading, 0, this._data.tweenShow_heading);
            if (this._description.player.data.bgTransparent && !this._data.heading.embed_fonts && "tint" in this._data.tweenShow_heading) 
            {
                this._txtHeading.textColor = this._data.tweenShow_heading.tint;
            }
            this._tweenParagraph = com.greensock.TweenLite.to(this._txtParagraph, 0, this._data.tweenShow_paragraph);
            if (this._description.player.data.bgTransparent && !this._data.paragraph.embed_fonts && "tint" in this._data.tweenShow_paragraph) 
            {
                this._txtParagraph.textColor = this._data.tweenShow_paragraph.tint;
            }
            this._bitmapData = new flash.display.BitmapData(this._data.width, this._data.height, true, 0);
            this._bitmapData.draw(this, null, null, null, null, true);
            this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._data.tweenHide_bg);
            this._tweenHeading = com.greensock.TweenLite.to(this._txtHeading, 0, this._data.tweenHide_heading);
            if (this._description.player.data.bgTransparent && !this._data.heading.embed_fonts && "tint" in this._data.tweenHide_heading) 
            {
                this._txtHeading.textColor = this._data.tweenHide_heading.tint;
            }
            this._tweenParagraph = com.greensock.TweenLite.to(this._txtParagraph, 0, this._data.tweenHide_paragraph);
            if (this._description.player.data.bgTransparent && !this._data.paragraph.embed_fonts && "tint" in this._data.tweenHide_paragraph) 
            {
                this._txtParagraph.textColor = this._data.tweenHide_paragraph.tint;
            }
            return;
        }

        public function showFast():void
        {
            this.addEventListener(flash.events.MouseEvent.ROLL_OVER, this._onRollOver, false, 0, true);
            this.addEventListener(flash.events.MouseEvent.ROLL_OUT, this._onRollOut, false, 0, true);
            if (this._description.slide.data.descriptionLink != "") 
            {
                this.buttonMode = true;
                this.addEventListener(flash.events.MouseEvent.MOUSE_UP, this._openLink, false, 0, true);
            }
            this._bg.visible = true;
            this._txtHeading.visible = true;
            this._txtParagraph.visible = true;
            this.mouseEnabled = true;
            this._onRollOutFast();
            return;
        }

        public function show():void
        {
            this.addEventListener(flash.events.MouseEvent.ROLL_OVER, this._onRollOver, false, 0, true);
            this.addEventListener(flash.events.MouseEvent.ROLL_OUT, this._onRollOut, false, 0, true);
            if (this._description.slide.data.descriptionLink != "") 
            {
                this.buttonMode = true;
                this.addEventListener(flash.events.MouseEvent.MOUSE_UP, this._openLink, false, 0, true);
            }
            com.madebyplay.CU3ER.util.AlignXML.align(this, this._data.xml);
            this._bg.visible = true;
            this._txtHeading.visible = true;
            this._txtParagraph.visible = true;
            this.mouseEnabled = true;
            this._onRollOut();
            return;
        }

        public function hideFast():void
        {
            this.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this._onRollOver);
            this.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this._onRollOut);
            if (this._description.slide.data.descriptionLink != "") 
            {
                this.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this._openLink);
            }
            this.killTweens();
            this.mouseEnabled = false;
            this.buttonMode = false;
            this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._data.tweenHide_bg);
            this._tweenHeading = com.greensock.TweenLite.to(this._txtHeading, 0, this._data.tweenHide_heading);
            if (this._description.player.data.bgTransparent && !this._data.heading.embed_fonts && "tint" in this._data.tweenHide_heading) 
            {
                this._txtHeading.textColor = this._data.tweenHide_heading.tint;
            }
            this._tweenParagraph = com.greensock.TweenLite.to(this._txtParagraph, 0, this._data.tweenHide_paragraph);
            if (this._description.player.data.bgTransparent && !this._data.paragraph.embed_fonts && "tint" in this._data.tweenHide_paragraph) 
            {
                this._txtParagraph.textColor = this._data.tweenHide_paragraph.tint;
            }
            return;
        }

        public function hide():void
        {
            this.removeEventListener(flash.events.MouseEvent.ROLL_OVER, this._onRollOver);
            this.removeEventListener(flash.events.MouseEvent.ROLL_OUT, this._onRollOut);
            if (this._description.slide.data.descriptionLink != "") 
            {
                this.removeEventListener(flash.events.MouseEvent.MOUSE_UP, this._openLink);
            }
            this.killTweens();
            this.mouseEnabled = false;
            this.buttonMode = false;
            this._tweenBg = com.greensock.TweenLite.to(this._bg, this._data.tweenHide_bg.time, this._data.tweenHide_bg);
            this._tweenHeading = com.greensock.TweenLite.to(this._txtHeading, this._data.tweenHide_heading.time, this._data.tweenHide_heading);
            if (this._description.player.data.bgTransparent && !this._data.heading.embed_fonts && "tint" in this._data.tweenHide_heading) 
            {
                this._txtHeading.textColor = this._data.tweenHide_heading.tint;
            }
            this._tweenParagraph = com.greensock.TweenLite.to(this._txtParagraph, this._data.tweenHide_paragraph.time, this._data.tweenHide_paragraph);
            if (this._description.player.data.bgTransparent && !this._data.paragraph.embed_fonts && "tint" in this._data.tweenHide_paragraph) 
            {
                this._txtParagraph.textColor = this._data.tweenHide_paragraph.tint;
            }
            return;
        }

        public function getHideTime():Number
        {
            return this._data.tweenHide_bg.time;
        }

        internal function _dispatchHide():void
        {
            return;
        }

        internal function _openLink(arg1:flash.events.MouseEvent):void
        {
            net.stevensacks.utils.Web.getURL(this._description.slide.data.descriptionLink, this._description.slide.data.descriptionLinkTarget);
            return;
        }

        internal function _onRollOut(arg1:flash.events.MouseEvent=null):void
        {
            if (this._tweenEnableMouse != null) 
            {
                this._tweenEnableMouse.kill();
            }
            this.killTweens();
            this._tweenBg = com.greensock.TweenLite.to(this._bg, this._data.tweenShow_bg.time, this._data.tweenShow_bg);
            this._tweenHeading = com.greensock.TweenLite.to(this._txtHeading, this._data.tweenShow_heading.time, this._data.tweenShow_heading);
            if (this._description.player.data.bgTransparent && !this._data.heading.embed_fonts && "tint" in this._data.tweenShow_heading) 
            {
                this._txtHeading.textColor = this._data.tweenShow_heading.tint;
            }
            this._tweenParagraph = com.greensock.TweenLite.to(this._txtParagraph, this._data.tweenShow_paragraph.time, this._data.tweenShow_paragraph);
            if (this._description.player.data.bgTransparent && !this._data.paragraph.embed_fonts && "tint" in this._data.tweenShow_paragraph) 
            {
                this._txtParagraph.textColor = this._data.tweenShow_paragraph.tint;
            }
            return;
        }

        public function killTweens():void
        {
            if (this._tweenBg != null) 
            {
                this._tweenBg.kill();
            }
            if (this._tweenHeading != null) 
            {
                this._tweenHeading.kill();
            }
            if (this._tweenParagraph != null) 
            {
                this._tweenParagraph.kill();
            }
            if (this._tweenDispatch != null) 
            {
                this._tweenDispatch.kill();
            }
            com.greensock.TweenLite.killTweensOf(this._bg);
            com.greensock.TweenLite.killTweensOf(this._txtParagraph);
            com.greensock.TweenLite.killTweensOf(this._txtHeading);
            return;
        }

        internal function _onRollOutFast(arg1:flash.events.MouseEvent=null):void
        {
            this._inAnim = false;
            this.killTweens();
            this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._data.tweenShow_bg);
            this._tweenHeading = com.greensock.TweenLite.to(this._txtHeading, 0, this._data.tweenShow_heading);
            if (this._description.player.data.bgTransparent && !this._data.heading.embed_fonts && "tint" in this._data.tweenShow_heading) 
            {
                this._txtHeading.textColor = this._data.tweenShow_heading.tint;
            }
            this._tweenParagraph = com.greensock.TweenLite.to(this._txtParagraph, 0, this._data.tweenShow_paragraph);
            if (this._description.player.data.bgTransparent && !this._data.paragraph.embed_fonts && "tint" in this._data.tweenShow_paragraph) 
            {
                this._txtParagraph.textColor = this._data.tweenShow_paragraph.tint;
            }
            return;
        }

        internal function _onRollOver(arg1:flash.events.MouseEvent):void
        {
            if (this._tweenEnableMouse != null) 
            {
                this._tweenEnableMouse.kill();
            }
            this.killTweens();
            this._tweenBg = com.greensock.TweenLite.to(this._bg, this._data.tweenOver_bg.time, this._data.tweenOver_bg);
            this._tweenHeading = com.greensock.TweenLite.to(this._txtHeading, this._data.tweenOver_heading.time, this._data.tweenOver_heading);
            if (this._description.player.data.bgTransparent && !this._data.heading.embed_fonts && "tint" in this._data.tweenOver_heading) 
            {
                this._txtHeading.textColor = this._data.tweenOver_heading.tint;
            }
            this._tweenParagraph = com.greensock.TweenLite.to(this._txtParagraph, this._data.tweenOver_paragraph.time, this._data.tweenOver_paragraph);
            if (this._description.player.data.bgTransparent && !this._data.paragraph.embed_fonts && "tint" in this._data.tweenOver_paragraph) 
            {
                this._txtParagraph.textColor = this._data.tweenOver_paragraph.tint;
            }
            this._inAnim = true;
            this._tweenEnableMouse = com.greensock.TweenLite.delayedCall(Math.max(this._data.tweenOver_bg.time, Math.max(this._data.tweenOver_heading.time, this._data.tweenOver_paragraph.time)), this._onAnimFinish);
            return;
        }

        internal function _onAnimFinish():void
        {
            this._inAnim = false;
            return;
        }

        internal function _onRollOverFast(arg1:flash.events.MouseEvent):void
        {
            this._inAnim = false;
            this.killTweens();
            this._tweenBg = com.greensock.TweenLite.to(this._bg, 0, this._data.tweenOver_bg);
            this._tweenHeading = com.greensock.TweenLite.to(this._txtHeading, 0, this._data.tweenOver_heading);
            if (this._description.player.data.bgTransparent && !this._data.heading.embed_fonts && "tint" in this._data.tweenOver_heading) 
            {
                this._txtHeading.textColor = this._data.tweenOver_heading.tint;
            }
            this._tweenParagraph = com.greensock.TweenLite.to(this._txtParagraph, 0, this._data.tweenOver_paragraph);
            if (this._description.player.data.bgTransparent && !this._data.paragraph.embed_fonts && "tint" in this._data.tweenOver_paragraph) 
            {
                this._txtParagraph.textColor = this._data.tweenOver_paragraph.tint;
            }
            return;
        }

        public function update():void
        {
            return;
        }

        public function get bitmapData():flash.display.BitmapData
        {
            return this._bitmapData;
        }

        internal var _data:com.madebyplay.CU3ER.model.DescriptionData;

        internal var _bitmapData:flash.display.BitmapData;

        internal var _description:com.madebyplay.CU3ER.controller.Description;

        internal var _roundedCorners:Array;

        internal var _bg:flash.display.Shape;

        internal var _txtHeading:flash.text.TextField;

        internal var _txtParagraph:flash.text.TextField;

        internal var _tweenBg:com.greensock.TweenLite;

        internal var _tweenHeading:com.greensock.TweenLite;

        internal var _tweenParagraph:com.greensock.TweenLite;

        internal var _tweenDispatch:com.greensock.TweenLite;

        internal var _tweenEnableMouse:com.greensock.TweenLite;

        internal var _inAnim:Boolean=false;
    }
}
