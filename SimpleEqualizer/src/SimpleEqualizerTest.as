package {
	import flash.display.Sprite;
	
	import zzl.media.SimpleEqualizer;
	import zzl.music.player.Mp3Player;

	[SWF(frameRate="24",width="200",height="100",backgroundColor="#000000")]
	public class SimpleEqualizerTest extends Sprite {
		private var equalizer:SimpleEqualizer;
		private var player:Mp3Player;
		private var mp3:String="http://flashas.heroedu.cn/mp3/test.mp3";

		public function SimpleEqualizerTest() {
			player=new Mp3Player(mp3,true,true);
			equalizer=new SimpleEqualizer(120,60,4,2,0xffffff);
			equalizer.x=40;
			addChild(equalizer);
		}
	}
}
