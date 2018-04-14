package;

/**
 * ...
 * @author Taylor
 */
class State {
	public var onEnter:Void->Void;
	public var onUpdate:Void->Void;
	public var onExit:Void->Void;
	public var name:String;
	
	public function new(name:String) {
		this.name = name;
	}
	
}