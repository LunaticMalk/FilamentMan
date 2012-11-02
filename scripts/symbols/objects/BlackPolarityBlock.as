package symbols.objects 
{
	import constants.GameAssets;
	import constants.GameplayConstants;
	import constants.ZOrder;
	/**
	 * ...
	 * @author Scano
	 */
	public class BlackPolarityBlock extends PolarityObject
	{
		
		public function BlackPolarityBlock(X:Number, Y:Number) 
		{
			super(X, Y);
			
			mPolarity = GameplayConstants.POLARITY_BLACK;
			
			this.zSort = ZOrder.COLLISION_OBJECTS;
		}
		
		override public function CreateSprite():void 
		{
			//this.createGraphic(50, 50, 0xFF000000);
			this.loadGraphic(GameAssets.BlackBlockSprite, false, false, 32, 32);
			this.addAnimation("Idle", [0]);
		}
		
	}

}