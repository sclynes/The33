package levels 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.display.BlendMode;
	import flash.geom.Utils3D;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.PreRotation;
	import net.flashpunk.graphics.Stamp;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Data;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import props.Computer;
	import states.GameState;
	import com.dynamicflash.util.Base64;
	import com.probertson.utils.GZIPBytesEncoder;
	import punk.fx.effects.ScanLinesFX;
	import sfx.SfxrSynth;
	import punk.fx.graphics.FXImage;
	import states.LevelCompleteState;
	import punk.fx.effects.BlurFX;
	import punk.fx.FXMan;
	/**
	 * ...
	 * @author 
	 */
	public class Level extends Entity
	{
		private var solidTilemap:Tilemap;
		
		private var grid:Grid;
		private var sectors:Array;
		private var colsPerSector:int;
		private var rowsPerSector:int;
		private var tilesWide:int;
		private var tilesHigh:int;
		private var numSectors:int;
		public var sectorsWide:int;
		public var sectorsHigh:int;
		

		private var currentSector:Sector;
		private var currentSectorIndex:int;
		private var playerStart:LocalPositionData;
		private var entityList:Vector.<Entity>;
		private var myWorld:GameState;
		private var activeCheckpoint:Checkpoint;
		private var shaking:Boolean;
		private var shakeNum:int;
		public var sfxMusic:Sfx;
		public var levelMeta:LevelMeta;
		private var computer:Computer;
		private var levelSaveData:LevelSaveData;

		private static const SOLIDS:String = "collision";
		

		private var backDrop:Backdrop;
		public static var gravity:Number;
		
		public function Level(meta:LevelMeta,w:GameState) 
		{
			levelMeta = meta;
			sfxMusic = new Sfx(levelMeta.getMusic());
		//	sfxMusic.loop(1,0);

			levelSaveData = new LevelSaveData(levelMeta.getId());

			var ghostString:String = levelSaveData.getGhostString();
			
			type = "level";
			myWorld = w;
			gravity = GAMEPLAY.GRAVITY;
			currentSectorIndex = 0;
			sectors = new Array();
			
			entityList = new Vector.<Entity>;
			
			shaking = false;
			shakeNum = 0;
			
			var xml:Class = levelMeta.getLevelData();;
			loadLevel(xml);
		
			addGraphic(solidTilemap);
			mask = grid;
			
			
			for (var i:int = 0; i < sectors.length; i++) Sector(sectors[i]).setMeta(levelMeta.getSectorMeta()[i]);

			
			setCurrentSector(playerStart.getSector());
			super(x, y);
		}
		
		private function loadLevel(xml:Class):void {
			var rawData:ByteArray = new xml; 
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			var i:int = 0;
			var positionData:LocalPositionData;
			var dataElement:XML;
			
			tilesWide = xmlData.@width;
			tilesHigh = xmlData.@height;
			
			//******************************change back afterward**********************************************//
			
			//sectorsWide = xmlData.properties.@sectorswide;
			//sectorsHigh = xmlData.properties.@sectorshigh;
			for each(dataElement in xmlData.properties.property) {
				if (dataElement.@name == "sectorshigh") sectorsHigh = dataElement.@value;
				if (dataElement.@name == "sectorswide") sectorsWide = dataElement.@value;	
			}
			
			Constants.COLS_PER_SECTOR =colsPerSector= tilesWide/sectorsWide;
			Constants.ROWS_PER_SECTOR =rowsPerSector= tilesHigh/sectorsHigh;
			
			Constants.GAME_HEIGHT = Constants.ROWS_PER_SECTOR * Constants.TILE_SIZE;
			Constants.GAME_WIDTH = Constants.COLS_PER_SECTOR*Constants.TILE_SIZE;
			
			/**********************************************************************************************/
			
			Main.setResolution(rowsPerSector, colsPerSector);
			  
			
			numSectors = sectorsHigh * sectorsWide;
						
			solidTilemap = new Tilemap(Assets.SOLID_TILESET, tilesWide*Constants.TILE_SIZE, tilesHigh*Constants.TILE_SIZE, Constants.TILE_SIZE, Constants.TILE_SIZE);	
			grid = new Grid(tilesWide * Constants.TILE_SIZE, tilesHigh * Constants.TILE_SIZE, Constants.TILE_SIZE, Constants.TILE_SIZE, 0, 0);

			for (i  = 0; i < numSectors; i++) sectors[i] = new Sector(colsPerSector, rowsPerSector);
			
			i = 0;
			
			for each(dataElement in xmlData.layer) 
				if (dataElement.@name == Level.SOLIDS) loadLayer(decodeLayer(dataElement.data), Level.SOLIDS);
				
				
			for each(dataElement in xmlData.objectgroup.object) {
				if (dataElement.@type == "player") playerStart = absolutePositionToLocalPositionData(dataElement.@x, dataElement.@y);				
				else if (dataElement.@type == "checkpoint") {
					positionData = absolutePositionToLocalPositionData(dataElement.@x, dataElement.@y);
					var checkpoint:Checkpoint = new Checkpoint(positionData);
					sectors[positionData.getSector()].addCheckpoint(checkpoint);
				}else if (dataElement.@type == "blinker") {
					positionData = absolutePositionToLocalPositionData(dataElement.@x, dataElement.@y);
					var blinker:Blinker = new Blinker(positionData);
					sectors[positionData.getSector()].addBlinker(blinker);
					for each(dataElement in dataElement.properties) {
						for each(dataElement in dataElement.property) {
							if (dataElement.@name == "offset") blinker.setOffset(dataElement.@value);
							if (dataElement.@name == "off") blinker.setOffTime(dataElement.@value);
							if (dataElement.@name == "on") blinker.setOnTime(dataElement.@value);
						}
					}	
				}else if (dataElement.@type == "laser") {
					positionData = absolutePositionToLocalPositionData(dataElement.@x, dataElement.@y);
					var freq:int=Laser.DEFAULT_FREQUENCY;
					for each(dataElement in dataElement.properties) {
						for each(dataElement in dataElement.property) {
							if (dataElement.@name == "freq") freq = dataElement.@value;
						}
					}			
					var laser:Laser = new Laser(positionData, this, freq);
					sectors[positionData.getSector()].addLaser(laser);
				}else if (dataElement.@type == "pelter") {	

					positionData = absolutePositionToLocalPositionData(dataElement.@x, dataElement.@y);
					trace("pelter sector:"+positionData.getSector());
					var dir:int;
					for each(dataElement in dataElement.properties) {
						for each(dataElement in dataElement.property) {
							if (dataElement.@name == "dir") dir = dataElement.@value;
						}
					}			
					var pelter:Pelter = new Pelter(positionData, dir);
					sectors[positionData.getSector()].addPelter(pelter);
				}else if (dataElement.@type == "coin") {
					
					positionData = absolutePositionToLocalPositionData(dataElement.@x, dataElement.@y);
					var coin:Coin = new Coin(positionData);
					
					var currentSector:Sector = sectors[positionData.getSector()];
					currentSector.addCoin(coin);

					for each(dataElement in dataElement.properties) {
						for each(dataElement in dataElement.property) {
							coin.setSequence(sectors[positionData.getSector()].getCoinSequence());
							if (dataElement.@name == "coin_index") {
								coin.setCoinIndex(dataElement.@value);
							}if (dataElement.@name == "limit") {
								coin.setTimeLimit(dataElement.@value);
							}
						}
					}
				}else if (dataElement.@type == "platform_rail") {
					positionData = absolutePositionToLocalPositionData(int(dataElement.@x), int(dataElement.@y));
					trace("rail sector:"+positionData.getSector());
					var railPoints:String = dataElement.polyline.@points;
					var speed:Number = 1;
					var direction:int = 1;
					var width:int = 1;
					var startDistance:Number = 0;
					for each(dataElement in dataElement.properties) {
						for each(dataElement in dataElement.property) {
							if (dataElement.@name == "speed") speed= dataElement.@value;
							else if (dataElement.@name == "dir") direction = dataElement.@value;
							else if (dataElement.@name == "pwidth") width = dataElement.@value;
							else if (dataElement.@name == "startdistance") startDistance = dataElement.@value;
						}
					}

					var platform:Platform= new Platform(positionData, width, direction, speed, startDistance, railPoints);
					sectors[positionData.getSector()].addPlatform(platform);
				}
			}
		}
		private function decodeLayer(data:String):ByteArray {
			var gzip:GZIPBytesEncoder = new GZIPBytesEncoder();
			var ba:ByteArray = Base64.decodeToByteArray(data);
			var unzipped:ByteArray = gzip.uncompressToByteArray(ba);
			unzipped.endian = "littleEndian";
			return unzipped;
		}
		
		private function absolutePositionToLocalPositionData(absX:Number, absY:Number):LocalPositionData {
	
			var absTile:Point = new Point(Math.floor(absX/Constants.TILE_SIZE), Math.floor(absY/Constants.TILE_SIZE));
			var linearTile:int = (absTile.y * tilesWide) + absTile.x;
			var sectorIndex:int = Math.floor(linearTile / ((sectorsWide * colsPerSector) * (rowsPerSector))) * sectorsWide;
			var mod:int = Math.floor(absTile.x / colsPerSector);
			sectorIndex += Math.floor((absTile.x / colsPerSector));
			return new LocalPositionData(new Point(absTile.x, absTile.y), sectorIndex);
		}
		
		private function loadLayer(data:ByteArray, type:String):void {
			var i:int = 0;
			var numBonusBricks:int = 0;
			while (i <(tilesHigh*tilesWide)){
				var colIndex:int = i - (Math.floor(i / (colsPerSector * sectorsWide)) * (colsPerSector * sectorsWide));
				var rowIndex:int = Math.floor(i / (colsPerSector*sectorsWide))%rowsPerSector;
				var sectorIndex:int = Math.floor(i / ((sectorsWide * colsPerSector) * (rowsPerSector))) * sectorsWide;

				var sectorOffset:int = Math.floor((colIndex / colsPerSector));
				sectorIndex += sectorOffset;
				var tileIndex:int = data.readInt();
				if (type == Level.SOLIDS) {
					if (tileIndex != 0) {
						if (tileIndex > 16) {
							grid.setTile(i % tilesWide, Math.floor(i / tilesWide), true);
							solidTilemap.setTile(i % tilesWide, Math.floor(i / tilesWide), tileIndex - 1);
						}
						if (tileIndex <=16) {
							var absX:Number = (i % (colsPerSector*sectorsWide))*Constants.TILE_SIZE;
							var absY:Number = (i / (colsPerSector * sectorsWide)) * Constants.TILE_SIZE; 
							var positionData:LocalPositionData = absolutePositionToLocalPositionData(absX, absY);
							
							if (tileIndex == 5) {
								var exit:Exit = new Exit(positionData, tileIndex);
								sectors[positionData.getSector()].addExit(exit);
							}else if (tileIndex == 6) {
								var bonusBrick:BonusBrick = new BonusBrick(positionData, tileIndex);
								sectors[positionData.getSector()].addBonusBrick(bonusBrick);
								grid.setTile(i % tilesWide, Math.floor(i / tilesWide), true);
								numBonusBricks++;
							}
							else{
								var bomb:Bomb = new Bomb(positionData, tileIndex);
								sectors[positionData.getSector()].addBomb(bomb);
							}
						}
					}
				}
				i++;
			}
			levelMeta.setNumberOfBricks(numBonusBricks);
		}
		
		public function getColumnsPerSector():int {
			return colsPerSector;
		}
		public function getRowsPerSector():int {
			return rowsPerSector;
		}
			
		public override function update():void {
			if (shaking) shake();
			super.update();
		}
		
		public function getTile(x:int, y:int):uint {
			return solidTilemap.getTile(Math.floor(x / Constants.TILE_SIZE), Math.floor(y / Constants.TILE_SIZE));
		}
		
		public function getTileIndexAtColumnRow(col:int, row:int):int {
			return (row * colsPerSector) + col;
		}
		
		public function getRelativeSectorIndex(xRel:int, yRel:int):int {
			return currentSectorIndex+xRel + (yRel * sectorsWide);
		}
		
		public function getPlayerStart():LocalPositionData {
			return playerStart;
		}
		
		public function getCurrentSector():Sector {
			return currentSector;
		}
		
		
		public function getCurrentSectorGridTile(col:int, row:int):Boolean {
			return grid.getTile(col, row);
		}
		
		public function getSector(i:int):Sector {
			return sectors[i];
		}
		
		public function setCurrentSector(i:int):void {
			myWorld.removeList(entityList);
			entityList = new Vector.<Entity>;
			currentSectorIndex = i;
			currentSector = sectors[i];
			addObjects(currentSector);
		}
		
		public function getLevelId():int {
			return levelMeta.getId();
		}
		
		public function stopMusic():void {
			if(sfxMusic.playing)sfxMusic.stop();
		}
		
		private function addObjects(currentSector:Sector):void {
			var i:int = 0;
				
			if (currentSector.getCheckpoints() != null) {
				var checkpoints:Vector.<Checkpoint> = currentSector.getCheckpoints();
				var currentCheckpoint:Checkpoint;
				
				for each(currentCheckpoint in checkpoints) {
					entityList.push(currentCheckpoint);
					if (currentCheckpoint == activeCheckpoint) currentCheckpoint.doCheckpointLoop();
					else currentCheckpoint.doIdle();
				}
			}
			
			if (currentSector.getBombs() != null) {
				var currentBomb:Bomb;
				var bombs:Vector.<Bomb> = currentSector.getBombs();
				for each(currentBomb in bombs) entityList.push(currentBomb);
			}
			
			if (currentSector.getBonusBricks() != null) {
				var currentBonusBrick:BonusBrick;
				var bonusBricks:Vector.<BonusBrick> = currentSector.getBonusBricks();
				for each(currentBonusBrick in bonusBricks) entityList.push(currentBonusBrick);
			}
			
			if (currentSector.getCoinSequence() != null) {
				if(!currentSector.getCoinSequence().areAllCoinsCollected()){
					var currentCoin:Coin;
					var coinSequence:CoinSequence = currentSector.getCoinSequence();
					coinSequence.start();
					for each(currentCoin in coinSequence.getCoins()) entityList.push(currentCoin);
				}
			}
			
			if (currentSector.getLasers() != null) {
				var laser:Laser;
				var lasers:Vector.<Laser> = currentSector.getLasers();
				for each(laser in lasers) {
					entityList.push(laser);
				}
			}
			
			if (currentSector.getBlinkers() != null) {
				var blinker:Blinker;
				var blinkers:Vector.<Blinker> = currentSector.getBlinkers();
				for each(blinker in blinkers) {
					blinker.init();
					entityList.push(blinker);
				}
			}
			
			if (currentSector.getPlatforms() != null) {
				var platform:Platform;
				var platforms:Vector.<Platform> = currentSector.getPlatforms();
				for each(platform in platforms) {
					platform.init();
					entityList.push(platform);
				}
			}
			
			if (currentSector.getBricks() != null) {
				var brick:Brick;
				var bricks:Vector.<Brick> = currentSector.getBricks();
				for each(brick in bricks) {
					if(brick.getEnergy()!=0)entityList.push(brick);
				}
			}
			
			if (currentSector.getExit() != null) {
				entityList.push(currentSector.getExit());
			}
			
			if (currentSector.getPelters() != null) {
				var pelter:Pelter;
				var pelters:Vector.<Pelter> = currentSector.getPelters();
				for each(pelter in pelters) {
					entityList.push(pelter);
				}
			}
			myWorld.addList(entityList);
		}
		
		public function setPlayerStart(positionData:LocalPositionData):void {
			playerStart = positionData;
		}
		
		public function setActiveCheckpoint(checkpoint:Checkpoint):void {
			activeCheckpoint = checkpoint;
		}
		
		public function revivePlayer(player:Player):void {
			//if (currentSectorIndex != getPlayerStart().getSector())
			setCurrentSector(playerStart.getSector());
			
			for each(var sector:Sector in sectors) {
				for each(var bb:BonusBrick in sector.getBonusBricks()) {
					bb.setActive();
				}
			}
			player.x = playerStart.getTile().x*Constants.TILE_SIZE;
			player.y = playerStart.getTile().y * Constants.TILE_SIZE;
			
			myWorld.resetFrameNumber();
		}
		
		public function getCurrentSectorIndex():int {
			return currentSectorIndex;
		}
		public function getActiveCheckpoint():Checkpoint {
			return activeCheckpoint;
		}
		
		public function getTileIndexAtPosition(px:int, py:int):int {
			solidTilemap.usePositions = true;
			var ret:int = solidTilemap.getTile(px, py);
			solidTilemap.usePositions = false;
			return ret;
		}
		
		public function shake():void {
			if (shakeNum == 0) shaking = true;
			else if (shakeNum >= 5) {
				shaking = false;
				shakeNum = 0;
				FP.screen.x = FP.screen.y = 0;
			}
			
			if (shaking) {
				if (shakeNum % 2) x = y = 0;
				else{
				//	FP.screen.x = (Math.random() * 18) - 9;
					FP.screen.y = (Math.random() * 18) - 5;
				}
				shakeNum++;
			}
		}
		
		public function setTileIndexAtRowColumnToSolid(column:int, row:int):void {
			solidTilemap.setTile(column, row, 64);
		}
		
		public function getLevelMeta():LevelMeta {
			return levelMeta;
		}
		public function getLevelSaveData():LevelSaveData {
			return levelSaveData;
		}
	}

}