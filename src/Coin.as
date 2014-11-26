package  
{
	/**
	 * ...
	 * @author 
	 */
	import flash.display.Graphics;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Graphic;
	public class Coin extends Entity
	{
		private var positionData:LocalPositionData;
		private var _graphic:Image;
		private var coinIndex:int;
		private var isActive:Boolean;
		private var spriteMap:Spritemap;
		private var sequence:CoinSequence;
		private var activateTime:int;
		private var limit:int;
		public function Coin(positionData:LocalPositionData, coinIndex:int=-1, limit:int=75) 
		{
			type = "coin";
			
			spriteMap = new Spritemap(Assets.COIN, 16, 16);
			spriteMap.add("inactive", [0], 0, false);
			spriteMap.add("collected", [0], 0,false);
			spriteMap.add("active", [1], 0);
			graphic = spriteMap;

			this.limit = limit;
			spriteMap.play("inactive");
			isActive = false;
			activateTime = 0;
			active = false;
			this.positionData = positionData;
			_graphic = new Image(Assets.COIN);
			setHitbox(16, 16, 0, 0);
			super(positionData.getTile().x * Constants.TILE_SIZE, positionData.getTile().y * Constants.TILE_SIZE);	
		}
		
		public function getGraphic():Graphic {
			return graphic;
		}

		
		override public function update():void {
		    if (this.coinIndex != 0 && isActive) {
				if (activateTime > limit) {
					sequence.start();
				}
				else activateTime++;
				trace(limit);
			}
			super.update();
		}
		
		public function getSector():int {
			return positionData.getSector();
		}
		public function setSequence(seq:CoinSequence):void {
			sequence = seq;
		}
		
		public function getSequence():CoinSequence{
			return sequence;
		}
		
		public function setCoinIndex(index:int):void {
			coinIndex = index;
		}
		
		public function getCoinIndex():int {
			return coinIndex;
		}
		
		public function getIsActive():Boolean {
			return isActive;
		}
		public function activate():void{
			spriteMap.play("active");
			isActive = true;
		}
		public function deactivate():void{
			spriteMap.play("inactive");
			activateTime = 0;
			isActive = false;
		}
			
		public function setCollected():void {
			spriteMap.play("inactive")
		}
		
		public function setTimeLimit(limit:int):void {
			this.limit = limit;
		}
	}

}