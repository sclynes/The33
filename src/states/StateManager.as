package states 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;

	public class StateManager 
	{
		private var stateVector:Vector.<World>;
		
		public function StateManager() 
		{
			stateVector = new Vector.<World>;
		}
		
		public function switchState(newState:World):void{
			var ret:World = stateVector.pop();
			stateVector.push(newState);
			FP.world = newState;
			ret = null;
		}
		
		public function pushState(newState:World):void {
			stateVector.push(newState);
			FP.world = newState;
		}
		
		public function popState():World {
			var ret:World = stateVector.pop();
			FP.world = stateVector[stateVector.length - 1];
			return ret;
		}
		
		public function getCurrentState():World {
			return stateVector[stateVector.length - 1];
		}
		
	}

}