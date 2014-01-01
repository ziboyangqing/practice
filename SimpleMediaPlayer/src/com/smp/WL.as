/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.events.*;
    //import flash.display.*;
    import flash.text.*;
    //import flash.ui.*;

    public final class WL extends W {

        public var tree:TR;
        public var search:T;
        public var dv:String;

        public function WL():void{
            Main.tr = (this.tree = new TR());
            main.addChild(this.tree);
            this.search = new T(TextFieldType.INPUT);
            main.addChild(this.search);
            this.search.text.addEventListener(Event.CHANGE, this.changeHandler);
            this.search.text.addEventListener(FocusEvent.FOCUS_IN, this.focusInHandler);
            this.search.text.addEventListener(FocusEvent.FOCUS_OUT, this.focusOutHandler);
        }
        public function changeHandler(_arg1:Event):void{
            var _local2:String = this.search.text.text;
            this.search.setFormat();
            if (_local2){
                this.tree.find(_local2);
            } else {
                this.tree.init();
            };
        }
        public function focusInHandler(_arg1:FocusEvent=null):void{
            this.search.setFormat();
            if (this.search.text.text == this.dv){
                this.search.text.text = "";
            };
        }
        public function focusOutHandler(_arg1:FocusEvent=null):void{
            if (this.search.text.text == ""){
                this.search.text.text = this.dv;
                this.search.setFormat(false);
            };
        }
        override protected function skinHandler(_arg1:SMPEvent):void{
            var _local2:XMLList = Main.sk.skin_xml.list;
            ss(_local2, 0, 0);
            this.tree.ss(_local2.tree, tw, th);
            this.search.ss(_local2.search, tw, th);
            this.focusInHandler();
            this.dv = _local2.search.@value;
            if (!this.dv){
                this.dv = "";
            };
            this.focusOutHandler();
            Scrollbar.ss(this.tree, _local2.scrollbar);
            IC.ss(_local2.icons);
        }
        override protected function closeHandler(_arg1:MouseEvent):void{
            Main.sendEvent(SMPEvent.VIEW_LIST);
        }
        override protected function ws():void{
            this.tree.ll(tw, th);
            this.search.ll(tw, th);
        }

    }
}
