package;

import altronix.ui.UpdateState;
import flixel.FlxGame;
import flixel.FlxSprite;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		
		FlxSprite.defaultAntialiasing = true;
		addChild(new FlxGame(1280, 720, UpdateState, 60, 60, true));
	}
}