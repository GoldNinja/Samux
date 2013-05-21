package ;
/* @author Gold_Ninja */

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
	private var drag_floor:Int = 650;
	private var drag_air:Int = 65;
	
	private var _aim:String = "R";
	private var _shotType:Int = 1;

	private var charge:Float = 0;
	
	private var _bullets:FlxGroup;
	private var _bullets_charge:FlxGroup;
	
	
	
	public function new(px:Int,py:Int,Bullets:FlxGroup,Chargeshot:FlxGroup):Void
	{	super(px, py);
		maxVelocity.x = 100;
		maxVelocity.y = 215;
		drag.x = drag_floor;
		
		
		_bullets = Bullets;
		_bullets_charge = Chargeshot;
		
		loadGraphic("assets/sprites/New Samux.png", true, false, 64, 64);
		
		width = 32;
		offset.x = 8;
		
		addAnimation("walkR", [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0], 16, true);
		addAnimation("walkL", [22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 23], 16, true);
		
		addAnimation("idleR", [0], 8, true);
		addAnimation("idleL", [23], 8, true);
		
		addAnimation("idleFR", [24], 8, true);
		addAnimation("idleFL", [25], 8, true);
		
		
		play("idleFR");
	}
	
	override public function destroy():Void
	{	super.destroy();
		_bullets = null;
	}
	
	override public function update():Void
	{	acceleration.x = 0;
		
		
		//*******************************************
		//*											*
		//*		WALKING								*
		//*											*
		//*******************************************
		
		if (this.isTouching(FlxObject.FLOOR))
		{	drag.x = drag_floor;
			if (FlxG.keys.RIGHT && !FlxG.keys.LEFT)
			{	acceleration.x = drag.x;
				if (PlayState.zeroG)
				{	play("idleFR");	}
				else
				{	play("walkR");	}
				
				_aim = "R";	}
				
			if (FlxG.keys.LEFT && !FlxG.keys.RIGHT)
			{	acceleration.x = -drag.x;
				if (PlayState.zeroG)
				{	play("idleFL");	}
				else
				{	play("walkL");	}
				
				_aim = "L";	}
		}
		else
		{	drag.x = drag_air;
			if (FlxG.keys.RIGHT && !FlxG.keys.LEFT)
			{	acceleration.x = drag.x * 6;
				if (PlayState.zeroG)
				{	play("idleFR");	}
				else
				{	play("walkR");	}
				_aim = "R";	}
			if (FlxG.keys.LEFT && !FlxG.keys.RIGHT)
			{	acceleration.x = -drag.x * 6;
				if (PlayState.zeroG)
				{	play("idleFL");	}
				else
				{	play("walkL");	}
				_aim = "L";	}
		}
			
		if (FlxG.keys.LEFT && FlxG.keys.RIGHT)
		{	play("idleL");	}											//Omake: idle_facing_screen anim
		
		if (FlxG.keys.justReleased("RIGHT"))
		{	if (PlayState.zeroG)
			{	play("idleFR");	}
			else
			{	play("idleR");	}
		}
		if (FlxG.keys.justReleased("LEFT"))
		{	if (PlayState.zeroG)
			{	play("idleFL");	}
			else
			{	play("idleL");	}
		}
		
		
		//*******************************************
		//*											*
		//*		FLOATING							*
		//*											*
		//*******************************************
		
		if (PlayState.zeroG)
		{	drag.x = drag.y = drag_air;
			maxVelocity.x = maxVelocity.y = 150;
			acceleration.y = 0;
			if (FlxG.keys.UP && !FlxG.keys.DOWN)
			{	acceleration.y = -drag_air * 6;	}
			if (FlxG.keys.DOWN && !FlxG.keys.UP)
			{	acceleration.y = drag_air * 6;	}
		}
		else
		{	drag.x = drag_floor;
			acceleration.y = 1200;
			drag.y = 0;
			maxVelocity.x = 100;
			maxVelocity.y = 215;
		}
		
		
		
		
		
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
				jumpOK = false;	}
		}
		else
		{	jump = -1;	}
		
		if (jump > 0)
		{	if (jump < 0.05)
			{	velocity.y = -maxVelocity.y * 0.65;	}
			else
			{	velocity.y = -maxVelocity.y;	}
		}
		
		if (this.isTouching(FlxObject.FLOOR))
		{	jump = 0;	}
		
		if (FlxG.keys.justReleased("X"))
		{	jumpOK = true;	}
		
		
		
		
		super.update();
		
		
		
		
		if (y > 800)							//Temp reset for falling off
		{
			y = 100;
		}
		
		
	}
	
}
















