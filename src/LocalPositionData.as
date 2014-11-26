package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class LocalPositionData 
	{
		
		private var tile:Point;
		private var sector:int;
		public function LocalPositionData(tile:Point, sector:int) 
		{
			this.tile = tile;
			this.sector = sector;
		}
		
		public function getTile():Point {
			return tile;
		}
		public function getSector():int {
			return sector;
		}
	}

}