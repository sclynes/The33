package levels 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author 
	 */
	public class Sector 
	{
		private var cols:int;
		private var rows:int;
		private var checkpoints:Vector.<Checkpoint>
		private var bombs:Vector.<Bomb>;
		private var coins:Vector.<Coin>;
		private var coinSequence:CoinSequence;
		private var bricks:Vector.<Brick>;
		private var pelters:Vector.<Pelter>;
		private var lasers:Vector.<Laser>;
		private var meta:SectorMeta;
		private var exit:Exit;
	//	private var backgroundImage:Image;
		private var blinkers:Vector.<Blinker>;
		private var bonusBricks:Vector.<BonusBrick>;
		private var platforms:Vector.<Platform>
		public function Sector(cols:int, rows:int) 
		{
			this.cols = cols;
			this.rows = rows;
		}
		
		public function addBrick(col:int, row:int):void {
			if (bricks == null) bricks = new Vector.<Brick>;
			bricks.push(new Brick(col, row, 3));
		}
		
		public function getBricks():Vector.<Brick> {
			return bricks;
		}		
		
		
		public function addLaser(laser:Laser):void {
			if (lasers == null) lasers = new Vector.<Laser>;
			lasers.push(laser);
		}
		
		public function getLasers():Vector.<Laser> {
			return lasers;
		}
		
		public function getPelters():Vector.<Pelter> {
			return pelters;
		}
		
		public function getPlatforms():Vector.<Platform> {
			return platforms;
		}
		
		public function addPelter(pelter:Pelter):void {
			if (pelters == null) pelters = new Vector.<Pelter>;
			pelters.push(pelter);
		}
		
		public function addBonusBrick(bonusBrick:BonusBrick):void {
			if (bonusBricks == null) bonusBricks = new Vector.<BonusBrick>;
			bonusBricks.push(bonusBrick);
		}
		
		public function getBonusBricks():Vector.<BonusBrick> {
			return bonusBricks;
		}
		

		public function addCheckpoint(checkpoint:Checkpoint):void {
			if (checkpoints == null) checkpoints = new Vector.<Checkpoint>;
			checkpoints.push(checkpoint);
		}
		public function getCheckpoints():Vector.<Checkpoint> {
			return checkpoints;
		}
		
		public function addBomb(bomb:Bomb):void {
			if (bombs == null) bombs = new Vector.<Bomb>;
			bombs.push(bomb);
		}
		
		public function getBombs():Vector.<Bomb> {
			return bombs;
		}
		
		public function addPlatform(platform:Platform):void {
			if (platforms == null) platforms = new Vector.<Platform>;
			platforms.push(platform);
		}
		
		public function addCoin(coin:Coin):void {
			if (coinSequence == null) coinSequence = new CoinSequence();
			coinSequence.addCoin(coin);
		}
		
		public function addBlinker(blinker:Blinker):void {
			if (blinkers == null) blinkers = new Vector.<Blinker>;
			blinkers.push(blinker);
		}
		
		public function setCoins(coins:Vector.<Coin>):void {
			this.coins = coins;
		}
		
		public function getCoins():Vector.<Coin> {
			return coins;
		}
		
		public function getCoinSequence():CoinSequence {
			return coinSequence;
		}
		
		public function setMeta(m:SectorMeta):void {
		//	if(m!=null){
		//		meta = m;
		//		if (meta.background != null) this.backgroundImage = new Image(meta.background);
		//	}
		}
		public function getBackground():Image {
	//		return this.backgroundImage;
			return null;
		}
		
		public function isStarfieldActive():Boolean {
			return meta.starField;
		}
		
		public function addExit(e:Exit):void {
			exit = e;
		}
		
		public function getExit():Exit {
			return exit;
		}
		public function getBlinkers():Vector.<Blinker> {
			return blinkers;
		}
	}

}