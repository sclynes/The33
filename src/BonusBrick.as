package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author 
	 */
	public class BonusBrick extends Entity
	{
		private var positionData:LocalPositionData;
		private var image:Image
		private var tileIndex:int;
		private var spritemap:Spritemap;
		private var bonus:int;
		public function BonusBrick(positionData:LocalPositionData, tileIndex:int) 
		{
			type = "bonusBrick";
			spritemap = new Spritemap(Assets.BONUS_BRICK, 16, 16);
			bonus = 1000;
			spritemap.add("active", [0]);
			spritemap.add("inactive-up", [1]);
			spritemap.add("inactive-down", [2]); 
			
			this.tileIndex = tileIndex;
			this.positionData = positionData;
			image = new Image(Assets.BONUS_BRICK, new Rectangle(0, 0, 16, 16));
			setHitbox(20, 16, 2, 0);
			graphic = spritemap;
			super(positionData.getTile().x * Constants.TILE_SIZE, positionData.getTile().y * Constants.TILE_SIZE);
			active = false;
		}
		 
		
		public function getGraphic():Graphic {
			return image;
		}
		
		public function getPositionData():LocalPositionData {
			return positionData;
		}
		
		public function getSector():int {
			return positionData.getSector();
		}
		
		public function setActive():void {
			spritemap.play("active");
			collidable = true;
			y=positionData.getTile().y * Constants.TILE_SIZE
		}
		public function setInactive(dir:int):void {
			spritemap.play("inactive");
			y += (dir == 1)?1: -1;
			spritemap.frame = (dir == 1)?1:2;
			collidable = false;
		}
		
		public function getBonus():int {
			return bonus;
		}
	}

}