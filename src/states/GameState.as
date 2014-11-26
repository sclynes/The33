package  states
{
	import flash.display.BitmapData;
	import flash.events.TextEvent;
	import levels.Level;
	import levels.LevelMeta;
	import levels.LevelSaveData;
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	import flash.system.Capabilities  
	import net.flashpunk.FP; 
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Text
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import flash.geom.Point;
	import levels.ScoreData;
	import sfx.SfxrSynth;
	
	public class GameState extends World implements IState
	{
		private var frameNumber:int;
		private var _gameRunning:Boolean;
		private var level:Level;
		private var player:Entity;
		private var currentSector:int;
		private var backgroundImage:Image;
		private var backgroundEntity:Entity;
		private var levelSaveData:LevelSaveData;
		private var levelMeta:LevelMeta;
		
		public function GameState(metaData:LevelMeta) 
		{
				levelSaveData = new LevelSaveData(metaData.getId());
				levelMeta = metaData;
				super();
				Text.font = "MainFont";

				FP.screen.color = 0x000000;
				level = new Level(metaData, this);
				frameNumber = 0;
	
				FP.camera.x = FP.camera.y = 0;

				_gameRunning = false;
		}
		
		public function moveCamera(direction:Point):void {
			currentSector += direction.x + (direction.y * level.sectorsWide);

			FP.camera.x += direction.x * Constants.GAME_WIDTH;
			FP.camera.y += direction.y * Constants.GAME_HEIGHT
			level.setCurrentSector(currentSector);
			
		//	backgroundEntity.active = false;
		//	backgroundEntity.collidable = false;

		//	if (level.getCurrentSector().getBackground() != null) {
			//	backgroundEntity.graphic = level.getCurrentSector().getBackground();
			//	backgroundEntity.x = FP.camera.x;
			//    backgroundEntity.y = FP.camera.y;
			//	backgroundImage.visible = true;
		//	}
		//	else {
		//		backgroundEntity.visible = false;
		//	}
		}
		
		public function resetFrameNumber():void {
			frameNumber = 0;
		}
		
		
		override public function begin():void {
			add(level);
			player = add(new Player(level, this, levelSaveData.getGhostString()));
		    player.layer = -1;
		}
		
		 override public function update():void {
			frameNumber++;

			_gameRunning = true;
			super.update();
		}
		
		public function getFrameNumber():int{
			return frameNumber;
		}
		
		public function gameRunning():Boolean {
			return _gameRunning;
		}
		
		override public function render():void 
		{
			super.render();
		}
		
		public function levelComplete(scoreData:ScoreData, ghostString:String):void {
			level.stopMusic();
			var levelCompleteState:LevelCompleteState = new LevelCompleteState(levelMeta, scoreData, levelSaveData, ghostString);
			Main.stateManager.switchState(levelCompleteState);
		}
		
		public function onSwitch():void {
			
		}
	}
}
