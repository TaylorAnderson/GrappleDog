package;

import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.Scene;
import haxepunk.graphics.text.Text;
import haxepunk.input.Input;
import haxepunk.input.Key;

/**
 * ...
 * @author ...
 */
class MenuScene extends Scene 
{

	public function new() 
	{
		super();
		var header =  new Text("wagtail cave");
		header.smooth = false;
		header.font = "font/ChevyRay - Magic Book.ttf";
		header.size = 16;
		var headerEntity = new Entity(HXP.halfWidth-header.textWidth/2, 20, header);
		this.add(headerEntity);
		
		var pressAny = new Text("press any button");
		pressAny.font = "font/ChevyRay - Magic Book.ttf";
		var pressAnyEntity = new Entity(HXP.halfWidth-pressAny.textWidth/2, 100, pressAny);
		this.add(pressAnyEntity);
		pressAny.smooth = false;
		Input.define("any", [Key.ANY]);
	}
	override public function update() {
		if (Input.pressed("any")) {
			HXP.scene = new GameScene();
		}
	}
	
}