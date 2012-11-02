package symbols.objects 
{
	import constants.GameAssets;
	import constants.GameplayConstants;
	import constants.ZOrder;
	/**
	 * ...
	 * @author Scano
	 */
	public class BlackPolaritySling extends PolarityObject
	{
		
		public function BlackPolaritySling(X:Number, Y:Number) 
		{
			super(X, Y);
			
			mPolarity = GameplayConstants.POLARITY_BLACK;
			
			this.solid = false;
			
			this.zSort = ZOrder.COLLISION_OBJECTS;
		}
		
		override public function CreateSprite():void 
		{
			this.loadGraphic(GameAssets.DebugTiles, false, false, 32, 32);
			this.addAnimation("Idle", [2]);
		}
		
	}

}