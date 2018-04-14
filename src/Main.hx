import com.haxepunk.Engine;
import com.haxepunk.HXP;
import haxepunk.debug.Console;
import openfl.Lib;
import openfl.display.StageQuality;

class Main extends Engine
{
	public function new() {
		super(240, 160);
		
	}
	override public function init()
	{
		
#if debug
		Console.enable();
#end
		HXP.scene = new GameScene();
		
		//HXP.screen.smoothing = false;
		//HXP.resize(960, 640);
		
	}

	public static function main() { new Main(); }

}