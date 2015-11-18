# SceneGen
A visual scene generator that uses bitmaps to identify where objects of different types should be.

##Usage
Create a `Generator` in your main, or in any other scene for that matter. You will need to set the `transparentColor` to identify the background, so that this color is ignored.

Then, you can associate `String`'s that identifies a specific type. By calling the function `generateScene`, this will result in a collection of `Object`'s that can be matched with the associated string, and then you can create your visual objects accordingly. Whenever you need to move an object, just change it in the bitmap image you pass into the Generator on construction.

Here is an example:
	
	private function openflTest()
	{
		var gen = new Generator("img/Test.png");
		gen.associations.set(0x007800, "SimpleButton");
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

This file has been reduced for readability, but you can see the rest of this example - and even test it for yourself by cloning this repository - from [this file](https://github.com/tienery/SceneGen/blob/master/src/Main.hx).

## TODO
Currently, it is not very smart. Because of it's very simple algorithm, it does not take into account the save of rectangles within a bitmap image. This will be resolved ASAP.
