package levels 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import flash.display.BitmapData;
	import net.flashpunk.FP;
	import punk.fx.effects.FX;
	import punk.fx.effects.GlitchFX;
	import punk.fx.effects.ScanLinesFX;
	import punk.fx.graphics.FXImage;
	import punk.fx.FXMan;
	import punk.fx.graphics.FXText;
	import ship.Node;

	public class LevelDescriptor extends Entity
	{
		
		private var txtName:TypeText
		private var txtBestTime:FXText;
		private var txtBestScore:FXText;
		private var image:FXImage;
		private var fxOn:Boolean;
		private var fxTimer:int;
		private var scanLines:ScanLinesFX;
		private var glitch:GlitchFX;
		private var node:Node;
		private var effectTimeLimit:int;
		private var glitchTime:int;
		private var glitchTimeLimit:int;
		public function LevelDescriptor() 
		{
			super(0, 0);
			effectTimeLimit = 10;
			glitchTime = 0;
			var bitmap:BitmapData = new BitmapData(250, 505, true, 0x000000);
			txtName = new TypeText(5, "_");
			Draw.setTarget(bitmap);
			Draw.rectPlus(0, 0, 250, 500, 0xff0000, 0.3, false, 4);
			txtBestTime = new FXText("", 10, 170);
			txtBestScore = new FXText("", 10, 150);
		
			txtBestScore.color = 0x00ff00;
			txtBestTime.color = 0x00ff00;
			txtBestScore.alpha = txtBestTime.alpha = txtName.alpha = 0.6;
			
			txtName.font = "MainFont";
			txtBestScore.font = "MainFont";
			txtBestTime.font = "MainFont";
			
			glitch = new GlitchFX(20);
			image = new FXImage(bitmap);
			addGraphic(image);
			addGraphic(txtName);
			addGraphic(txtBestTime);
			addGraphic(txtBestScore);
			
			
			
			scanLines = new ScanLinesFX();
			FXMan.add(image, scanLines);
			FXMan.add(txtName, glitch);
			FXMan.add(txtBestTime, glitch);
			FXMan.add(txtBestScore, glitch);
		}
		
		public function setNode(node:Node):void {
			this.node = node;
			txtName.setText("");
			txtBestTime.text = "";
			txtBestScore.text = "";
			scanLines.noiseAmount = 100;
			scanLines.scanLinesGap = 5;
			scanLines.scanLinesThickness = 1;
			scanLines.scanLines = true;

			fxOn = true;
			txtName.disable();
		}
		
		override public function update():void {
			if (fxOn) {
				fxTimer++;
				if (fxTimer > effectTimeLimit) {
					fxOn = false;
					fxTimer = 0;
					txtName.setText(node.getMetaData().getName());
					txtBestScore.text = "High Score:\t" + node.getSaveData().getHighScore();
					txtBestTime.text = "Best Time:\t" + node.getSaveData().getBestTime();
					//FXMan.clear();
					scanLines.noiseAmount = 0;
					scanLines.scanLines = true;
					
					txtName.enable();
				}
			}else{
				txtName.update();
				scanLines.scanLinesOffset += 1;
				scanLines.redrawScanLines();
			}
			
			if (glitchTime >= glitchTimeLimit) {
				glitchTimeLimit = (Math.random() * 120);
				glitchTime = 0;
				glitch.maxHeight = (Math.random() * 60) + 20;
				glitch.maxSlide = 100;
			}else {
				glitch.maxHeight = 0;
				glitchTime++;
			}
		}
	}

}