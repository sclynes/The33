package  
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	public class Blinker extends Entity
	{
		private var positionData:LocalPositionData;

		private static const im:Image = new Image(Assets.SOLID_TILESET, new Rectangle(64, 32, 16, 16));

		private var offset:int;
		private var onTime:int;
		private var offTime:int;
		private var frameNumber:int;
		private var lastSwitch:int;
		private var isOn:Boolean;

		public function Blinker(positionData:LocalPositionData) 
		{
			type = "level";

			isOn = false;
			offset = 0;
			offTime = 120;
			onTime = 240;
			frameNumber = 0;

			this.positionData = positionData;
			setHitbox(16, 16, 0, 0);
			graphic = im;
			super(positionData.getTile().x * Constants.TILE_SIZE, positionData.getTile().y * Constants.TILE_SIZE);
		}

		public function setOffTime(num:int):void {
			offTime = num;
			trace(offTime);
		}
		public function setOffset(num:int):void {
			offset = num;
			trace(offset);
		}
		public function setOnTime(num:int):void {
			onTime = num;
			trace(onTime);
		}

		override public function update():void {
			frameNumber++;
			if (frameNumber > offset) {
				if (isOn) {
					if (frameNumber - lastSwitch > onTime) {
						deactivate();
					}
				}else {
					if (frameNumber - lastSwitch > offTime) {
						activate();
						if (collide("player", x, y)) {
							var player:Player = Player(collide("player", x, y));
							player.die();
						}
					}
				}
			}

			super.update();
		}

		public function init():void {
			frameNumber = 0;
			lastSwitch = 0;
			activate();
		}

		private function deactivate():void {
			isOn = false;
			lastSwitch = frameNumber;
			collidable = false;
			visible = false;
		}

		private function activate():void {
			isOn = true;
			lastSwitch = frameNumber;
			collidable = true;
			visible = true;
		}
	}

}