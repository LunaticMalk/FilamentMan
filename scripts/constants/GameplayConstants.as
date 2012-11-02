package constants 
{
	/**
	 * ...
	 * @author Scano
	 */
	public class GameplayConstants
	{
		public static const GRAVITY : Number = 1000;
		
		
		public static const POLARITY_NEUTRAL:int = -1;
		public static const POLARITY_BLACK:int = 0;
		public static const POLARITY_RED:int = 1;
		
		
		//Max effect a magnet can have on acceleration
		public static const MAX_MAGNETIC_EFFECT:Number = 2000;
		//affects how much distance to a "magnet" matters
		public static const MAG_ACCEL_COEFFICIENT:Number = 80000;
		//affects how much pull magnets have
		public static const MAGNETIC_STRENGTH:Number = 0.3;
		//max distance his polarity will check for
		public static const MAX_MAGNET_DISTANCE:Number = 800;
		//max velocity
		public static const MAX_VELOCITY:Number = 2000;
		//how long do we stay neutralized after hitting a neutralizer
		public static const NEUTRALIZER_TIME:Number = 1.0;
		
		
		public static const GAME_LEVELS:Array = 
		[
			"testLevel3.oel",
			"testLevel2.oel",
			"testLevel.oel",

		];
	}

}