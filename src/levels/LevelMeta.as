package levels 
{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.display.Loader;
	public class LevelMeta 
	{
		private var music:Class
		private var sectorMeta:Array;
		private var levelData:Class;
		private var name:String;
		private var id:int;
		private var par:int;
		private var numBricks:int;
		
		public function LevelMeta(metaData:Class) 
		{
			sectorMeta = new Array();
			loadData(metaData);
		}
		
		public function setNumberOfBricks(num:int):void {
			numBricks = num;
		}
		
		public function getNumberOfBricks():int {
			return numBricks;
		}
		
		private function loadData(xml:Class):void {
			var rawData:ByteArray = new xml; 
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			var dataElement:XML;
			
			id = xmlData.level;
			par = xmlData.par;
			music = _getMusic(xmlData.music.toString());
			levelData = _getLevelData(xmlData.level.toString());
			name = xmlData.name.toString();
			
			for each(dataElement in xmlData.backgrounds.sector) {
				var sm:SectorMeta = new SectorMeta();
				
				sm.id = Number(dataElement.@id);
				
				sm.background = _getBackground(dataElement.image);
				
				var b:int = int(dataElement.starfield);
				if (b==1) sm.starField = true;
				else sm.starField = false;

				sectorMeta.push(sm);
			}
			
		}
		
		private function _getMusic(musicString:String):Class {
			if (musicString == "cakephone") return Assets.MUSIC_CAKEPHONE;
			
			return null;
		}
		
		private function _getBackground(bgString:String):Class {
		//	if (bgString == "01") return Assets.BG_WINDOW;
		//	if (bgString == "02") return Assets.BG_WINDOW2;
			return null;
		}
		
		private function _getLevelData(levelString:String):Class {
			
			switch(int(levelString)) {
				case 0:return Assets.LEVEL_00;break;
				case 1:return Assets.LEVEL_01;break;
				case 2:return Assets.LEVEL_02; break;
				case 3:return Assets.LEVEL_03; break;
				case 4:return Assets.LEVEL_04; break;
				case 5:return Assets.LEVEL_05; break;
				case 6:return Assets.LEVEL_06; break;
				case 7:return Assets.LEVEL_07; break;
				case 8:return Assets.LEVEL_08;break;
				case 9:return Assets.LEVEL_09;break;
				case 10:return Assets.LEVEL_10;break;
				case 11:return Assets.LEVEL_11;break;
				case 12:return Assets.LEVEL_12;break;
				case 13:return Assets.LEVEL_13;break;
				case 14:return Assets.LEVEL_14;break;
				case 15:return Assets.LEVEL_15;break;
				case 16:return Assets.LEVEL_16;break;
				case 17:return Assets.LEVEL_17;break;	
				case 18:return Assets.LEVEL_18;break;	
				case 19:return Assets.LEVEL_19;break;	
				case 20:return Assets.LEVEL_20;break;	
			}
			return null;
		}
		
		public function getMusic():Class {
			return music;
		}
		
		public function getSectorMeta():Array {
			return sectorMeta;
		}
		
		public function getId():int {
			return id;
		}
		
		public function getName():String {
			return name;
		}
		
		public function getLevelData():Class {
			return levelData;
		}
		
		public function getPar():int {
			return par;
		}
	}

}