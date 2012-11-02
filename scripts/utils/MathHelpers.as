package utils
{
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import org.flixel.FlxObject;
	/**
	 * ...
	 * @author Scano
	 */
	public class MathHelpers
	{
		public static function PointMultiply(point:Point, factor:Number):Point
		{
			return new Point(point.x * factor, point.y * factor);
		}
		
		public static function PointDivide(point:Point, factor:Number):Point
		{
			return new Point(point.x / factor, point.y / factor);
		}
		
		public static function Truncate(point:Point, max:Number):void
		{
			if (point.length > max)
			{
				point.normalize(max);
			}
		}
		
		public static function RandomBetween(min:Number, max:Number):Number
		{
			return  Math.floor(Math.random() * (1 + max - min) + min);
		}
		
		public static function RandomBetweenNoRound(min:Number, max:Number):Number
		{
			return  (Math.random() * (max - min) + min);
		}
		
		public static function RandomPoint(radius:int):Point
		{
			var randomPoint:Point = new Point( RandomBetween( -1, 1), RandomBetween( -1, 1) );
			randomPoint.normalize(radius);
			return randomPoint;
		}
		
		public static function RandomPointBetween(point1:Point, point2:Point):Point
		{
			//y = mx + b
			//find the slope
			var m:Number = (point1.y - point2.y) / (point1.x - point2.x);
			//solve for b
			var b:Number = point1.y - (m * point1.x);
			//find a random x
			var x:Number = RandomBetween( Math.min(point1.x, point2.x), Math.max(point1.x, point2.x));
			var y:Number = m * x + b;
			
			return new Point(x, y);
		}
				
		public static function VectorPointToHeading(vector:Point):int
		{
			var vector3d:Vector3D = new Vector3D(vector.x, vector.y, 0);
			vector3d.normalize();
			if (vector3d.length == 0) { return 0; }
			var axis:Vector3D = new Vector3D( 1, 0 , 0);
			
			var angle:int = int(Math.acos( vector3d.dotProduct(axis) ) * (180 / Math.PI));
			if (vector.y < 0)
			{
				//sign flip
				angle = ~angle + 1;
			}
			angle = MathHelpers.HeadingTo360(angle);
			return angle;
		}
		
		/**
		 * Picks a point on a circle with center and radius at angle heading (360degrees)
		 * @param	center
		 * @param	radius
		 * @param	heading
		 * @return
		 */
		
		//changes a heading to its 360 degree equivalent, this function was made purely to avoid using modulo...
		//note: short cut here, assuming this will never get outside -720 and 720
		public static function HeadingTo360(x:int):int
		{
			//bitwise absolute value
			var absolute:int = (x ^ (x >> 31)) - (x >> 31);
			if (absolute > 359)
			{
				absolute -= 360;
			}
			
			//if the original value was less than 0, subtract its absolute value from 360
			absolute = x < 0 ? 360 - absolute : absolute;
			
			return absolute;
			
		}
		
		/**
		 * Utility function to strip the whitespace from a string.
		 * so it's not a math function. sue me.
		 * @param	value
		 * @return
		 */
		public static function WhitespaceStrip(value:String):String
		{
			//yay regexes
			return value.replace(/\s+/g, '');
		}
		
		/**
		 * Gets the distance between two FlxObjects
		 */
		public static function DistanceBetween(obj1:FlxObject, obj2:FlxObject):Number
		{
			var dx:Number = obj1.x - obj2.x;
			var dy:Number = obj1.y - obj2.y;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		/**
		 * Does distance without using "new" points, which is a bit expensive
		 * @param	x1
		 * @param	x2
		 * @param	y1
		 * @param	y2
		 * @return
		 */
		public static function DistanceBetweenCoords(x1:Number, x2:Number, y1:Number, y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public static function DegreesToRadians(deg:Number):Number
		{
			return (deg * Math.PI) / 180;
		}
		public static function RadiansToDegrees(radians:Number):Number
		{
			return (radians * 180) / Math.PI;
		}
		
	}

}