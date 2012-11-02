package symbols.levelmanagement 
{
	import adobe.utils.ProductManager;
	import constants.GameplayConstants;
	import flash.geom.Point;
	import gamestates.PlayState;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import symbols.objects.GoalObject;
	/**
	 * ...
	 * @author Scano
	 */
	public class Level
	{
		
		public function Level() 
		{
			//create polarity block array
			mPolarityBlocks = new Array();
			//red and black
			mPolarityBlocks.push(new Array());
			mPolarityBlocks.push(new Array());
			
			//create object hash
			mLevelObjects = new Object();
			mObjectGroups = new Array();
			
			mPlayerSpawnPoint = new Point();
			
			mLevelGoal = null;
			
			xmlFileName = "default"
		}
			
		
		public function GetPolarityBlocks(polarity:int):Array
		{
			if (polarity < 0 || polarity > mPolarityBlocks.length - 1)
			{
				return null;
			}
			
			return mPolarityBlocks[polarity] as Array;
		}
		
		public function GetAllObjects():FlxGroup
		{
			var group:FlxGroup = new FlxGroup();
			
			for (var i:int = 0; i < mObjectGroups.length; i++) 
			{
				group.add( mLevelObjects[mObjectGroups[i]] );
			}
			
			return group;
		}
		
		public function AddObject(obj:FlxObject, groupkey:String = "Misc", polarity:int = GameplayConstants.POLARITY_NEUTRAL):void
		{
			//might have to use try/catch logic?
			if (mLevelObjects[groupkey] == null)
			{
				AddNewObjectGroup(groupkey);
				
			}
			
			(mLevelObjects[groupkey] as FlxGroup).members.push(obj);
			
			if (polarity > GameplayConstants.POLARITY_NEUTRAL)
			{
				(mPolarityBlocks[polarity] as Array).push(obj);
			}
		}
		
		public function RemoveObject(obj:FlxObject, groupkey:String):void
		{
			(mLevelObjects[groupkey] as FlxGroup).remove(obj);
		}
		
		public function Reset():void
		{
			//create polarity block array
			mPolarityBlocks = new Array();
			//red and black
			mPolarityBlocks.push(new Array());
			mPolarityBlocks.push(new Array());
			
			//create object hash
			mLevelObjects = new Object();
			
			mObjectGroups = new Array();
		}
		
		public function Init():void
		{			
			if (FlxG.state is PlayState)
			{
				//add all the objects to level
				for each (var key:String in mObjectGroups) 
				{
					FlxG.state.add(mLevelObjects[key]);
				}
			
				(FlxG.state as PlayState).player.ResetPlayer(mPlayerSpawnPoint.x, mPlayerSpawnPoint.y);
			}
			else
			{
				throw new Error("Tried to init a level outside of the playstate");
			}
		}
		
		/**
		 * Completely kills the level. Need a cleaner "restart"
		 */
		public function Shutdown():void
		{
			//kill all the objects
			for each (var key:String in mObjectGroups) 
			{
				(mLevelObjects[key] as FlxGroup).kill();
			}
		}
		
		public function SetPlayerSpawn(X:Number, Y:Number):void
		{
			mPlayerSpawnPoint.x = X;
			mPlayerSpawnPoint.y = Y;
		}
		
		public function SetGoal(goal:GoalObject):void
		{
			mLevelGoal = goal;
		}
		public function GetGoal():GoalObject { return mLevelGoal; }
		//========================================================
		/// Private functions
		//========================================================
		private function AddNewObjectGroup(key:String):void
		{
			//unique groups
			for (var i:int = 0; i < mObjectGroups.length; i++) 
			{
				if (mObjectGroups[i] == key)
				{
					return;
				}
			}
			
			mObjectGroups.push(key);
			mLevelObjects[key] = new FlxGroup();
			
		}
		
		
		public var xmlFileName:String;
		
		private var mPolarityBlocks:Array;
		//hash
		private var mLevelObjects:Object;
		
		private var mObjectGroups:Array;
		
		private var mPlayerSpawnPoint:Point
		
		private var mLevelGoal:GoalObject;
		
	}

}