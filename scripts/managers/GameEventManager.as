package managers 
{
	import customEvents.LevelEvent;
	import flash.events.Event;
	/**
	 * ...
	 * @author Scano
	 */
	public class GameEventManager extends GameManager
	{
		
		public function GameEventManager() 
		{
			super();
			
			mSubscriberDict = new Object();
			mRegisteredEvents = new Array();
		}
		
		
		public static function GetInstance():GameEventManager
		{
			if (mInstance == null)
			{
				Create();
			}
			
			return mInstance;
		}
		
		public static function Create():void
		{
			if (mInstance != null)
			{
				throw new Error("Trying to create GameEventManager when it already exists!");
				return;
			}
			
			mInstance = new GameEventManager();
			mInstance.Init();
		}
		
		public static function Shutdown():void
		{
			if (mInstance == null)
			{
				throw new Error("Trying to shutdown GameEventManager when it doesn't exist");
				return;
			}
			
			
			mInstance.Destroy();
		}
		
		/**
		 * Add an event type that can be subscribed to
		 * @param	eventType
		 */
		public function RegisterEvent( eventType:String ):void
		{
			for (var i:int = 0; i < mRegisteredEvents.length; i++) 
			{
				if (mRegisteredEvents[i] == eventType)
				{
					trace("Already registered this event");
					return;
				}
			}
			
			mRegisteredEvents.push(eventType);
			this.addEventListener( eventType, BubbleEvent);
			mSubscriberDict[eventType] = new Array();
		}
		
		/**
		 * Removes an all events, clearing out possible subscriptions
		 */
		public function UnregisterAllEvents():void
		{
			for (var i:int = 0; i < mRegisteredEvents.length; i++) 
			{
				this.removeEventListener( mRegisteredEvents[i], BubbleEvent);
			}
			mRegisteredEvents = new Array();
			mSubscriberDict = new Object();
		}
		
		/**
		 * Adds the object to a list to get sent events that this service gets
		 * @param	subscriber
		 * @param	event
		 */
		public function SubscribeToEvent(subscriber:*, event:String):void
		{
			mSubscriberDict[event].push(subscriber);
		}
		
		/**
		 * Checks if the subscriber is already listening for an event
		 * @param	subscriber
		 * @param	event
		 * @return
		 */
		public function IsSubscribed(subscriber:*, event:String):Boolean
		{
			var array:Array = mSubscriberDict[event] as Array;
			for (var i:int = 0; i < array.length; i++) 
			{
				if (array[i] == subscriber)
				{
					return true;
				}
			}
			return false;
		}
		/**
		 * Removes a subscriber from an event type. the subscriber will no longer receive events
		 * @param	subscriber
		 * @param	event
		 */
		public function UnsubscribeFromEvent(subscriber:*, event:String):void
		{
			var array:Array = mSubscriberDict[event] as Array;
			if (array != null)
			{
				for (var i:int = 0; i < array.length; i++) 
				{
					if (array[i] == subscriber)
					{
						array.splice(i, 1);
						break;
					}
				}
			}
		}
		
		
		//==========================================================================
		// Private
		private function Destroy():void
		{
			mInstance = null;
		}
		
		override protected function Init():void 
		{
			super.Init();
			
			//register events here
			LevelEvent.RegisterEvents(this);
		}
		
		/**
		 * Simply passes the event to all subscribers of it
		 * @param	event
		 */
		private function BubbleEvent(event:Event):void
		{
			var array:Array = mSubscriberDict[event.type] as Array;
			if (array != null)
			{
				for (var i:int = 0; i < array.length; i++) 
				{
					array[i].dispatchEvent(event);
				}
			}
		}

		//===================================================================
		/// Member Variables
		//===================================================================
		//a dictionary object of events to subscribers
		private var mSubscriberDict:Object;
		//all events that have been registered with this service and can be subscribed to
		private var mRegisteredEvents:Array;
		
		
		

		private static var mInstance:GameEventManager = null;
		
	}

}