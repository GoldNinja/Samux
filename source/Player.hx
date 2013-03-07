package ;
/** @author Gold_Ninja */

import org.flixel.FlxBasic;
import org.flixel.FlxGroup;
import org.flixel.FlxObject;
import org.flixel.FlxSprite;
import org.flixel.system.FlxAnim;
import org.flixel.FlxG;

class Player extends FlxSprite
{	private var _jump:Float = 0;
	private var _jumpTimer:Float = 0;
	private var _jumpReset:Int = 1;
	private var _aim:String = "R";
	
	private var charge:Float = 0;
	
	private var _bullets:FlxGroup;
	private var _bullets_charge:FlxGroup;
	
	
	
	public function new(px:Int,py:Int,Bullets:FlxGroup,Chargeshot:FlxGroup):Void
	{	super(px, py);
		acceleration.y = 200;
		maxVelocity.y = 300;
		
		_bullets = Bullets;
		_bullets_charge = Chargeshot;
		
		loadGraphic("assets/sprites/Samux.png", true, false, 32, 32);
		
		width = 16;
		offset.x = 8;
		
		addAnimation("walkR", [5, 6, 7, 0, 1, 2, 3, 4], 12, true);
		addAnimation("walkL", [10, 9, 8, 15, 14, 13, 12, 11], 12, true);
		
		addAnimation("idleR", [0], 8, true);
		addAnimation("idleL", [15], 8, true);
		
		play("idleR");
	}
	
	override public function destroy():Void
	{	super.destroy();
		_bullets = null;
	}
	
	
	
	override public function update():Void
	{	if (x > FlxG.width - 43)
		{	x = FlxG.width - 42;
			play("idleR");	}
		if (x < 9)
		{	x = 10;
			play("idleL");	}
		
		velocity.x = 0;
		
		//SHOOTING
		if(FlxG.keys.justPressed("C"))
		{	getMidpoint(_point);
			cast(_bullets.recycle(S_Bullet), S_Bullet).shoot(_point, _aim);
		}
		
		if (FlxG.keys.C)
		{	charge += FlxG.elapsed;
			//play Charging animation & sound (after a few frames)
		}
		
		if (FlxG.keys.justReleased("C"))
		{	
			if (charge > 1.5)
			{	getMidpoint(_point);
				cast(_bullets_charge.recycle(S_Bullet_Charge), S_Bullet_Charge).shoot(_point, _aim);
			}
			
			charge = 0;
			
		}
		
		
		
		if((_jump >= 0) && (FlxG.keys.X) && (_jumpReset == 1))				//Horrible jumping
		{	_jump += FlxG.elapsed;
			if (_jump > 0.2) 
			{	_jump = -1;
				_jumpTimer = 0;
				_jumpReset = 0;	}
		}
		else
		{	_jump = -1;	}
		if (FlxG.keys.justReleased("X"))
		{	_jumpReset = 1;	}
		
		
		if (_jumpTimer > 0.2)
		{	_jump = -1;	}
		
		if (_jump > 0)
		{	_jumpTimer += FlxG.elapsed;
		
			if(_jump < 0.04)
			{	velocity.y = -180;	}			//This is the minimum speed of the jump
			else
			{	acceleration.y = 50;	}		//The general acceleration of the jump
        }
		else
		{	velocity.y = 200;	}				//Make the character fall after the jump button is released
		
		if (this.isTouching(FlxObject.FLOOR))
		{	_jumpTimer = 0;
			_jump = 0;
			
		}
		
		
		
		
		if (FlxG.keys.RIGHT)				//Walking
		{	velocity.x = 80;
			play("walkR");
			_aim = "R";	}
		if (FlxG.keys.LEFT)
		{	velocity.x = -80;
			play("walkL");
			_aim = "L";	}
		
		if (FlxG.keys.justReleased("RIGHT"))
		{	play("idleR");	}
		if (FlxG.keys.justReleased("LEFT"))
		{	play("idleL");	}
		
		super.update();
		
		
		
		if (y > 500)							//Temp reset for falling off
		{
			y = 100;
		}
		
		
	}
	
}
















