package
{
	import citrus.core.StarlingState;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	public class MarioState extends StarlingState
	{
		public function MarioState()
		{
			super();
		}
		
		override public function initialize():void{
			super.initialize();
			var physics:Box2D = new Box2D("physics");
			physics.visible = true;
			add(physics);
			
			var mario:Hero = new Hero("mario", 
				{
					jumpHeight:10,
					jumpAccleration:.25
				});
			add(mario);
			
			var platform:Platform = new Platform("ground",
				{
					width:500,
					x:250,
					y:300
				});
			add(platform);
			
		}
	}
}