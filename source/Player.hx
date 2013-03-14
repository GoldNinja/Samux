package ;
/** @author Gold_Ninja */

import org.flixel.FlxBasic;
import org.flixel.FlxGroup;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.system.FlxAnim;
import org.flixel.FlxG;

class Player extends FlxSprite
{	private var jump:Float;
	private var jumpLimit:Float = 0.10;
	private var jumpOK:Bool = true;
	
	private var _aim:String = "R";
	private var _shotType:Int = 1;

	private var charge:Float = 0;
	
	private var _bullets:FlxGroup;
	private var _bullets_charge:FlxGroup;
	
	
	
	public function new(px:Int,py:Int,Bullets:FlxGroup,Chargeshot:FlxGroup):Void
	{	super(px, py);
		acceleration.y = 1200;
		maxVelocity.y = 250;
		
		_bullets = Bullets;
		_bullets_charge = Chargeshot;
		
		loadGraphic("assets/sprites/Samux.png", true, false, 32, 32);
		
		width = 16;
		offset.x = 8;
		
		addAnimation("walkR", [5, 6, 7, 0, 1, 2, 3, 4], 16, true);
		addAnimation("walkL", [10, 9, 8, 15, 14, 13, 12, 11], 16, true);
		
		addAnimation("idleR", [0], 8, true);
		addAnimation("idleL", [15], 8, true);
		
		play("idleR");
	}
	
	override public function destroy():Void
	{	super.destroy();
		_bullets = null;
	}
	
	
	
	override public function update():Void
	{	velocity.x = 0;										//Want a nice roll-off to stop and start really.
		
		
		//*******************************************
		//*											*
		//*		WALKING								*
		//*											*
		//*******************************************
		
		if (FlxG.keys.RIGHT)
		{	velocity.x = 100;
			play("walkR");
			_aim = "R";	}
		if (FlxG.keys.LEFT)
		{	velocity.x = -100;
			play("walkL");
			_aim = "L";	}
		if (FlxG.keys.LEFT && FlxG.keys.RIGHT)
		{	velocity.x = 0;
			play("idleL");
		}
		
		if (FlxG.keys.justReleased("RIGHT"))
		{	play("idleR");	}
		if (FlxG.keys.justReleased("LEFT"))
		{	play("idleL");	}		
		
		
		//*******************************************
		//*											*
		//*		SHOOTING							*
		//*											*
		//*******************************************
		
		if (FlxG.keys.justReleased("ONE"))
		{	_shotType = 1;	}
		if (FlxG.keys.justReleased("TWO"))
		{	_shotType = 2;	}
		
		if(FlxG.keys.justPressed("C"))
		{	getMidpoint(_point);
			_point.x = _point.x + 9;
			_point.y = _point.y - 3;
			cast(_bullets.recycle(S_Bullet), S_Bullet).shoot(_point, _aim);
		}
		
		if (FlxG.keys.C)
		{	charge += FlxG.elapsed;
			//play Charging animation & sound (after a few frames)
		}
		
		if (FlxG.keys.justReleased("C"))
		{	if (charge > 0.9)
			{	getMidpoint(_point);
				_point.x = _point.x + 9;
				_point.y = _point.y - 3;
				cast(_bullets_charge.recycle(S_Bullet_Charge), S_Bullet_Charge).shoot(_point, _aim, _shotType);
			}
			charge = 0;
		}
		
		//*******************************************
		//*											*
		//*		JUMPING								*
		//*											*
		//*******************************************
		
		if (jump >= 0 && FlxG.keys.X && jumpOK)
		{	jump += FlxG.elapsed;
			if (jump > jumpLimit)
			{	jump = -1;
				jumpOK = false; }
		}
		else
		{	jump = -1;	}
		
		if (jump > 0)
		{	if (jump < 0.05)
			{	velocity.y = -maxVelocity.y*0.65;	}
			else
			{	velocity.y = -maxVelocity.y;	}
		}
		
		if (this.isTouching(FlxObject.FLOOR))
		{	jump = 0;	}
		
		if (FlxG.keys.justReleased("X"))
		{	jumpOK = true;	}
		
		
		
		
		super.update();
		
		
		
		
		if (y > 500)							//Temp reset for falling off
		{
			y = 100;
		}
		
		
	}
	
}
















