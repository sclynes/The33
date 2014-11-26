package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import levels.Level;
	import levels.ScoreData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.PreRotation;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import punk.fx.effects.GlitchFX;
	import punk.fx.effects.ScanLinesFX;
	import punk.fx.graphics.FXSpritemap;
	import net.flashpunk.utils.Data;
	import sfx.SfxrSynth;
	import states.GameState;
	import states.LevelCompleteState;
	import punk.fx.FXMan;
	import flash.display.BlendMode;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class Player extends Entity
	{
		private var jumpSpeed:int;
		private var maxFallSpeed:int;
		private var velocity:Vector2d;
		private var walkAcceleration:Number;
		private var maxWalkSpeed:Number;
		private var gravity:Number;
		private var level:Level;
		private var friction:Number;
		private var timeSinceLastSwitch:int;
		private var switchingGravity:Boolean;
		private var upsideDown:Boolean;
		private var doShake:Boolean;
		private var amountRotated:int;
		private var gravitySwitchSpeed:int;
		private var playerWidth:int;
		private var playerHeight:int;
		public var spriteMap:FXSpritemap;
		private var rotationTracker:int;
	//	private var numberOfRotationFrames:int;
		private var levelWidth:int;
		private var levelHeight:int;
		private var myWorld:GameState;
		private var stomping:Boolean;
		public  var gravityDirection:int;
		public var flyingX:Boolean;
		private var flyingY:Boolean;
		public var sfxGravitySwitch:SfxrSynth;
		//public var sfxStomp:SfxrSynth;
		public var sfxStomp:Sfx;
	//	public var sfxJump:SfxrSynth;
		private var sfxPelter:SfxrSynth;
		public var sfxBomb:SfxrSynth;
		public var previousPosition:Point;
		private var alive:Boolean;
		private var deathEmitter:DeathEmitter;
		private var sfxBonusBrick:SfxrSynth;
		private var isOnGround:Boolean;
		
		private var isOnPlatform:Boolean;
		private var currentPlatform:Platform;
		
		private var gravitySwitches:int;
		private var groundedBonus:int;
		private var brickBonus:int;
		
		private var ghost:PlayerGhost;

		private var jumping:Boolean;
		private var jumpPressed:Boolean;
		
		private var scanlines:ScanLinesFX;

		public function Player(level:Level, myWorld:GameState, ghostStringData:String)
		{

			
			super(0, 0);
			
			sfxBonusBrick = new SfxrSynth();
			sfxBonusBrick.loadFromSFXFile(new Assets.SFX_COIN);
			
			this.myWorld = myWorld;
			this.level = level;
			
			myWorld.resetFrameNumber();
			
			//sfxJump = new SfxrSynth();
			sfxGravitySwitch = new SfxrSynth();
			sfxBomb = new SfxrSynth();
		
				
			sfxGravitySwitch.loadFromSFXFile(new Assets.SFX_GRAVITY_SWITCH);

			sfxPelter = new SfxrSynth();
			sfxPelter.loadFromSFXFile(new Assets.SFX_PELTER);
			sfxBomb.loadFromSFXFile(new Assets.SFX_BOMB);
			sfxStomp = new Sfx(Assets.SFX_STOMP_MP3);
			
			spriteMap = new FXSpritemap(Assets.PLAYER, Constants.PLAYER_WIDTH, Constants.PLAYER_WIDTH);
			spriteMap.add("falling", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19,20,21,22,23, 24, 25,26], 0.5,false);
			spriteMap.add("running", [27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40], 0.9, true);
		spriteMap.add("runningFast", [27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40], 1, true);
			spriteMap.add("standing", [46]);
			spriteMap.add("jumping", [41, 42, 43, 44, 45], 0.5, false);
			
						
			scanlines = new ScanLinesFX(false, 255);
			
			type = "player";
			graphic = spriteMap;
			playerWidth = Constants.PLAYER_WIDTH;
			playerHeight = Constants.PLAYER_HEIGHT;

		    setHitbox(6, 16, 0, 0);
			
			spriteMap.centerOO();
			this.spriteMap.rate = 0.75;
			this.spriteMap.smooth = false;
			this.centerOrigin();
			
			ghost = new PlayerGhost(this, ghostStringData);
						
			FP.world.add(ghost);
		
			init();
		}
		
		public function init():void {
			jumping = false;
			isOnPlatform = false;
			friction = GAMEPLAY.PLAYER_FRICTION;
			jumpSpeed = GAMEPLAY.JUMP_SPEED;
			maxFallSpeed = GAMEPLAY.MAX_FALL_SPEED;
			walkAcceleration = GAMEPLAY.WALK_ACCELERATION;
			gravitySwitchSpeed = GAMEPLAY.GRAVITY_SWITCH_SPEED; 
			maxWalkSpeed = GAMEPLAY.MAX_WALK_SPEED;
			gravityDirection = 1;
			flyingX = false; 
			flyingY = false;
			this.visible = true;
			amountRotated = 0;
			velocity = new Vector2d(0, 0);
			stomping = false;
			spriteMap.angle = 0;
			
			groundedBonus = 0;
			gravitySwitches = 0;
			brickBonus = 0;

			alive = true;
			deathEmitter = null;

		
			switchingGravity = false;
			upsideDown = false;

			timeSinceLastSwitch = 40;

			rotationTracker = 1;
			
			x = level.getPlayerStart().getTile().x * Constants.TILE_SIZE;
			y = level.getPlayerStart().getTile().y * Constants.TILE_SIZE;
			
			previousPosition = new Point(x, y);
			
			ghost.reset();
		}
		
		public function getVelocity():Vector2d {
			return velocity;
		}
		
		private function getInput():void {

			if(!flyingX&&!flyingY){
				if (Input.check(Key.LEFT)) {
					this.moveLeft(); 
				}
				else if (Input.check(Key.RIGHT)) {

					this.moveRight();
					
				}
				else doStand();
			}
			
			if (Input.pressed(Key.UP)) this.setSwitchingGravity();
			
			if (Input.check(Key.SPACE)) {
				if (!(flyingX || flyingY || stomping)) {
					this.jump();
					jumpPressed = true;
				}else if ((flyingY || flyingX) && !jumpPressed) {
					velocity.y = (maxFallSpeed * -gravityDirection) * 0.5;
					if(!flyingY)velocity.x = (maxWalkSpeed * (velocity.x > 0?10: -10));
					flyingY = false;
					flyingX = false;
					maxFallSpeed = GAMEPLAY.MAX_FALL_SPEED
					jumpPressed = true;
				}
			}else {
				if (jumping && jumpPressed) {
					if(velocity.y*gravityDirection <0)velocity.y *= GAMEPLAY.JUMP_CUTOFF;
				}
				jumpPressed = false;
			}
			
			if (Input.pressed(Key.DOWN)) {
				if (isOnGround) {
					if (switchingGravity) stomp();
					else doAction();
				}
				else stomp();
			}
			if (Input.pressed(Key.R)) {
				this.die();
			}
		}
		
		override public function update():void {
			if(myWorld.gameRunning()){
				if (alive) aliveUpdate();
				else deadUpdate();
			}
			super.update();
		}
		
		private function doTrails():void {
			
			var intervalX:Number = (x - previousPosition.x)/GAMEPLAY.TRAIL_FREQUENCY;
			var intervalY:Number = (y - previousPosition.y)/ GAMEPLAY.TRAIL_FREQUENCY;
			var i:int;
			for (i = 0; i < GAMEPLAY.TRAIL_FREQUENCY; i++) {
				var newX:int = previousPosition.x + (i * intervalX);
				var newY:int = previousPosition.y + (i * intervalY);
				FP.world.add(new Trailer(this,new Point(newX, newY)));
			}
		}
		
		
		private function get onGround():Boolean {
			return ((collide("level", x, y + gravityDirection)!=null)||(collide("brick", x, y + gravityDirection)!=null)||(collide("platform", x, y+gravityDirection)));
		}

		
		private function doWallTypeCollision(collisionType:String, diffX:Number = 0, diffY:Number = 0):void {
			if (flyingX) flyingX = false;
  			if (flyingY) flyingY = false;
			
			var delta:Point = new Point(x - previousPosition.x, y - previousPosition.y);
			var longerAxis:Number = Math.abs(delta.x) > Math.abs(delta.y)?Math.abs(delta.x):Math.abs(delta.y);
			var step:Point = new Point(delta.x / longerAxis, delta.y / longerAxis);

			x = previousPosition.x+diffX;
			y = previousPosition.y+diffY;
			
			for (var i:int = 0; i < Math.ceil(longerAxis); i++) {
				
				var collideY:Boolean = (collide(collisionType, x, y + step.y) != null);
				var collideX:Boolean = (collide(collisionType, x + step.x, y) != null);
				
				if (!collideY) {
					y += step.y;
				}
				else {
					if (!velocity.y && !velocity.x) {
						previousPosition.x = x;
						previousPosition.y = y;
						return;
					}
					velocity.y = 0;
				}
						
				if (!collideX) {
					x += step.x;
				}
				else {
					if (!velocity.y && !velocity.x) {
						previousPosition.x = x;
						previousPosition.y = y;
						return;
					}
					velocity.x = 0;
				}
			}
			previousPosition.x = x;
			previousPosition.y = y;
		}
		
		
		private function checkObjectCollisions(currentPosition:Point): void{

			var setToReturn:Boolean = false;
			    if (collide("level", currentPosition.x, currentPosition.y)) {
					doWallTypeCollision("level");
					setToReturn = true;
				}
				
				var mod:Number = 0;
				if (flyingX)mod = gravityDirection;
				if (collide("bonusBrick", currentPosition.x, currentPosition.y+mod)) {
					var bonusBrick:BonusBrick=BonusBrick(collide("bonusBrick", currentPosition.x, currentPosition.y+mod));
					if(stomping||flyingX||flyingY) {
						bonusBrick.collidable  = false;
						bonusBrick.setInactive(gravityDirection);
						var b:BonusText = BonusText(FP.world.create(BonusText));
						b.init(gravityDirection, bonusBrick.x+8, bonusBrick.y+(gravityDirection*16));
						sfxBonusBrick.play();
						sfxStomp.play();
						brickBonus += 1;
					}
					setToReturn = true;
				}
				if (setToReturn) return;
				
				if (collide("platform", currentPosition.x, currentPosition.y)) {
					var platform:Platform = Platform(collide("platform", currentPosition.x, currentPosition.y));
					currentPlatform = platform;
					platform.setTraveller(this);
					isOnPlatform = true;
					doWallTypeCollision("platform", platform.getVelocity().x, platform.getVelocity().y);
				}
		
				
				
				if (collide("pelter", currentPosition.x, currentPosition.y)) {
					var pelter:Pelter = Pelter(collide("pelter", currentPosition.x, currentPosition.y));
					var direction:Point = pelter.getDirection();
					var power:Number = pelter.getPower();

					sfxPelter.play();
					spriteMap.play("runningFast");
					x = pelter.x+halfHeight;
					if (direction.x) {
						y+= (Constants.TILE_SIZE / 2) * gravityDirection
						doWallTypeCollision("level");
					}
					timeSinceLastSwitch = GAMEPLAY.GRAVITY_SWITCH_SPEED;
					velocity.x = power * direction.x;
					velocity.y = power * direction.y;

					if (direction.x) {
						flyingX = true;
						spriteMap.flipped = velocity.x > 0?false:true;
					}
					else flyingX = false;

					if (direction.y) flyingY = true;
					else flyingY = false;
				}
				
				
				if (collide("exit", x, y)) {
					var scoreData:ScoreData = new ScoreData(myWorld.getFrameNumber(), 0, groundedBonus, gravitySwitches, brickBonus);
					var ghostString:String = ghost.toString();
					level.stopMusic();
				    var levelCompleteState:LevelCompleteState = new LevelCompleteState(level.getLevelMeta(), scoreData, level.getLevelSaveData(), ghostString);
					Main.stateManager.switchState(levelCompleteState);
				}
				
				if  (collide("bomb", currentPosition.x, currentPosition.y)) {
					var bomb:Bomb = Bomb(collide("bomb", currentPosition.x, currentPosition.y));
					if (bomb.getSector() == level.getCurrentSectorIndex()) {
						
						sfxBomb.play();
						this.die();
						return;
					}
				}else if (collide("coin", currentPosition.x, currentPosition.y)) {
					var coin:Coin = Coin(collide("coin", currentPosition.x, currentPosition.y));
					if(coin.getSequence().getActiveCoin()==coin){
						coin.getSequence().activateNext();
					}
					return;
				}
				
				if (collide("laser", currentPosition.x, currentPosition.y)) {
					var laser:Laser = Laser(collide("laser", currentPosition.x, currentPosition.y));
					laser.playLaserDeathSFX();
					this.die();
					return;
				}
				
				if (collide("brick", currentPosition.x, currentPosition.y-gravityDirection)) {
					if (!stomping) {
						doWallTypeCollision("brick");
					}
					else {
						var brick:Brick;
						var bArray:Array = new Array(); 
						collideInto("brick", currentPosition.x, currentPosition.y, bArray);
						var yHit:int = bArray[0].y;
						for each(brick in bArray) {
							if (gravityDirection == 1) yHit = Math.min(yHit, brick.y);
							else yHit = Math.max(yHit, brick.y);
						}
						for each(brick in bArray) {
							if(brick.y==yHit){
								if (brick.damage()) FP.world.remove(brick);
							}
						}
						doWallTypeCollision("brick");
						if (!collide("brick", x+velocity.x, y - (16 * gravityDirection))) velocity.y -= gravityDirection * 5;
					}
				}
		}
	
		
		private function stomp():void {
			if (flyingX) flyingX = false;
			if (flyingY) flyingY = false;
			while (switchingGravity) switchGravity();
			this.stomping = true;
			maxFallSpeed = GAMEPLAY.FALL_SPEED_STOMP;
			velocity.y = maxFallSpeed * gravityDirection;
		}
		
		private function doAction():void {
			if (collide("checkpoint", x, y)) {
				var checkpoint:Checkpoint = Checkpoint(collide("checkpoint", x, y));
				if(checkpoint!=level.getActiveCheckpoint()){
					level.setPlayerStart(checkpoint.getPositionData());
					checkpoint.doActivated();
					level.setActiveCheckpoint(checkpoint);
				}
			}
		}
		
		private function moveLeft():void {
			
			if (velocity.x > 0) velocity.x *= friction;
			
			if (upsideDown) spriteMap.flipped = false;
			else spriteMap.flipped = true;
			
			if (isOnGround) spriteMap.play("running");

			if (velocity.x > -maxWalkSpeed)
					velocity.x -= walkAcceleration;
			else{
			if (isOnGround) velocity.x = -maxWalkSpeed;
				else velocity.x *= GAMEPLAY.JUMP_X_SLOWDOWN;
			}
		}
		private function moveRight():void {
			if (velocity.x < 0) velocity.x *= friction;
			
			if (upsideDown) spriteMap.flipped = true;
			else spriteMap.flipped = false;
			
			if (isOnGround) spriteMap.play("running");
			if (velocity.x < maxWalkSpeed){
					velocity.x = velocity.x + walkAcceleration;
				}
				else{
					if (isOnGround) velocity.x = maxWalkSpeed;
					else velocity.x *= GAMEPLAY.JUMP_X_SLOWDOWN;
				}
		}
		
		private function doStand():void 
		{	
			if(!flyingX){
				if (isOnGround) {
					spriteMap.play("standing");
					if (Math.abs(velocity.x) < 0.1)velocity.x = 0;
					else velocity.x *= friction;
				}
				else {
					velocity.x *= 0.9;
				}
			}
		} 
		
		private function setSwitchingGravity():void {
			if (flyingX) {
				velocity.x = 0;
				flyingX = false;
			}
			if (flyingY) {
				flyingY = false;
			}
			
			 if (!switchingGravity && timeSinceLastSwitch >= gravitySwitchSpeed)
			{
				
				upsideDown = !upsideDown;
				timeSinceLastSwitch = 0;
				switchingGravity = true;
			}
		}
		
		private function switchGravity():void {
			if (amountRotated <= 180) {
				spriteMap.angle += 20;
				if (amountRotated == 0) {
					if (stomping) velocity.y *= 0.3;
					else velocity.y *= 0.8;
				}
				else velocity.y *= 0.98 ;
				amountRotated += 20;
			}else {
				amountRotated = 0;
				spriteMap.angle = (rotationTracker%2)*180
				switchingGravity = false;
			}
			++rotationTracker;
			gravityDirection*=-1;
		}
		
		private function jump():void {
			if(!flyingX&&!flyingY){
				if (isOnGround)
				{
					spriteMap.play("jumping", false);
					jumping = true;
					if (gravityDirection == 1) {
						velocity.y = -jumpSpeed;
					}
					else {
						velocity.y = velocity.y + jumpSpeed;
					}
				}
			}
		}
		
		public function die():void {
			alive = false;
			this.visible = false;
			sfxBomb.play();
		}
		
		private function aliveUpdate():void {
			getInput();
			
			++timeSinceLastSwitch;
			previousPosition.x = x;
			previousPosition.y = y;
	
			x += velocity.x;
			if (!flyingX||!isOnPlatform) y += velocity.y;
		
			if (!isOnPlatform) {
				if (currentPlatform != null) currentPlatform.setTraveller(null);
			}
			
			if (Math.abs(velocity.y) > Constants.TILE_SIZE || Math.abs(velocity.x) > Constants.TILE_SIZE) {
				var i:Number = 0;
				var steps:Number = 0;
				
				if (Math.abs(velocity.y) > Math.abs(velocity.x)) {
					steps = Math.abs(Math.floor(velocity.y / (Constants.TILE_SIZE-1)));
					for (i = 1; i < steps; i++)
						checkObjectCollisions(new Point(x, previousPosition.y + ((i*(Constants.TILE_SIZE)) * (velocity.y > 0?1: -1))));
				}else {
					steps= Math.abs(Math.floor(velocity.x / Constants.TILE_SIZE+(velocity.x>0?1:-1 )));
					for (i = 1; i <steps; i++)
						checkObjectCollisions(new Point(previousPosition.x + ((i*Constants.TILE_SIZE) * (velocity.x > 0?1: -1)), y));
				}
			}

			checkObjectCollisions(new Point(x, y)) ;	
			isOnGround = onGround;
			
			if (!isOnGround) {
				if (!flyingX)velocity.y += Level.gravity * gravityDirection;
				isOnPlatform = false;
				
				if(!flyingY){
					if (velocity.y > maxFallSpeed) velocity.y = maxFallSpeed;
					else if (velocity.y < -maxFallSpeed) velocity.y = -maxFallSpeed;
				}
				if (stomping) doTrails();
				if(!flyingX&&!flyingY)spriteMap.play("falling", false);
			}
			else 
			{
				if (stomping) {					
					sfxStomp.play();
					stomping = false;
					level.shake();
					
					maxFallSpeed = GAMEPLAY.MAX_FALL_SPEED;
				}
				groundedBonus++;
				jumping = false;
				if(!switchingGravity)timeSinceLastSwitch = GAMEPLAY.GRAVITY_SWITCH_SPEED;
			}
				
	
			if (switchingGravity)switchGravity();
			
			
			if (x - FP.camera.x > Constants.GAME_WIDTH) myWorld.moveCamera(new Point(1, 0));
			else if (x - FP.camera.x < 0) myWorld.moveCamera(new Point(-1,0));
			else if (y - FP.camera.y > Constants.GAME_HEIGHT) myWorld.moveCamera(new Point(0, 1));
			else if (y - FP.camera.y < 0) myWorld.moveCamera(new Point(0, -1));
		}
		
		private function deadUpdate():void {
			if (deathEmitter == null) {
				deathEmitter = new DeathEmitter(this);
			}

			if (deathEmitter.getTimer() <= 0) {
				FP.world.remove(deathEmitter); 
				deathEmitter = null;
				level.revivePlayer(this);
				init();
			}
		}
	}
}