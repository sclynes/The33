package states 
{
	import levels.Graph;
	import levels.Level;
	import levels.LevelDescriptor;
	import levels.LevelMeta;
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import levels.SectorMeta;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import sfx.SfxrSynth;
	import flash.system.System;
	import punk.fx.FXMan;
	import ship.Node;
	
	public class LevelSelectState extends World implements IState 
	{
		private var levelMeta:Array;
		private var grid:Graph;
		private var text:Text;
		private var textEntity:Entity;
		private var rightPressed:Boolean;
		private var leftPressed:Boolean;
		private var upPressed:Boolean;
		private var downPressed:Boolean;
		private var spacePressed:Boolean;
		private var levelDescriptor:LevelDescriptor;
		private var sfxSelect:SfxrSynth;
		
		public function LevelSelectState() 
		{
			var levelMetaData:Array = getLevelMetaClasses();
			levelDescriptor = new LevelDescriptor();
			levelMeta = getLevelMetaXML(levelMetaData);
			grid = new Graph(levelMeta);
			rightPressed = false;
			leftPressed = false;
			upPressed = false;
			spacePressed = true;
			downPressed = false;
			levelDescriptor.setNode(grid.getActiveNode());
			
			sfxSelect = new SfxrSynth();
			sfxSelect.loadFromSFXFile(new Assets.SFX_LEVEL_SELECT);
			sfxSelect.params.masterVolume = 0.2;
			
			super();
		}
		
		override public function begin():void {
			add(grid);
			FP.world.add(levelDescriptor);
			super.begin();
		}
		
		override public function update():void {
			getInput();
			super.update();
		}
		
			
		private function getInput():void {
			var currentId:int = grid.getActiveNode().getId();
			if (Input.check(Key.RIGHT)) {
				if(!rightPressed){
					grid.activateNodeRelative(1, 0);
					rightPressed = true;
					levelDescriptor.setNode(grid.getActiveNode());
				//	sfxSelect.play();
				}
			}else {
				rightPressed = false;
			}
			
			if (Input.check(Key.LEFT)) {
				if(!leftPressed){
					grid.activateNodeRelative( -1, 0);
					leftPressed = true;
					levelDescriptor.setNode(grid.getActiveNode());
				//	sfxSelect.play();
				}
			}else {
				leftPressed = false;
			}
			
			if (Input.check(Key.UP)) {
				if (!upPressed) {
					sfxSelect.play();
					grid.activateNodeRelative(0, -1);
					upPressed = true;
					levelDescriptor.setNode(grid.getActiveNode());
				}
			}else {
				upPressed = false;
			}
			
			if (Input.check(Key.DOWN)) {
				if (!downPressed) {
					sfxSelect.play();
					grid.activateNodeRelative(0, 1);
					downPressed = true;
					levelDescriptor.setNode(grid.getActiveNode());
				}
			}else {
				downPressed = false;
			}
			
			if (Input.check(Key.SPACE) ||Input.check(Key.ENTER)) {
				if(!spacePressed){
					var node:Node = grid.getActiveNode();
					Main.stateManager.switchState(new GameState(node.getMetaData()));
					spacePressed = true;
				}
			}else {
				spacePressed = false;
			}
			
			if (Input.check(Key.C)) {
				grid.getActiveNode().getSaveData().clear();
				grid.getActiveNode().refreshSaveData();
			}
			
		}
		
		
		private function getLevelMetaClasses():Array {
			var meta:Array = new Array();
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
		
		private function getLevelMetaXML(metaData:Array):Array {
			var xmlData:Array = new Array();
			
			for each(var xml:Class in metaData) {
				xmlData.push(new LevelMeta(xml));
			}
			
			return xmlData;
		}
		
		public function onSwitch():void {
			FXMan.clear();
			levelDescriptor = null;
			this.levelMeta = null;
			this.grid = null;
		}
	}

}