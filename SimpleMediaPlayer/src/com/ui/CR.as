/*SimpleMediaPlayer*/
package com.ui {
    import flash.events.*;
    import com.skin.downSkin;
    import com.skin.overSkin;
    import com.skin.selectedDownSkin;
    import com.skin.selectedOverSkin;
    import com.skin.selectedUpSkin;
    import com.skin.upSkin;
    import interfaces.ICR;

    public class CR extends SLabel implements ICR {

        private static var defaultStyles:Object = {
            upSkin:upSkin,
            downSkin:downSkin,
            overSkin:overSkin,
            selectedUpSkin:selectedUpSkin,
            selectedDownSkin:selectedDownSkin,
            selectedOverSkin:selectedOverSkin,
            textFormat:null,
            textPadding:5
        };

        protected var _lsd:LSD;
        protected var _data:Object;

        public function CR():void{
            toggle = true;
        }
        public static function getStyleDefinition():Object{
            return (defaultStyles);
        }

        override public function setSize(_arg1:Number, _arg2:Number):void{
            super.setSize(_arg1, _arg2);
        }
        public function get lsd():LSD{
            return (this._lsd);
        }
        public function set lsd(_arg1:LSD):void{
            this._lsd = _arg1;
            label = this._lsd.label;
            setStyle("icon", this._lsd.icon);
        }
        public function get data():Object{
            return (this._data);
        }
        public function set data(_arg1:Object):void{
            this._data = _arg1;
        }
        override public function get selected():Boolean{
            return (super.selected);
        }
        override public function set selected(_arg1:Boolean):void{
            super.selected = _arg1;
        }
        override protected function toggleSelected(_arg1:MouseEvent):void{
        }
        override protected function drawLayout():void{
            var _local1:Number;
            var _local3:Number;
            _local1 = Number(getStyleValue("textPadding"));
            var _local2:Number = 0;
            if (icon != null){
                icon.x = _local1;
                icon.y = Math.round(((height - icon.height) >> 1));
                _local2 = (icon.width + _local1);
            };
            if (label.length > 0){
                textField.visible = true;
                _local3 = Math.max(0, ((width - _local2) - (_local1 * 2)));
                textField.width = _local3;
                textField.height = (textField.textHeight + 4);
                textField.x = (_local2 + _local1);
                textField.y = Math.round(((height - textField.height) >> 1));
            } else {
                textField.visible = false;
            };
            size(background, width, height);
        }

    }
}
