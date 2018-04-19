package;
import openfl.geom.Point;
import haxepunk.Entity;
import haxepunk.graphics.Image;
import haxepunk.math.MathUtil;
import haxepunk.math.Vector2;


/**
 * ...
 * @author Taylor
 */
class Grapple extends Entity {
	
	public var v:Vector2 = new Vector2();
	public var stuck:Bool = false;
	public var deactivated:Bool = false;
	private var speed:Float = 10;
	public var length:Float = 70;
	public var maxLength:Float = 125;
	private var img:Image = new Image("graphics/grapple.png");
	private var player:Player;
	private var line:GrappleLine;
	public var stuckTo:String = null;
	private var collisionTypes = [CollisionTypes.LEVEL, CollisionTypes.BAT];
	private var potentialTargets:Array<Entity> = [];
	public function new(x:Float=0, y:Float=0, dir:Vector2, player:Player) {
		super(x, y, img);
		
		this.v = dir.normalize().mult(speed);
		//this.centerOrigin();
		this.player = player;
		this.img.centerOrigin();
		this.img.angle = MathUtil.angle(0, 0, dir.x, dir.y) - 90;
		
	}
	override public function added() {
		scene.add(line = new GrappleLine(this, this.player));
		scene.getClass(Grappleable, potentialTargets);
	}
	override public function removed() {
		scene.remove(line);
	}
	override public function update() {
		var closestDist = Math.POSITIVE_INFINITY;
		var closestEntity = null;
		for (entity in potentialTargets) {
			if (distanceFrom(entity, true) < closestDist) {
				closestDist = distanceFrom(entity, true);
				closestEntity = entity;
			}
		}
		if (closestDist < 10) {
			this.v = Helper.findVector(new Point(this.x + this.width/2, this.y + this.height/2), new Point(closestEntity.x + closestEntity.halfWidth, closestEntity.y + closestEntity.halfHeight), speed);
		}
		
		if (!this.stuck) {
			this.x += this.v.x;
			this.y += this.v.y;
			if (distanceFrom(player) > maxLength) {
				scene.remove(this);
			}
			for (type in collisionTypes) {
				if (this.collide(type, x, y) != null) {
					stuck = true;
					this.length = distanceFrom(player);
					this.stuckTo = type;
				}
			}

		}
		else {

		}
	}
	
}