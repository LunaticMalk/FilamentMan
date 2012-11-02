package managers 
{
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Scano
	 */
	public class GameManager extends EventDispatcher
	{
		
		public function GameManager() 
		{
			
		}
		
		protected function Init():void
		{
			mActive = true;
		}
		
		//if we need to check if this manager is active or not...
		protected var mActive:Boolean;
			
	}

}