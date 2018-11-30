package;

import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.Scene;
import haxepunk.graphics.text.BitmapText;
import haxepunk.graphics.text.Text;
import haxepunk.input.Input;
import haxepunk.input.Key;

/**
 * ...
 * @author ...
 */
class EndScene extends Scene 
{

	public function new(timer:Timer) 
	{
		super();
		
		createText("you collected the dogs!", 20, 24, "font/magicbook/magicbook0.fnt");
		createText("time: " + timer.txt.text,  100, 12, "font/magicbook/magicbook0.fnt"); 
		createText("(press t while playing to toggle the timer)", 124, 12, "font/magicbook/magicbook0.fnt");
	
		Input.define("any", [Key.ANY]);
	}
	override public function update() {
		if (Input.pressed("any")) {
			HXP.scene = new GameScene();
		}
	}
	public function createText(str:String, y:Float, size:Int=16, font:String) {
		var txt = new BitmapText(str, 0, 0, 0, 0, {size: size, font: font});
		var txtEntity = new Entity(Math.round(HXP.halfWidth-txt.textWidth/2), y, txt);
		this.add(txtEntity);
	}
	
}