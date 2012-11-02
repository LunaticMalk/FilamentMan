package managers 
{
	import customEvents.LevelEvent;
	import org.flixel.FlxG;
	/**
	 * Keeps track of scores and level times
	 * @author Scano
	 */
	public class RulesManager extends GameManager
	{
		
		public function RulesManager() 
		{
			super();
		}
		
		//====================================================
		/// Singleton functions
		//====================================================
		public static function GetInstance():RulesManager
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
				throw new Error("Trying to create RulesManager when it already exists!");
				return;
			}
			
			mInstance = new RulesManager();
			mInstance.Init();
		}
		
		override protected function Init():void 
		{
			super.Init();
			
			//listen for relevant events
			GameEventManager.GetInstance().SubscribeToEvent(this, LevelEvent.LEVEL_START_EVENT);
			GameEventManager.GetInstance().SubscribeToEvent(this, LevelEvent.LEVEL_END_EVENT);
			this.addEventListener(LevelEvent.LEVEL_START_EVENT, OnLevelStart);
			this.addEventListener(LevelEvent.LEVEL_END_EVENT, OnLevelEnd);
			
			mActive = false;
			
			Reset();
		}
		
		public function Update():void
		{
			if (mActive)
			{
				mLevelTime += FlxG.elapsed;
				HudManager.GetInstance().UpdateTimer(mLevelTime);
			}
		}
		
		/**
		 * Resets our values
		 */
		public function Reset():void
		{
			mTotalScore = 0;
			mLevelTime = 0;
		}
		
		public function OnLevelStart(event:LevelEvent):void
		{
			mActive = true;
			//reset level time
			mLevelTime = 0;
		}
		
		/**
		 * Right now only called when the user hits the goal...
		 * @param	event
		 */
		public function OnLevelEnd(event:LevelEvent):void
		{
			mActive = false;
			
			AddToTotalScore(mLevelTime);
		}
		
		public function AddToTotalScore(score:int):void
		{
			mTotalScore += score;
		}
		
		public function GetTotalScore():int
		{
			return mTotalScore;
		}
		
		public function GetLevelTime():int
		{
			return mLevelTime;
		}
		
		//===================================================================
		/// Member Variables
		//===================================================================
		//running tally of the time spent to finish a level
		private var mLevelTime:Number;
		//the total score, which right now is the sum of times
		private var mTotalScore:int;
		//the singleton instance
		private static var mInstance:RulesManager;
	}

}