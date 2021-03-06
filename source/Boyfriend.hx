package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxTimer;

using StringTools;

class Boyfriend extends Character
{
	public var stunned:Bool = false;
	var dadTimerFinished:Bool = false;
	var curBf:String = GameOverSubstate.daBf;

	public function new(x:Float, y:Float, ?char:String = 'bf')
	{
		super(x, y, char, true);
	}

	override function update(elapsed:Float)
	{
		if (!debugMode)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}
			else
				holdTimer = 0;

			if (animation.curAnim.name.endsWith('miss') && animation.curAnim.finished && !debugMode)
			{
				playAnim('idle', true, false, 10);
			}

			if (animation.curAnim.name == 'firstDeath' && animation.curAnim.finished)
			{
				playAnim('deathLoop');
			}

			if (curBf == 'bf-dad' && animation.curAnim.name == 'firstDeath' && dadTimerFinished == false)
				{
					new FlxTimer().start(2.75, function(e:FlxTimer)
					{
						playAnim('deathLoop');
						dadTimerFinished = true;
					});
				}
		}

		super.update(elapsed);
	}
}
