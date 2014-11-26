package 
{
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;	
	import states.GameState;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Stamp;
	import states.LevelSelectState;
	import states.MainMenuState;
	import states.ShipState;
	import states.StateManager;
	import flash.events.KeyboardEvent;
	import net.flashpunk.graphics.Text;
	import flash.system.Capabilities;

	public class Main extends Engine
	{
		public static var stateManager:StateManager = new StateManager();
		
		public function Main():void 
		{
			super(1024, 576, 60, true);
			FP.screen.color = 0x000000;
			stateManager.pushState(new MainMenuState());
	        FP.console.enable();
			FP.console.visible = false;
			Text.font = "MainFont";
			Input.mouseCursor = "hide";
			addEventListener(Event.ACTIVATE, onStageAdded);
		}
		
		override public function setStageProperties():void 
		{
			super.setStageProperties();
			//var s:Number = Capabilities.screenResolutionY / Constants.GAME_HEIGHT;
			//FP.screen.scale = s;
		}
		
		public function onStageAdded(e:Event):void {
			removeEventListener(Event.ACTIVATE, onStageAdded);
			FP.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		public static function setResolution(rows:int, cols:int):void {
			//var factor:Number = Math.min(Capabilities.screenResolutionX / (cols * Constants.TILE_SIZE), Capabilities.screenResolutionY / (rows * Constants.TILE_SIZE));
			//FP.screen.scale = factor;
			FP.resize(Constants.GAME_WIDTH, Constants.GAME_HEIGHT);
		}
		
		override public function update():void {
			if (Input.pressed(Key.F)) {
				
				if(stage.displayState == StageDisplayState.NORMAL){
					FP.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					var s:Number = Capabilities.screenResolutionY / Constants.GAME_HEIGHT;
					FP.screen.scale = s;
				}else {
					FP.stage.displayState = StageDisplayState.NORMAL;
					FP.screen.scale = 1;
				}
			}
			if (Input.pressed(Key.E)) FP.console.visible = !FP.console.visible;

			
			super.update();
		}	
	
	}
}