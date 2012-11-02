package gamestates 
{
	import constants.ConfigConstants;
	import managers.GameEventManager;
	import managers.HudManager;
	import managers.LevelManager;
	import managers.RulesManager;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxU;
	import symbols.characters.PlayerCharacter;
	/**
	 * ...
	 * @author Scano
	 */
	public class PlayState extends FlxState
	{
		public function PlayState()
		{
			super();
		}
		
		override public function create():void 
		{
			super.create();
			
			//create the player
			mPlayer = new PlayerCharacter(400, 500);
			this.add(mPlayer);
			mPlayer.exists = false;
			
			FlxState.bgColor = 0xAAAAAA;
			
		}

		public function get player():PlayerCharacter { return mPlayer; }
		
		override public function update():void 
		{
			super.update();
			
			if (mPlayer != null && LevelManager.GetInstance().GetCurrentLevel() != null)
			{
				FlxU.collide(mPlayer, LevelManager.GetInstance().GetCurrentLevel().GetAllObjects());
			}
			
			if (FlxG.keys.justPressed("R"))
			{
				LevelManager.GetInstance().RestartLevel();
			}
			
			//mPlayer.update();
			//LevelManager.GetInstance()
		}
		
		private var mPlayer:PlayerCharacter
		
	}

}