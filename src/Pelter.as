package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import sfx.SfxrSynth;
	/**
	 * ...
	 * @author 
	 */
	public class Pelter extends Entity
	{
		//private var spriteMap:Spritemap;
	    private var positionData:LocalPositionData;
		private var direction:Point;
		private var power:Number;
		private var spriteMap:Spritemap = new Spritemap(Assets.PELTER, 16, 16);
		
		public function Pelter(positionData:LocalPositionData, dir:int=0, power:Number = GAMEPLAY.PELT_POWER) 
		{
			type = "pelter";
			this.power = power;
			this.positionData = positionData;
			graphic = spriteMap;
			
			if(dir==0)direction = new Point(1, 0);
			else if (dir == 1) direction = new Point(0, 1);
			else if (dir == 2) direction = new Point( -1, 0);
			else if (dir == 3) direction   = new Point(0, -1);

			spriteMap.frame = dir;
			setHitbox(16, 16, 0, 0);
			trace(positionData.getTile().x);
			super(positionData.getTile().x * Constants.TILE_SIZE, positionData.getTile().y * Constants.TILE_SIZE);
		}
		
		public function setDirection(direction:Point):void {
			this.direction = direction;
		}
		
		public function getDirection():Point {
			return direction;
		}
		
		public function getPower():Number {
			return power;
		}
	}

}