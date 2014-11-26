package org.flapp 
{
	import flash.external.ExternalInterface;
	
	public class FlappCore
	{
		
		public function FlappCore(useXinput:Boolean = false) 
		{
			if (useXinput)
				ControllerSupport.initControllerSupport();
				
			ExternalInterface.call("flappInitComplete");
		}
		
	}

}