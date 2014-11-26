package  
{
	import net.flashpunk.graphics.Text;
	import punk.fx.graphics.FXText;
	import sfx.SfxrSynth;
	/**
	 * ...
	 * @author 
	 */
	public class TypeText extends FXText
	{
		private var speed:int;
		private var fullText:String;
		private var textFullyTyped:Boolean
		private var cursor:String;
		private var nextIndex:int;
		private var cursorVisible:Boolean;
		private var previousCursorVisible:Boolean;
		private var frameNumber:int;
		private var sfxTyping:SfxrSynth;
		private var enabled:Boolean;
		public function TypeText(speed:int, cursor:String) 
		{
			super("");
			textFullyTyped = false;
			this.speed = speed;
			this.nextIndex = 0;
			frameNumber = 0;
			enabled = false;
			sfxTyping = new SfxrSynth();
			sfxTyping.loadFromSFXFile(new Assets.SFX_TYPING);

			width = 230;
			size = 30;
			x = 10;
			y = 5;
			color = 0xff0000;
			wordWrap = true;
			this.cursor = cursor;
			active = true;
			previousCursorVisible = false;
		}
		
		public function setText(fullText:String):void {
			this.fullText = fullText;
			textFullyTyped = false;
			nextIndex = 0;
		}
		
		override public function update():void {
			if(enabled){
				frameNumber++;
				
				if (!textFullyTyped) {
					if (frameNumber % speed == 0) {
					//	if (nextIndex % 2)
					sfxTyping.playMutated(0.01);
						text = fullText.substring(0, nextIndex);
						nextIndex++;
						if (nextIndex == fullText.length) textFullyTyped = true;
					}
				}
				if (frameNumber % 30 == 0) {
					cursorVisible = !cursorVisible;
					if (cursorVisible) text = text + cursor;
					else {
						if (textFullyTyped) text = fullText;
						else text = text.substring(0, text.length-1);
					}
				}
			}
			super.update();
		}
		
		public function enable():void {
			enabled = true;
		}
		public function disable():void {
			enabled = false;
			text = "";
		}
		
		
	}

}