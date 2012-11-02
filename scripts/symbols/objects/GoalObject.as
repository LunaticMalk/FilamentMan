package symbols.objects 
{
	import constants.GameAssets;
	import constants.ZOrder;
	import customEvents.LevelEvent;
	import gamestates.PlayState;
	import managers.GameEventManager;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import symbols.characters.PlayerCharacter;
	/**
	 * ...
	 * @author Scano
	 */
	public class GoalObject extends FlxSprite
	{
		
		public var goalActive:Boolean;
		
		public function GoalObject(X:Number, Y:Number) 
		{
			super(X, Y);
			
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			this.fixed = true;
			this.solid = false;
			
			goalActive = true;
			
			CreateSprite();
			
			this.zSort = ZOrder.COLLISION_OBJECTS;
		}
		
		public function CreateSprite():void 
		{
			this.loadGraphic( GameAssets.GoalSprite );
		}
		
		override public function update():void 
		{
			super.update();
			
			if ( FlxG.state is PlayState && goalActive)
			{
				var player:PlayerCharacter = (FlxG.state as PlayState).player;
				if (player.overlaps(this))
				{
					goalActive = false;
					GameEventManager.GetInstance().dispatchEvent(new LevelEvent(LevelEvent.LEVEL_END_EVENT) );
				}
			}
		}
		
	}

}