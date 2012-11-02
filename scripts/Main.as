package  
{
	import constants.ConfigConstants;
	import gamestates.MainMenuState;
	import gamestates.PlayState;
	import org.flixel.data.FlxMouse;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	
	[SWF(width="960", height="600", backgroundColor="#55AAAA")]
    [Frame(factoryClass="Preloader")]
	
	/**
	 * ...
	 * @author jcapote
	 */
	public class Main extends FlxGame
	{		
		public function Main() 
		{
			super(ConfigConstants.SCREEN_WIDTH, ConfigConstants.SCREEN_HEIGHT, MainMenuState , 1);
		}		
	}

}