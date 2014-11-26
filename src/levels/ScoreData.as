package levels 
{
	/**
	 * ...
	 * @author 
	 */
	public class ScoreData 
	{
		private var timeTaken:int;
		private var cash:int;
		private var groundedBonus:int;
		private var gravitySwitches:int;
		private var brickBonus:int;
		public function ScoreData(timeTaken:int, cash:int, groundedBonus:int, gravitySwitches:int, brickBonus:int) 
		{
			this.timeTaken = timeTaken;
			this.cash = cash;
			this.brickBonus = brickBonus;
			this.groundedBonus = groundedBonus;
			this.gravitySwitches = gravitySwitches;
		}
		
		public function getTimeTaken():int {
			return timeTaken;
		}
		
		public function getCash():int {
			return cash;
		}
		public function getGroundedBonus():int {
			return groundedBonus;
		}
		public function getGravitySwitches():int {
			return gravitySwitches;
		}
		
		public function getBrickBonus():int {
			return brickBonus;
		}
		
		
	}

}