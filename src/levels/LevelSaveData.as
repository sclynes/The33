package levels 
{
	import net.flashpunk.utils.Data;
	/**
	 * ...
	 * @author 
	 */
	public class LevelSaveData 
	{
		private var bestTime:int;
		private var ghostString:String;
		private var cash:int;
		private var gravitySwitches:int;
		private var groundedBonus:int;
		private var score:int;
		private var levelId:int;
		public function LevelSaveData(levelId:int) 
		{
			this.levelId = levelId;
			Data.load("level_" + levelId.toString());
			bestTime = Data.readInt("time");
			cash = Data.readInt("cash");
			ghostString = Data.readString("ghost");
			gravitySwitches = Data.readInt("gravitySwitches");
			groundedBonus = Data.readInt("groundedBonus");
			score = Data.readInt("score");
		}
		
		public function getBestTime():int {
			return bestTime;
		}
		
		public function getGhostString():String {
			return ghostString;
		}
		
		public function getCash():int {
			return cash;
		}
		
		public function getGravitySwitches():int {
			return gravitySwitches;
		}
		public function getGroundedBonus():int {
			return groundedBonus;
		}
		
		public function setGhost(ghostString:String):void {
			this.ghostString = ghostString;
		}
		
		public function setCash(cash:int):void {
			this.cash = cash;
		}
		public function setGroundedBonus(bonus:int):void {
			this.groundedBonus = bonus;
		}
		public function setGravitySwitches(switches:int):void {
			this.gravitySwitches = switches;
		}
		public function setTimeTaken(time:int):void {
			bestTime = time;
		}
		
		public function getHighScore():int {
			return score;
		}
		
		public function setHighScore(val:int):void {
			score = val;
		}
		
		public function writeData():void {
			Data.load("level_" + levelId.toString());
			Data.writeString("ghost", ghostString);
			Data.writeInt("time",bestTime);
			Data.writeInt("cash", cash);
			Data.writeInt("gravitySwitches", gravitySwitches);
			Data.writeInt("groundedBonus", groundedBonus);
			Data.writeInt("score", score);
			Data.save("level_" + levelId.toString());
		}
		
		public function clear():void {
			Data.load("level_" + levelId.toString());
			Data.writeString("ghost", "");
			Data.writeInt("time",int.MAX_VALUE);
			Data.writeInt("cash", 0);
			Data.writeInt("gravitySwitches", 0);
			Data.writeInt("groundedBonus", 0);
			Data.writeInt("score", 0);
			Data.save("level_" + levelId.toString());
		}
		
		
	}

}