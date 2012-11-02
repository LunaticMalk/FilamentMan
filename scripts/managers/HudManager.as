package managers 
{
	import customEvents.LevelEvent;
	import gamestates.PlayState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import symbols.ui.LevelTimerUI;
	/**
	 * Handles any UI/HUD properties
	 * @author Scano
	 */
	public class HudManager extends GameManager
	{
		
		public function HudManager() 
		{
			super();
		}
		
		//====================================================
		/// Singleton functions
		//====================================================
		public static function GetInstance():HudManager
		{
			if (mInstance == null)
			{
				Create();
			}
			
			return mInstance;
		}
		
		public static function Create():void
		{
			if (mInstance != null)
			{
				throw new Error("Trying to create HudManager when it already exists!");
				return;
			}
			
			mInstance = new HudManager();
			mInstance.Init();
		}
		
		override protected function Init():void 
		{
			super.Init();
			
			GameEventManager.GetInstance().SubscribeToEvent(this, LevelEvent.LEVEL_START_EVENT);
			this.addEventListener(LevelEvent.LEVEL_START_EVENT, OnLevelStart);
		}
		
		public function ResetHUD():void
		{
			mTimer = new LevelTimerUI( FlxG.width - 80, FlxG.height - 80 );
			mLevelDisplay = new FlxText( 40, FlxG.height - 80, 100);
			
			mTimer.scrollFactor.x = mTimer.scrollFactor.y = 0;
			mLevelDisplay.scrollFactor.x = mLevelDisplay.scrollFactor.y = 0;
			
			if (FlxG.state is PlayState)
			{
				(FlxG.state as PlayState).add(mTimer);
				(FlxG.state as PlayState).add(mLevelDisplay);
			}
		}
		
		public function UpdateTimer(newTime:Number):void
		{
			mTimer.UpdateTime(newTime);
		}
		
		private function OnLevelStart(event:LevelEvent):void
		{
			ResetHUD();
			mLevelDisplay.text = LevelManager.GetInstance().GetCurrentLevelName();
			UpdateTimer(0);
			
		}
		
		//===================================================================
		/// Member Variables
		//===================================================================
		private var mTimer:LevelTimerUI;
		private var mLevelDisplay:FlxText;
		private static var mInstance:HudManager = null;
		
	}

}