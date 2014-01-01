/*SimpleMediaPlayer*/
package com.ui {
    import com.smp.events.DATACHGEvent;
    import com.smp.events.DATACHGType;
    
    import flash.events.EventDispatcher;

    public class DP extends EventDispatcher {

        protected var data:Array;

        public function DP(_arg1:Object=null){
            this.data = [];
        }
        public function get length():uint{
            return (this.data.length);
        }
        public function invalidateItemAt(_arg1:int):void{
            if (this.checkIndex(_arg1, (this.data.length - 1))){
                this.dispatchChangeEvent(DATACHGType.INVALIDATE, [this.data[_arg1]], _arg1, _arg1);
            };
        }
        public function invalidateItem(_arg1:Object):void{
            var _local2:uint = this.getItemIndex(_arg1);
            if (_local2 == -1){
                return;
            };
            this.invalidateItemAt(_local2);
        }
        public function invalidate():void{
            dispatchEvent(new DATACHGEvent(DATACHGEvent.DATA_CHANGE, DATACHGType.INVALIDATE_ALL, this.data.concat(), 0, this.data.length));
        }
        public function addItemAt(_arg1:Object, _arg2:uint):void{
            if (this.checkIndex(_arg2, this.data.length)){
                this.dispatchPreChangeEvent(DATACHGType.ADD, [_arg1], _arg2, _arg2);
                this.data.splice(_arg2, 0, _arg1);
                this.dispatchChangeEvent(DATACHGType.ADD, [_arg1], _arg2, _arg2);
            };
        }
        public function addItem(_arg1:Object):void{
            this.dispatchPreChangeEvent(DATACHGType.ADD, [_arg1], (this.data.length - 1), (this.data.length - 1));
            this.data.push(_arg1);
            this.dispatchChangeEvent(DATACHGType.ADD, [_arg1], (this.data.length - 1), (this.data.length - 1));
        }
        public function getItemAt(_arg1:uint):Object{
            if (this.checkIndex(_arg1, (this.data.length - 1))){
                return (this.data[_arg1]);
            };
            return (null);
        }
        public function getItemIndex(_arg1:Object):int{
            return (this.data.indexOf(_arg1));
        }
        public function removeItemAt(_arg1:uint):Object{
            var _local2:Array;
            if (this.checkIndex(_arg1, (this.data.length - 1))){
                this.dispatchPreChangeEvent(DATACHGType.REMOVE, this.data.slice(_arg1, (_arg1 + 1)), _arg1, _arg1);
                _local2 = this.data.splice(_arg1, 1);
                this.dispatchChangeEvent(DATACHGType.REMOVE, _local2, _arg1, _arg1);
                return (_local2[0]);
            };
            return (null);
        }
        public function removeItem(_arg1:Object):Object{
            var _local2:int = this.getItemIndex(_arg1);
            if (_local2 != -1){
                return (this.removeItemAt(_local2));
            };
            return (null);
        }
        public function removeAll():void{
            var _local1:Array = this.data.concat();
            this.dispatchPreChangeEvent(DATACHGType.REMOVE_ALL, _local1, 0, _local1.length);
            this.data = [];
            this.dispatchChangeEvent(DATACHGType.REMOVE_ALL, _local1, 0, _local1.length);
        }
        public function sort(... _args):Array{
            this.dispatchPreChangeEvent(DATACHGType.SORT, this.data.concat(), 0, (this.data.length - 1));
            var _local2:Array = this.data.sort.apply(this.data, _args);
            this.dispatchChangeEvent(DATACHGType.SORT, this.data.concat(), 0, (this.data.length - 1));
            return (_local2);
        }
        public function sortOn(_arg1:Object, _arg2:Object=null):Array{
            this.dispatchPreChangeEvent(DATACHGType.SORT, this.data.concat(), 0, (this.data.length - 1));
            var _local3:Array = this.data.sortOn(_arg1, _arg2);
            this.dispatchChangeEvent(DATACHGType.SORT, this.data.concat(), 0, (this.data.length - 1));
            return (_local3);
        }
        override public function toString():String{
            return ((("DP [" + this.data.join(" , ")) + "]"));
        }
        protected function checkIndex(_arg1:int, _arg2:int):Boolean{
            if ((((_arg1 > _arg2)) || ((_arg1 < 0)))){
                return (false);
            };
            return (true);
        }
        protected function dispatchChangeEvent(_arg1:String, _arg2:Array, _arg3:int, _arg4:int):void{
            dispatchEvent(new DATACHGEvent(DATACHGEvent.DATA_CHANGE, _arg1, _arg2, _arg3, _arg4));
        }
        protected function dispatchPreChangeEvent(_arg1:String, _arg2:Array, _arg3:int, _arg4:int):void{
            dispatchEvent(new DATACHGEvent(DATACHGEvent.PRE_DATA_CHANGE, _arg1, _arg2, _arg3, _arg4));
        }

    }
}
