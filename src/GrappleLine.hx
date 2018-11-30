package;

import com.haxepunk.Entity;
import haxepunk.Camera;
import haxepunk.math.MathUtil;
import haxepunk.utils.DrawContext;
import openfl.geom.Point;

/**
 * ...
 * @author Taylor Anderson
 */
class GrappleLine extends Entity
{
	private var hook:Grapple;
	private var player:Player;
	private var xPos:Float = 0;
	private var yPos:Float = 0;
	private var pScreenX:Float;
	private var pScreenY:Float;
	private var hScreenX:Float;
	private var hScreenY:Float;
	private var wavyTimer:Float = 0;
	private var slowTimer:Float = 0;
	private var context:DrawContext = new DrawContext();
	public function new(hook:Grapple, player:Player) 
	{
		super(0, 0);
		this.player = player;
		this.hook = hook;
	}
	override public function added() {
		this.context.scene = this.scene;
		this.context.smooth = false;
		
		this.context.scale = true;
		
	}
	
	
	override public function render(camera:Camera):Void
	{
		super.render(camera);
		xPos = hook.x - camera.x;
		yPos = hook.y - camera.y;
		pScreenX = player.x - camera.x + player.halfWidth;
		pScreenY = player.y - camera.y + player.halfHeight;
		context.setColor();
		context.lineThickness = 0;
		
		var scale = 2;
		
		var d:Point = Helper.findVector(new Point(xPos, yPos), new Point(pScreenX, pScreenY), scale);
		while (MathUtil.distance(xPos, yPos, pScreenX, pScreenY) > scale) {
			if (!hook.stuck && !hook.deactivated) {
				if (Math.abs(hook.v.x) > Math.abs(hook.v.y))
					wavyTimer += d.x/5;
				else 
					wavyTimer += d.y/5;
			}
			else wavyTimer = 0;
			
			var revX:Float = xPos;
			var revY:Float = yPos;
			if (Math.abs(hook.v.x) > Math.abs(hook.v.y)) {
				revY = yPos + (MathUtil.sin(wavyTimer % 360) * 5); 
			}
			else {
				revX = xPos + (MathUtil.sin(wavyTimer % 360) * 5);
			}
			xPos += d.x;
			yPos += d.y;
			context.setColor(0xFFFFFF);
			context.rectFilled(revX, revY, scale, scale);
		}
	}
	
}