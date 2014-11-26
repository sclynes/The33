package states 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import levels.Level;
	import levels.LevelMeta;
	import levels.LevelSaveData;
	import levels.ScoreData;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Data;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author 
	 */
	public class LevelCompleteState extends World implements IState
	{
		private var scoreData:ScoreData;
		private var levelMeta:LevelMeta;
		private var ghostString:String;
		private var txtLevelName:Text;
		private var enterPressed:Boolean;
		
		private var txtNewFastestTime:Text;
		private var txtTimeBonus:Text;
		private var txtBrickBonus:Text;
		private var txtPenalties:Text;
		
		private var txtScore:Text;
		private var brickScore:int;
		private var timeScore:int;
		private var penalties:int;
		private var overallScore:int;
		
		public function LevelCompleteState(levelMeta:LevelMeta, scoreData:ScoreData, saveData:LevelSaveData, ghostString:String) 
		{
			brickScore = 0;
			timeScore = 0;
			this.penalties = 0;
			this.scoreData = scoreData;
			this.levelMeta = levelMeta;
			this.ghostString = ghostString;
			txtLevelName = new Text(levelMeta.getName(), 10, 20);
			txtLevelName.size = 50;
			
			var txtLevelName2:Text = new Text(txtLevelName.text, 12, 22);
			txtLevelName2.color = 0xaaaa00;
			txtLevelName2.size = txtLevelName.size;
			enterPressed = false;
			txtLevelName.color = 0xff0000;

			
			overallScore = calculateScore();
			
			if (overallScore > saveData.getHighScore()) {
				txtNewFastestTime = new Text("NEW HIGH SCORE", 110, 200);
				txtNewFastestTime.size = 80;
				addGraphic(txtNewFastestTime);
				saveData.setTimeTaken(scoreData.getTimeTaken());
				saveData.setGhost(ghostString);
				saveData.setHighScore(overallScore);
			}
			txtScore = new Text("your score:" + overallScore + "\thigh score: " + saveData.getHighScore(), 100, 300);
			txtScore.color = 0xff0000;
			
			txtTimeBonus = new Text("Time Bonus: " + timeScore, 100, 320);
			txtBrickBonus = new Text("Brick Bonus: " + brickScore, 100, 340);
			txtPenalties = new Text("Penalties: " + penalties, 100, 360);
			
			txtTimeBonus.color = 0x00ff00;
			txtBrickBonus.color = 0x00ff00;
			txtPenalties.color = 0xff0000;

			/*var underlineImage:Image = new Image(new BitmapData(800, 10, false, 0xff0000));
			var underlineImage2:Image = new Image(new BitmapData(800, 2, false, 0xffff00));
			underlineImage.x = underlineImage2.x = txtLevelName.x;
			underlineImage.y = txtLevelName.y + 120;
			underlineImage2.y = txtLevelName.y + 130;
			addGraphic(underlineImage);
			addGraphic(underlineImage2);*/
			addGraphic(txtScore);
			addGraphic(txtLevelName2);
			addGraphic(txtLevelName);
			addGraphic(txtTimeBonus);
			addGraphic(txtBrickBonus);
			addGraphic(txtPenalties);
			
			saveData.writeData();
		}
		
		private function calculateScore():int {
			brickScore = (scoreData.getBrickBonus() / levelMeta.getNumberOfBricks()) * 10000;
			
			if (scoreData.getTimeTaken() > levelMeta.getPar()) timeScore = 0;
			else timeScore = ((Math.abs(scoreData.getTimeTaken() - levelMeta.getPar())) / levelMeta.getPar()) * 10000;
			
			penalties = scoreData.getGravitySwitches() * 50;
			
			return (timeScore + brickScore) - penalties;
		}
		
		override public function update():void {
			getInput();
		}
		
		public function getInput():void {
			if (Input.pressed(Key.ENTER)) {
				if (!enterPressed) {
					Main.stateManager.switchState(new ShipState());
					enterPressed = true;
				}
			}else {
				enterPressed = false;
			}
		}
		
		public function onSwitch():void {
			
		}
	}

}