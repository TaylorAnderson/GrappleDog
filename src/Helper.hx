package ;
import openfl.geom.Point;

/**
 * ...
 * @author ...
 */
class Helper
{

	/**
	 * Find vector from arg1 to arg2.  if revrse is true, it finds the vector pointing away from arg1.
	*/
	public static function findVector(from:Point, to:Point, power:Float, reverse:Bool = false):Point {
		var v:Point = new Point();
		v = new Point(to.x - from.x, to.y - from.y);
		v.normalize(power);
		if (reverse)
		{
			v.x *= -1;
			v.y *= -1;
		}
		return v;
	}
	public static function snapToGrid(num:Float, gridsize:Int, useFloor:Bool = true):Int {
		if (!useFloor)
			return Math.round(num / gridsize) * gridsize;
		else return Math.floor(num / gridsize) * gridsize;
	}
	
}