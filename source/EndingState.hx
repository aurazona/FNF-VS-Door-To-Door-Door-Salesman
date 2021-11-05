package;

import flixel.*;
import flixel.util.FlxColor;

class EndingState extends FlxState
{
    
    override public function create():Void
        {

            super.create();
            var endingSprite:FlxSprite = new FlxSprite(0, 0);
            FlxG.sound.playMusic(Paths.music("endingTheme"), 1, false);
            endingSprite.loadGraphic(Paths.image("endingScreen"));
            add(endingSprite);
            endingSprite.screenCenter(XY);

        }


    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ENTER)
        {
            trace("BACK TO THE MAIN MENU WE GO!");
            FlxG.switchState(new StoryMenuState());
        }
    }
}