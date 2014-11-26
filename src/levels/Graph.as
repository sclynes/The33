package levels 
{
	import com.greensock.plugins.Positions2DPlugin;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import flash.utils.ByteArray;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	import ship.Node;


	/**
e	 * @author 
	 */
	public class Graph extends Entity
	{
		private var nodes:Array;
		private var gridDimensions:Point;
		private var nodeRelationships:BitmapData;
		private var activeNode:Node;
		private var grid:Array;

		public function Graph(metaData:Array) 
		{
			super(10, 100);
			
			grid = new Array();
			grid = new Array();
			for (var i:int = 0; i < 13; i++)grid[i] = new Array();
			
			var rawData:ByteArray = new Assets.LEVEL_NODES; 
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			var dataElement:XML;
			
			gridDimensions = new Point(int(xmlData.nodes.@width), int(xmlData.nodes.@height));
			
			readXML(metaData);
		
			
			nodeRelationships = renderNodeRelationships();
			addGraphic(new Image(nodeRelationships));
			
			activateNode(nodes[0]);
			
			for each(var node:Node in nodes) {
				node.setPosition(node.getGridPosition().x * Constants.TILE_SIZE * 4, node.getGridPosition().y * Constants.TILE_SIZE*2);
			}
		}
		
		private function readXML(metaData:Array):void {
			var rawData:ByteArray = new Assets.LEVEL_NODES; 
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			var dataElement:XML;
			nodes = new Array;
			
			for each(dataElement in xmlData.nodes.node) {
				var id:int = int(dataElement.@id);
				var node:Node;
				if (nodes[id] == null){
					node = new Node(metaData[id], new LevelSaveData(id));
					node.setId(id);
					nodes[id] = node;
				}
				else
				node = nodes[id];
					
					
				
				for each(var childElement:XML in dataElement.children.child) {
					var childId:int = int(childElement);
					var child:Node;
					if (nodes[childId] == null) {
						child = new Node(metaData[childId], new LevelSaveData(childId));
						child.setId(childId);
						nodes[child.getId()] = child;
					}
					else child = nodes[childId];
					node.addChild(child);
				}
			
				for each(var gridElement:XML in dataElement.grid) {
					node.setGridPosition(int(gridElement.x), int(gridElement.y));
					grid[int(gridElement.x)][int(gridElement.y)] = node;
				}
				addGraphic(node.graphic);
			}
		}
	
		
		public function renderNodeRelationships():BitmapData {
			var bitmap:BitmapData = new BitmapData(1000, 700, true, 0x000000);
			Draw.setTarget(bitmap);
			for each(var node:Node in nodes) {
				var p1:Point = node.getGridPosition();
				for each(var child:Node in node.getChildren()) {
					var p2:Point = child.getGridPosition();
					if (child.getId() == 0) trace("p2 = 0");
					Draw.line((p1.x*Constants.TILE_SIZE*4)+8, (p1.y*Constants.TILE_SIZE * 2)+8, (p2.x *Constants.TILE_SIZE* 4)+8, (p2.y*Constants.TILE_SIZE * 2)+8, 0xFF0000);
				}
			}
			return bitmap;
		}
		
		override public function render():void {
			super.render();
		}
		
		public function activateNodeRelative(dirX:int, dirY:int):void {
			var currentGridPosition:Point = activeNode.getGridPosition();
			var p:Point = new Point(currentGridPosition.x, currentGridPosition.y);
			var n:Node = null;
			
				while (n == null) {
					p.y += dirY;
					p.x += dirX;
					
					if (p.y > 12) p.y = 0;
					else if (p.y < 0) p.y = 12;
					if (p.x > 10) p.x = 0;
					else if (p.x < 0) p.x = 10;
					
					if (dirX) {
						for (var i:int = 0; i < 13; i++) {
							n = grid[p.x][p.y];
							if (grid[p.x][(p.y + i) % 13] != null) {
								n=grid[p.x][(p.y + i) % 13]
								break;
							}else if (grid[p.x][(p.y - 1) % 13] != null) {
								n = grid[p.x][(p.y - 1) % 13];
								break;
							}
						}
					}else n = grid[p.x][p.y];
				}
			activateNode(n);
		}
		
		public function getActiveNode():Node {
			return activeNode;
		}
		
		public function activateNode(node:Node):void {
			if (activeNode != null) activeNode.deactivate();
			node.activate();
			activeNode = node;
		}
		
		public function getNodes():Array {
			return nodes;
		}
	}

}