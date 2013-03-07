package;
/** @author Gold_Ninja */

import nme.Assets;
import nme.Lib;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxObject;
import org.flixel.FlxPoint;
import org.flixel.FlxSprite;
import org.flixel.FlxState;
import org.flixel.FlxText;
import org.flixel.FlxTilemap;

class PlayState extends FlxState
{
	private var bg_stars:FlxSprite;
	private var player:Player;
	private var gun:FlxSprite;
	private var grain:FlxSprite;
	private var fpsText:FlxText;
	private var map:FlxTilemap;
	private var map_bg:FlxTilemap;
	private var _bullets:FlxGroup;
	private var _bullets_charge:FlxGroup;
	
	
	override public function create():Void
	{
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		FlxG.mouse.show();
		
		bg_stars = new FlxSprite(0, 0, "assets/sprites/BG_Stars.png");
		add(bg_stars);
		
		map_bg = new FlxTilemap();
		map_bg.loadMap(Assets.getText("assets/csv/lvl_1_bg.csv"), "assets/sprites/Tiles01_bg.png", 64, 64, 0, 0, 1, 1);
		add(map_bg);
		
		map = new FlxTilemap();
		map.loadMap(Assets.getText("assets/csv/lvl_1.csv"), "assets/sprites/Tiles01.png", 16, 16, 0, 0, 1, 1);
		add(map);
		
		_bullets = new FlxGroup();
		_bullets.maxSize = 30;
		add(_bullets);
		
		_bullets_charge = new FlxGroup();
		_bullets_charge.maxSize = 20;
		add(_bullets_charge);
		
		player = new Player(200, 160, _bullets, _bullets_charge);
		add(player);
		
		
		
		gun = new FlxSprite(200, 160, "assets/sprites/gun.png");
		add(gun);
		
		/*TileMap of stuff that goes over the player
		map = new FlxTilemap();
		map.loadMap(Assets.getText("assets/csv/lvl_1.csv"), "assets/sprites/Tiles01.png", 16, 16, 0, 0, 1, 1);
		add(map);
		*/
		
		grain = new FlxSprite(0, 0, "assets/sprites/grain.png");
		add(grain);
		
		
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{	super.update();
		
		gun.x = player.x+15;
		gun.y = player.y+9;
		
	
	
		if (FlxG.keys.justReleased("G"))
		{	grain.visible = !grain.visible;	}
		
		FlxG.collide(player, map);
		FlxG.collide(_bullets, map);

	}
	
	
	
	
}

















