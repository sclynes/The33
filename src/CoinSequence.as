package  
{
	import net.flashpunk.graphics.Spritemap
	import net.flashpunk.FP;
	import levels.Sector;
	import sfx.SfxrSynth;
	import sfx.SfxrParams;
	import flash.utils.ByteArray;
	import sfx.SfxrSynth;
	/**
	 * ...
	 * @author 
	 */
	public class CoinSequence 
	{
		private var coins:Vector.<Coin>
		private var timer:int;
		private var id:int;
		private var activeCoin:Coin;
		private var allCoinsCollected:Boolean;
		private var coinSynth:SfxrSynth
		private var coinSuccessSynth:SfxrSynth;
		private var coinStartFrequency:Number;
		private var coinMaxFrequency:Number;
		private var coinFrequencyStep:Number;
		
		public function CoinSequence(timer:int=100) 
		{
			this.id = -1;
			this.timer = timer;
			this.allCoinsCollected = false;
			activeCoin = null;
			coinSynth = new SfxrSynth;
			coinSuccessSynth = new SfxrSynth;
			coinSuccessSynth.loadFromSFXFile(new Assets.SFX_COIN_SUCCESS);
			coinSynth.loadFromSFXFile(new Assets.SFX_COIN);
			coinStartFrequency = coinSynth.params.startFrequency;
			coinMaxFrequency = 0.85;

		}
		
		
		public function addCoin(coin:Coin):void {
			if (coins == null) {
				coins = new Vector.<Coin>;
			}

			coins.push(coin);
		}
		
		public function get frequencyStep():Number {
			return (coinMaxFrequency - coinStartFrequency) / coins.length;
		}
		
		public function getCoins():Vector.<Coin> {
			return coins;
		}
		
		public function toString():String {
			var ret:String;
			for each(var coin:Coin in coins) {
				ret += "\tcoin index:" + coin.getCoinIndex() + "\n";
			}
			return ret;
		}
		
		public function getActiveCoin():Coin {
			return activeCoin;
		}
		
		public function activateNext():void {
			activeCoin.setCollected();
			var nextIndex:int = activeCoin.getCoinIndex() + 1;
			if (nextIndex >= coins.length) {
				collectedAll();
				return;
			}
			else {
				var newCoin:Coin;
				for each(newCoin in coins) {
					if (newCoin.getCoinIndex() == nextIndex) break;
				}
				if (newCoin == null) {
					collectedAll();
					return;
				}
				setActiveCoin(newCoin);
			}
		}
		
		public function start():void {
			for each(var coin:Coin in coins) {
				if (coin.getCoinIndex() == 0) {
					setActiveCoin(coin);
				}else {
					coin.deactivate();
				}
			}
	
			coinSynth.params.startFrequency = coinStartFrequency;
		}
		
		public function collectedAll():void {
			for each(var coin:Coin in coins) coin.getGraphic().visible = false;
			FP.world.removeList(coins);
			allCoinsCollected = true;
			coinSuccessSynth.play();
		}
		
		public function areAllCoinsCollected():Boolean {
			return allCoinsCollected;
		}
		
		private function setActiveCoin(coin:Coin):void {
			if(activeCoin!=null)activeCoin.deactivate();
			activeCoin = coin;
			coin.activate();
			trace(coinSynth.params.startFrequency);
			if (coin.getCoinIndex() != 0) {
				coinSynth.play();
			//	coinSynth.params.startFrequency += frequencyStep;
			}
		}
		
	}

}