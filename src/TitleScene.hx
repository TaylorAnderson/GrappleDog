package;


import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.Scene;
import haxepunk.graphics.Image;
import haxepunk.graphics.text.BitmapText;
import haxepunk.graphics.text.Text;
import haxepunk.input.Input;
import haxepunk.input.Key;
import haxepunk.math.Rectangle;

/**
 * ...
 * @author ...
 */
class TitleScene extends Scene 
{

	public function new() 
	{
		super();
		var header =  new BitmapText("wagtail cave",0,0,0,0,{font: "font/magicbook/magicbook0.fnt", size: 24});
		var headerEntity = new Entity(HXP.halfWidth-header.textWidth/2, 20, header);
		this.add(headerEntity);
		
		var pressAny = new BitmapText("press any button",0,0,0,0,{font: "font/magicbook/magicbook0.fnt", size: 12});
		
		
		var pressAnyEntity = new Entity(HXP.halfWidth-pressAny.textWidth/2, 130, pressAny);
		this.add(pressAnyEntity);
		
		var dog = new Entity(HXP.halfWidth, HXP.halfHeight, new Image("graphics/dog1.png", new Rectangle(0, 0, 10, 10)));
		this.add(dog);
		var img = cast(dog.graphic, Image);
		img.scaleX = 2;
		img.scaleY = 2;
		dog.x -= img.scaledWidth / 2;
		dog.y -= img.scaledHeight/2;
		pressAny.smooth = false;
		Input.define("any", [Key.ANY]);
	}
	override public function update() {
		if (Input.pressed("any")) {
			HXP.scene = new GameScene();
		}
	}
	
}