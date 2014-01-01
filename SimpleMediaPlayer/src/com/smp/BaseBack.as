/*SimpleMediaPlayer*/
package com.smp {
	import com.utils.AppUtil;

    //import com.smp.events.*;
    //import flash.events.*;
    //import flash.display.*;
    //import flash.net.*;
    //import flash.ui.*;
    //import flash.system.*;

    public class BaseBack extends RemovableSP {

        public var bk:SBack;
        public var xl:XMLList;
        public var dt:Object;

        public function BaseBack(_arg1:Object):void{
            var _local2:String;
            super();
            this.bk = new SBack(this);
            addChild(this.bk);
            this.dt = _arg1;
            this.xl = new XMLList(<l/>);
            for (_local2 in this.dt) {
				trace("BaseBack:",this.dt[_local2]);
                this.xl.@[_local2] = AppUtil.parse(this.dt[_local2]);
            };
        }
        public function init(_arg1:Number, _arg2:Number):void{
            this.bk.ss(this.xl, _arg1, _arg2);
            this.bk.lo();
        }
        override public function rm():void{
            this.bk.rm();
            super.rm();
        }

    }
}
