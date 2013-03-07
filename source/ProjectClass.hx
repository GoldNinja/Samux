package;

import nme.Lib;
import org.flixel.FlxGame;
	
class ProjectClass extends FlxGame
{	
	public function new()
	{
		//var stageWidth:Int = Lib.current.stage.stageWidth;
		//var stageHeight:Int = Lib.current.stage.stageHeight;
		//var ratioX:Float = stageWidth / 800;
		//var ratioY:Float = stageHeight / 400;
		//var ratio:Float = Math.min(ratioX, ratioY);
		super(800, 400, TitleState, 1, 60, 60);
		
	}
}
