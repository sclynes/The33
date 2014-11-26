package  
{
	import flash.display.BitmapData;
	import flash.display.SpreadMethod;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Bomb extends Entity
	{
		private var positionData:LocalPositionData;
		private var tileIndex:int;
		private static const im:Image = new Image(Assets.BOMB);
		
		public function Bomb(positionData:LocalPositionData, tileIndex:int) 
		{
			type = "bomb";
			this.tileIndex = tileIndex;
			this.positionData = positionData;
			setHitbox(9, 9, -3, -3);
			graphic = im;
			super(positionData.getTile().x * Constants.TILE_SIZE, positionData.getTile().y * Constants.TILE_SIZE);
			active = false;
		}
		 
		
		public function getGraphic():Graphic {
			return im;
		}
		
		public function getSector():int {
			return positionData.getSector();
		}
		
	}

}