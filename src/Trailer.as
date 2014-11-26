package  
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	 import net.flashpunk.FP;  
 	 import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author 
	 */
	public class Trailer extends Entity
	{
		private var image:Image;
		public function Trailer(entity:Player, position:Point) 
		{
			this.image = new Image(Assets.PLAYER, entity.spriteMap.clipRect);
			image.flipped = entity.spriteMap.flipped;
			image.angle = entity.spriteMap.angle;
			image.alpha = 0.2;
			position.x += 8*(entity.getVelocity().y>0?-1:1);
	//		image.centerOrigin();
			graphic = image;
			super(position.x, position.y-(entity.gravityDirection*entity.halfHeight), image);
		}
		
		override public function update():void {
			this.image.alpha -= 0.02;
			if (this.image.alpha <= 0) FP.world.remove(this);
			super.update();
		}
		
	}

}