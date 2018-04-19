package;

import haxepunk.Entity;
import haxepunk.graphics.Spritemap;

/**
 * ...
 * @author Taylor
 */
class LogoAnim extends Entity {

	var img:Spritemap = new Spritemap("graphics/logoanim.png", 45, 50);
	public function new(x:Float=0, y:Float=0) {
		super(x, y, img);
		setHitbox(45, 50);
		img.add("play", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 14, 14, 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14], 12);
		img.play("play");
		
	}
	override public function update() {
		
		if (collide("player", x, y) != null) {
			this.scene.remove(this);
		}
	}
	
}