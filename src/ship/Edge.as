package ship 
{
	import flash.geom.Point;

	public class Edge {
		private var p1:Point;
		private var p2:Point;
		
		public function Edge(p1:Point, p2:Point) {
			this.p1 = p1;
			this.p2 = p2;
		}
		
		public function getP1():Point {
			return p1;
		}
		public function getP2():Point {
			return p2;
		}
	}
}