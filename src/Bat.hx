package;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.Mask;
import haxepunk.graphics.Spritemap;

/**
 * ...
 * @author Taylor
 */
class Bat extends Grappleable {

	var img:Spritemap = new Spritemap("graphics/bat-sheet.png", 18, 15);
	public function new(x:Float=0, y:Float=0) {
		super(x, y);
		graphic = img;
		img.add("flap", [0, 1, 2],10);
		img.play("flap");
		setHitbox(18, 15);
		this.type = CollisionTypes.BAT;
	}
	
}