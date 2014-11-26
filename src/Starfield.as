package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	/**
	 * implements a simple starfield
	 * @author Richard Marks
	 */
	public class Starfield extends Graphic
	{
		// stars is [star1, star2, star3, etc]
		// star# is [graphic, x, y, color, speed]
		private var stars:Array;
		
		// number of stars
		private var fieldDensity:int;
		private var fieldColors:Array;
		
		override public function update():void 
		{
			// move stars from the bottom of the screen to the top
			for each(var star:Star in stars)
			{
				star.position.x -= star.speed;
				if (star.position.x < 0)
				{
					// new random x position and warp back to bottom
					star.position.x = FP.width;
					star.position.y = Math.floor(Math.random()*Constants.GAME_HEIGHT);
				}
			}
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void 
		{
			for each(var star:Star in stars)
			{
				star.graphic.render(target, new Point(star.position.x+FP.camera.x, star.position.y+FP.camera.y), camera);
			}
		}
		
		/**
		 * creates a new starfield
		 * @param	density - number of stars
		 * @param	colors - an array of unsigned integers for each star color depth
		 */
		public function Starfield(density:int = 300, colors:Array = null) 
		{
			if (colors == null)
			{
				colors = [0x444444, 0x999999, 0xBBBBBB, 0xFFFFFF, 0xAAAAFF, 0xFFAA99];
			}
			
			if (density > 1000)
			{
				density = 1000;
			}
			
			fieldDensity = density; 
			fieldColors = colors;
			active = true;
			visible = true;
			
			CreateField();
		}
		
		// creates the starfield
		private function CreateField():void
		{
			// new array of stars
			stars = new Array;
			
			for (var i:int = 0; i < fieldDensity; i++)
			{
				// star is [graphic, x, y, color, speed]
				var star:Star = new Star();
				
				// random position
				star.position.x = (Math.random() * FP.width);
				star.position.y = Math.random() * 550;
				
				// random speed based on number of available colors
				star.speed= Math.floor(Math.random()*fieldColors.length);
				
				// color based on speed
				star.color = fieldColors[star.speed];
				
				// star graphic itself
				star.graphic = Image.createRect(1,1, star.color,1);
				
				// add star to the stars array
				stars.push(star);
			}
		}	
	}
}

	class Star {
		//star is [graphic, x, y, color, speed]
		public var position:flash.geom.Point;
		public var color:uint;
		public var speed:Number;
		public var graphic: net.flashpunk.graphics.Image;
		
		public function Star() {
			position = new flash.geom.Point();
		}
	}
	 