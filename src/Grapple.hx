package;

import flash.geom.Point;
import haxepunk.Camera;
import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.Mask;
import haxepunk.graphics.Image;
import haxepunk.math.MathUtil;
import haxepunk.math.Vector2;
import haxepunk.utils.Draw;

/**
 * ...
 * @author Taylor
 */
class Grapple extends Entity {
	
	public var v:Vector2 = new Vector2();
	public var stuck:Bool = false;
	public var deactivated:Bool = false;
	private var speed:Float = 6;
	public var length:Float = 70;
	public var maxLength:Float = 125;
	private var img:Image = new Image("graphics/grapple.png");
	private var player:Player;
	private var line:GrappleLine;
	public function new(x:Float=0, y:Float=0, dir:Vector2, player:Player) {
		super(x, y, img);
		img.smooth = false;
		this.centerOrigin();
		this.v = dir.normalize().mult(speed);
		
		this.player = player;
		this.img.centerOrigin();
		this.img.angle = MathUtil.angle(0, 0, dir.x, dir.y) - 90;
	}
	override public function added() {
		scene.add(line = new GrappleLine(this, this.player));
	}
	override public function removed() {
		scene.remove(line);
	}
	override public function update() {
		
		if (!this.stuck) {
			this.x += this.v.x;
			this.y += this.v.y;
			if (distanceFrom(player) > maxLength) {
				scene.remove(this);
			}
			if (this.collide("level", x, y) != null) {
				stuck = true;
				this.length = distanceFrom(player);
			}
		}
		else {

		}
	}
	
}