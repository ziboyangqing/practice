package 
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.reintroducing.debug.Environment;
	import com.reintroducing.events.SoundManagerEvent;
	import com.reintroducing.sound.SoundManager;
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @author Matt Przybylski [http://www.reintroducing.com]
	 * @version 1.0
	 */
	public class Main extends MovieClip
	{
		//- PRIVATE & PROTECTED VARIABLES -------------------------------------------------------------------------
		
		private var _env:Environment;
		private var _sm:SoundManager;
		private var _mp3Loader:MP3Loader;
		
		//- PUBLIC & INTERNAL VARIABLES ---------------------------------------------------------------------------
		
		//- CONSTRUCTOR	-------------------------------------------------------------------------------------------
		
		public function Main()
		{
			super();
			
			init();
		}
		//- PRIVATE & PROTECTED METHODS ---------------------------------------------------------------------------
		private function init():void
		{
			_env = Environment.getInstance();
			_env.setPaths("./", "");
			
			// Set up the sound manager and its listeners
			_sm = SoundManager.getInstance();
			_sm.addEventListener(SoundManagerEvent.SOUND_ITEM_ADDED, onSoundAdded);
			_sm.addEventListener(SoundManagerEvent.SOUND_ITEM_LOAD_PROGRESS, onSoundProgress);
			_sm.addEventListener(SoundManagerEvent.SOUND_ITEM_LOAD_COMPLETE, onSoundLoadComplete);
			_sm.addEventListener(SoundManagerEvent.SOUND_ITEM_FADE_COMPLETE, onFadeComplete);
			_sm.addEventListener(SoundManagerEvent.SOUND_ITEM_PLAY_COMPLETE, onPlayComplete);
			// 从库中加载声音
			//var Elephant:Class = (getDefinitionByName("Elephant") as Class);
			//_sm.addLibrarySound(Elephant, "elephant");
			
			// 直接加载外部声音
			_sm.addExternalSound(String(_env.basePath + "sounds/birds.mp3"), "birds");
			
			// 通过 LoaderMax 加载外部声音，添加到 SoundManager
			_mp3Loader = new MP3Loader(String(_env.basePath + "sounds/frogs.mp3"), {name: "frogs", autoPlay: false, onComplete: handleMP3Loaded}); 
			_mp3Loader.load();
			
			_sm.playSound("birds");
			//_sm.playSound("elephant");
		}
		
		//- PUBLIC & INTERNAL METHODS -----------------------------------------------------------------------------
		//- 加载完外部声音后添加到SM中----------------------------------------------------------------------------------------
		private function handleMP3Loaded($evt:LoaderEvent):void
		{
			var frogs:Sound = LoaderMax.getContent("frogs");
			
			_sm.addPreloadedSound(frogs, "frogs");
			_sm.playSound("frogs");
		}
		
		private function onSoundAdded($evt:SoundManagerEvent):void
		{
			trace("SOUND added: " + $evt.soundItem.name);
		}
		private function onSoundProgress($evt:SoundManagerEvent):void
		{
			trace("SOUND: " + $evt.soundItem.name + " & PROGRESS: " + $evt.percent);
		}
		private function onSoundLoadComplete($evt:SoundManagerEvent):void
		{
			trace("SOUND: " + $evt.soundItem.name + " & LENGTH: " + $evt.duration);
			trace("ALTERNATE METHOD: " + ($evt.soundItem.sound.length * .001));
		}
		private function onFadeComplete($evt:SoundManagerEvent):void
		{
			//			trace("SOUND: " + $evt.soundItem.name + " FADE COMPLETE");
		}
		private function onPlayComplete($evt:SoundManagerEvent):void
		{
			trace("SOUND: " + $evt.soundItem.name + " PLAY COMPLETE");
		}
		
		//- GETTERS & SETTERS -------------------------------------------------------------------------------------
		
		//- HELPERS -----------------------------------------------------------------------------------------------
		
		override public function toString():String
		{
			return getQualifiedClassName(this);
		}
		
		//- END CLASS ---------------------------------------------------------------------------------------------
	}
}