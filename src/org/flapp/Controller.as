package org.flapp 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class Controller
	{
		public var leftStick:Point;
		public var rightStick:Point;
		public var leftTrigger:Number;
		public var rightTrigger:Number;
		
		public var A:Boolean;
		public var B:Boolean;
		public var X:Boolean;
		public var Y:Boolean;
		
		public var dpadUp:Boolean;
		public var dpadDown:Boolean;
		public var dpadLeft:Boolean;
		public var dpadRight:Boolean;
		
		public var start:Boolean;
		public var back:Boolean;
		
		public var leftBumper:Boolean;
		public var rightBumper:Boolean;
		
		public function Controller() 
		{
			leftStick = new Point();
			rightStick = new Point();
			leftTrigger = 0;
			rightTrigger = 0;
		}
		
	}

}