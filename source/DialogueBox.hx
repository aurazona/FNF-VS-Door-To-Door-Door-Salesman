package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'doorcember':
				FlxG.sound.playMusic(Paths.music('scammersSerenade'));
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'heavens door':
				FlxG.sound.playMusic(Paths.music('scammersSerenade'));
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'ajar':
				FlxG.sound.playMusic(Paths.music('scammersSerenade'));
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'doorman':
				FlxG.sound.playMusic(Paths.music('scammersSerenade'));
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'doorkicker':
				FlxG.sound.playMusic(Paths.music('scammersSerenade'));
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'stage exit':
				FlxG.sound.playMusic(Paths.music('scammersSerenade'));
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);

		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'doorcember':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil', 'shared');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'heavens door':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil', 'shared');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'ajar':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil', 'shared');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'doorman':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil', 'shared');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'doorkicker':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil', 'shared');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
			case 'stage exit':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil', 'shared');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft = new FlxSprite(-20, 40);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
			portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			portraitLeft.updateHitbox();
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitRight = new FlxSprite(0, 40);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
			portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			portraitRight.updateHitbox();
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		}

		if (PlayState.SONG.song.toLowerCase() == 'doorcember' || PlayState.SONG.song.toLowerCase() == 'heavens door' || PlayState.SONG.song.toLowerCase() == 'ajar') //WEEK 1
		{
			portraitLeft = new FlxSprite(150, 200);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/scam_portraits', 'shared');
			portraitLeft.animation.addByPrefix('enter', 'start', 24, false);
			portraitLeft.animation.addByPrefix('nervous', 'nervous', 24, false);
			portraitLeft.animation.addByPrefix('normal', 'normal', 24, false);
			portraitLeft.animation.addByPrefix('smug', 'smug', 24, false);
			portraitLeft.animation.addByPrefix('shocked', 'shocked', 24, false);
			portraitLeft.animation.addByPrefix('yeet', 'yeet', 24, false);
			//portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			//portraitLeft.updateHitbox();
			//portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitRight = new FlxSprite(800, 200);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/bf_portrait', 'shared');
			portraitRight.animation.addByPrefix('enter', 'BF', 24, false);
			//portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			//portraitRight.updateHitbox();
			//portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		}

		if (PlayState.SONG.song.toLowerCase() == 'doorman' || PlayState.SONG.song.toLowerCase() == 'doorkicker' || PlayState.SONG.song.toLowerCase() == 'stage exit') //WEEK 2
		{
			portraitLeft = new FlxSprite(150, 200);
			portraitLeft.frames = Paths.getSparrowAtlas('weeb/scam_portraits', 'shared');
			//portraitLeft.animation.addByPrefix('enter', 'start', 24, false);
			portraitLeft.animation.addByPrefix('nervous', 'nervous', 24, false);
			portraitLeft.animation.addByPrefix('normal', 'normal', 24, false);
			portraitLeft.animation.addByPrefix('smug', 'smug', 24, false);
			portraitLeft.animation.addByPrefix('shocked', 'shocked', 24, false);
			portraitLeft.animation.addByPrefix('yeet', 'yeet', 24, false);
			//portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
			//portraitLeft.updateHitbox();
			//portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;
	
			portraitRight = new FlxSprite(800, 200);
			portraitRight.frames = Paths.getSparrowAtlas('weeb/dd_portraits', 'shared');
			portraitRight.animation.addByPrefix('dd anger', 'dd anger', 24, false);
			portraitRight.animation.addByPrefix('dd down', 'dd down', 24, false);
			portraitRight.animation.addByPrefix('dd left', 'dd left', 24, false);
			portraitRight.animation.addByPrefix('dd right', 'dd right', 24, false);
			portraitRight.animation.addByPrefix('dd up', 'dd up', 24, false);
			//portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
			//portraitRight.updateHitbox();
			//portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;
		}
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		//portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}
		//ME TOO NINJA
		if (PlayState.SONG.song.toLowerCase() == 'doorcember' || PlayState.SONG.song.toLowerCase() == 'heavens door' || PlayState.SONG.song.toLowerCase() == 'ajar')
		{
			swagDialogue.color = FlxColor.WHITE;
		}
		//ME TOO AGAIN NINJA
		if (PlayState.SONG.song.toLowerCase() == 'doorman' || PlayState.SONG.song.toLowerCase() == 'doorkicker' || PlayState.SONG.song.toLowerCase() == 'stage exit')
		{
			swagDialogue.color = FlxColor.WHITE;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);
					if (PlayState.SONG.song.toLowerCase() == 'doorcember' || PlayState.SONG.song.toLowerCase() == 'heavens door' || PlayState.SONG.song.toLowerCase() == 'ajar')
					{
						FlxG.sound.music.fadeOut(2.2, 0);
					}
					if (PlayState.SONG.song.toLowerCase() == 'doorman' || PlayState.SONG.song.toLowerCase() == 'doorkicker' || PlayState.SONG.song.toLowerCase() == 'stage exit')
					{
						FlxG.sound.music.fadeOut(2.2, 0);
					}
					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'd2d':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('normal');
			case 'd2dnervous':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('nervous');
			case 'd2dshocked':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('shocked');
			case 'd2dsmug':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
				}
				portraitLeft.animation.play('smug');
			case 'd2dyeet':
				portraitRight.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;	
				}
				portraitLeft.animation.play('yeet');
			case 'dadmad':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
				}
				portraitRight.animation.play('dd anger');
			case 'daddown':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
				}
				portraitRight.animation.play('dd down');
			case 'dadleft':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
				}
				portraitRight.animation.play('dd left');
			case 'dadright':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
				}
				portraitRight.animation.play('dd right');
			case 'dadup':
				portraitLeft.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
				}
				portraitRight.animation.play('dd up');
			case 'hide':
				portraitLeft.visible = false;
				portraitRight.visible = false;
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
