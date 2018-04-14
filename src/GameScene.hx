import com.haxepunk.Scene;
import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.graphics.Image;
import haxepunk.math.MathUtil;
import haxepunk.math.Vector2;

class GameScene extends Scene {

	private var player:Player;
	private var level:LevelChunk;
	public override function begin() {
		
		this.player = new Player();
		C.PLAYER = player;
		this.add(player);
		this.add(level = new LevelChunk(0, 0, "levels/cave.oel", player));
	}
	public override function update() {
		super.update();
		var clampedPos:Vector2 = new Vector2(player.x - HXP.halfWidth + player.halfWidth, player.y - HXP.halfHeight + player.halfHeight);
		MathUtil.clampInRect(clampedPos, 0, 0, this.level.width - HXP.width, this.level.height - HXP.height);
		HXP.camera.x = MathUtil.lerp(HXP.camera.x, clampedPos.x, 0.3);
		HXP.camera.y = MathUtil.lerp(HXP.camera.y, clampedPos.y, 0.3);
	}

}