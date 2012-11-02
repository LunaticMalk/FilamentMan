package gamestates 
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	import managers.GameEventManager;
	import managers.HudManager;
	import managers.LevelManager;
	import managers.RulesManager;
	
	/**
	 * ...
	 * @author Steve Cano
	 */
	public class InitializeState extends FlxState
	{
		
		public function InitializeState() 
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			//create the managers
			GameEventManager.Create();
			LevelManager.Create();
			RulesManager.Create();
			HudManager.Create();
			
			//switch to main menu
			FlxG.state = new MainMenuState();
		}
		
	}

}