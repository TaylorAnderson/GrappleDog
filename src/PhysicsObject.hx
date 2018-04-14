package;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.Mask;
import haxepunk.math.Vector2;

/**
 * ...
 * @author Taylor
 */
class PhysicsObject extends Entity {

	private var gravity:Float = 1;
	private var friction:Float = 0.8;
	public var v:Vector2 = new Vector2();
	public function new(x:Float=0, y:Float=0, ?graphic:Graphic, ?mask:Mask) {
		super(x, y, graphic, mask);
		
	}
	override public function update() {
		v.y += gravity;
		v.x *= friction;
		this.x += v.x;
		resolveCollisions("level", true, false);
		this.y += v.y;
		resolveCollisions("level", false, true);
	}
	public function resolveCollisions(type:String, useX:Bool, useY:Bool, bounce:Bool = false, xOffset:Int = 0, yOffset:Int = 0):Void {
		if (collide(type, x + xOffset, y + yOffset) != null)
		{
			if (useX)
			{
				if (Math.abs(v.x) > 0)
				{
					x -= v.x;
					v.x = 0;
					
				}
			}
			if (useY)
			{
				if (Math.abs(v.y) > 0)
				{
					y -= v.y;
					v.y = 0;
				}
			}
		}
	}
	
}