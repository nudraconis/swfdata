package swfdata.atlas 
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;

	public class AtlasDrawerUtils 
	{
		private static var boundCheckers:Vector.<BitmapData> = new Vector.<BitmapData>(12, true);
		
		private static const MAX_SIZE:int = 2048;
		
		public static function getBestPowerOf2(value:int):int
		{
			var p:uint = 1;
			
			while (p < value)
				p <<= 1;
			
			if (p > MAX_SIZE)
				p = MAX_SIZE;
			
			return p;
		}
		
		[Inline]
		public static function getColorBoundCheck(value:int):BitmapData
		{
			var checker:BitmapData = boundCheckers[value];
			
			if (checker == null)
			{
				var size:int = Math.pow(2, value);
				
				if (size == 0)
					size = 1;
				
				checker = new BitmapData(size, size, true, 0);
				boundCheckers[value] = checker;
			}
			
			return checker;
		}
		
		public function clear():void
		{
			for (var i:int = 0; i < boundCheckers.length; i++)
			{
				boundCheckers[i].dispose();
				boundCheckers[i] = null;
			}
		}
	}
}