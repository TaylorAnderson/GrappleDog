package;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.Mask;
import haxepunk.graphics.Graphiclist;
import haxepunk.graphics.text.BitmapText;
import haxepunk.graphics.text.Text;

/**
 * ...
 * @author Taylor
 */
class DogCounter extends Entity {

	var header:Text = new Text("DOGS"); 
	var num:Text = new Text("0/0"); 
	public function new(x:Float=0, y:Float=0) {
		super(x, y, new Graphiclist([header, num]));
		num.font = "font/ChevyRay - Magic Book.ttf";
		header.font = "font/ChevyRay - Magic Book.ttf";
		num.pixelSnapping = true;
		header.pixelSnapping = true;
		num.size = 8;
		header.size = 8;
		header.smooth = false;
		num.smooth = false;
		num.x = Math.round(header.x+2);
		num.y = header.textHeight / 2;
		this.header.scrollX = this.num.scrollX = this.header.scrollY = this.num.scrollY = 0;
	}
	override public function update() {
		num.text = C.PLAYER.dogs.length + "/" + C.DOGS.length;
	}
}