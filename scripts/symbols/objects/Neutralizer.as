package symbols.objects 
{
	import constants.GameAssets;
	import constants.GameplayConstants;
	import constants.ZOrder;
	import gamestates.PlayState;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import symbols.characters.PlayerCharacter;
	/**
	 * ...
	 * @author Scano
	 */
	public class Neutralizer extends FlxSprite
	{
		
		public function Neutralizer(X:Number, Y:Number) 
		{
			super(X,Y);
			
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			this.fixed = true;
			this.solid = false;
			
			this.zSort = ZOrder.COLLISION_OBJECTS;
			
			CreateSprite();
		}
		
		public function CreateSprite():void 
		{
			this.loadGraphic( GameAssets.NeutralizerSprite );
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FlxG.state is PlayState)
			{
				var player:PlayerCharacter = (FlxG.state as PlayState).player;
				
				//neutralize the player if he runs over us...
				if (this.overlaps(player))
				{
					player.ChangePolarity(GameplayConstants.POLARITY_NEUTRAL);
					player.DisablePolarity(GameplayConstants.NEUTRALIZER_TIME);
					player.flicker( GameplayConstants.NEUTRALIZER_TIME );
				}
			}
		}
		
		
	}

}