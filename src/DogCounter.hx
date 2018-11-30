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

	var header:BitmapText = new BitmapText("DOGS", 0, 0, 0, 0, {size: 16, font: "font/skullboy/skullboy.fnt"}); 
	var num:BitmapText = new BitmapText("0/0", 0, 0, 0, 0, {size: 16, font: "font/skullboy/skullboy.fnt"}); 
	public function new(x:Float=0, y:Float=0) {
		super(x, y, new Graphiclist([header, num]));
		num.x = Math.round(header.textWidth/2 - num.textWidth/2);
		num.y = Math.round(header.textHeight);
		this.header.scrollX = this.num.scrollX = this.header.scrollY = this.num.scrollY = 0;
	}
	override public function update() {
		num.text = Global.PLAYER.dogs.length + "/" + Global.DOGS.length;
	}
}