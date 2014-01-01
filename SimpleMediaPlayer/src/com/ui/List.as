/*SimpleMediaPlayer*/
package com.ui {
    import flash.display.DisplayObject;
    import flash.display.InteractiveObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.ui.Keyboard;
    import flash.utils.Dictionary;
    import interfaces.ICR;
    import interfaces.IT;

    public class List extends SL {

        private static var defaultStyles:Object = {};
        public static var createAccessibilityImplementation:Function;

        protected var _rowHeight:Number = 20;
        protected var _cr:Object;

        public function List(){
            addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, this.focusHandler);
            addEventListener(MouseEvent.MOUSE_OVER, this.focusHandler);
        }
        public static function getStyleDefinition():Object{
            return (mergeStyles(defaultStyles, SL.getStyleDefinition()));
        }

        private function focusHandler(_arg1:MouseEvent):void{
            var _local2:InteractiveObject = getFocus();
            if (_local2){
                if ((_local2 is TextField)){
                    if ((_local2 as TextField).type == TextFieldType.INPUT){
                        return;
                    };
                };
            };
            if (_local2 != this){
                setFocus();
            };
        }
        override public function get rowCount():uint{
            return (Math.ceil((this.calculateAvailableHeight() / this.rowHeight)));
        }
        public function set rowCount(_arg1:uint):void{
            var _local2:Number = Number(getStyleValue("contentPadding"));
            height = ((this.rowHeight * _arg1) + (2 * _local2));
        }
        public function get rowHeight():Number{
            return (this._rowHeight);
        }
        public function set rowHeight(_arg1:Number):void{
            this._rowHeight = _arg1;
            invalidate(IT.SIZE);
        }
        override public function scrollToIndex(_arg1:int):void{
            drawNow();
            var _local2:uint = (Math.floor(((_verticalScrollPosition + availableHeight) / this.rowHeight)) - 1);
            var _local3:uint = Math.ceil((_verticalScrollPosition / this.rowHeight));
            if (_arg1 < _local3){
                verticalScrollPosition = (_arg1 * this.rowHeight);
            } else {
                if (_arg1 > _local2){
                    verticalScrollPosition = (((_arg1 + 1) * this.rowHeight) - availableHeight);
                };
            };
        }
        protected function calculateAvailableHeight():Number{
            var _local1:Number = Number(getStyleValue("contentPadding"));
            return ((height - (_local1 * 2)));
        }
        override protected function setVerticalScrollPosition(_arg1:Number, _arg2:Boolean=false):void{
            invalidate(IT.SCROLL);
            super.setVerticalScrollPosition(_arg1, true);
        }
        override protected function draw():void{
            var _local1:Boolean = !((contentHeight == (this.rowHeight * length)));
            contentHeight = (this.rowHeight * length);
            if (isInvalid(IT.STYLES)){
                setStyles();
                drawBackground();
                if (contentPadding != getStyleValue("contentPadding")){
                    invalidate(IT.SIZE, false);
                };
                if (this._cr != getStyleValue("cr")){
                    _invalidateList();
                    this._cr = getStyleValue("cr");
                };
            };
            if (((isInvalid(IT.SIZE, IT.STATE)) || (_local1))){
                drawLayout();
            };
            if (isInvalid(IT.RENDERER_STYLES)){
                updateRendererStyles();
            };
            if (isInvalid(IT.STYLES, IT.SIZE, IT.DATA, IT.SCROLL, IT.SELECTED)){
                this.drawList();
            };
            updateChildren();
            validate();
        }
        override protected function drawList():void{
            var _local4:uint;
            var _local5:Object;
            var _local6:ICR;
            var _local9:Boolean;
            var _local10:String;
            var _local11:Object;
            var _local12:Sprite;
            var _local13:String;
            listHolder.x = (listHolder.y = contentPadding);
            var _local1:Rectangle = listHolder.scrollRect;
            _local1.x = 0;
            _local1.y = (Math.floor(_verticalScrollPosition) % this.rowHeight);
            listHolder.scrollRect = _local1;
            listHolder.cacheAsBitmap = true;
            var _local2:uint = Math.floor((_verticalScrollPosition / this.rowHeight));
            var _local3:uint = Math.min(length, ((_local2 + this.rowCount) + 1));
            var _local7:Dictionary = (renderedItems = new Dictionary(true));
            _local4 = _local2;
            while (_local4 < _local3) {
                _local7[_dp.getItemAt(_local4)] = true;
                _local4++;
            };
            var _local8:Dictionary = new Dictionary(true);
            while (activeCRs.length > 0) {
                _local6 = (activeCRs.pop() as ICR);
                _local5 = _local6.data;
                if ((((_local7[_local5] == null)) || ((invalidItems[_local5] == true)))){
                    availableCRs.push(_local6);
                } else {
                    _local8[_local5] = _local6;
                    invalidItems[_local5] = true;
                };
                list.removeChild((_local6 as DisplayObject));
            };
            invalidItems = new Dictionary(true);
            _local4 = _local2;
            while (_local4 < _local3) {
                _local9 = false;
                _local5 = _dp.getItemAt(_local4);
                if (_local8[_local5] != null){
                    _local9 = true;
                    _local6 = _local8[_local5];
                    delete _local8[_local5];
                } else {
                    if (availableCRs.length > 0){
                        _local6 = (availableCRs.pop() as ICR);
                    } else {
                        _local6 = (getDisplayObjectInstance(getStyleValue("cr")) as ICR);
                        _local12 = (_local6 as Sprite);
                        if (_local12 != null){
                            _local12.addEventListener(MouseEvent.CLICK, handleCRClick, false, 0, true);
                            _local12.addEventListener(MouseEvent.ROLL_OVER, handleCRMouseEvent, false, 0, true);
                            _local12.addEventListener(MouseEvent.ROLL_OUT, handleCRMouseEvent, false, 0, true);
                            _local12.addEventListener(Event.CHANGE, handleCRChange, false, 0, true);
                            _local12.doubleClickEnabled = true;
                            _local12.addEventListener(MouseEvent.DOUBLE_CLICK, handleCRDoubleClick, false, 0, true);
                            if (_local12.hasOwnProperty("setStyle")){
                                for (_local13 in rendererStyles) {
                                    var _local16:Sprite = _local12;
                                    _local16["setStyle"](_local13, rendererStyles[_local13]);
                                };
                            };
                        };
                    };
                };
                list.addChild((_local6 as Sprite));
                activeCRs.push(_local6);
                _local6.y = (this.rowHeight * (_local4 - _local2));
                _local6.setSize(availableWidth, this.rowHeight);
                _local10 = itemToLabel(_local5);
                _local11 = null;
                if (!_local9){
                    _local6.data = _local5;
                };
                _local6.lsd = new LSD(_local10, _local11, this, _local4, _local4, 0);
                _local6.selected = !((_selectedIndices.indexOf(_local4) == -1));
                if ((_local6 is UICore)){
                    (_local6 as UICore).drawNow();
                };
                _local4++;
            };
        }
        protected function keyDownHandler(_arg1:KeyboardEvent):void{
            var _local2:int;
            switch (_arg1.keyCode){
                case Keyboard.UP:
                case Keyboard.DOWN:
                case Keyboard.END:
                case Keyboard.HOME:
                case Keyboard.PAGE_UP:
                case Keyboard.PAGE_DOWN:
                    this.moveSelectionVertically(_arg1.keyCode, _arg1.shiftKey, _arg1.ctrlKey);
                    break;
                case Keyboard.SPACE:
                    if (caretIndex == -1){
                        caretIndex = 0;
                    };
                    this.doKeySelection(caretIndex, _arg1.shiftKey, _arg1.ctrlKey);
                    scrollToSelected();
                    break;
                default:
                    _local2 = getNextIndexAtLetter(String.fromCharCode(_arg1.keyCode), selectedIndex);
                    if (_local2 > -1){
                        selectedIndex = _local2;
                        scrollToSelected();
                    };
            };
            _arg1.stopPropagation();
        }
        protected function moveSelectionVertically(_arg1:uint, _arg2:Boolean, _arg3:Boolean):void{
            var _local4:int = Math.max(Math.floor((this.calculateAvailableHeight() / this.rowHeight)), 1);
            var _local5:int = -1;
            var _local6:int;
            switch (_arg1){
                case Keyboard.UP:
                    if (caretIndex > 0){
                        _local5 = (caretIndex - 1);
                    };
                    break;
                case Keyboard.DOWN:
                    if (caretIndex < (length - 1)){
                        _local5 = (caretIndex + 1);
                    };
                    break;
                case Keyboard.PAGE_UP:
                    if (caretIndex > 0){
                        _local5 = Math.max((caretIndex - _local4), 0);
                    };
                    break;
                case Keyboard.PAGE_DOWN:
                    if (caretIndex < (length - 1)){
                        _local5 = Math.min((caretIndex + _local4), (length - 1));
                    };
                    break;
                case Keyboard.HOME:
                    if (caretIndex > 0){
                        _local5 = 0;
                    };
                    break;
                case Keyboard.END:
                    if (caretIndex < (length - 1)){
                        _local5 = (length - 1);
                    };
                    break;
            };
            if (_local5 >= 0){
                this.doKeySelection(_local5, _arg2, _arg3);
                scrollToSelected();
            };
        }
        protected function doKeySelection(_arg1:int, _arg2:Boolean, _arg3:Boolean):void{
            var _local5:int;
            var _local6:Array;
            var _local7:int;
            var _local8:int;
            var _local4:Boolean;
            if (_arg2){
                _local6 = [];
                _local7 = lastCaretIndex;
                _local8 = _arg1;
                if (_local7 == -1){
                    _local7 = ((caretIndex)!=-1) ? caretIndex : _arg1;
                };
                if (_local7 > _local8){
                    _local8 = _local7;
                    _local7 = _arg1;
                };
                _local5 = _local7;
                while (_local5 <= _local8) {
                    _local6.push(_local5);
                    _local5++;
                };
                selectedIndices = _local6;
                caretIndex = _arg1;
                _local4 = true;
            } else {
                selectedIndex = _arg1;
                caretIndex = (lastCaretIndex = _arg1);
                _local4 = true;
            };
            if (_local4){
                dispatchEvent(new Event(Event.CHANGE));
            };
            invalidate(IT.DATA);
        }
        override protected function initializeAccessibility():void{
            if (List.createAccessibilityImplementation != null){
                List.createAccessibilityImplementation(this);
            };
        }

    }
}
