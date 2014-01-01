/*SimpleMediaPlayer*/
package com.smp {
    import flash.display.*;

    public class RemovableSP extends Sprite {

        public function rm():void{
            if (parent){
                parent.removeChild(this);
            };
        }
    }
}
