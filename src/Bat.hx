package;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.Mask;
import haxepunk.graphics.Spritemap;

/**
 * ...
 * @author Taylor
 */
class Bat extends Entity {

	var img:Spritemap = new Spritemap("graphics/bat-sheet.png", 18, 15);
	public function new(x:Float=0, y:Float=0) {
		super(x, y);
		graphic = img;
		img.smooth = false;
		img.add("flap", [0, 1, 2],10);
		img.play("flap");
	}
	
}