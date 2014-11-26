package ship 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import levels.LevelMeta;
	import punk.fx.graphics.FXSpritemap;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import levels.LevelSaveData;
	public class Node extends Entity
	{
		private var levelMeta:LevelMeta;
		private var children:Array;
		private var parents:Array;
		private var gridPosition:Point;
		private var edges:Vector.<Edge>;
		private var id:int;
		private var txtNumber:Text;
		private var saveData:LevelSaveData;
		public function Node(meta:LevelMeta, saveData:LevelSaveData) 
		{
			super(0, 0);
			edges = new Vector.<Edge>;
			this.saveData = saveData;
			levelMeta = meta;
			gridPosition = new Point();
		}
		
		public function addChild(child:Node):void {
			if (children == null) children = new Array();
			children.push(child);
		}
		
		public function getChildren():Array {
			return children;
		}
		
		public function setGridPosition(px:int, py:int):void {
			gridPosition.x = px;
			gridPosition.y = py;
		}
		
		public function getGridPosition():Point {
			return gridPosition;
		}
		
		public function setId(id:int):void {
			this.id = id;
		}
		
		public function getId():int {
			return id;
		}
		
		public function getMetaData():LevelMeta {
			return levelMeta;
		}
		
		public function activate():void {
		//	spritemap.play("active");
		}
		public function deactivate():void {
		//	spritemap.play("inactive");
		}
		
		public function setPosition(px:int, py:int):void {
		//	x = spritemap.x = px;
		//	y = spritemap.y = py;
		}
		
		public function getSaveData():LevelSaveData {
			return saveData;
		}
		
		override public function update():void {
			super.update();
		}
		
		public function refreshSaveData():void {
			saveData = new LevelSaveData(id);
		}
		
		public function addEdge(e:Edge):void {
			edges.push(e);
		}
		
		public function getEdges():Vector.<Edge> {
			return edges;
		}
	}
}