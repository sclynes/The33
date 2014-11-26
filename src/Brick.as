package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author 
	 */
	public class Brick extends Entity
	{
		private var col:int;
		private var row:int;
		private var spriteMap:Spritemap;
		private var energy:int;
		
		public function Brick(col:int, row:int, energy:int=3) 
		{
			type = "brick";
			spriteMap = new Spritemap(Assets.LASER, 16, 16);
			this.col = col;
			this.row = row;
			this.x = col * Constants.TILE_SIZE;
			this.y = row * Constants.TILE_SIZE;
			graphic = spriteMap;
			setHitbox(16, 16, 0, 0);
			this.energy = energy;
			active = false;
		}
		
		public function getCol():int {
			return col;
		}
		public function getRow():int {
			return row;
		}
		public function damage():Boolean {
			energy -= 1;
			spriteMap.frame = 3-energy;
			if (energy <= 0) return true;
			return false;
		}
		
		public function getEnergy():int {
			return energy;
		}
		
	}

}