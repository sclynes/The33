package ship 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import levels.LevelDescriptor;
	import levels.LevelMeta;
	import mx.core.EdgeMetrics;
	import flash.utils.ByteArray;
	import levels.LevelSaveData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import punk.fx.graphics.FXImage;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class ShipEntity extends Entity
	{
		private var vertices:Vector.<Point>;
		private var nodes:Array;
		private var metaData:Vector.<LevelMeta>;
		private var edges:Vector.<Edge>;
		private var image:FXImage;
		private var bitmap:BitmapData;
		private var shipScale:Point;
		private var activeNode:Node;
		
		public function ShipEntity(metaData:Vector.<LevelMeta>) 
		{	
			var rawData:ByteArray = new Assets.LEVEL_NODES; 
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			var dataElement:XML;
			shipScale = new Point(10, 10);
			bitmap = new BitmapData(800, 500, false, 0x000000);
			image = new FXImage(bitmap);
			addGraphic(image);
			vertices = configureVertices();
			edges = configureEdges();
			readXML(metaData);	
			
			super(20, 100);
		}
		
		public function getActiveNode():Node {
			return activeNode;
		}
		
		public function getNumNodes():int {
			return nodes.length;
		}
		
		private function drawEdges():void {
			Draw.setTarget(bitmap);
			var p1:Point;
			var p2:Point;
			var node:Node;
			var e:Edge;
			bitmap.floodFill(0, 0, 0x000000);
			
			for each(node in nodes) {
				if(node != activeNode){
					for each (e in edges) {
						p1 = e.getP1();
						p2 = e.getP2();

						Draw.linePlus(p1.x*shipScale.x, (p1.y+15)*shipScale.y, p2.x*shipScale.x, (p2.y+15)*shipScale.y, 0x222222, 1, 3)
					}
				}
			}
			
			for each(e in activeNode.getEdges()) {
				p1 = e.getP1();
				p2 = e.getP2();
				Draw.linePlus(p1.x*shipScale.x, (p1.y+15)*shipScale.y, p2.x*shipScale.x, (p2.y+15)*shipScale.y, 0x00ffff, 1, 3);
			}
		}
		
		public function activateNode(index:int):void {
			activeNode = nodes[index];
			drawEdges();
		}
		
		
		
		private function configureVertices():Vector.<Point> {
			var v:Vector.<Point> = new Vector.<Point>;
			
			v.push(new Point(0,0)); //0
			v.push(new Point(9,-9)); //1
			v.push(new Point(9,9)); //2
			v.push(new Point(12,-11)); //3
			v.push(new Point(12,11)); //4
			v.push(new Point(9,0)); //5
			v.push(new Point(14,-5)); //6
			v.push(new Point(14,5)); //7
			v.push(new Point(16,-6)); //8
			v.push(new Point(16,6)); //9
			v.push(new Point(20,-13)); //10
			v.push(new Point(20, 13)); //11
			v.push(new Point(20,-9)); //12
			v.push(new Point(20,9)); //13
			v.push(new Point(20, 0)); //14
			v.push(new Point(23, -6)); //15
			v.push(new Point(23,6)); //16
			v.push(new Point(27,-15)); //17
			v.push(new Point(27,15)); //18
			v.push(new Point(27,-10)); //19
			v.push(new Point(27,10)); //20
			v.push(new Point(27,-6)); //21
			v.push(new Point(27,6)); //22
			v.push(new Point(29,0)); //23
			v.push(new Point(33,-12)); //24
			v.push(new Point(33,12)); //25
			v.push(new Point(33,-5)); //26
			v.push(new Point(33,5)); //27
			v.push(new Point(33,-2)); //28
			v.push(new Point(33,2)); //29
			v.push(new Point(43,-3)); //30
			v.push(new Point(43,3)); //31
			v.push(new Point(46,-7)); //32
			v.push(new Point(46,7)); //33
			v.push(new Point(49,0)); //34
			v.push(new Point(53,-3)); //35
			v.push(new Point(53,3)); //36
			v.push(new Point(62, 0)); //37
			
			return v;
		}
		
		private function readXML(metaData:Vector.<LevelMeta>):void {
			var rawData:ByteArray = new Assets.LEVEL_NODES; 
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			var dataElement:XML;
			nodes = new Array();
			
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
					//grid[int(gridElement.x)][int(gridElement.y)] = node;
				}
				
				for each(var edge:XML in dataElement.edges.e) {
					node.addEdge(edges[int(edge)]);
				}
				
				
			//	addGraphic(node.graphic);
			}
		}
		
		public function configureEdges():Vector.<Edge> {
			var e:Vector.<Edge> = new Vector.<Edge>;
			e.push(new Edge(vertices[0],vertices[1]));//0
			e.push(new Edge(vertices[0],vertices[2]));//1
			e.push(new Edge(vertices[1],vertices[3]));//2
			e.push(new Edge(vertices[2],vertices[4]));//3
			e.push(new Edge(vertices[5],vertices[6]));//4
			e.push(new Edge(vertices[5],vertices[7]));//5
			e.push(new Edge(vertices[1],vertices[6]));//6
			e.push(new Edge(vertices[2],vertices[7]));//7
			e.push(new Edge(vertices[6],vertices[8]));//8
			e.push(new Edge(vertices[7],vertices[9]));//9
			e.push(new Edge(vertices[3],vertices[10]));//10
			e.push(new Edge(vertices[4],vertices[11]));//11
			e.push(new Edge(vertices[8],vertices[14]));//12
			e.push(new Edge(vertices[9],vertices[14]));//13
			e.push(new Edge(vertices[10],vertices[12]));//14
			e.push(new Edge(vertices[11],vertices[13]));//15
			e.push(new Edge(vertices[8],vertices[12]));//16
			e.push(new Edge(vertices[9],vertices[13]));//17
			e.push(new Edge(vertices[12],vertices[15]));//18
			e.push(new Edge(vertices[13],vertices[16]));//19
			e.push(new Edge(vertices[10],vertices[17]));//20
			e.push(new Edge(vertices[11],vertices[18]));//21
			e.push(new Edge(vertices[10],vertices[19]));//22
			e.push(new Edge(vertices[11],vertices[20]));//23
			e.push(new Edge(vertices[15],vertices[19]));//24
			e.push(new Edge(vertices[16],vertices[20]));//25
			e.push(new Edge(vertices[14],vertices[21]));//26
			e.push(new Edge(vertices[14],vertices[22]));//27
			e.push(new Edge(vertices[14],vertices[23]));//28
			e.push(new Edge(vertices[17],vertices[24]));//29
			e.push(new Edge(vertices[18],vertices[25]));//30
			e.push(new Edge(vertices[19],vertices[24]));//31
			e.push(new Edge(vertices[20],vertices[25]));//32
			e.push(new Edge(vertices[15],vertices[21]));//33
			e.push(new Edge(vertices[16],vertices[22]));//34
			e.push(new Edge(vertices[21],vertices[26]));//35
			e.push(new Edge(vertices[22],vertices[27]));//36
			e.push(new Edge(vertices[23],vertices[28]));//37
			e.push(new Edge(vertices[23],vertices[29]));//38
			e.push(new Edge(vertices[26],vertices[28]));//39
			e.push(new Edge(vertices[27],vertices[29]));//40
			e.push(new Edge(vertices[19],vertices[30]));//41
			e.push(new Edge(vertices[20],vertices[31]));//42
			e.push(new Edge(vertices[28],vertices[29]));//43
			e.push(new Edge(vertices[26],vertices[30]));//44
			e.push(new Edge(vertices[27],vertices[31]));//45
			e.push(new Edge(vertices[24],vertices[32]));//46
			e.push(new Edge(vertices[25],vertices[33]));//47
			e.push(new Edge(vertices[30],vertices[32]));//48
			e.push(new Edge(vertices[31],vertices[33]));//49
			e.push(new Edge(vertices[30],vertices[34]));//50
			e.push(new Edge(vertices[31],vertices[34]));//51
			e.push(new Edge(vertices[32],vertices[35]));//52
			e.push(new Edge(vertices[33],vertices[36]));//53
			e.push(new Edge(vertices[34],vertices[35]));//54
			e.push(new Edge(vertices[34],vertices[36]));//55
			e.push(new Edge(vertices[35],vertices[37]));//56
			e.push(new Edge(vertices[36], vertices[37]));//57
			
			return e;
		}
	}
}

