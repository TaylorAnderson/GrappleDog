package;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.HXP;
import haxepunk.Mask;
import haxepunk.graphics.Image;
import haxepunk.input.Mouse;

/**
 * ...
 * @author Taylor
 */
class Button extends Entity {

	public function new() {
		super(20, 20, Image.createRect(40, 10));
		this.graphic.scrollX = 0;
		this.graphic.scrollY = 0;
		setHitbox(40, 10);
	}
	override public function update() {
		if (Mouse.mouseDown && collidePoint(x, y, Mouse.mouseX, Mouse.mouseY)) {
			HXP.scene = new GameScene();
		}
	}
	
}