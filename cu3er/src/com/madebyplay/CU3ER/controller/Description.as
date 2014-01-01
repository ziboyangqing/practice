package com.madebyplay.CU3ER.controller 
{
    import com.madebyplay.CU3ER.model.*;
    import com.madebyplay.CU3ER.view.*;
    import flash.events.*;
    
    public class Description extends flash.events.EventDispatcher
    {
        public function Description(arg1:com.madebyplay.CU3ER.controller.Player, arg2:com.madebyplay.CU3ER.controller.Slide, arg3:com.madebyplay.CU3ER.model.DescriptionData)
        {
            super();
            this._player = arg1;
            this._slide = arg2;
            this._data = arg3;
            this._view = new com.madebyplay.CU3ER.view.DescriptionView(this, this._data);
            return;
        }

        public function get slide():com.madebyplay.CU3ER.controller.Slide
        {
            return this._slide;
        }

        public function set slide(arg1:com.madebyplay.CU3ER.controller.Slide):void
        {
            this._slide = arg1;
            this._view.update();
            return;
        }

        public function get player():com.madebyplay.CU3ER.controller.Player
        {
            return this._player;
        }

        public function get view():com.madebyplay.CU3ER.view.DescriptionView
        {
            return this._view;
        }

        internal var _data:com.madebyplay.CU3ER.model.DescriptionData;

        internal var _player:com.madebyplay.CU3ER.controller.Player;

        internal var _slide:com.madebyplay.CU3ER.controller.Slide;

        internal var _view:com.madebyplay.CU3ER.view.DescriptionView;
    }
}
