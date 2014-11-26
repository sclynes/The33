package{

	public class Vector2d 
	{
		public var x:Number; 
		public var y:Number;
		function Vector2d(x:Number, y:Number)
		{
			this.x = x;
			this.y = y;
		} 
		public function toString():String
		{
			return ("(x:" + x + ", y:" + y + ")");
		}
		public function getLen():Number
		{
			return (Math.sqrt(x * x + y * y));
		} 
		public function norm():Vector2d
		{
			var n:Vector2d = new Vector2d(0 , 0);
			var len:Number = this.getLen();
			n.x = x / len;
			n.y = y / len;
			return n;
		}
		public function dot(v2:Vector2d):Number
		{
			return (x * v2.x + y * v2.y);
		}
		
		public function project(v2:Vector2d):Vector2d
		{
			var _loc4:Number = v2.dot(v2);
			var _loc2:Vector2d = v2.clone();
			_loc2.mult(this.dot(v2) / _loc4);
			return (_loc2);
		} 
		public function clone():Vector2d
		{
			var _loc2:Vector2d = new Vector2d(x, y);
			return (_loc2);
		}
		public function copy(v2:Vector2d):void
		{
			x = v2.x;
			y = v2.y;
		} 
		/*function minus(v2:Vector2d):Vector2d
		{
			var _loc2:Vec =new Vector2d(x - v2.x, y - v2.y);
			return (_loc2);
		}
		function plus(v2)
		{
	//		var _loc2 = new Classes.Vector2d();
		//	_loc2.x = x + v2.x;
	//		_loc2.y = y + v2.y;
	//		return (_loc2);
		} */
		public function mult(s:Number):void
		{
			x = x * s;
			y = y * s;
		} 
		public function setXY(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
		} 
	} 
}
