package levels 
{
	import states.GameState;
	
	import net.flashpunk.FP;
	import flash.geom.Point;
	import com.demonsters.debugger.MonsterDebugger;
	public class StaticLevel extends Level
	{
		public function StaticLevel(meta:LevelMeta,w:GameState) 
		{
			super(meta, w);
			currentSectorIndex = 0;
			setCurrentSector(playerStart.getSector());
		}
		
		override public function update():void {
			player.getInput();
			
			if (player.x - FP.camera.x > Constants.GAME_WIDTH)setSector(new Point(1, 0));
			else if (player.x - FP.camera.x < 0) setSector(new Point(-1,0));
			else if (player.y - FP.camera.y > Constants.GAME_HEIGHT) setSector(new Point(0, 1));
			else if (player.y - FP.camera.y < 0) setSector(new Point(0, -1));

			//FP.camera.x = player.x - 50;
			super.update();
		}
		
		public function setSector(direction:Point):void {
			currentSectorIndex += direction.x + (direction.y * sectorsWide);

			FP.camera.x += direction.x * Constants.GAME_WIDTH;
			FP.camera.y += direction.y * Constants.GAME_HEIGHT
			super.setCurrentSector(currentSectorIndex);
		}
		
	}

}