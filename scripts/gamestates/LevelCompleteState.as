package gamestates 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import constants.GameAssets;
	import managers.LevelManager;
	
	/**
	 * ...
	 * @author Steve Cano
	 */
	public class LevelCompleteState extends FlxState
	{
		
		public function LevelCompleteState() 
		{
			super();
		}
		
		override public function create():void
		{
			super.create();
			
			mContinueButton = new FlxButton( FlxG.width / 2, FlxG.height / 2, OnContinueClick);
			var buttonSprite:FlxSprite = new FlxSprite();
			buttonSprite.loadGraphic(GameAssets.ContinueButtonSprite);
			mContinueButton.loadGraphic(buttonSprite, null);
			
			this.add(mContinueButton);
			
		}
		
		private function OnContinueClick():void
		{
			LevelManager.GetInstance().NextLevel();
			FlxG.state = new PlayState();
		}
		
		private var mContinueButton:FlxButton;
		
	}

}