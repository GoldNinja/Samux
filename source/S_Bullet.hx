package ;
/* @author Gold_Ninja */

import org.flixel.FlxSprite;
import org.flixel.FlxPoint;

class S_Bullet extends FlxSprite
{
	private var speed:Int;
	
	public function new():Void
	{	super();
		
		loadGraphic("assets/sprites/S_bullet.png", true, false, 4, 2);
		
		addAnimation("flashing", [0,1,2], 6, true);
		play("flashing");
		
		speed = 600;							//800
		solid = true;
	}
	
	override public function update():Void
	{	if (x > 1200 || x < -400 || y > 600 || y < -400)
		{	exists = false;	}
		
		if(touching != 0)
		{	exists = false;	}
		
		
		
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












