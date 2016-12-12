package swfdata 
{
	import flash.display.BitmapData;
	public class BitmapLibrary 
	{
		public var bitmapsLibrary:Object = {};
		
		public function BitmapLibrary() 
		{
			
		}
		
		public function addBitmap(id:int, bitmap:BitmapData):void
		{
			bitmapsLibrary[id] = bitmap;
		}
		
		public function getBitmap(id:int):BitmapData
		{
			return bitmapsLibrary[id];
		}
		
		public function clear(callDestroy:Boolean = true):void
		{
			if (callDestroy)
			{
				for each(var bitmap:BitmapData in bitmapsLibrary)
				{
					bitmap.dispose();
				}
			}
			
			bitmapsLibrary = { };
		}
	}
}