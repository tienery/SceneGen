package;

import core.Generator;
import core.Object;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.display.SimpleButton;
import openfl.display.Bitmap;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.Assets;
import openfl.text.TextFormat;

class Main extends Sprite 
{

	private var gen:Generator;
	private var index:Int;
	
	public function new()
	{
		super();
		
		openflTest();
	}
	
	private function openflTest()
	{
		gen = new Generator("img/Test.png");
		gen.associations.set(0x007800, "SimpleButton");
		gen.associations.set(0x00FF00, "Bitmap");
		gen.associations.set(0x00FFFF, "TextField");
		gen.transparentColor = 0xFFFFFF;
		
		var objs = gen.generateScene();
		
		for (i in 0...objs.length)
		{
			index = i;
			var cl = objs[i];
			if (cl.name == "SimpleButton")
			{
				setSimpleButton(cl);
			}
			else if (cl.name == "Bitmap")
			{	
				setBitmap(cl);
			}
			else if (cl.name == "TextField")
			{
				setTextField(cl);
			}
		}
	}
	
	private function setSimpleButton(obj:Object)
	{
		var casted = new SimpleButton();
		casted.x = obj.x;
		casted.y = obj.y;
		casted.upState = new Bitmap(Assets.getBitmapData("img/ButtonUp.png"));
		casted.overState = new Bitmap(Assets.getBitmapData("img/ButtonOver.png"));
		casted.downState = new Bitmap(Assets.getBitmapData("img/ButtonDown.png"));
		addChild(casted);
	}
	
	private function setBitmap(obj:Object)
	{
		var casted = new Bitmap();
		casted.x = obj.x;
		casted.y = obj.y;
		if (index == 0)
			casted.bitmapData = Assets.getBitmapData("img/TopBanner.png");
		
		addChild(casted);
	}
	
	private function setTextField(obj:Object)
	{
		var casted:TextField = new TextField();
		casted.defaultTextFormat = new TextFormat("Times New Roman", 14, 0xFFFFFF);
		casted.autoSize = TextFieldAutoSize.LEFT;
		casted.selectable = false;
		casted.text = "This is a test to see if the generator works as expected.";
		
		casted.x = obj.x;
		casted.y = obj.y;
		
		addChild(casted);
	}

}
