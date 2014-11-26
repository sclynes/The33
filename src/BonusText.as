package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author 
	 */
	public class BonusText extends Entity
	{
		private var image:Image;
		private var direction:int;
		private var speed:Number;
		public function BonusText() 
		{
			image = new Image(Assets.BONUS_TEXT);
			direction = 0;
			speed = 50;
			
			graphic = image;
			super();
		}
		
		public function init(dir:int, px:int, py:int):void {
			direction = dir;
			image.alpha = 1;
			speed = 5;
			x = px;
			y = py;
		}
		
		override public function update():void {
			y += direction * speed;
			if(speed>0.5)speed /= 1.8;
			
			image.alpha -= 0.05;
			if (image.alpha <= 0) FP.world.recycle(this);
			
			super.update();
		}
	}

}