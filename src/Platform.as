package  
{
	import com.greensock.motionPaths.Direction;
	import com.greensock.motionPaths.MotionPath;
	import com.greensock.motionPaths.PathFollower;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import flash.geom.Point;
	import com.demonsters.debugger.MonsterDebugger;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;

	import com.greensock.motionPaths.LinePath2D;
	import com.greensock.*;
	import com.greensock.easing.*;

	public class Platform extends Entity
	{
		private var tilemap:Tilemap;
		private var tween:TweenMax;
		private var grid:Grid;
		private var platformWidth:int
		private var direction:int;
		public var velocity:Point;
		private var railPoints:Array;
		private var positionData:LocalPositionData;
		public var speed:Number;

		private var traveller:Entity;
		private var startDistance:Number;
		private var path:LinePath2D;
		private var previousPathPoint:Point;

		public function Platform(positionData:LocalPositionData, pWidth:int, direction:int, speed:Number, startDistance:Number, strRailPoints:String) 
		{
			this.startDistance = startDistance;
			this.direction = direction;
			this.platformWidth= pWidth;
			this.positionData = positionData;
			this.speed = speed;
			makeRailPoints(strRailPoints);

			previousPathPoint = new Point(railPoints[0].x, railPoints[1].y);
			velocity = new Point();

			tilemap = new Tilemap(Assets.SOLID_TILESET, platformWidth*Constants.TILE_SIZE, Constants.TILE_SIZE, Constants.TILE_SIZE, Constants.TILE_SIZE);	
			grid = new Grid(platformWidth*Constants.TILE_SIZE, Constants.TILE_SIZE, Constants.TILE_SIZE, Constants.TILE_SIZE, 0, 0);
			type = "platform";

			tilemap.setRect(0, 0, platformWidth, 1, 44);
			grid.setRect(0, 0, platformWidth, 1, true);
			setHitbox(platformWidth * Constants.TILE_SIZE, Constants.TILE_SIZE);

			super(0, 0, tilemap);
		}

		override public function update():void {

			velocity.x=x-previousPathPoint.x;
			velocity.y=y-previousPathPoint.y;

			if (traveller != null) {
				traveller.x += velocity.x;
				traveller.y += velocity.y;
			}

			previousPathPoint.x = x;
			previousPathPoint.y = y;

		}

		public function setTraveller(traveller:Entity):void {
			this.traveller = traveller;
		}

		public function init():void {
			path = new LinePath2D(railPoints, positionData.getTile().x * Constants.TILE_SIZE, positionData.getTile().y * Constants.TILE_SIZE);
			path.addFollower(this);
			tween = new TweenMax(path, speed, { progress:1, repeat: -1, ease:SineInOut.ease } );
			tween.seek(startDistance*speed);
			tween.yoyo(true);
		}


		public function getVelocity():Point {
			return velocity;
		}

		private function makeRailPoints(strPoints:String):void {
			railPoints = new Array;
			var strVector:Array = strPoints.split(" ");
			var strCoords:Array;

			var i:int = 0;
			if (direction == 1) {
				for (i=0; i < strVector.length; i++) {
					strCoords= strVector[i].split(",");
					railPoints.push(new Point(Number(strCoords[0]), Number(strCoords[1])));
				}
			}else {
				for (i=strVector.length-1; i >= 0; i--) {
					strCoords = strVector[i].split(",");
					railPoints.push(new Point(Number(strCoords[0]), Number(strCoords[1])));
				}
			}

		}
	}

}