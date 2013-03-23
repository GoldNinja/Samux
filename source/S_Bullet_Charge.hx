package ;
/* @author Gold_Ninja */

import org.flixel.FlxSprite;
import org.flixel.FlxPoint;

class S_Bullet_Charge extends FlxSprite
{
	private var speed:Int;
	private var bulletType:Int;
	
	
	public function new():Void
	{	super();
		
		loadGraphic("assets/sprites/S_bullet_charge.png", true, false, 8, 4);
		
		addAnimation("chargeR", [0, 1, 2], 6, true);
		addAnimation("chargeL", [3,4,5], 6, true);
		addAnimation("grenade", [6,7,8], 6, true);
		
		speed = 300;
		
	}
	
	override public function update():Void
	{	if (x > 1200 || x < -400 || y > 600 || y < -400)
		{	exists = false;	}
		
		if(touching != 0)
		{	exists = false;	}
		
		if (velocity.y != 0)										//Parabola for grenade
		{	acceleration.y = 120;
			if (velocity.x > 0)
			{	acceleration.x = -40;	}
			else
			{	acceleration.x = 40;	}
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
	
	public function shoot(Location:FlxPoint, Aim:String, _type:Int):Void
	{	super.reset(Location.x - width / 2, Location.y - height / 2);
		solid = true;
		acceleration.y = 0;
		
		switch(_type)
		{	case 1:													//Charge Shot
				switch(Aim)
				{	case "L":
						velocity.x = -speed;
						play("chargeL");
					case "R":
						velocity.x = speed;
						play("chargeR");
				}
			case 2:													//Grenade Shot
				velocity.y = -60;
				offset.x = 1;
				width = 4;
				height = 4;
				switch(Aim)
				{	case "L":
						velocity.x = -speed/1.5;
						play("grenade");
					case "R":
						velocity.x = speed/1.5;
						play("grenade");
				}
		}
	}
	
	
	
	
}












