package;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.Mask;
import haxepunk.graphics.Graphiclist;
import haxepunk.graphics.text.BitmapText;

/**
 * ...
 * @author Taylor
 */
class DogCounter extends Entity {

	var header:BitmapText = new BitmapText("DOGS"); 
	var num:BitmapText = new BitmapText("0/0"); 
	public function new(x:Float=0, y:Float=0) {
		super(x, y, new Graphiclist([header, num]));
		num.x = header.x + header.width / 2 - num.width / 2;
		num.y = header.height;
		this.header.scrollX = this.num.scrollX = this.header.scrollY = this.num.scrollY = 0;
	}
	
}