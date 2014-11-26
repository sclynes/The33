package states 
{
	import levels.LevelDescriptor;
	import levels.LevelMeta;
	import net.flashpunk.World;
	import ship.ShipEntity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author 
	 */
	public class ShipState extends World implements IState
	{
		private var shipEntity:ShipEntity;
		private var levelMeta:Vector.<LevelMeta>;
		private var levelDescriptor:LevelDescriptor;
		private var activeIndex:int;
		
		public function ShipState() 
		{
			var levelMetaClasses:Vector.<Class> = getLevelMetaClasses();
			levelMeta = getLevelMetaXML(levelMetaClasses);
			levelDescriptor = new LevelDescriptor();
			
			shipEntity = new ShipEntity(levelMeta);
			activeIndex = 1;
			levelDescriptor.x = 700;
			levelDescriptor.y = 20;
			add(shipEntity);
			add(levelDescriptor);
			
			shipEntity.activateNode(activeIndex);
			levelDescriptor.setNode(shipEntity.getActiveNode());
		}
		
		public function onSwitch():void { }
		
		private function getLevelMetaClasses():Vector.<Class> {
			var meta:Vector.<Class> = new Vector.<Class>;
			meta.push(Assets.LEVEL_00_META);
			meta.push(Assets.LEVEL_01_META);
			meta.push(Assets.LEVEL_02_META);
			meta.push(Assets.LEVEL_03_META);
			meta.push(Assets.LEVEL_04_META);
			meta.push(Assets.LEVEL_05_META);
			meta.push(Assets.LEVEL_06_META);
			meta.push(Assets.LEVEL_07_META);
			meta.push(Assets.LEVEL_08_META);
			meta.push(Assets.LEVEL_09_META);
			meta.push(Assets.LEVEL_10_META);
			meta.push(Assets.LEVEL_11_META);
			meta.push(Assets.LEVEL_12_META);
			meta.push(Assets.LEVEL_13_META);
			meta.push(Assets.LEVEL_14_META);
			meta.push(Assets.LEVEL_15_META);
			meta.push(Assets.LEVEL_16_META);
			meta.push(Assets.LEVEL_17_META);
			meta.push(Assets.LEVEL_18_META);
			meta.push(Assets.LEVEL_19_META);
			meta.push(Assets.LEVEL_20_META);
			
			return meta;
		}
		
		private function getLevelMetaXML(metaData:Vector.<Class>):Vector.<LevelMeta> {
			var xmlData:Vector.<LevelMeta> = new Vector.<LevelMeta>;
			
			for each(var xml:Class in metaData) {
				xmlData.push(new LevelMeta(xml));
			}
			
			return xmlData;
		}
		
		override public function update():void {
			getInput();
			
			super.update();
		}
		
		private function getInput():void {
			if (Input.pressed(Key.RIGHT)) {
				activeIndex = (activeIndex+1)%shipEntity.getNumNodes();
				shipEntity.activateNode(activeIndex);
				levelDescriptor.setNode(shipEntity.getActiveNode());
			}else if (Input.pressed(Key.LEFT)) {
				activeIndex = activeIndex - 1;
				if (activeIndex < 0) activeIndex = shipEntity.getNumNodes() - 1;
				shipEntity.activateNode(activeIndex);
				levelDescriptor.setNode(shipEntity.getActiveNode());
			}else if (Input.pressed(Key.ENTER) || Input.pressed(Key.SPACE)) {
				Main.stateManager.switchState(new GameState(shipEntity.getActiveNode().getMetaData()));
			}else if (Input.check(Key.C)) {
				shipEntity.getActiveNode().getSaveData().clear();
				shipEntity.getActiveNode().refreshSaveData();
			}
		}
		
		
	}

}