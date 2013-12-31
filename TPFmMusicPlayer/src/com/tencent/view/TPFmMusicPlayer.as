
package com.tencent.view {
	import flash.events.*;
	import flash.net.*;
	import com.tencent.core.*;
	import com.tencent.event.*;
	import com.sun.utils.*;
	import com.tencent.utils.*;
	import flash.display.*;
	import flash.utils.*;
	import flash.external.*;
	import flash.system.*;
	import flash.ui.*;

	public class TPFmMusicPlayer extends MovieClip {

		private var _version:String = "TPFmMusicPlayer";
		private var _loader:URLLoader;
		private var _soundPlayer:SoundPlayer;

		public function TPFmMusicPlayer(){
			this.init();
		}
		private function init():void{
			ParamsVerify.objIdAllowed = ParamsVerify.checkObjectID();
			if (ParamsVerify.objIdAllowed){
				Security.allowDomain(ParamsVerify.getAllowDomainName());
			} else {
				return;
			};
			this.stage.frameRate = 10;
			this.addEventListener(Event.ADDED_TO_STAGE, this.onAddToStage);
		}
		private function onAddToStage(_arg1:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.onAddToStage);
			this.onLoadComplete(null);
			this.initRightMenu();
			this.initCallBack();
			//this.js_swfPlayMusic("http://flashas.heroedu.cn/mp3/test.mp3");
			this.js_swfPlayMusic("1.m4a",5000,"m4a");
		}
		private function initRightMenu():void{
			AS3Debugger.identity = this._version;
			AS3Debugger.OmitTrace = true;
			var _local1:ContextMenu = new ContextMenu();
			_local1.hideBuiltInItems();
			var _local2:ContextMenuItem = new ContextMenuItem(this._version);
			_local2.enabled = false;
			_local1.customItems.push(_local2);
			this.contextMenu = _local1;
		}
		private function initCallBack():void{
			if (ExternalInterface.available){
				try {
					setTimeout(function ():void{
						ExternalInterface.addCallback("swfPlayMusic", js_swfPlayMusic);
						ExternalInterface.addCallback("swfPauseMusic", js_swfPauseMusic);
						ExternalInterface.addCallback("swfStopMusic", js_swfStopMusic);
						ExternalInterface.addCallback("swfSeekMusic", js_swfSeekMusic);
						ExternalInterface.addCallback("swfSetVolume", js_swfSetVolume);
						ExternalInterface.addCallback("swfGetVolume", js_swfGetVolume);
						ExternalInterface.addCallback("swfSetMute", js_swfSetMute);
						ExternalInterface.addCallback("swfGetMute", js_swfGetMute);
						ExternalInterface.addCallback("swfGetPosion", js_swfGetPosion);
						ExternalInterface.addCallback("swfGetTotalTime", js_swfGetTotalTime);
						ExternalInterface.addCallback("swfGetPlayStat", js_swfGetPlayStat);
						ExternalInterface.call("g_flashPlayer.swfInitComplete");
						AS3Debugger.Trace("TPFmMusicPlayer::swfInitComplete");
					}, 0);
				} catch(error:SecurityError) {
					AS3Debugger.Trace((("A SecurityError occurred: " + error.message) + "\n"));
				} catch(error:Error) {
					AS3Debugger.Trace((("An Error occurred: " + error.message) + "\n"));
				};
			} else {
				AS3Debugger.Trace("initCallBack>>External interface is not available.");
			};
		}
		private function checkJavaScriptReady():Boolean{
			if (ExternalInterface.available){
				return (ExternalInterface.call("isReady"));
			};
			AS3Debugger.Trace("checkJavaScriptReady>>External interface is not available.");
			return (false);
		}
		private function onClick(_arg1:MouseEvent):void{
			switch (_arg1.target.name){
			case "pauseBtn":
				this.js_swfPauseMusic();
				break;
			case "playBtn":
				this.js_swfPlayMusic();
				break;
			case "stopBtn":
				this.js_swfStopMusic();
				break;
			};
		}
		private function onLoadComplete(_arg1:Event):void{
			this._soundPlayer = SoundPlayer.getInstance();
			this._soundPlayer.init();
			this._soundPlayer.addEventListener(SoundPlayerEvent.SOUND_STAT_CHANGE, this.onSoundStatChange);
			this._soundPlayer.addEventListener(SoundPlayerEvent.SOUND_DATA, this.onSoundData);
			this._soundPlayer.addEventListener(SoundPlayerEvent.SOUND_IOERROR, this.onSoundIOError);
		}
		private function onSoundStatChange(_arg1:SoundPlayerEvent):void{
			trace("g_flashPlayer.soundStatChange", _arg1.data);
			for(var a:* in _arg1.data){
				trace(a,_arg1.data[a]);
			}
			if (ExternalInterface.available){
				ExternalInterface.call("g_flashPlayer.soundStatChange", _arg1.data);
			};
		}
		private function onSoundData(_arg1:SoundPlayerEvent):void{
			if (ExternalInterface.available){
				ExternalInterface.call("g_flashPlayer.soundData", _arg1.data);
			};
		}
		private function onSoundIOError(_arg1:SoundPlayerEvent):void{
			if (ExternalInterface.available){
				this._soundPlayer.close();
				ExternalInterface.call("g_flashPlayer.soundIOError", _arg1.data);
			};
		}
		private function js_swfPlayMusic(_arg1:String="", _arg2:int=5000, _arg3:String="mp3"):void{
			AS3Debugger.Trace("$url=" + _arg1 + "  $bufferTime=" + _arg2 + "  $type=" + _arg3);
			this._soundPlayer.play(_arg1, _arg2, _arg3);
		}
		private function js_swfPauseMusic():void{
			AS3Debugger.Trace("js_swfPauseMusic==================");
			this._soundPlayer.pause();
		}
		private function js_swfStopMusic():void{
			AS3Debugger.Trace("js_swfStopMusic==================");
			this._soundPlayer.stop();
		}
		private function js_swfSeekMusic(_arg1:int):void{
			AS3Debugger.Trace("js_swfSeekMusic==================");
			this._soundPlayer.seek(_arg1);
		}
		private function js_swfSetVolume(_arg1:Number):void{
			AS3Debugger.Trace(("js_swfSetVolume==================$value==" + _arg1));
			this._soundPlayer.volume = _arg1;
		}
		private function js_swfGetVolume():Number{
			return (this._soundPlayer.volume);
		}
		private function js_swfSetMute(_arg1:Boolean):void{
			AS3Debugger.Trace("js_swfSetMute==================");
			this._soundPlayer.mute = _arg1;
		}
		private function js_swfGetMute():Boolean{
			return (this._soundPlayer.mute);
		}
		private function js_swfGetPosion():Number{
			return (this._soundPlayer.position);
		}
		private function js_swfGetTotalTime():int{
			return (this._soundPlayer.totalTime);
		}
		private function js_swfGetPlayStat():int{
			return (this._soundPlayer.playStat);
		}

	}
}


