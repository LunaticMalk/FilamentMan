package symbols.characters 
{
	import constants.GameAssets;
	import constants.GameplayConstants;
	import flash.geom.Point;
	import managers.LevelManager;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import utils.MathHelpers;
	/**
	 * ...
	 * @author Scano
	 */
	public class PlayerCharacter extends FlxSprite
	{
		
		public function PlayerCharacter(X:Number, Y:Number) 
		{
			super(X, Y);
			
			CreateSprite();
			
			mPolarity = GameplayConstants.POLARITY_NEUTRAL;
			mMagnetStuck = false;
			mFocusObject == null;
			mPolarityCooldown = 0;
			
		}
		
		public function CreateSprite():void
		{
			//debug
			this.createGraphic(32, 32, 0xFFFF00FF);
		}
		
		public function ChangePolarity(newPolarity:int):void
		{
			//if our polarity shift is on cooldown/disabled, return out
			if (mPolarityCooldown > 0)
			{
				return;
			}
			
			if (newPolarity != mPolarity)
			{
				mPolarity = newPolarity;
				
				//change colors
				switch(newPolarity)
				{
					case GameplayConstants.POLARITY_BLACK:
						this.color = 0xFF111111;
						break;
					case GameplayConstants.POLARITY_RED:
						this.color = 0xFFCC0000;
						break;
					case GameplayConstants.POLARITY_NEUTRAL:
						this.color = 0xFFFF00FF;
						break;
				}
			}
		}
		
		/**
		 * Resets the player to the specified position, rotating it back to 0 and resetting its local variables
		 * @param	X
		 * @param	Y
		 */
		public function ResetPlayer(X:Number = 0, Y:Number = 0):void
		{
			this.reset(X, Y);
			this.angle = 0;
			
			ChangePolarity(GameplayConstants.POLARITY_NEUTRAL);
			mMagnetStuck = false;
			mFocusObject == null;
		}
		
		override public function update():void 
		{			
			//check input
			if (FlxG.keys.LEFT)
			{
				ChangePolarity(GameplayConstants.POLARITY_BLACK);
			}
			else if (FlxG.keys.RIGHT)
			{
				ChangePolarity(GameplayConstants.POLARITY_RED);
			}
			else
			{
				ChangePolarity(GameplayConstants.POLARITY_NEUTRAL);
			}
			
			//move in appropriate direction
			if (mPolarity > GameplayConstants.POLARITY_NEUTRAL)
			{
				//find the nearest corresponding block
				var closestBlock:FlxObject = GetClosestObject(LevelManager.GetInstance().GetCurrentLevel().GetPolarityBlocks(mPolarity));
				
				if (closestBlock != null)
				{
					//if we're stuck on the target, don't unstuck
					if (!(mMagnetStuck && closestBlock == mFocusObject))
					{
						//get center point
						var blockCenter:FlxPoint = new FlxPoint( closestBlock.x + closestBlock.width / 2, closestBlock.y + closestBlock.height / 2 );
						
						//move to that point
						AccelerateToward(blockCenter);
					}
					
					mFocusObject = closestBlock;
				}
				else
				{
					this.acceleration.x = 0;
					this.acceleration.y = GameplayConstants.GRAVITY;
				}
			}
			else
			{
				this.acceleration.x = 0;
				this.acceleration.y = GameplayConstants.GRAVITY;
				//friction decrease
				if (onFloor)
				{						
					this.velocity.x = this.velocity.x < 0.5 && this.velocity.x > -0.5 ? 0 : this.velocity.x * 0.4;
					this.velocity.y = this.velocity.y < 0.5 && this.velocity.y > -0.5 ? 0 : this.velocity.y * 0.4;
					this.acceleration.x = this.acceleration.x < 0.5 && this.acceleration.x > -0.5 ? 0 : this.acceleration.x * 0.4;
					this.acceleration.y = this.acceleration.y < 0.5 && this.acceleration.y > -0.5 ? 0 : this.acceleration.y * 0.4;
				}
			}
			
			
			//decrease any polarity time change
			if (mPolarityCooldown > 0) { mPolarityCooldown -= FlxG.elapsed; }
			
			
			mMagnetStuck = false;
			super.update();
		}
		
		/**
		 * Accelerate toward a particular point
		 * @param	focusPoint
		 */
		public function AccelerateToward(focusPoint:FlxPoint):void
		{
			//determine direction and distance
			var diffX:Number = focusPoint.x - this.x;
			var diffY:Number = focusPoint.y - this.y;
			var distance:Number = Math.sqrt((diffX * diffX) + (diffY * diffY));
			
			//direction to face
			this.angle = FlxU.getAngle(diffX, diffY);
			
			//set acceleration in that direction
			this.acceleration = DetermineMagneticAcceleration(distance);
		}
		
		/**
		 * Disallows polarity shifts for the time specified
		 * @param	time - how long
		 */
		public function DisablePolarity(time:Number = 1):void
		{
			mPolarityCooldown = time;
		}
		
		/**
		 * Determine what acceleration will bring us toward an object at the specified
		 * distance
		 * @param	distance
		 * @return
		 */
		public function DetermineMagneticAcceleration(distance:Number):FlxPoint
		{
			var magAccel:FlxPoint = new FlxPoint();
			
			var accelMagnitude:Number = Math.abs((1 / distance ) * GameplayConstants.MAG_ACCEL_COEFFICIENT);
			
			//cap
			if (accelMagnitude > GameplayConstants.MAX_MAGNETIC_EFFECT)
			{
				accelMagnitude = GameplayConstants.MAX_MAGNETIC_EFFECT;
			}
			
			magAccel.x = Math.cos(MathHelpers.DegreesToRadians(this.angle)) * accelMagnitude;
			magAccel.y = Math.sin(MathHelpers.DegreesToRadians(this.angle)) * accelMagnitude;
			
			return magAccel;
		}
		
		/**
		 * Returns the closest object to the player from the provided array of flx objects
		 * @param	flxObjArray - array of flxobjects
		 * @return
		 */
		public function GetClosestObject(flxObjArray:Array, maxDistance:int = -1):FlxObject
		{
			var closestDistance:Number = 99999;
			var closetObject:FlxObject = null;
			//use the constant if no maxDistance specified
			maxDistance = maxDistance < 0 ? GameplayConstants.MAX_MAGNET_DISTANCE : maxDistance;
			
			for each (var obj:FlxObject in flxObjArray) 
			{
				var distance:Number = MathHelpers.DistanceBetween(this, obj);
				if ( distance < closestDistance && distance <= maxDistance )
				{
					closetObject = obj;
					closestDistance = distance;
				}
			}
			
			return closetObject;
		}
		
		public function StopMoving():void
		{
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			this.velocity.x = 0;
			this.velocity.y = 0;
		}
		override public function hitBottom(Contact:FlxObject, Velocity:Number):void 
		{
			super.hitBottom(Contact, Velocity);
			
			if (Contact == mFocusObject && !mMagnetStuck)
			{
				mMagnetStuck = true;
				StopMoving();
				this.angle = 180; //upside down
			}
		}
		override public function hitTop(Contact:FlxObject, Velocity:Number):void 
		{
			super.hitTop(Contact, Velocity);
			if (Contact == mFocusObject && !mMagnetStuck)
			{
				mMagnetStuck = true;
				StopMoving();
				this.angle = 0; //right side up
			}
		}
		override public function hitLeft(Contact:FlxObject, Velocity:Number):void 
		{
			super.hitLeft(Contact, Velocity);
			if (Contact == mFocusObject && !mMagnetStuck)
			{
				mMagnetStuck = true;
				StopMoving();
				this.angle = -190; //right
			}
		}
		override public function hitRight(Contact:FlxObject, Velocity:Number):void 
		{
			super.hitRight(Contact, Velocity);
			if (Contact == mFocusObject && !mMagnetStuck)
			{
				mMagnetStuck = true;
				StopMoving();
				this.angle = 90; //left
			}
		}
		
		
		private var mPolarity:int;	
		private var mFocusObject:FlxObject;
		private var mMagnetStuck:Boolean;
		private var mPolarityCooldown:Number;

	}

}