package;
/* @author Gold_Ninja */

import nme.Assets;
import nme.Lib;
import org.flixel.addons.FlxBackdrop;
import org.flixel.FlxCamera;
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
	private var bg_stars:FlxBackdrop;
	private var player:Player;
	private var grain:FlxSprite;
	private var fpsText:FlxText;
	private var map:FlxTilemap;
	private var map_bg:FlxTilemap;
	private var map_slope:FlxTilemap;
	//private var map_over:FlxTilemap;
	
	private var _bullets:FlxGroup;
	private var _bullets_charge:FlxGroup;
	private var _bullets_explode:FlxGroup;
	
	private var _bullets_all:FlxGroup;
	
	private var _hud:FlxGroup;
	
	private var hud_scroll:FlxPoint;
	
	public static var zeroG:Bool = true;
	
	
	public static var variable:Int;
	private var dev_text:FlxText;
	
	
	
	override public function create():Void
	{
		#if !neko
		FlxG.bgColor = 0xff131c1b;
		#else
		FlxG.bgColor = {rgb: 0x131c1b, a: 0xff};
		#end		
		FlxG.mouse.show();
		
		bg_stars = new FlxBackdrop("assets/sprites/BG_Stars.png", 0.1, 1, true, true);
		add(bg_stars);
		
		map_bg = new FlxTilemap();
		map_bg.loadMap(Assets.getText("assets/csv/mapCSV_Lvl1_BG.csv"), "assets/sprites/Tiles01_bg.png", 64, 64, 0, 0, 1, 1);
		add(map_bg);
		
		map = new FlxTilemap();
		map.loadMap(Assets.getText("assets/csv/mapCSV_Lvl1_Floor.csv"), "assets/sprites/Tiles01.png", 16, 16, 0, 0, 1, 1);
		add(map);
		
		map_slope = new FlxTilemap();
		map_slope.loadMap(Assets.getText("assets/csv/mapCSV_Lvl1_Slope.csv"), "assets/sprites/Tiles01_slope.png", 16, 16, 0, 0, 1, 1);
		add(map_slope);
		
		
		
		
		
		_bullets = new FlxGroup();
		_bullets.maxSize = 30;
		add(_bullets);
		
		_bullets_charge = new FlxGroup();
		_bullets_charge.maxSize = 10;
		add(_bullets_charge);
		
		_bullets_explode = new FlxGroup();								//Not added to _bullets_all group
		_bullets_explode.maxSize = 10;
		add(_bullets_explode);
		
		player = new Player(300, 260, _bullets, _bullets_charge);
		add(player);
		
		_bullets_all = new FlxGroup();									//Helper FlxGroup for all bullets to collide with world.
		_bullets_all.add(_bullets);
		_bullets_all.add(_bullets_charge);
		add(_bullets_all);
		
		/*																TileMap of stuff that goes over the player
		map_over = new FlxTilemap();
		map_over.loadMap(Assets.getText("assets/csv/lvl_1.csv"), "assets/sprites/Tiles01.png", 16, 16, 0, 0, 1, 1);
		add(map);
		*/
		
		hud_scroll = new FlxPoint(0,0);
		
		grain = new FlxSprite(0, 0, "assets/sprites/grain.png");
		add(grain);
		grain.scrollFactor = hud_scroll;
		
		dev_text = new FlxText(5, 5, 200, "");
		add(dev_text);
		dev_text.scrollFactor = hud_scroll;
		
		_hud = new FlxGroup();
		_hud.add(grain);
		_hud.add(dev_text);
		
		
		FlxG.camera.setBounds(0, 0, map.width, map.height, true);
		FlxG.camera.follow(player);
		FlxG.camera.deadzone.height = 70;
		
	}
	
	override public function destroy():Void
	{	super.destroy();	}

	override public function update():Void
	{	
		
		if (FlxG.keys.justReleased("G"))									//TEMP STUFF FOR FAFFING ABOUT
		{	grain.visible = !grain.visible;	}
		
		if (FlxG.keys.justReleased("H"))
		{	FlxG.timeScale = 0.2;	}
		if (FlxG.keys.justReleased("J"))
		{	FlxG.timeScale = 1;	}
		
		if (FlxG.keys.justReleased("Q"))
		{
			zeroG = !zeroG;
		}
		
		if (FlxG.keys.justReleased("O"))
		{	variable = variable - 10;
			dev_text.text = "-10";
			dev_text.alpha = 1; }
		if (FlxG.keys.justReleased("P"))
		{	variable = variable + 10;
			dev_text.text = "+10";
			dev_text.alpha = 1;	}
		dev_text.alpha -= FlxG.elapsed / 2;
		
		
		super.update();
		
		FlxG.collide(player, map);
		FlxG.collide(_bullets_all, map, doExplode);
		
		
	}
	
	private function doExplode(Sprite1:FlxObject, Sprite2:FlxObject):Void
	{	if (Std.is(Sprite1, S_Bullet_Charge))
		{	var _point = new FlxPoint(Sprite1.x + 4, Sprite1.y);
			cast(_bullets_explode.recycle(Explode_Grenade), Explode_Grenade).shoot(_point);
		}
		Sprite1.kill();
		
		
	}
	
	
	
	
}

















