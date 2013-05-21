package ;
/* @author Gold_Ninja */

import org.flixel.FlxSprite;
import org.flixel.FlxPoint;
import org.flixel.FlxG;

class Explode_Grenade extends FlxSprite
{	private var _timer:Float = 0;

	public function new(x:Float,y:Float):Void
	{	super(x,y);
		
		loadGraphic("assets/sprites/Explode.png", true, false, 32, 32);
		
		addAnimation("idle", [0, 1, 2, 3, 4, 5], 12, false);
		play("idle");
		
	}

	override public function kill():Void
	{	if(!alive)
		{	return;	}
		velocity.x = 0;
		velocity.y = 0;
		alive = false;
		solid = false;
	}
	
	
	public function shoot(Location:FlxPoint):Void
	{	super.reset(Location.x - width / 2, Location.y - height / 2);
		solid = true;
		play("idle", true);
		_timer = 0;
		
	}
	
	override public function update():Void
	{	_timer += FlxG.elapsed;
		
		if (_timer > 0.5)
		{	exists = false;	}
		
		super.update();
	}
	
	
	
}