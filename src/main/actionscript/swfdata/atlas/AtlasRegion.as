package swfdata.atlas 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class AtlasRegion 
	{
		public var masterBitmap:BitmapData;
		
		public var bounds:Rectangle;
		public var width:int;
		public var height:int;
		public var areaSize:int;
		public var name:String;
		
		public function AtlasRegion(bounds:Rectangle, name:String, masterBitmap:BitmapData) 
		{
			this.masterBitmap = masterBitmap;
			this.name = name;
			this.bounds = bounds;
			
			width = bounds.width;
			height = bounds.height;
			
			areaSize = width * height;
		}
		
		public function copyTo(destPoint:Point, destBitmap:BitmapData):void
		{
			
		}
	}
}