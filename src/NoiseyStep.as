package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author 
	 */
	public class NoiseyStep extends Entity
	{
		private var bitmap:BitmapData;
		private var image:Image;
		private var level:int;
		private var inc:int;
		private var speed:Number;
		public function NoiseyStep() 
		{
			bitmap = new BitmapData(16, 16, false);
			image = new Image(bitmap);
			speed = 0.6;
			graphic = image;
		}
		
		public function init(dir:int, px:int,py:int):void {
			level = 0;
			x = px;
			y = py;
			speed = 0.6;
			inc = 1;
			image.alpha = 0.1;
		}
		
		override public function update():void {
			image.alpha += inc*speed;
			if (image.alpha > 0.1) {
				inc = -1;
				speed = 0.05;
			}
			else if (image.alpha < 0) FP.world.recycle(this);
			
			super.update();
		}
	}

}