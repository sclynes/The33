package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author 
	 */
	public class DeathEmitter extends Entity
	{
		private var timer:int;
		private var emitter:Emitter;
		public function DeathEmitter(player:Player) 
		{
			emitter = new Emitter(new BitmapData(1, 1, false, 0xffffff), 2, 2);
			emitter.newType("bits", [0]);
			var angle:Number = Math.atan2(player.getVelocity().y, player.getVelocity().x);
			var angleRange:Number = 360;

			angle = (angle * 180) / Math.PI;
			angle+= (angleRange/2);
			
			
			emitter.setMotion("bits", -angle, 300, 60, angleRange, 300, 60);
			
			timer = 30;
			graphic = emitter;
			explode(player.x, player.y);
			FP.world.add(this);
		}
		
		override public function update():void {
			super.update();
			timer -= 1;
			if (timer <= 0)FP.world.remove(this);
			
		}
		
		private function explode(x:Number, y:Number):void {
			for(var i:int = 0; i < 64; i++){
				emitter.emit('bits',x,y);
			}
		}
		
		public function getTimer():int {
			return timer;
		}
		
	}

}