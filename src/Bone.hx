package;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.Mask;
import haxepunk.graphics.Image;
import haxepunk.math.MathUtil;
import haxepunk.math.Vector2;

/**
 * ...
 * @author Taylor
 */
class Bone extends Entity {

	var img:Image = new Image("graphics/bone.png");
	var collected:Bool = false;
	var dog:Dog;
	public function new(x:Float=0, y:Float=0) {
		super(x, y, img);
		setHitbox(10, 10);
		
	}
	override public function update() {
		if (collide("player", x, y) != null && !collected) {
			collected = true;
			this.x = C.PLAYER.x - 20; //setting up for rotation
			for (dog in C.DOGS) {
				if (!dog.collected) {
					this.dog = dog;
				}
			}
		}
		if (collected) {
			var pos = new Vector2();
			var px = C.PLAYER.x + C.PLAYER.halfWidth;
			var py = C.PLAYER.y + C.PLAYER.halfHeight;
			MathUtil.angleXY(pos, MathUtil.angle(px, py, dog.x, dog.y), 20, px, py); 
			this.x = pos.x;
			this.y = pos.y;
		}
		if (collide("dog", x, y) == dog && dog != null) {
			scene.remove(this);
		}
	}
	
}