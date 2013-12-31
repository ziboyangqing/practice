package
{
	import com.devnet.osmf.application.MediaDisplay;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	[SWF(width="1000",height="600")]
	public class OSMFComponent extends Sprite
	{
		private var md:MediaDisplay;
		private var url:String="http://mediapm.edgesuite.net/osmf/content/test/manifest-files/dynamic_Streaming.f4m";
		
		public function OSMFComponent()
		{
			url="rtmp://cp67126.edgefcs.net/ondemand/mediapm/strobe/content/test/SpaceAloneHD_sounas_640_500_short";
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			md=new MediaDisplay(stage.stageWidth,stage.stageHeight);
			md.source=url;
			addChild(md);
			
		}
	}
}