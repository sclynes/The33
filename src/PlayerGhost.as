package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import punk.fx.effects.BlurFX;
	import punk.fx.FXMan;
	import punk.fx.graphics.FXSpritemap

	public class PlayerGhost extends Entity
	{
		private var playerStatesRecord:Array;
		private var playerStatesSaved:Array;
		private var currentGhostNumber:int;
		private var spritemap:	FXSpritemap;
		private var isReplaying:Boolean;
		private var isSaving:Boolean;
		private var player:Player;
		private var spriteAlpha:Number;
		
		public function PlayerGhost(player:Player, ghostString:String) 
		{
			spriteAlpha = 0.75;
			this.isReplaying = false;
			this.isSaving = true;
			this.collidable = false;
			this.player = player;
			playerStatesRecord = new Array();
			playerStatesSaved = new Array();
			spritemap = new FXSpritemap(Assets.PLAYER, 16, 16);
			super(0, 0);
			this.graphic = spritemap;
			currentGhostNumber = 0;
			spritemap.centerOO();
			this.spritemap.rate = 0.75;
			spritemap.alpha = spriteAlpha;
			if (ghostString != "") {
				getGhostArrayFromString(ghostString);
				isReplaying = true;
			}
			this.centerOrigin();
		}
		
		public function reset():void {
			currentGhostNumber = 0;
			spritemap.alpha = spriteAlpha;
			playerStatesRecord.splice(0,playerStatesRecord.length);
		} 
		
		public function replayStates():void {
			if(currentGhostNumber<playerStatesSaved.length){
				var p:PlayerState = PlayerState(playerStatesSaved[currentGhostNumber])
				currentGhostNumber++;
				this.spritemap.x = p.x;
				this.spritemap.y = p.y;
				spritemap.frame = p.frame;
				this.spritemap.angle = p.rotation;
				this.spritemap.flipped = (p.flipped==0)?false:true;
			}else {
				spritemap.alpha = 0;
			}
		} 
		 
		public function saveState(px:int, py:int, frame:int, rotation:int, flipped:int):void {
			playerStatesRecord.push(new PlayerState(px, py, frame, rotation, flipped));
		}
		
		
		override public function update():void {
			replayStates();
			var flipped:int = player.spriteMap.flipped?1:0;
			saveState(player.x, player.y, player.spriteMap.frame+48, player.spriteMap.angle, flipped);
		}
		
		override public function toString():String {
			var pString:String = "";
			for each(var p:PlayerState in playerStatesRecord) {
				pString += p.toString()+" ";
			}
			return pString;
		}
		
		public function setIsSaving(saving:Boolean):void {
			isSaving = saving;
		}
		
		public function setIsReplaying(replaying:Boolean):void {
			isReplaying = replaying;
			if (isReplaying) playerStatesSaved = playerStatesRecord;
		}
		
		private function getGhostArrayFromString(ghostString:String):void {
			playerStatesSaved = new Array();
			
			for each(var stateString:String in ghostString.split(" ")) {
				var attributes:Array = stateString.split(":");
				var p:PlayerState = new PlayerState(int(attributes[0]), int(attributes[1]), int(attributes[2]), int(attributes[3]), int(attributes[4]));
				playerStatesSaved.push(p);
			}
		}
	}
}


	class PlayerState {
		public var frame:int;
		public var x:int;
		public var y:int;
		public var rotation:int;
		public var flipped:int;
			public function PlayerState(x:int, y:int, frame:int, rotation:int, flipped:int) {
			this.x = x;
			this.y = y;
			this.flipped = flipped;
			this.rotation = rotation;
			this.frame = frame;
		}
	
		public function toString():String {
			return this.x + ":" + this.y + ":" + this.frame+":"+this.rotation+":"+this.flipped;
		}
	}