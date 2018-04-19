package;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.HXP;
import haxepunk.Mask;
import haxepunk.graphics.Image;
import haxepunk.graphics.Spritemap;


/**
 * ...
 * @author Taylor
 */
class Dog extends PhysicsObject {

	public var img:Spritemap;
	public var collected:Bool = false;
	public function new(x:Float=0, y:Float=0) {
		super(x, y);
		var file = HXP.choose("graphics/dog1.png", "graphics/dog2.png", "graphics/dog3.png");
		trace(file);
		img = new Spritemap(TileType.fromString(file), 10, 10);
		img.add("idle", [0]); 
		img.add("walk", [1]);
		type = "dog";
		this.graphic = img;
		setHitbox(10, 10);
	}
	override public function update() {
		if (!collected) super.update();
		if (collide("player", x, y) != null && C.PLAYER.dogs.indexOf(this) == -1) {
			collected = true;
			C.PLAYER.dogs.push(this);
			img.play("walk");
		}
		
	}
	
}