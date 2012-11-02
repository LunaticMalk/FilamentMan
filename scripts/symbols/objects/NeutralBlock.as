package symbols.objects 
{
	import constants.GameAssets;
	import constants.ZOrder;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Scano
	 */
	public class NeutralBlock extends FlxSprite
	{
		
		public function NeutralBlock(X:Number, Y:Number) 
		{
			super(X, Y);
			this.fixed = true;
			this.acceleration.y = 0;
			this.acceleration.x = 0;
			
			CreateSprite();
			
			this.play("Idle");
			
			this.zSort = ZOrder.COLLISION_OBJECTS;
		}
		
		public function CreateSprite():void
		{
			//debug
			this.loadGraphic(GameAssets.NeutralBlockSprite, false, false, 32, 32);
			this.addAnimation("Idle", [0]);
		}
	}
}