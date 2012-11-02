package managers 
{
	import constants.ConfigConstants;
	import constants.GameplayConstants;
	import customEvents.LevelEvent;
	import flash.events.Event;
	import gamestates.PlayState;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import symbols.levelmanagement.Level;
	import symbols.objects.BlackPolarityBlock;
	import symbols.objects.BlackPolaritySling;
	import symbols.objects.NeutralBlock;
	import symbols.objects.RedPolaritySling;
	/**
	 * ...
	 * @author Scano
	 */
	public class LevelManager extends GameManager
	{
		
		public function LevelManager() 
		{	
			
		}
		
		public static function GetInstance():LevelManager
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
				throw new Error("Trying to create LevelManager when it already exists!");
				return;
			}
			
			mInstance = new LevelManager();
			mInstance.Init();
		}
		
		public static function Shutdown():void
		{
			if (mInstance == null)
			{
				throw new Error("Trying to shutdown LevelManager when it doesn't exist");
				return;
			}
			
			
			mInstance.Destroy();
		}
		
		
		public function NextLevel():void
		{
			mCurrentLevelIndex++;
			if (mCurrentLevelIndex >= GameplayConstants.GAME_LEVELS.length)
			{
				//game over, we're done
			}
			else
			{
				mCurrentLevel = new Level();
				mCurrentLevel.xmlFileName = GameplayConstants.GAME_LEVELS[mCurrentLevelIndex];
				mParser.LoadLevel( mCurrentLevel, ConfigConstants.LEVEL_PATH + mCurrentLevel.xmlFileName );
			}
		}
		
		public function StartLevel():void
		{
			mCurrentLevel.Init();
			
			GameEventManager.GetInstance().dispatchEvent(new LevelEvent(LevelEvent.LEVEL_START_EVENT));
		}
		
		/**
		 * Shuts down and nulls out the current level
		 */
		public function EndLevel():void
		{
			mCurrentLevel.Shutdown();
			mCurrentLevel = null;
		}
		
		/**
		 * TODO: Doesn't work, kills entire level
		 */
		public function RestartLevel():void
		{
			EndLevel();
			--mCurrentLevelIndex;
			NextLevel();
		}
		
		
		public function GetCurrentLevel():Level
		{
			return mCurrentLevel;
		}
				
		public function GetCurrentLevelName():String
		{
			//todo: make this clever
			return "Level " + (mCurrentLevelIndex + 1).toString();
		}
		//==========================================================================
		// Private
		
		private function Destroy():void
		{
			mInstance = null;
		}
		
		override protected function Init():void 
		{
			super.Init();
			
			mCurrentLevelIndex = -1;
			mCurrentLevel = null;
			
			mParser = new OgmoXMLParser();
			mParser.addEventListener("LEVEL LOADED", OnLevelLoaded);
														
			//listen for level end events
			GameEventManager.GetInstance().SubscribeToEvent(this, LevelEvent.LEVEL_END_EVENT);
			this.addEventListener(LevelEvent.LEVEL_END_EVENT, OnLevelEnd);
			
			NextLevel();
		}
		
		private function OnLevelLoaded(event:Event):void
		{
			StartLevel();
		}
		
		private function DebugLevel():Level
		{
			var level:Level = new Level();
			
			var blackSling:BlackPolarityBlock = new BlackPolarityBlock(400, 150);
			var redSling:RedPolaritySling = new RedPolaritySling(500, 400);
			
			level.AddObject(blackSling, "Slings", GameplayConstants.POLARITY_BLACK);
			level.AddObject(redSling, "Slings", GameplayConstants.POLARITY_RED);
			
			//borders
			for (var i:int = 0; i < (ConfigConstants.SCREEN_WIDTH/32) + 1; i++) 
			{
				var bottom:NeutralBlock = new NeutralBlock( i * 32, 580 );
				var top:NeutralBlock = new NeutralBlock( i * 32, 0 );
				level.AddObject(bottom, "NeutralBlock");
				level.AddObject(top, "NeutralBlock");
			}
			for (i = 0; i < (ConfigConstants.SCREEN_HEIGHT/32) + 1; i++) 
			{
				var left:NeutralBlock = new NeutralBlock( -16, i * 32 );
				var right:NeutralBlock = new NeutralBlock( 950, i * 32 );
				level.AddObject(left, "NeutralBlock");
				level.AddObject(right, "NeutralBlock");
			}
		
			return level;
		}
		
		
		private function OnLevelEnd(event:LevelEvent):void
		{
			EndLevel();
			NextLevel();
		}
		
		
		//===================================================================
		/// Member Variables
		//===================================================================
		private static var mInstance:LevelManager = null;
		private var mCurrentLevel:Level;
		private var mCurrentLevelIndex:int;
		private var mParser:OgmoXMLParser;
		
		
	}

}