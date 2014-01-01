/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.events.*;
    import com.ui.*;

    public final class TD extends DP {

        public var root:TN;
        public var dict:Object;
        public var root_xml:XML;
        public var copy_xml:XML;
        public var copy:TN;
        public var keyword:String = "";
        public var pattern:RegExp;

        public function TD(_arg1:Object){
            this.dict = {};
            super();
            if ((_arg1 is XML)){
                this.dict = {};
                this.root_xml = (_arg1 as XML);
                this.root = new TN(this, this.root_xml);
                this.init();
            };
            Main.addEventListener(UIEvent.ICONS_LOADED, this.iconsHandler);
        }
        private function iconsHandler(_arg1:SMPEvent):void{
            invalidate();
        }
        public function getIndices(_arg1:Boolean=true):Array{
            var _local4:TN;
            var _local2:Array = [];
            var _local3:int;
            while (_local3 < length) {
                _local4 = (getItemAt(_local3) as TN);
                if (_arg1){
                    if ((((_local4.node_type == CS.NODE_ITEM)) || (_local4.src))){
                        _local2.push(_local3);
                    };
                } else {
                    if ((((_local4.node_type == CS.NODE_LIST)) && (!(_local4.opened)))){
                        _local2.push(_local3);
                    };
                };
                _local3++;
            };
            return (_local2);
        }
        public function init():void{
            this.keyword = "";
            data = [];
            this.root.open();
            invalidate();
        }
        public function find(_arg1:String):void{
            if (_arg1 == this.keyword){
                return;
            };
            this.keyword = _arg1;
            this.pattern = new RegExp(this.keyword, "i");
            data = [];
            this.copy_xml = new XML(<list/>
            );
            var _local2:XML = this.search(this.root_xml);
            if (_local2){
                this.copy_xml = _local2;
            };
            this.copy = new TN(this, this.copy_xml, null, 0);
            this.copy.open();
            invalidate();
        }
        private function search(_arg1:XML):XML{
            var _local3:XML;
            var _local4:XML;
            var _local5:XML;
            var _local2:String = _arg1.@label;
            if (((_local2) && (!((_local2.search(this.pattern) == -1))))){
                return (_arg1);
            };
            if (_arg1.hasComplexContent()){
                _local3 = _arg1.copy();
                _local3.setChildren("");
                _local3.normalize();
                for each (_local4 in _arg1.children()) {
                    _local5 = this.search(_local4);
                    if (_local5){
                        _local3.appendChild(_local5);
                    };
                };
                if (_local3.children().length()){
                    _local3.@opened = "true";
                    return (_local3);
                };
            };
            return (null);
        }

    }
}
