package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Graphic;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author 
	 */
	public class Exit extends Entity
	{
		private var positionData:LocalPositionData;
		private var image:Image
		private var tileIndex:int;
		public function Exit(positionData:LocalPositionData, tileIndex:int) 
		{
			type = "exit";
			this.tileIndex = tileIndex;
			this.positionData = positionData;
			image = new Image(Assets.SOLID_TILESET, new Rectangle((tileIndex-1)*Constants.TILE_SIZE, 0, 16, 16));
			setHitbox(9, 9, -3, -3);
			graphic = image;
			super(positionData.getTile().x * Constants.TILE_SIZE, positionData.getTile().y * Constants.TILE_SIZE);
			active = false; 	
		}
		
		public function getGraphic():Graphic {
			return image;
		}
		
		public function getSector():int {
			return positionData.getSector();
		}
		
	}

}