package symbols.objects 
{
	import constants.GameAssets;
	import constants.GameplayConstants;
	import constants.ZOrder;
	/**
	 * ...
	 * @author Scano
	 */
	public class RedPolaritySling extends PolarityObject
	{
		
		public function RedPolaritySling(X:Number , Y:Number) 
		{
			super(X, Y);
			
			mPolarity = GameplayConstants.POLARITY_RED;
			
			this.solid = false;
			
			zSort = ZOrder.COLLISION_OBJECTS;
		}
		
		override public function CreateSprite():void 
		{
			this.loadGraphic(GameAssets.RedSlingSprite, false, false, 32, 32);
			this.addAnimation("Idle", [0]);
		}
		
	}

}