package managers 
{
	import constants.GameAssets;
	import constants.GameplayConstants;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import symbols.levelmanagement.Level;
	import symbols.levelmanagement.OgmoTilemap;
	import symbols.objects.BlackPolarityBlock;
	import symbols.objects.BlackPolaritySling;
	import symbols.objects.GoalObject;
	import symbols.objects.NeutralBlock;
	import symbols.objects.Neutralizer;
	import symbols.objects.RedPolarityBlock;
	import symbols.objects.RedPolaritySling;
	import utils.ConfigFile;
	/**
	 * ...
	 * @author Scano
	 */
	public class OgmoXMLParser extends EventDispatcher
	{
		
		public function OgmoXMLParser() 
		{
			super();
		}
		
		/**
		 * Reads a level xml and parses it out
		 * @param	level
		 */
		public function LoadLevel(level:Level, xmlName:String):void
		{
			mCurrentLevel = level;
			var levelConfig:ConfigFile = new ConfigFile();
			levelConfig.Load(xmlName, ParseLevelXML);
		}
		
		public function ParseLevelXML(data:XML):void
		{
			//parse the main level
			//var ogmoTile:OgmoTilemap = new OgmoTilemap();
			//ogmoTile.LoadTilemap(data, "stage", GameAssets.GameTiles);

			for each (var obj:XML in data.objects) 
			{
				FactoryObjects(obj, mCurrentLevel);
			}
			
			dispatchEvent(new Event("LEVEL LOADED") );
		}
		
		/**
		 * Factories out the objects and adds them to the provided level
		 * @param	obj - the XML that contains all of the objects in a level
		 * @param	level - the level to add the objects to
		 */
		private function FactoryObjects(obj:XML, level:Level):void
		{
			for each (var playerSpawn:XML in obj.playerSpawn) 
			{
				level.SetPlayerSpawn( Number(playerSpawn.@x), Number(playerSpawn.@y) );
			}
			for each (var blackSling:XML in obj.blackSling) 
			{
				var blackSlingObj:BlackPolaritySling = new BlackPolaritySling(Number(blackSling.@x), Number(blackSling.@y));
				level.AddObject(blackSlingObj, "Slings", GameplayConstants.POLARITY_BLACK);
			}
			for each (var redSling:XML in obj.redSling) 
			{
				var redSlingObj:RedPolaritySling = new RedPolaritySling(Number(redSling.@x), Number(redSling.@y));
				level.AddObject(redSlingObj, "Slings", GameplayConstants.POLARITY_RED);
			}
			for each (var blackBlock:XML in obj.blackBlock) 
			{
				var blackBlockObj:BlackPolarityBlock = new BlackPolarityBlock(Number(blackBlock.@x), Number(blackBlock.@y));
				level.AddObject(blackBlockObj, "Blocks", GameplayConstants.POLARITY_BLACK);
			}
			for each (var redBlock:XML in obj.redBlock) 
			{
				var redBlockObj:RedPolarityBlock = new RedPolarityBlock(Number(redBlock.@x), Number(redBlock.@y));
				level.AddObject(redBlockObj, "Blocks", GameplayConstants.POLARITY_RED);
			}
			for each (var neutralBlock:XML in obj.neutralBlock)
			{
				var neutralBlockObj:NeutralBlock = new NeutralBlock(Number(neutralBlock.@x), Number(neutralBlock.@y));
				level.AddObject(neutralBlockObj, "Neutrals", GameplayConstants.POLARITY_NEUTRAL);
			}
			for each (var goal:XML in obj.goalObject)
			{
				if (level.GetGoal() != null)
				{
					throw new Error("XML contains more than one goal for this level");
				}
				var goalObj:GoalObject = new GoalObject(Number(goal.@x), Number(goal.@y));
				level.AddObject(goalObj, "Goal", GameplayConstants.POLARITY_NEUTRAL);
				level.SetGoal(goalObj);
			}
			for each( var neutralizer:XML in obj.neutralizer)
			{
				var neutralizerObj:Neutralizer = new Neutralizer( Number(neutralizer.@x), Number(neutralizer.@y) );
				level.AddObject(neutralizerObj, "Neutrals", GameplayConstants.POLARITY_NEUTRAL );
			}
		}
		
		public function get level():Level { return mCurrentLevel; }
		
	
		private var mCurrentLevel:Level;
	}

}