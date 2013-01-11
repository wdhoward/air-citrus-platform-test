package
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.starling.StarlingState;
	import citrus.math.MathVector;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Cannon;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.starlingview.AnimationSequence;
	
	import feathers.controls.Slider;
	import feathers.themes.AeonDesktopTheme;
	
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/*
TODO: wire up goal at end
	: resize moving platform to match skin
	: add toggle for triggers
	: add springboard
	*/
	public class SuperMarioGameState extends citrus.core.starling.StarlingState
	{
		[Embed(source="../assets/tilesetground.png")]
		private var tilesetground:Class;

		[Embed(source="../assets/mariocopy.png")]
		private var marioTile:Class;
		
		[Embed(source="../assets/mario.xml", mimeType="application/octet-stream")]
		private var marioXML:Class;
		
		[Embed(source="../assets/frog.png")]
		private var frogSkin:Class;
		
		[Embed(source="../assets/cannon.png")]
		private var cannonSkin:Class;
		
		[Embed(source="../assets/missile.png")]
		private var missileSkin:Class;
		
		[Embed(source="../assets/brick_platform.png")]
		private var brickPlatform:Class;
		
		private static const GRID_SIZE:int = 16;
		//private static const MARIO_SETTINGS:String = "marioSettings";
		//private static const MARIO_LEVEL:String = "marioLevel";
		
		private var hero:Hero;
		private var map:XML;
		private var cannon:Cannon;
		private var firing:Boolean = false;
		private var rightTrigger:Boolean = false;
		private var theme:AeonDesktopTheme;
		private var jumpSlider:Slider;

		
		public function SuperMarioGameState( map:XML )
		{
			super();
			this.map = map;

			var objects:Array = [Hero, Platform, Enemy];
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			setupUserInterface();
			setupPhysics();
			setupMap();
			setupSensors();	
			setupPlatforms();
			setupHero();
			setupEnemy();
			setupCannon();
			
			view.setupCamera(hero, new MathVector(stage.stageWidth/2, 500), new Rectangle(0,0,1600,1600), new MathVector(0.25,.05));		
			
		}
		
		private function setupEnemy():void
		{
			var frog:Enemy = getObjectByName("frog") as Enemy;
			frog.view = new frogSkin();
		}
		
		private function setupHero():void
		{
			hero = getObjectByName("mario") as Hero;
			hero.acceleration = 0.2;
			hero.jumpHeight = 8;
			hero.canDuck = true;
			hero.enemySpringHeight = 10;
			hero.friction = 1.5;
			hero.enemyClass = Enemy;
			hero.onTakeDamage.add(killMario);
			
			var marioAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new marioTile()), XML(new marioXML()));
			var animationSequence:AnimationSequence = new AnimationSequence(marioAtlas,["walk","idle","jump","hurt","duck"], "idle");
			
			hero.view = animationSequence;
		}
		
		private function setupPlatforms():void
		{
			var mover:MovingPlatform = getObjectByName("mover") as MovingPlatform;
			mover.view = new brickPlatform();
			mover.startX = 70*GRID_SIZE;
			mover.startY = 83*GRID_SIZE;
			mover.endX = 85*GRID_SIZE;
			mover.endY = 83*GRID_SIZE;
			mover.speed = 2;
		}
		
		private function setupMap():void
		{
			var imagebits:Bitmap = new tilesetground();
			imagebits.name = "tilesetground.png";
			ObjectMaker2D.FromTiledMap(map,[imagebits],true);
		}
		
		private function setupPhysics():void
		{
			var physics:Box2D = new Box2D("physics");
			physics.visible = false;
			add(physics);
			
		}
		
		private function setupSensors():void
		{
			
			var bottom:Sensor = getObjectByName("bottom") as Sensor;
			bottom.onBeginContact.add(onBottomContact);
			
			var trigger:Sensor = getObjectByName("trigger") as Sensor;
			trigger.onBeginContact.add(onTriggerContact);
			
			var rightTrigger:Sensor = getObjectByName("rightTrigger") as Sensor;
			rightTrigger.onBeginContact.add(onRightTriggerContact);
			
		}
		
		private function setupUserInterface():void
		{
			theme = new AeonDesktopTheme(stage);
			jumpSlider = new Slider();
			jumpSlider.minimum = 2;
			jumpSlider.maximum = 20;
			jumpSlider.value = 8;
			jumpSlider.x = stage.stageWidth - 100;
			jumpSlider.y = 10;
			jumpSlider.step = 1;
			jumpSlider.page = 5;
			jumpSlider.addEventListener(Event.CHANGE, jumpSlider_changeHandler);
			this.addChild(jumpSlider);
			
		}
		
		private function jumpSlider_changeHandler(event:Event):void
		{
			var slider:Slider = Slider( event.currentTarget );
			hero.jumpHeight = slider.value;
		}
		
		private function setupCannon():void
		{
			cannon = getObjectByName("cannon") as Cannon;
			cannon.view = new cannonSkin();
			cannon.fireRate = 1000;
			cannon.startingDirection = "left";
			cannon.missileView = new missileSkin();
			cannon.openFire = false; 
			cannon.stopFire();
			cannon.missileHeight = 12;
			cannon.missileWidth = 30;
			cannon.missileFuseDuration = 5000;
			cannon.onGiveDamage.add(onMissileExplode);
			
		}
		
		private function onTriggerContact(c:b2Contact):void
		{
			cannon.startingDirection = "left";
			toggleCannon();
			
		}
		
		private function onRightTriggerContact(c:b2Contact):void
		{
			cannon.startingDirection = "right";
			toggleCannon();
		}
		
		private function toggleCannon():void
		{
			if (firing)
			{
				cannon.stopFire();
				firing = false;
			} else
			{
				cannon.startFire();
				firing = true;
			}
		}
		
		private function onBottomContact(c:b2Contact):void
		{
			trace("I've fallen and I can't get up!");
			killMario();
		}
		
		private function onMissileExplode(missileContact:Box2DPhysicsObject):void
		{
			trace("BOOM!");
			trace(missileContact);
			
			if (missileContact.name == "mario" ) 
			{
				killMario();
			}
			
			/*
			if (missileContact.name == "platform" )
			{
				
			}
			*/
		}
		
		private function killMario():void
		{
			trace("R.I.P. Mario");
			hero.body.SetType(b2Body.b2_staticBody);
			hero.x = 2 * GRID_SIZE;
			hero.y = 77 * GRID_SIZE;
			hero.body.SetType(b2Body.b2_dynamicBody);	
		}
		
	}
}