package symbols.objects 
{
	import constants.GameplayConstants;
	import org.flixel.FlxSprite;
	import symbols.characters.PlayerCharacter;
	/**
	 * ...
	 * @author Scano
	 */
	public class PolarityObject extends FlxSprite
	{
		
		public function PolarityObject(X:Number, Y:Number) 
		{
			super(X, Y);
			
			mPolarity = GameplayConstants.POLARITY_NEUTRAL;
			
			this.fixed = true;
			this.acceleration.y = 0;
			this.acceleration.x = 0;
			
			CreateSprite();
			
			this.play("Idle");
			
		}
		
		public function CreateSprite():void
		{
			//debug
			this.createGraphic(50, 50, 0xFFFFFFFF);
		}
		
		public function get polarity():int { return mPolarity; }
		
		protected var mPolarity:int;
		
		
	}

}