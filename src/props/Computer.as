package props 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	public class Computer extends Entity
	{
		private var image:Image; 
		private var overlay:Image;
		public function Computer() 
		{
			super(0, 0);
			//active = false;
			collidable = false;
			image = new Image(Assets.COMPUTER, new Rectangle(0, 0, 57, 66));
			overlay = new Image(Assets.COMPUTER, new Rectangle(57, 0, 57, 66));
			addGraphic(image);
			addGraphic(overlay);
		}
		
		override public function render():void {
		//	overlay.alpha -= 0.01;
			super.render();
		}
		
	}

}