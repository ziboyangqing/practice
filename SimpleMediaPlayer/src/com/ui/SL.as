/*SimpleMediaPlayer*/
package com.ui {
    import com.smp.events.DATACHGEvent;
    import com.smp.events.DATACHGType;
    import com.smp.events.ListEvent;
    import com.smp.events.ScrollEvent;
    
    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.utils.Dictionary;
    import interfaces.ICR;
    import interfaces.IT;

    public class SL extends BaseScrollPanel {

        private static var defaultStyles:Object = {
            skin:null,
            cr:CR,
            contentPadding:null
        };
        public static var createAccessibilityImplementation:Function;

        protected var listHolder:Sprite;
        protected var list:Sprite;
        protected var _dp:DP;
        protected var activeCRs:Array;
        protected var availableCRs:Array;
        protected var renderedItems:Dictionary;
        protected var invalidItems:Dictionary;
        protected var _verticalScrollPosition:Number;
        protected var _selectable:Boolean = true;
        protected var _selectedIndices:Array;
        protected var caretIndex:int = -1;
        protected var lastCaretIndex:int = -1;
        protected var preChangeItems:Array;
        protected var rendererStyles:Object;
        protected var updatedRendererStyles:Object;

        public function SL(){
            this.activeCRs = [];
            this.availableCRs = [];
            this.invalidItems = new Dictionary(true);
            this.renderedItems = new Dictionary(true);
            this._selectedIndices = [];
            if (this.dp == null){
                this.dp = new DP();
            };
            this.rendererStyles = {};
            this.updatedRendererStyles = {};
        }
        public static function getStyleDefinition():Object{
            return (mergeStyles(defaultStyles, BaseScrollPanel.getStyleDefinition()));
        }

        override public function set enabled(_arg1:Boolean):void{
            super.enabled = _arg1;
            this.list.mouseChildren = _enabled;
        }
        public function get dp():DP{
            return (this._dp);
        }
        public function set dp(_arg1:DP):void{
            if (this._dp != null){
                this._dp.removeEventListener(DATACHGEvent.DATA_CHANGE, this.handleDataChange);
                this._dp.removeEventListener(DATACHGEvent.PRE_DATA_CHANGE, this.onPreChange);
            };
            this._dp = _arg1;
            this._dp.addEventListener(DATACHGEvent.DATA_CHANGE, this.handleDataChange, false, 0, true);
            this._dp.addEventListener(DATACHGEvent.PRE_DATA_CHANGE, this.onPreChange, false, 0, true);
            this.clearSelection();
            this.invalidateList();
        }
        public function get length():uint{
            return (this._dp.length);
        }
        public function get selectedIndex():int{
            return (((this._selectedIndices.length)==0) ? -1 : this._selectedIndices[(this._selectedIndices.length - 1)]);
        }
        public function set selectedIndex(_arg1:int):void{
            this.selectedIndices = ((_arg1)==-1) ? null : [_arg1];
        }
        public function get selectedIndices():Array{
            return (this._selectedIndices.concat());
        }
        public function set selectedIndices(_arg1:Array):void{
            if (!this._selectable){
                return;
            };
            this._selectedIndices = ((_arg1)==null) ? [] : _arg1.concat();
            invalidate(IT.SELECTED);
        }
        public function get selectedItem():Object{
            return (((this._selectedIndices.length)==0) ? null : this._dp.getItemAt(this.selectedIndex));
        }
        public function set selectedItem(_arg1:Object):void{
            var _local2:int = this._dp.getItemIndex(_arg1);
            this.selectedIndex = _local2;
        }
        public function get selectedItems():Array{
            var _local1:Array = [];
            var _local2:uint;
            while (_local2 < this._selectedIndices.length) {
                _local1.push(this._dp.getItemAt(this._selectedIndices[_local2]));
                _local2++;
            };
            return (_local1);
        }
        public function set selectedItems(_arg1:Array):void{
            var _local4:int;
            if (_arg1 == null){
                this.selectedIndices = null;
                return;
            };
            var _local2:Array = [];
            var _local3:uint;
            while (_local3 < _arg1.length) {
                _local4 = this._dp.getItemIndex(_arg1[_local3]);
                if (_local4 != -1){
                    _local2.push(_local4);
                };
                _local3++;
            };
            this.selectedIndices = _local2;
        }
        public function get rowCount():uint{
            return (0);
        }
        public function clearSelection():void{
            this.selectedIndex = -1;
        }
        public function itemToCR(_arg1:Object):ICR{
            var _local2:*;
            var _local3:ICR;
            if (_arg1 != null){
                for (_local2 in this.activeCRs) {
                    _local3 = (this.activeCRs[_local2] as ICR);
                    if (_local3.data == _arg1){
                        return (_local3);
                    };
                };
            };
            return (null);
        }
        public function addItem(_arg1:Object):void{
            this._dp.addItem(_arg1);
            this.invalidateList();
        }
        public function addItemAt(_arg1:Object, _arg2:uint):void{
            this._dp.addItemAt(_arg1, _arg2);
            this.invalidateList();
        }
        public function removeAll():void{
            this._dp.removeAll();
        }
        public function getItemAt(_arg1:uint):Object{
            return (this._dp.getItemAt(_arg1));
        }
        public function removeItem(_arg1:Object):Object{
            return (this._dp.removeItem(_arg1));
        }
        public function removeItemAt(_arg1:uint):Object{
            return (this._dp.removeItemAt(_arg1));
        }
        public function invalidateList():void{
            this._invalidateList();
            invalidate(IT.DATA);
        }
        public function invalidateItem(_arg1:Object):void{
            if (this.renderedItems[_arg1] == null){
                return;
            };
            this.invalidItems[_arg1] = true;
            invalidate(IT.DATA);
        }
        public function invalidateItemAt(_arg1:uint):void{
            var _local2:Object = this._dp.getItemAt(_arg1);
            if (_local2 != null){
                this.invalidateItem(_local2);
            };
        }
        public function sortItems(... _args):Array{
            return (this._dp.sort.apply(this._dp, _args));
        }
        public function sortItemsOn(_arg1:String, _arg2:Object=null):Array{
            return (this._dp.sortOn(_arg1, _arg2));
        }
        public function isItemSelected(_arg1:Object):Boolean{
            return ((this.selectedItems.indexOf(_arg1) > -1));
        }
        public function scrollToSelected():void{
            this.scrollToIndex(this.selectedIndex);
        }
        public function scrollToIndex(_arg1:int):void{
        }
        public function getNextIndexAtLetter(_arg1:String, _arg2:int=-1):int{
            var _local5:Number;
            var _local6:Object;
            var _local7:String;
            if (this.length == 0){
                return (-1);
            };
            _arg1 = _arg1.toUpperCase();
            var _local3:int = (this.length - 1);
            var _local4:Number = 0;
            while (_local4 < _local3) {
                _local5 = ((_arg2 + 1) + _local4);
                if (_local5 > (this.length - 1)){
                    _local5 = (_local5 - this.length);
                };
                _local6 = this.getItemAt(_local5);
                if (_local6 == null){
                    break;
                };
                _local7 = this.itemToLabel(_local6);
                if (_local7 == null){
                } else {
                    if (_local7.charAt(0).toUpperCase() == _arg1){
                        return (_local5);
                    };
                };
                _local4++;
            };
            return (-1);
        }
        public function itemToLabel(_arg1:Object):String{
            return (_arg1["label"]);
        }
        public function setRendererStyle(_arg1:String, _arg2:Object, _arg3:uint=0):void{
            if (this.rendererStyles[_arg1] == _arg2){
                return;
            };
            this.updatedRendererStyles[_arg1] = _arg2;
            this.rendererStyles[_arg1] = _arg2;
            invalidate(IT.RENDERER_STYLES);
        }
        public function getRendererStyle(_arg1:String, _arg2:int=-1):Object{
            return (this.rendererStyles[_arg1]);
        }
        public function clearRendererStyle(_arg1:String, _arg2:int=-1):void{
            delete this.rendererStyles[_arg1];
            this.updatedRendererStyles[_arg1] = null;
            invalidate(IT.RENDERER_STYLES);
        }
        override protected function configUI():void{
            super.configUI();
            this.listHolder = new Sprite();
            addChild(this.listHolder);
            this.listHolder.scrollRect = contentScrollRect;
            this.list = new Sprite();
            this.listHolder.addChild(this.list);
        }
        protected function _invalidateList():void{
            this.availableCRs = [];
            while (this.activeCRs.length > 0) {
                this.list.removeChild((this.activeCRs.pop() as DisplayObject));
            };
        }
        protected function handleDataChange(_arg1:DATACHGEvent):void{
            var _local5:uint;
            var _local2:int = _arg1.startIndex;
            var _local3:int = _arg1.endIndex;
            var _local4:String = _arg1.changeType;
            if (_local4 == DATACHGType.INVALIDATE_ALL){
                this.clearSelection();
                this.invalidateList();
            } else {
                if (_local4 == DATACHGType.INVALIDATE){
                    _local5 = 0;
                    while (_local5 < _arg1.items.length) {
                        this.invalidateItem(_arg1.items[_local5]);
                        _local5++;
                    };
                } else {
                    if (_local4 == DATACHGType.ADD){
                        _local5 = 0;
                        while (_local5 < this._selectedIndices.length) {
                            if (this._selectedIndices[_local5] >= _local2){
                                this._selectedIndices[_local5] = (this._selectedIndices[_local5] + (_local2 - _local3));
                            };
                            _local5++;
                        };
                    } else {
                        if (_local4 == DATACHGType.REMOVE){
                            _local5 = 0;
                            while (_local5 < this._selectedIndices.length) {
                                if (this._selectedIndices[_local5] >= _local2){
                                    if (this._selectedIndices[_local5] <= _local3){
                                        delete this._selectedIndices[_local5];
                                    } else {
                                        this._selectedIndices[_local5] = (this._selectedIndices[_local5] - ((_local2 - _local3) + 1));
                                    };
                                };
                                _local5++;
                            };
                        } else {
                            if (_local4 == DATACHGType.REMOVE_ALL){
                                this.clearSelection();
                            } else {
                                if (_local4 == DATACHGType.REPLACE){
                                } else {
                                    this.selectedItems = this.preChangeItems;
                                    this.preChangeItems = null;
                                };
                            };
                        };
                    };
                };
            };
            invalidate(IT.DATA);
        }
        protected function handleCRMouseEvent(_arg1:MouseEvent):void{
            var _local2:ICR = (_arg1.target as ICR);
            var _local3:String = ((_arg1.type)==MouseEvent.ROLL_OVER) ? ListEvent.ITEM_ROLL_OVER : ListEvent.ITEM_ROLL_OUT;
            dispatchEvent(new ListEvent(_local3, false, false, _local2.lsd.column, _local2.lsd.row, _local2.lsd.index, _local2.data));
        }
        protected function handleCRClick(_arg1:MouseEvent):void{
            var _local5:int;
            if (!_enabled){
                return;
            };
            var _local2:ICR = (_arg1.currentTarget as ICR);
            var _local3:uint = _local2.lsd.index;
            if (((!(dispatchEvent(new ListEvent(ListEvent.ITEM_CLICK, false, true, _local2.lsd.column, _local2.lsd.row, _local3, _local2.data)))) || (!(this._selectable)))){
                return;
            };
            var _local4:int = this.selectedIndices.indexOf(_local3);
            if (_local4 != -1){
                return;
            };
            _local2.selected = true;
            this._selectedIndices = [_local3];
            this.lastCaretIndex = (this.caretIndex = _local3);
            dispatchEvent(new Event(Event.CHANGE));
            invalidate(IT.DATA);
        }
        protected function handleCRChange(_arg1:Event):void{
            var _local2:ICR = (_arg1.currentTarget as ICR);
            var _local3:uint = _local2.lsd.index;
            this._dp.invalidateItemAt(_local3);
        }
        protected function handleCRDoubleClick(_arg1:MouseEvent):void{
            if (!_enabled){
                return;
            };
            var _local2:ICR = (_arg1.currentTarget as ICR);
            var _local3:uint = _local2.lsd.index;
            dispatchEvent(new ListEvent(ListEvent.ITEM_DOUBLE_CLICK, false, true, _local2.lsd.column, _local2.lsd.row, _local3, _local2.data));
        }
        override protected function setVerticalScrollPosition(_arg1:Number, _arg2:Boolean=false):void{
            if (_arg1 == this._verticalScrollPosition){
                return;
            };
            var _local3:Number = (_arg1 - this._verticalScrollPosition);
            this._verticalScrollPosition = _arg1;
            if (_arg2){
                dispatchEvent(new ScrollEvent(_local3, _arg1));
            };
        }
        override protected function draw():void{
            super.draw();
        }
        override protected function drawLayout():void{
            super.drawLayout();
            contentScrollRect = this.listHolder.scrollRect;
            contentScrollRect.width = availableWidth;
            contentScrollRect.height = availableHeight;
            this.listHolder.scrollRect = contentScrollRect;
        }
        protected function updateRendererStyles():void{
            var _local4:String;
            var _local1:Array = this.availableCRs.concat(this.activeCRs);
            var _local2:uint = _local1.length;
            var _local3:uint;
            while (_local3 < _local2) {
                if (_local1[_local3].setStyle == null){
                } else {
                    for (_local4 in this.updatedRendererStyles) {
                        _local1[_local3].setStyle(_local4, this.updatedRendererStyles[_local4]);
                    };
                    _local1[_local3].drawNow();
                };
                _local3++;
            };
            this.updatedRendererStyles = {};
        }
        protected function drawList():void{
        }
        override protected function initializeAccessibility():void{
            if (SL.createAccessibilityImplementation != null){
                SL.createAccessibilityImplementation(this);
            };
        }
        protected function onPreChange(_arg1:DATACHGEvent):void{
            switch (_arg1.changeType){
                case DATACHGType.REMOVE:
                case DATACHGType.ADD:
                case DATACHGType.INVALIDATE:
                case DATACHGType.REMOVE_ALL:
                case DATACHGType.REPLACE:
                case DATACHGType.INVALIDATE_ALL:
                    break;
                default:
                    this.preChangeItems = this.selectedItems;
            };
        }

    }
}
