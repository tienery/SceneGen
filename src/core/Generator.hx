package core;
import haxe.Constraints.Function;

#if openfl
import openfl.display.BitmapData;
import openfl.Assets;
#end

class Generator
{
	
	private var _bitmap:
						#if openfl 
						BitmapData 
						#end 
						;
	
	private var _previousColor:Int;
	private var _cache:Array<Object>;
	

	/**
	 * Add integer values that identify a specific color associated with the given type.
	 */
	public var associations:Map<Int, String>;
	
	/**
	 * Specifies the transparent color in the bitmap file. This color will be ignored.
	 */
	public var transparentColor:Int;
	
	/**
	 * Creates a generator based on a bitmap file.
	 */
	public function new(bitmapFile:String)
	{
		_bitmap = 
			#if openfl
				Assets.getBitmapData(bitmapFile);
			#end
		
		associations = new Map<Int, String>();
	}
	
	public function generateScene():Array<Object>
	{
		var objects = new Array<Object>();
		
		#if openfl
		
		var width = _bitmap.width;
		var height = _bitmap.height;
		
		for (y in 0...height)
		{
			for (x in 0...width)
			{
				var color = _bitmap.getPixel(x, y);
				
				if (color == transparentColor)
					continue;
				else if (color == _previousColor && _previousColor != transparentColor)
				{
					//This is an unfinished attempt at resolving whether or not the current pixel location is within
					//the bounds of a rectangle of the same color.
					if (_cache.length > 0)
					{
						for (obj in _cache)
						{
							if (x > obj.x && y > obj.y)
							{
								if (obj.color == color)
									break;
							}
						}
					}
				}
				else
				{
					var cl:String = associations.get(color);
					var obj = new Object();
					obj.x = x;
					obj.y = y;					
					obj.name = cl;
					
					_previousColor = color;
					objects.push(obj);
				}
			}
		}
		
		#end
		
		return objects;
	}
}