/*SimpleMediaPlayer*/
package com.smp.events {
    import flash.events.*;

    public final class SMPEvent extends Event {

        public static const API:String = "api";
        public static const API_REMOVE:String = "api_remove";
        public static const RESIZE:String = "resize";
        public static const READY:String = "ready";
        public static const CONFIG_LOADED:String = "config_loaded";
        public static const ITEM_DELETED:String = "item_deleted";
        public static const ITEM_OPENED:String = "item_opened";
        public static const ITEM_CLOSED:String = "item_closed";
        public static const ITEM_LOADED:String = "item_loaded";
        public static const SKIN_LOAD:String = "skin_load";
        public static const SKIN_LOADED:String = "skin_loaded";
        public static const SKIN_CHANGE:String = "skin_change";
        public static const SKIN_COMPLETE:String = "skin_complete";
        public static const LIST_LOAD:String = "list_load";
        public static const LIST_LOADED:String = "list_loaded";
        public static const LIST_CHANGE:String = "list_change";
        public static const PLUGINS_LOAD:String = "plugins_load";
        public static const PLUGINS_LOADED:String = "plugins_loaded";
        public static const PLUGINS_REMOVE:String = "plugins_remove";
        public static const CONTROL_LOAD:String = "control_load";
        public static const CONTROL_PLAY:String = "control_play";
        public static const CONTROL_PAUSE:String = "control_pause";
        public static const CONTROL_STOP:String = "control_stop";
        public static const CONTROL_PREV:String = "control_prev";
        public static const CONTROL_NEXT:String = "control_next";
        public static const CONTROL_PLAYMODE:String = "control_playmode";
        public static const CONTROL_MUTE:String = "control_mute";
        public static const CONTROL_VOLUME:String = "control_volume";
        public static const CONTROL_PROGRESS:String = "control_progress";
        public static const CONTROL_WIN:String = "control_win";
        public static const CONTROL_WINBT:String = "control_winbt";
        public static const CONTROL_FULLSCREEN:String = "control_fullscreen";
        public static const CONTROL_MAX:String = "control_max";
        public static const VIEW_ITEM:String = "view_item";
        public static const VIEW_PLAY:String = "view_play";
        public static const VIEW_STOP:String = "view_stop";
        public static const VIEW_PREV:String = "view_prev";
        public static const VIEW_NEXT:String = "view_next";
        public static const VIEW_REWIND:String = "view_rewind";
        public static const VIEW_FORWARD:String = "view_forward";
        public static const VIEW_MUTE:String = "view_mute";
        public static const VIEW_RANDOM:String = "view_random";
        public static const VIEW_REPEAT:String = "view_repeat";
        public static const VIEW_SINGLE:String = "view_single";
        public static const VIEW_VOLUME:String = "view_volume";
        public static const VIEW_PROGRESS:String = "view_progress";
        public static const VIEW_LIST:String = "view_list";
        public static const VIEW_LRC:String = "view_lrc";
        public static const VIEW_VIDEO:String = "view_video";
        public static const VIEW_OPTION:String = "view_option";
        public static const VIEW_CONSOLE:String = "view_console";
        public static const VIEW_FULLSCREEN:String = "view_fullscreen";
        public static const VIEW_LINK:String = "view_link";
        public static const VIEW_MORE:String = "view_more";
        public static const MODEL_LOAD:String = "model_load";
        public static const MODEL_LOADING:String = "model_loading";
        public static const MODEL_LOADED:String = "model_loaded";
        public static const MODEL_CHANGE:String = "model_change";
        public static const MODEL_START:String = "model_start";
        public static const MODEL_STATE:String = "model_state";
        public static const MODEL_META:String = "model_meta";
        public static const MODEL_TIME:String = "model_time";
        public static const MODEL_ERROR:String = "model_error";
        public static const MODEL_COMPLETE:String = "model_complete";
        public static const LRC_MAX:String = "lrc_max";
        public static const LRC_RESIZE:String = "lrc_resize";
        public static const LRC_LOAD:String = "lrc_load";
        public static const LRC_LOADED:String = "lrc_loaded";
        public static const LRC_COMPLETE:String = "lrc_complete";
        public static const LRC_ERROR:String = "lrc_error";
        public static const LRC_ROWCHANGE:String = "lrc_rowchange";
        public static const VIDEO_MAX:String = "video_max";
        public static const VIDEO_SCALEMODE:String = "video_scalemode";
        public static const VIDEO_ROTATION:String = "video_rotation";
        public static const VIDEO_RESIZE:String = "video_resize";
        public static const VIDEO_HIGHLIGHT:String = "video_highlight";
        public static const VIDEO_BLACKWHITE:String = "video_blackwhite";
        public static const VIDEO_EFFECT:String = "video_effect";
        public static const VIDEO_SMOOTHING:String = "video_smoothing";
        public static const MIXER_PREV:String = "mixer_prev";
        public static const MIXER_NEXT:String = "mixer_next";
        public static const MIXER_COLOR:String = "mixer_color";
        public static const MIXER_DISPLACE:String = "mixer_displace";
        public static const MIXER_FILTER:String = "mixer_filter";

        private var _data:Object;

        public function SMPEvent(_arg1:String, _arg2:Object=null, _arg3:Boolean=false, _arg4:Boolean=false):void{
            super(_arg1, _arg3, _arg4);
            this._data = _arg2;
        }
        public function get data():Object{
            return (this._data);
        }
        public function set data(_arg1:Object):void{
            this._data = _arg1;
        }
        override public function toString():String{
            return ("[CMPEvent]");
        }
        override public function clone():Event{
            return (new SMPEvent(type, bubbles, cancelable));
        }

    }
}
