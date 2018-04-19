package;


import haxepunk.HXP;
import haxepunk.utils.Color;
import haxepunk.utils.Draw;
import haxepunk.Camera;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.math.Vector2;
import haxepunk.graphics.Graphiclist;
import haxepunk.graphics.Image;
import haxepunk.utils.DrawContext;
import openfl.geom.Point;
//import com.haxepunk.Sfx;
import com.haxepunk.input.Input;
import com.haxepunk.input.Key;
import haxepunk.math.MathUtil;

/**
 * ...
 * @author Taylor Anderson
*/
enum PlayerState {
	GRAPPLING;
	GROUND;
	AIR;
	WALLRUNNING;
}
class Player extends PhysicsObject {
	private var img:Spritemap = new Spritemap("graphics/player.png", 16, 16);
	private var gun:Image = new Image("graphics/gun.png");

	private var groundFriction:Float = 0.8;
	private var grappleFriction:Float = 1;
	private var airFriction:Float = 0.95;
	private var accel:Float = 0.5;
	private var speed:Float = 1.5;
	private var jumpCount:Int = 0;
	private var jumpStrength:Float = 3;
	private var jumpsAllowed:Int = 2;
	private var jumpsDone:Int = 0;
	
	private var risingGravity:Float = 0.1;
	private var fallingGravity:Float = 0.15;
	private var grappleGravity:Float = 0.25;
	
	//private var step:Sfx = new Sfx("audio/step.mp3");
	//private var step1:Sfx = new Sfx("audio/step2.mp3");
	//private var step2:Sfx = new Sfx("audio/step3.mp3");
	//private var playedStep:Bool = false;
	//private var thunder:Sfx = new Sfx("audio/thunder.mp3");
	
	private var fsm:StateMachine<PlayerState>;
	private var grapple :Grapple;
	private var canExitGrapple:Bool = false;
	private var endedGrappleAction:Bool = false;
	private var addedVelocity:Bool = false;
	public var inputVector:Vector2 = new Vector2();
	public var dogs:Array<Dog> = [];
	public var trail:Array<Vector2> = [];
	
	private var trailUpdateInterval = 5;
	private var trailUpdateCounter = 0;
	
	

	private var drawContext:DrawContext = new DrawContext();
	
	public function new() {
		super(0, 0, new Graphiclist([img, gun]));
		
		
		fsm = new StateMachine(PlayerState);
		
		
		fsm.bind(PlayerState.GROUND, this.onGroundEnter, this.onGroundUpdate, this.onGroundExit);
		fsm.bind(PlayerState.AIR, this.onAirEnter, this.onAirUpdate, this.onAirExit);
		fsm.bind(PlayerState.GRAPPLING, this.onGrappleEnter, this.onGrappleUpdate, this.onGrappleExit);
		
		fsm.changeState(PlayerState.AIR);
		
		setHitbox(cast(img.scaledWidth), cast(img.scaledHeight));
		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
		Input.define("jump", [Key.SPACE, Key.Z]);
		Input.define("up", [Key.W, Key.UP]);
		Input.define("action", [Key.X, Key.SHIFT, Key.R]);
		img.add("walk", [0, 1, 2, 3, 4, 5, 6, 7], 15, true);
		img.add("idle", [0]);
		img.add("jump", [2]);
		type = "player";
		name = "player";
		img.frame = 0;
		img.centerOrigin();
		img.x += img.scaledWidth / 2;
		img.y += img.scaledHeight / 2;
		
		this.fsm.onChangeState.bind(function() {
			
		});
	}
	public function onGroundEnter():Void {
		friction = groundFriction;
		jumpsDone = 0;
	}
	private function onGroundUpdate():Void {
		if (collide("level", x, y + 1) == null) {
			fsm.changeState(PlayerState.AIR);
		}	
		
		if (Math.abs(v.x) > 0.5) {
			img.play("walk");
		}
		else img.play("idle");
		

		
		handleMovement();
		handleGrapple();
	}
	private function onGroundExit():Void {
		
	}
	private function onAirEnter():Void {
		this.friction = airFriction;
	}
	private function onAirUpdate():Void {
		gravity = v.y > 0 ? fallingGravity : risingGravity;
		img.play("jump");
		
		if (collide("level", x, y + 1) != null) {
			fsm.changeState(PlayerState.GROUND);
		}	
		handleMovement();
		handleGrapple();
		
	}
	private function onAirExit():Void {
		
	}
	private function onGrappleEnter():Void {
		gravity = grappleGravity;
		var dir = inputVector;
		if (dir.length == 0) dir.x = img.flipX ? -1 : 1;
		this.grapple = new Grapple(this.x + this.halfWidth, this.y + this.halfHeight, dir, this);
		this.scene.add(grapple);
		
		this.friction = this.grappleFriction;
		endedGrappleAction = false;
		addedVelocity = false;
	}
	private function onGrappleUpdate():Void {
		if (this.grapple.stuck) {
			//take the distance from the player to the grapple.
			var dist = MathUtil.distance(this.grapple.x, this.grapple.y, this.x + v.x, y + v.y);
			var dir = Helper.findVector(
				new Point(x + v.x, y + v.y), 
				new Point(grapple.x,  grapple.y), 
				1
			);
			if (grapple.stuckTo == CollisionTypes.LEVEL) {
				dir.normalize(dist - grapple.length);
				//if its less than the grapples length, we gotta do something about that.
				if (dist > grapple.length) {
					//get the vector from the player pointing to the grapple, set its magnitude to the distance - grapple's length.
					this.v.x += dir.x;
					this.v.y += dir.y;
				}
				if (!addedVelocity) {
					addedVelocity = true;
				}
				
				if (endedGrappleAction) {
					if (Input.check("action") && grapple.length > 20) {
						grapple.length -= 1.5; 
					}
					if (Input.released("action")) {
						scene.remove(grapple);
					}
				}
			}
			else if (grapple.stuckTo == CollisionTypes.BAT) {
				dir.normalize(4);
				v = dir.clone();
				if (dist < 30) {
					scene.remove(grapple);
					dir.normalize(2);
					v = v.add(dir);
				}
			}
		}
		else {
			handleMovement();
		}
		
		if (Input.released("action")) endedGrappleAction = true;

		if (grapple.scene == null) {
			fsm.changeState(PlayerState.AIR);
		}
		
	}
	private function onGrappleExit():Void {
		var dir = Helper.findVector(
			new Point(x + v.x, y + v.y), 
			new Point(grapple.x,  grapple.y), 
			1
		);
		if (v.length > 1) {
			if (grapple.stuckTo == CollisionTypes.LEVEL) {
				v = v.mult(1.5);
			}
			else {
				var extraForce = dir;
				extraForce.normalize(2);
				v = v.add(extraForce);
			}

		}

		
	}	
	private function handleMovement() {
		if (Input.pressed("jump") && (jumpsDone < jumpsAllowed)) {
			v.y = -jumpStrength;
			jumpsDone++;
		}
		
		if (Input.released("jump")) {
			v.y *= 0.5;
		}
		
		 //this sorta weird setup  means that the player can still MOVE really fast (if propelled by external forces)
        //its just that he cant go super fast just by player input alone
		var inputForce = accel * inputVector.x;
		
        //force should be clamped so it doesnt let velocity extend past currentSpeed
        inputForce = MathUtil.clamp(inputForce + v.x, -this.speed, this.speed) - v.x;

        //basically making sure the adjusted force of the input doesn't act against the input itself
        if (MathUtil.sign(inputForce) == MathUtil.sign(inputVector.x)) v.x += inputForce;

        if (Math.abs(this.v.x) > this.speed) v.x *= 0.96;

        if (inputVector.x == 0) this.v.x *= friction;
		
	}
	private function handleGrapple () {
		if (Input.pressed("action")) {
			fsm.changeState(PlayerState.GRAPPLING);
		}
	}
	override public function update():Void {
		fsm.update();
		trailUpdateCounter++;
		if (trailUpdateCounter % trailUpdateInterval == 0) {
			this.trail.unshift(new Vector2(x, y));
			if (this.trail.length > 200) this.trail.pop();
		}

		
		this.gravity = v.y > 0 ? fallingGravity : risingGravity;

		super.update();
		
		//gun rotation
		var dir = inputVector.normalize();
		
		img.flipX = dir.length > 0 ? dir.x < 0 : img.flipX;
		
		var angle = MathUtil.angle(0, 0, dir.x, dir.y);
		gun.flipX = img.flipX;
		angle = gun.flipX && dir.length > 0 ? angle - 180 : angle;
		gun.angle = angle;
		
		gun.y = 5;
		gun.x = gun.flipX ? -1 : 7;
		if (dir.y == -1) {
			gun.x = gun.flipX ? 2 : 4;
		}
		
		for (i in 0...dogs.length) {
			var objToFollow:Vector2 = trail[i * 2];
			if (Math.abs(v.x) < 0.1) objToFollow.x = dogs[i].x;
			
			dogs[i].x = MathUtil.lerp(dogs[i].x, objToFollow.x, 0.1);
			dogs[i].y = MathUtil.lerp(dogs[i].y, objToFollow.y + dogs[i].halfHeight, 0.1);
			dogs[i].img.flipX = v.x < 0;
		};
		
		inputVector.x = inputVector.y = 0;
		if (Input.check("left")) inputVector.x = -1;
		if (Input.check("right")) inputVector.x = 1;
		if (Input.check("down")) inputVector.y = 1;
		if (Input.check("up")) inputVector.y = -1;
		
		
	}
	override public function render(camera:Camera):Void {
		var vector = inputVector;
		vector.normalize(200);
		drawContext.setColor(Color.White, 0.1);
		drawContext.smooth = false;
		drawContext.scale = true;
		drawContext.lineThickness = 4;
		var pScreenX = x - camera.x + halfWidth;
		var pScreenY = y - camera.y + halfHeight;
		drawContext.line(pScreenX, pScreenY, pScreenX + vector.x, pScreenY + vector.y);
		super.render(camera);
	}


}