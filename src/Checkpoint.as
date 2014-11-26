package  
{
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author 
	 */
	public class Checkpoint extends Entity
	{
		private var spriteMap:Spritemap;
		private var positionData:LocalPositionData;
		private var activated:Boolean;
		
		public function Checkpoint(positionData:LocalPositionData) 
		{
			type = "checkpoint";
			this.positionData = positionData;
			spriteMap = new Spritemap(Assets.LASER, 8, 16, onAnimationComplete);
			spriteMap.add("idle", [0, 1, 2, 3], 0.1);
			spriteMap.add("activated", [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17], 0.25, false);
			spriteMap.add("checkpointLoop", [18, 19], 0.1, true);
			setHitbox(8, 16, 0, 0);
			graphic = spriteMap;
			super(positionData.getTile().x * Constants.TILE_SIZE, positionData.getTile().y * Constants.TILE_SIZE);
			activated = false;
			active = false;
		}
		
		public function getGraphic():Graphic{
			return spriteMap;
		}
		
		public function doIdle():void {
			spriteMap.play("idle");
		}
		public function doActivated():void {
			spriteMap.play("activated");
			activated = true;
		}
		public function doCheckpointLoop():void {
			spriteMap.play("checkpointLoop");
		}
		
		public function getPositionData():LocalPositionData {
			return positionData;
		}
		
		private function onAnimationComplete():void {
			if (activated) {
				activated = false;
				doCheckpointLoop();
			}
		}
		
	}

}