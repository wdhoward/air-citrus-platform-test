package
{

	import citrus.core.starling.StarlingCitrusEngine;
		
    [SWF(frameRate="60", width="800", height="600")]
	public class CitrusMario extends StarlingCitrusEngine
	{
		[Embed(source="../assets/levelOne.tmx", mimeType="application/octet-stream")]
		private var map:Class;
		
		public function CitrusMario()
		{
			trace("startup");
			setUpStarling(true);
			state = new SuperMarioGameState(XML(new map()));
		}
	}
}