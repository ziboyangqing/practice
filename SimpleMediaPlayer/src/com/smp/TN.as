/*SimpleMediaPlayer*/
package com.smp {
    import com.smp.events.*;
    import flash.utils.*;
    import flash.events.*;
    import com.utils.AppUtil;

    public dynamic class TN extends EventDispatcher {

        public var tc:TC;
        public var td:TD;
        public var parent:TN;
        public var children:Array;
        private var _label:String;
        private var _loading:Boolean;
        private var _listing:String;
        public var index:int;
        public var level:Number;
        public var opened:Boolean;
        public var deleted:Boolean;
        public var node_type:String;
        public var position:Number = 0;
        public var duration:Number = 0;
        public var tag:String;
        public var label:String;
        public var list_src:String;
        public var seekable:Boolean = true;
        public var type:String;
        public var stream:Boolean = false;
        public var start_seconds:Number = 0;
        public var start_bytes:Number = 0;
        public var bytes:Number = 0;
        public var rtmp:String;
        public var url:String;
        public var src:String;
        public var bak:String;
        public var lrc:String;
        public var rotation:Number = 0;
        public var scalemode:Number;
        public var image:String;
        public var text:String;
        public var bg_video:String;
        public var bg_lrc:String;
        public var xywh:String;
        public var error:int = 0;
        public var message:String;
        public var reload:Boolean = false;
        public var data:Boolean = false;
        public var meta:Object;
        public var key:String;
        public var xml:XML;

        public function TN(_arg1:TD, _arg2:XML, _arg3:TN=null, _arg4:int=0, _arg5:int=0):void{
            var _local7:XML;
            this.children = [];
            super();
            this.td = _arg1;
            this.xml = _arg2;
			this.parent = _arg3;
            this.level = _arg4;
            this.index = _arg5;
            this.tag = this.xml.localName();
            var _local6:XMLList = this.xml.attributes();
           
            for each (_local7 in _local6) {
                this[_local7.localName()] = AppUtil.parse(_local7.toString());
				 //trace(this[_local7.localName()],"00000000000000");
            };
            this.getChildren();
            if (!this.label){
                this.xml.@label = (this.label = ((this.src) || (this.tag)));
            };
            this.label = AppUtil.auto(AppUtil.rn(this.label), Config);
            this.key = ("ITEM" + this.getPath(this));
            this.td.dict[this.key] = this;
        }
        public function getChildren():void{
            var _local1:int;
            var _local2:XML;
            var _local3:TN;
            if (this.xml.hasComplexContent()){
                this.node_type = CS.NODE_LIST;
                _local1 = 0;
                for each (_local2 in this.xml.children()) {
                    _local3 = new TN(this.td, _local2, this, (this.level + 1), _local1);
                    this.children.push(_local3);
                    _local1++;
                };
            } else {
                this.list_src = this.xml.@list_src;
				if (this.list_src){
                    this.node_type = CS.NODE_LIST;
                    this.opened = false;
                } else {
                    this.node_type = CS.NODE_ITEM;
                    if (((!(this.label)) && (this.xml.text()))){
                        this.label = this.xml.text();
                    };
                };
            };
        }
        public function getPath(_arg1:TN):String{
            if (_arg1.parent){
                return (((this.getPath(_arg1.parent) + "_") + _arg1.index));
            };
            return ("");
        }
        public function clone(_arg1:Boolean=false):Object{
            var _local3:String;
            var _local4:TN;
            var _local2:Object = AppUtil.meta(this);
            for each (_local3 in SList.vars) {
                if (this[_local3] != undefined){
                    _local2[_local3] = this[_local3];
                };
            };
            _local2.url = this.url;
            if (this.parent){
                _local2.parent = this.parent.clone();
            };
            if (_arg1){
                _local2.children = [];
                if (this.children.length){
                    for each (_local4 in this.children) {
                        if (_local4.deleted){
                        } else {
                            _local2.children.push(_local4.clone(_arg1));
                        };
                    };
                };
            };
            return (_local2);
        }
        public function loadChildren():void{
            if (this._loading){
                return;
            };
            this._loading = true;
            this._label = this.label;
            this._listing = Main.info.queryMessage("view_listing");
            this.label = this._listing;
            this.showLabel(this.label);
            var _local1:String = AppUtil.auto(this.list_src, Config);
			//trace(_local1,"-------------");
            //_local1 = CMP.fU(_local1, true);
            //trace(_local1,"=============");
			new SURLLodader(_local1, this.lsE, this.lsP, this.lsL);
        }
        private function lsP(_arg1:uint, _arg2:uint):void{
            if (_arg2){
                this.label = (((this._listing + " ") + Math.round(((100 * _arg1) / _arg2))) + "%");
                this.showLabel(this.label);
            };
        }
        private function lsE(_arg1:String):void{
            this._loading = false;
            this.label = this._label;
            this.error++;
            this.message = _arg1;
            this.lsD();
        }
        private function lsL(_arg1:ByteArray):void{
            var _local2:Array;
            var _local3:int;
            if (_arg1){
                _local2 = Zip.extract(_arg1);
                if (_arg1 == _local2[0]){
                    this.xml.appendChild(SList.celh(_arg1));
                } else {
                    _local3 = 0;
                    while (_local3 < _local2.length) {
                        _arg1 = AppUtil.bom(_local2[_local3]);
                        this.xml.appendChild(SList.celh(_arg1));
                        _local3++;
                    };
                };
                this.getChildren();
                if (this.children.length){
                    this._loading = false;
                    this.label = this._label;
                    this.error = 0;
                    this.message = "";
                    this.open();
                    this.lsD();
                    return;
                };
            };
            this.lsE("Invalid xml format");
        }
        private function lsD():void{
            this.td.invalidate();
            this.sendEvent(SMPEvent.ITEM_LOADED, this.clone(true));
        }
        public function showLabel(_arg1:String):void{
            if (this.tc){
                if (this.tc.tn == this){
                    this.tc.label = _arg1;
                };
            };
        }
        public function play():void{
            var _local1:int = this.td.getItemIndex(this);
            if ((((((_local1 == -1)) && (this.parent))) && (!((this.parent.key == "ITEM"))))){
                this.parent.open();
            };
            _local1 = this.td.getItemIndex(this);
            Main.sendEvent(SMPEvent.VIEW_PLAY, (_local1 + 1));
        }
        public function open():void{
            if (this.node_type == CS.NODE_LIST){
                if (this.children.length){
                    this.opened = true;
                    this.xml.@opened = true;
					this.show();
                    this.sendEvent(SMPEvent.ITEM_OPENED, this.clone(true));
                } else {
                    this.loadChildren();
                };
            };
        }
        public function close():void{
            if (this.node_type == CS.NODE_LIST){
                this.opened = false;
                this.xml.@opened = false;
                this.hide();
                this.sendEvent(SMPEvent.ITEM_CLOSED, this.clone(true));
            };
        }
        public function toggle():void{
            if (this.opened){
                this.close();
            } else {
                this.open();
            };
        }
        public function show():int{
            var _local4:TN;
            var _local1:int = this.td.getItemIndex(this);
            if ((((((_local1 == -1)) && (this.parent))) && (!((this.parent.key == "ITEM"))))){
                this.parent.open();
                return (0);
            };
            var _local2:int;
            var _local3:int;
            while (_local3 < this.children.length) {
                _local4 = this.children[_local3];
				
                if (_local4.deleted){
                } else {
                    _local2 = (_local2 + 1);
                    this.td.addItemAt(_local4, (_local1 + _local2));
                    if (_local4.opened){
                        _local2 = (_local2 + _local4.show());
                    };
                };
                _local3++;
            };
            return (_local2);
        }
        public function hide(_arg1:Boolean=false):void{
            var _local2:TN;
            for each (_local2 in this.children) {
                _local2.hide(_arg1);
                this.td.removeItem(_local2);
                this.stop(_arg1, _local2);
            };
        }
        public function remove():void{
            var item:* = null;
            var xl:* = null;
            var i:* = 0;
            item = this.clone(true);
            this.hide(true);
            this.td.removeItem(this);
            this.stop(true, this);
            this.deleted = true;
            this.children = [];
            this.xml.@deleted = true;
            this.td.dict[this.key] = null;
            xl = Main.lst.list_xml..*.((hasOwnProperty("@deleted")) && ((@deleted == "true")));
            while (xl.length()) {
                delete xl[0];
            };
            if (this.parent){
                i = this.parent.children.indexOf(this);
                this.parent.children.splice(i, 1);
            };
            this.sendEvent(SMPEvent.ITEM_DELETED, item);
        }
        private function stop(_arg1:Boolean, _arg2:TN):void{
            if (((((_arg1) && (!((Config.state == SMPStates.STOPPED))))) && (Main.item))){
                if ((((_arg2 == Main.item)) || ((_arg2.xml == Main.item.xml)))){
                    Main.sendEvent(SMPEvent.VIEW_STOP);
                };
            };
        }
        public function sendEvent(_arg1:String, _arg2:Object):void{
            if (this.key == "ITEM"){
                return;
            };
            dispatchEvent(new SMPEvent(_arg1, this));
            Main.sendEvent(_arg1, _arg2);
        }

    }
}
