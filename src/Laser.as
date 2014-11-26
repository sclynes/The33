package  
{
	import flash.geom.Point;
	import levels.Level;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	import sfx.SfxrSynth;
	/**
	 * ...
	 * @author 
	 */
	public class Laser extends Entity
	{
		private var positionData:LocalPositionData;
		private var spriteMap:Spritemap;
		private var frequency:int;
		private var direction:Point;
		private var level:Level;
		private var colsPerSector:int;
		private var rowsPerSector:int;
		private var sectorTiles:Vector.<int>;
		private var p2:Point;
		private var synth:SfxrSynth;
		private var laserDeath:SfxrSynth;
		
		private var on:Boolean;
		private var time:int;
		public static const DEFAULT_FREQUENCY:int = 100;
		public function Laser(positionData:LocalPositionData, level:Level, frequency:int) 
		{
			this.positionData = positionData;
			type = "laser";
			spriteMap = new Spritemap(Assets.LASER, 16, 16);
			spriteMap.add("default", [0]);
			spriteMap.frame = 0;
			graphic = spriteMap;
			
			synth = new SfxrSynth();
			laserDeath = new SfxrSynth()
			synth.loadFromSFXFile(new Assets.SFX_LASER);
			laserDeath.loadFromSFXFile(new Assets.SFX_LASER_DEATH);
			
			setHitbox(16, 16, 0, 0);
			this.level = level;
			colsPerSector = level.getColumnsPerSector();
			rowsPerSector = level.getRowsPerSector();
			this.frequency = frequency;
			this.time = 1;
			this.direction = new Point(1, 0);
			this.on = false;
			this.collidable = false;

			super(positionData.getTile().x * Constants.TILE_SIZE, positionData.getTile().y * Constants.TILE_SIZE);	
		}
		
		override public function update():void {
			if (!(time++ % frequency)) {
				on = !on;
				time = 1;
				this.collidable = on;
			}
			
			
			if (p2 == null) {
				p2 = new Point(positionData.getTile().x, positionData.getTile().y);
				p2.x += direction.x;
				p2.y += direction.y;
				var currentTileIndex:Boolean;
				
				while(p2.x < colsPerSector && p2.y < rowsPerSector){
					currentTileIndex = level.getCurrentSectorGridTile(p2.x, p2.y);
					if (!currentTileIndex ) {
						p2.x += direction.x;
						p2.y += direction.y;
					}else {
						//trace(p2);
						break;
					}
				}
				setHitbox(Math.abs(x - (p2.x * Constants.TILE_SIZE)), 10, 0, -halfHeight + 5);
				this.collidable = on;
			}
			
			super.update();
		}
		
		override public function render():void {
			if(on){
				Draw.line(x, y   + 8, p2.x * Constants.TILE_SIZE, (p2.y * Constants.TILE_SIZE) +8 , 0xff0000);
			}
			super.render();
		}
		
		public function playLaserDeathSFX():void {
			laserDeath.play();
		}
	}

}