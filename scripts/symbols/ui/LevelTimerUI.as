package symbols.ui 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Scano
	 */
	public class LevelTimerUI extends FlxText
	{
		
		public function LevelTimerUI(X:Number, Y:Number) 
		{
			super(X, Y, 100);
		
			this.setFormat(null, 10, 0xffffffff, "left");
		}
		
		public function UpdateTime(newTime:Number):void
		{
			this.text = newTime.toString();
		}
		
		//===================================================================
		/// Member Variables
		//===================================================================
	
	}

}