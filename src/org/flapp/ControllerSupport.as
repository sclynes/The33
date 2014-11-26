package org.flapp
{
	import adobe.utils.CustomActions;
	import flash.geom.Point;
	import flash.external.ExternalInterface;
	import flash.text.engine.GroupElement;

	/**
	 * ...
	 * @author ...
	 */
	public class ControllerSupport
	{
		public static var controllers:Array;
		
		private static const stickMax:int = 32767;
		private static var stickDeadZone:int;
		private static var stickDeadZonePercentage:Number;
		
		private static const triggerMax:int = 255;
		private static var triggerDeadZone:int;
		private static var triggerDeadZonePercentage:Number;
		
		public function ControllerSupport() 
		{	
		}
		
		public static function initControllerSupport(stickDZ:Number = 0.2, triggerDZ:Number = 0.1):void
		{
			stickDeadZonePercentage = stickDZ;
			triggerDeadZonePercentage = triggerDZ;
			stickDeadZone = int(stickMax * stickDeadZonePercentage);
			triggerDeadZone = int(stickMax * triggerDeadZonePercentage);
			
			controllers = new Array();
			controllers.push(new Controller());
			controllers.push(new Controller());
			controllers.push(new Controller());
			controllers.push(new Controller());
			
			ExternalInterface.addCallback("joyUpdate", joyUpdate);
			ExternalInterface.call("controllerCallbackSet");
		}
		
		private static function joyUpdate(index:int, controllersInput:Object):void
		{
			if (controllersInput.LeftThumbX < -stickDeadZone || controllersInput.LeftThumbX > stickDeadZone)
				controllers[index].leftStick.x = controllersInput.LeftThumbX / stickMax;
			else
				controllers[index].leftStick.x = 0;
				
			if (controllersInput.LeftThumbY < -stickDeadZone || controllersInput.LeftThumbY > stickDeadZone)
				controllers[index].leftStick.y = controllersInput.LeftThumbY / stickMax * -1;
			else
				controllers[index].leftStick.y = 0;
				
			if (controllersInput.RightThumbX < -stickDeadZone || controllersInput.RightThumbX > stickDeadZone)
				controllers[index].rightStick.x = controllersInput.RightThumbX / stickMax;
			else
				controllers[index].rightStick.x = 0;
				
			if (controllersInput.RightThumbY < -stickDeadZone || controllersInput.RightThumbY > stickDeadZone)
				controllers[index].rightStick.y = controllersInput.RightThumbY / stickMax * -1;
			else
				controllers[index].rightStick.y = 0;
				
			if (controllersInput.LeftTrigger < triggerDeadZone)
				controllers[index].leftTrigger = controllersInput.LeftTrigger / triggerMax;
				
			if (controllersInput.RightTrigger < triggerDeadZone)
				controllers[index].rightTrigger = controllersInput.RightTrigger / triggerMax;
				
			controllers[index].A = controllersInput.ButtonA == 1;
			controllers[index].B = controllersInput.ButtonB == 1;
			controllers[index].X = controllersInput.ButtonX == 1;
			controllers[index].Y = controllersInput.ButtonY == 1;
			
			controllers[index].dpadUp = controllersInput.ButtonDpadUp == 1;
			controllers[index].dpadDown = controllersInput.ButtonDpadDown == 1;
			controllers[index].dpadLeft = controllersInput.ButtonDpadLeft == 1;
			controllers[index].dpadRight = controllersInput.ButtonDpadRight == 1;
			
			controllers[index].start = controllersInput.ButtonStart == 1;
			controllers[index].back = controllersInput.ButtonBack == 1;
			
			controllers[index].leftBumper = controllersInput.ButtonLeftBumper == 1;
			controllers[index].rightBumper = controllersInput.ButtonRightBumper == 1;
			
		}
		
	}

}