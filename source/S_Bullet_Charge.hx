package ;
/** @author Gold_Ninja */

import nme.filters.GlowFilter;
import org.flixel.FlxSprite;
import org.flixel.FlxPoint;

class S_Bullet_Charge extends FlxSprite
{
	private var speed:Int;
	
	private var glow:GlowFilter;
	
	
	public function new():Void
	{	super();
		
		loadGraphic("assets/sprites/S_bullet.png", true, false, 4, 2);
		
		glow = new GlowFilter(0xFF0000, 1, 50, 50, 1.5, 1);
		addFilter(glow, new FlxPoint(50, 50));
		
		
		addAnimation("flashing", [0,1,2], 6, true);
		play("flashing");
		
		speed = 100;
		
	}
	
	override public function update():Void
	{	if (x > 1200 || x < -400 || y > 600 || y < -400)
		{	kill;	}
		
		if(touching != 0)
		{
			exists = false;
		}
		
		
		
	}

	override public function kill():Void
	{	if(!alive)
		{	return;	}
		velocity.x = 0;
		velocity.y = 0;
		alive = false;
		solid = false;
	}
	
	public function shoot(Location:FlxPoint, Aim:String):Void
	{	super.reset(Location.x - width / 2, Location.y - height / 2);
		solid = true;
		switch(Aim)
		{	case "L":
				velocity.x = -speed;
			case "R":
				velocity.x = speed;
		}
		
	}
	
	
	
}












