package;
/** @author Gold_Ninja */

import nme.Assets;
import nme.Lib;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTilemap;


class TitleState extends FlxState
{
	private var grain:FlxSprite;
	private var start_text:FlxSprite;
	private var stars:FlxSprite;
	private var planet:FlxSprite;
	private var moon:FlxSprite;
	private var title1:FlxSprite;
	private var title2:FlxSprite;
	private var title3:FlxSprite;
	private var title4:FlxSprite;
	private var title5:FlxSprite;
	private var title6:FlxSprite;
	private var t_counter:Int = 60;
	
	
	
	override public function create():Void
	{	#if !neko
		FlxG.bgColor = 0xff010122;
		#else
		FlxG.bgColor = {rgb: 0x010122, a: 0xff};
		#end		
		FlxG.mouse.show();
		
		stars = new FlxSprite(0, 0, "assets/sprites/T_stars.png");
		stars.alpha = 0.8;
		add(stars);
		
		title1 = new FlxSprite(120, 120, "assets/sprites/T_title1.png");
		add(title1);
		title2 = new FlxSprite(116, 124, "assets/sprites/T_title2.png");
		add(title2);
		title3 = new FlxSprite(112, 128, "assets/sprites/T_title3.png");
		add(title3);
		title4 = new FlxSprite(108, 132, "assets/sprites/T_title4.png");
		add(title4);
		title5 = new FlxSprite(104, 136, "assets/sprites/T_title5.png");
		add(title5);
		title6 = new FlxSprite(100, 140, "assets/sprites/T_title6.png");
		add(title6);
		
		
		
		moon = new FlxSprite(606, 98, "assets/sprites/T_moon.png");
		add(moon);
		
		planet = new FlxSprite(630, 90, "assets/sprites/T_planet.png");
		add(planet);
		
		
		start_text = new FlxSprite(282, 290, "assets/sprites/T_start.png");
		add(start_text);
		
		grain = new FlxSprite(0, 0, "assets/sprites/grain.png");
		grain.alpha = 0.5;
		add(grain);
		
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{	super.update();
		
		t_counter += 1;
		
		if (t_counter == 240)									//Reset
		{	t_counter = 0;	}
		
		
		
		if (FlxG.keys.justReleased("G"))
		{	grain.visible = !grain.visible;	}
		
		if (FlxG.keys.justPressed("SPACE"))
		{	start_text.flicker( -1);	}
		
		if (FlxG.keys.justReleased("SPACE"))
		{	FlxG.fade(0xff010122, 1, false, Load_Level);	}
		
		
		if (t_counter == 0)
		{	title6.y -= 2;	}
		
		if (t_counter == 3)
		{	title5.y -= 2;	}
		
		if (t_counter == 6)
		{	title4.y -= 2;	}
		
		if (t_counter == 9)
		{	title3.y -= 2;	}
		
		if (t_counter == 12)
		{	title2.y -= 2;	}
		
		if (t_counter == 15)
		{	title1.y -= 2;	}
		
		
		if (t_counter == 6)
		{	title6.y += 2;	}
		if (t_counter == 9)
		{	title5.y += 2;	}
		if (t_counter == 12)
		{	title4.y += 2;	}
		if (t_counter == 15)
		{	title3.y += 2;	}
		if (t_counter == 18)
		{	title2.y += 2;	}
		if (t_counter == 21)
		{	title1.y += 2;	}
		
		
		
		
		
	}
	
	public function Load_Level():Void
	{	FlxG.switchState(new PlayState());	}
	
}

















