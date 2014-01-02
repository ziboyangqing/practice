package {
    import com.everydayflash.equalizer.Equalizer;
    
    import flash.display.Sprite;
    import flash.events.ContextMenuEvent;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    
    import zzl.Copy;
    import zzl.events.ID3Event;
    import zzl.events.LrcEvent;
    import zzl.events.PlayerEvent;
    import zzl.music.player.Mp3Player;
    import zzl.utils.ID3Reader;
    import zzl.utils.LrcShower;
    import zzl.utils.QQLRCReader;
    import zzl.vo.LRCObject;

	[SWF(width="375",height="75",backgroundColor="#336699")]
    public class Main extends Sprite {
        private var url:String = "http://flashas.heroedu.cn/mp3/test.mp3";
        private var reader:ID3Reader;
        private var lrc:LRCObject;
		private var player:Mp3Player;
		private var lrcShow:LrcShower;
		private var image:Sprite;
		private var eq:Equalizer;
		public static const proxyUrl:String="http://flashas.heroedu.cn/mp3/ajax.asp";
		
        public function Main() {
			//url="http://yinyueshiting.baidu.com/data2/music/41868206/2330761388458861128.mp3?xcode=7f603113ac92fd475fab86c8f6a58dbabcf8ad810828d504";
            if(!Copy.checkCopy(this))return;
			reader = new ID3Reader(url);
            reader.addEventListener(ID3Event.ID3OK, onID3ok);
            reader.addEventListener(ID3Event.ID3ERROR, onID3error);
			image=new Sprite();
            addChild(image);
			Copy.addMenue(this,"官方陶宝",goTaobao);
			player=new Mp3Player();
			player.source=url;
			player.addEventListener(PlayerEvent.PLAYPROGRESS,showLrc);
			lrcShow=new LrcShower();
			addChild(lrcShow);
			lrcShow.y=35;
			lrcShow.x=75;
			eq=new Equalizer(300,75,128,1,0xff00ffff);
			eq.x=75;
			addChild(eq);
        }
		
		protected function showLrc(event:PlayerEvent):void
		{
			//trace(event.info.position);
			lrcShow.showLRC(event.info.position,lrc.lrc);
		}
		
        protected function onID3error(event:ID3Event):void {
            trace("得不到id3v2信息");
        }

        protected function onID3ok(event:ID3Event):void {
            var title:String            = decodeURI(encodeURI(reader.songName).substr(9));
            var singer:String           = decodeURI(encodeURI(reader.singer).substr(9));
			image.addChild(reader.image);
            var qqlrcReader:QQLRCReader = new QQLRCReader(title, singer);
            qqlrcReader.addEventListener(LrcEvent.LRCOK, lrcOk);
			qqlrcReader.addEventListener(LrcEvent.LRCERROR, lrcError);
        }
		
		protected function lrcError(event:LrcEvent):void
		{
			trace("can't find lrc...");
		}
		
        protected function lrcOk(event:LrcEvent):void {
            lrc = LRCObject(event.data);
            /*for each (var ele:LRCElement in lrc.lrc) {
                    trace(ele.timer, ele.lyric);
            }*/
			player.Play();
			addEventListener(Event.ENTER_FRAME, eq.render);
        }
		private function goTaobao(e:ContextMenuEvent):void{
			navigateToURL(new URLRequest("http://flashas.taobao.com"));
		}
    }
}
