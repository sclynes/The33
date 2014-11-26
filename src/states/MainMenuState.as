package states 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input
	import net.flashpunk.utils.Key
	
	public class MainMenuState extends World implements IState 
	{
		private var titleImage:Image;
		
		public function MainMenuState() 
		{
			titleImage = new Image(Assets.TITLE);
			super();
		}
		
		override public function begin():void {
			this.addGraphic(titleImage, 0, 0, 0);
			super.begin();
		}
		
		override public function update():void {
			getInput();
			super.update();
		}
		
		private function getInput():void {
			if (Input.check(Key.ENTER)) {
				Main.stateManager.switchState(new ShipState());
			}
		}
		
		public function onSwitch():void {
			
		}
	}

}