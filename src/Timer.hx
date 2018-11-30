package;

import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.HXP;
import haxepunk.Mask;
import haxepunk.graphics.text.BitmapText;

/**
 * ...
 * @author Taylor
 */
class Timer extends Entity {

	public var txt:BitmapText = new BitmapText("0",0,0,0,0,{size: 16, font: "font/skullboy/skullboy.fnt"});
	var time:Float = 0;
	public function new() {
		super(20, 10, txt);
		txt.scrollX = txt.scrollY = 0;
		
	}
	override public function update() {
		time += HXP.elapsed*1000;
		var date = Date.fromTime(time);
		
		var minutes = Std.string(date.getMinutes());
		if (minutes.length == 1) minutes = "0" + minutes;
		
		var seconds = Std.string(date.getSeconds());
		if (seconds.length == 1) seconds = "0" + seconds;
		
		var milli = Std.string(date.getTime() - (date.getSeconds()+date.getMinutes()*60) * 1000);
		if (milli.length == 1) milli = "00" + milli;
		if (milli.length == 2) milli = "0" + milli;
		
		txt.text = minutes + ":" + seconds + ":" + milli;
	}
	private function addZeros() {
		
	}
}