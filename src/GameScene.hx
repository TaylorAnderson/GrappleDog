import com.haxepunk.Scene;
import haxepunk.Entity;
import haxepunk.Graphic;
import haxepunk.HXP;
import haxepunk.graphics.Image;
import haxepunk.math.MathUtil;
import haxepunk.math.Vector2;
import haxepunk.pixel.PixelArtScaler;
import js.html.svg.AnimatedBoolean;

class GameScene extends Scene {

	private var player:Player;
	private var level:LevelChunk;
	private var snappedCamera:Bool = false;
	public function new() {
		
		super();
	}
	public override function begin() {
		
		this.player = new Player();

		C.PLAYER = player;
		this.add(player);
		this.add(level = new LevelChunk(0, 0, "levels/cave-big.oel", player));
		
		var counter = new DogCounter(HXP.halfWidth, 10);
		counter.x -= counter.width;
		this.add(counter);

	}
	public override function update() {
		super.update();
		if (!snappedCamera) {
			var playerPosInfluence = new Vector2(player.x - HXP.halfWidth + player.halfWidth, player.y - HXP.halfHeight + player.halfHeight);
			HXP.camera.x = playerPosInfluence.x+30;
			HXP.camera.y = playerPosInfluence.y;
			
			snappedCamera = true;
		}
		var offset = player.inputVector.normalize(40);
		var playerPosInfluence = new Vector2(player.x - HXP.halfWidth + player.halfWidth, player.y - HXP.halfHeight + player.halfHeight);
		var playerLookInfluence = new Vector2(offset.x, offset.y);
		MathUtil.clampInRect(playerPosInfluence, 0, 0, this.level.width - HXP.width, this.level.height - HXP.height);
		MathUtil.clampInRect(playerLookInfluence, 0, 0, this.level.width - HXP.width, this.level.height - HXP.height);
		
		var playerPosStrength = 0.7;
		HXP.camera.x = MathUtil.lerp(HXP.camera.x, playerPosInfluence.x, 0.2);
		HXP.camera.y = MathUtil.lerp(HXP.camera.y, playerPosInfluence.y, 0.2);
		HXP.camera.x = Math.floor(HXP.camera.x);
		HXP.camera.y = Math.floor(HXP.camera.y);
	
		
	}

}