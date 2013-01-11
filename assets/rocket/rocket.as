package {

    import Box2DAS.Collision.Shapes.b2PolygonShape;
	import Box2DAS.Common.V2;

	import citrus.objects.PhysicsObject;

	/**
	 * @author Aymeric
	 * <p>This is a class created by the software http://www.physicseditor.de/</p>
	 * <p>Just select the CitrusEngine template, upload your png picture, set polygons and export.</p>
	 * <p>Be careful, the registration point is topLeft !</p>
	 * @param peObject : the name of the png file
	 */
    public class PhysicsEditorObjects extends PhysicsObject {
		
		[Inspectable(defaultValue="")]
		public var peObject:String = "";

		private var _tab:Array;

		public function PhysicsEditorObjects(name:String, params:Object = null) {

			super(name, params);
		}

		override public function destroy():void {

			super.destroy();
		}

		override public function update(timeDelta:Number):void {

			super.update(timeDelta);
		}

		override protected function defineFixture():void {
			
			super.defineFixture();
			
			_createVertices();

			_fixtureDef.density = _getDensity();
			_fixtureDef.friction = _getFriction();
			_fixtureDef.restitution = _getRestitution();
			
			for (var i:uint = 0; i < _tab.length; ++i) {
				var polygonShape:b2PolygonShape = new b2PolygonShape();
				polygonShape.Set(_tab[i]);
				_fixtureDef.shape = polygonShape;

				body.CreateFixture(_fixtureDef);
			}
		}
		
        protected function _createVertices():void {
			
			_tab = [];
			var vertices:Vector.<V2> = new Vector.<V2>();

			switch (peObject) {
				
				case "Rocket2":
											
			        vertices.push(new V2(28.5/_box2D.scale, 80/_box2D.scale));
					vertices.push(new V2(39/_box2D.scale, 77.5/_box2D.scale));
					vertices.push(new V2(37.5/_box2D.scale, 87/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(38/_box2D.scale, 96.5/_box2D.scale));
					vertices.push(new V2(39.5/_box2D.scale, 81/_box2D.scale));
					vertices.push(new V2(45/_box2D.scale, 80.5/_box2D.scale));
					vertices.push(new V2(56.5/_box2D.scale, 90/_box2D.scale));
					vertices.push(new V2(57.5/_box2D.scale, 111/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(2.5/_box2D.scale, 89/_box2D.scale));
					vertices.push(new V2(12/_box2D.scale, 81.5/_box2D.scale));
					vertices.push(new V2(20.5/_box2D.scale, 89/_box2D.scale));
					vertices.push(new V2(21.5/_box2D.scale, 95/_box2D.scale));
					vertices.push(new V2(2/_box2D.scale, 111.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(37.5/_box2D.scale, 90/_box2D.scale));
					vertices.push(new V2(30.5/_box2D.scale, 123/_box2D.scale));
					vertices.push(new V2(28.5/_box2D.scale, 124/_box2D.scale));
					vertices.push(new V2(23.5/_box2D.scale, 87/_box2D.scale));
					vertices.push(new V2(23.5/_box2D.scale, 86/_box2D.scale));
					vertices.push(new V2(29.5/_box2D.scale, 82/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(31.5/_box2D.scale, 1/_box2D.scale));
					vertices.push(new V2(31.5/_box2D.scale, 2/_box2D.scale));
					vertices.push(new V2(26.5/_box2D.scale, 2/_box2D.scale));
					vertices.push(new V2(30/_box2D.scale, -0.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(7.5/_box2D.scale, 76/_box2D.scale));
					vertices.push(new V2(12/_box2D.scale, 81.5/_box2D.scale));
					vertices.push(new V2(10/_box2D.scale, 81.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(12/_box2D.scale, 81.5/_box2D.scale));
					vertices.push(new V2(7.5/_box2D.scale, 76/_box2D.scale));
					vertices.push(new V2(-0.5/_box2D.scale, 46/_box2D.scale));
					vertices.push(new V2(23.5/_box2D.scale, 86/_box2D.scale));
					vertices.push(new V2(23.5/_box2D.scale, 87/_box2D.scale));
					vertices.push(new V2(20.5/_box2D.scale, 89/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(44/_box2D.scale, 79.5/_box2D.scale));
					vertices.push(new V2(45/_box2D.scale, 80.5/_box2D.scale));
					vertices.push(new V2(39.5/_box2D.scale, 81/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(44/_box2D.scale, 79.5/_box2D.scale));
					vertices.push(new V2(49.5/_box2D.scale, 81/_box2D.scale));
					vertices.push(new V2(45/_box2D.scale, 80.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(-0.5/_box2D.scale, 46/_box2D.scale));
					vertices.push(new V2(-0.5/_box2D.scale, 41/_box2D.scale));
					vertices.push(new V2(58.5/_box2D.scale, 41/_box2D.scale));
					vertices.push(new V2(58.5/_box2D.scale, 47/_box2D.scale));
					vertices.push(new V2(49.5/_box2D.scale, 81/_box2D.scale));
					vertices.push(new V2(44/_box2D.scale, 79.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(58.5/_box2D.scale, 41/_box2D.scale));
					vertices.push(new V2(-0.5/_box2D.scale, 41/_box2D.scale));
					vertices.push(new V2(26.5/_box2D.scale, 2/_box2D.scale));
					vertices.push(new V2(31.5/_box2D.scale, 2/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(23.5/_box2D.scale, 87/_box2D.scale));
					vertices.push(new V2(28.5/_box2D.scale, 124/_box2D.scale));
					vertices.push(new V2(21.5/_box2D.scale, 92/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(28.5/_box2D.scale, 80/_box2D.scale));
					vertices.push(new V2(-0.5/_box2D.scale, 46/_box2D.scale));
					vertices.push(new V2(40/_box2D.scale, 76.5/_box2D.scale));
					vertices.push(new V2(39/_box2D.scale, 77.5/_box2D.scale));
					
					_tab.push(vertices);
					vertices = new Vector.<V2>();
											
			        vertices.push(new V2(23.5/_box2D.scale, 86/_box2D.scale));
					vertices.push(new V2(-0.5/_box2D.scale, 46/_box2D.scale));
					vertices.push(new V2(28.5/_box2D.scale, 80/_box2D.scale));
					
					_tab.push(vertices);
					
					break;
			
			}
		}

		protected function _getDensity():Number {

			switch (peObject) {
				
				case "Rocket2":
					return 1;
					break;
			
			}

			return 1;
		}
		
		protected function _getFriction():Number {
			
			switch (peObject) {
				
				case "Rocket2":
					return 0.6;
					break;
			
			}

			return 0.6;
		}
		
		protected function _getRestitution():Number {
			
			switch (peObject) {
				
				case "Rocket2":
					return 0.3;
					break;
			
			}

			return 0.3;
		}
	}
}
