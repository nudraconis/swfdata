package swfdata.atlas 
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Atlas 
	{
		static public const NULL_POINT:Point = new Point();
		
		private static const DRAWING_MATRIX:Matrix = new Matrix();
		
		private static var COLOR_BOUND_CHECK_10:BitmapData = new BitmapData(1024, 1024, true, 0);
		private static var COLOR_BOUND_CHECK_9:BitmapData = new BitmapData(512, 512, true, 0);
		private static var COLOR_BOUND_CHECK_8:BitmapData = new BitmapData(256, 256, true, 0);
		private static var COLOR_BOUND_CHECK_7:BitmapData = new BitmapData(128, 128, true, 0);
		private static var COLOR_BOUND_CHECK_6:BitmapData = new BitmapData(64, 64, true, 0);
		private static var COLOR_BOUND_CHECK_5:BitmapData = new BitmapData(32, 32, true, 0);
		private static var COLOR_BOUND_CHECK_4:BitmapData = new BitmapData(16, 16, true, 0);
		private static var COLOR_BOUND_CHECK_3:BitmapData = new BitmapData(8, 8, true, 0);
		private static var COLOR_BOUND_CHECK_2:BitmapData = new BitmapData(4, 4, true, 0);
		private static var COLOR_BOUND_CHECK_1:BitmapData = new BitmapData(2, 2, true, 0);
		private static var COLOR_BOUND_CHECK_0:BitmapData = new BitmapData(1, 1, true, 0);
		
		private static var boundCheckers:Vector.<BitmapData> = new <BitmapData>[COLOR_BOUND_CHECK_0, COLOR_BOUND_CHECK_1, COLOR_BOUND_CHECK_2, COLOR_BOUND_CHECK_3, 
																				COLOR_BOUND_CHECK_4, COLOR_BOUND_CHECK_5, COLOR_BOUND_CHECK_6, COLOR_BOUND_CHECK_7,
																				COLOR_BOUND_CHECK_8, COLOR_BOUND_CHECK_9, COLOR_BOUND_CHECK_10];
		
		private static const MAX_SIZE:int = 512;
		
		public static function getBestPowerOf2(value:int):int
		{
			var p:uint = 1;
			
			while (p < value)
				p <<= 1;
			
			if (p > MAX_SIZE)
				p = MAX_SIZE;
			
			return p;
		}
		
		public var atlasData:BitmapData = new BitmapData(1024*2, 1024*2, true, 0);//0x55000011);
		//public var atlasData:BitmapData = new BitmapData(1024 * 8, 1024 * 8, true, 0);//0x55000011);
		private var lastPosition:Point = new Point();
		
		public var subTextures:Object = { };
		private var padding:int;
		
		public var scale:Number;

		public function Atlas(scale:Number = 1, padding:int = 1) 
		{
			
			this.padding = padding;
			this.scale = scale;
			lastPosition.setTo(padding, padding);
		}
		
		public function getSubTexture(shapeId:int):Subtexture
		{
			return subTextures[shapeId];
		}
		
		private var maxPadding:Number = 0;
		public function addShape(shapeId:int, shape:Shape, defineRect:Rectangle, sceneTransfrm:TextureTransform):Rectangle
		{
			var shapeBound:Rectangle = defineRect.clone();
			
			DRAWING_MATRIX.identity();
			
			var scaleX:Number = sceneTransfrm.scaleX = sceneTransfrm.scaleX * scale;
			var scaleY:Number = sceneTransfrm.scaleY =  sceneTransfrm.scaleY * scale;
			sceneTransfrm.recalculate();
			var subtexture:Subtexture = new Subtexture(shapeId, shapeBound, scaleX, scaleY);
			
			var posX:Number = lastPosition.x - defineRect.x;
			
			if (posX + defineRect.width * scaleX + padding >= atlasData.width)
			{
				lastPosition.setTo(padding, lastPosition.y + maxPadding + padding);
				maxPadding = 2;
			}		
			
			//scaleX = Number(scaleX.toFixed(2));
			//scaleY = Number(scaleY.toFixed(2));
			
			DRAWING_MATRIX.scale(scaleX, scaleY);
			shapeBound.width *= scaleX;
			shapeBound.height *= scaleY;
			
			DRAWING_MATRIX.tx = -sceneTransfrm.tx * scaleX + 20;
			DRAWING_MATRIX.ty = -sceneTransfrm.ty * scaleY + 10;
			
			var powerOf2Size:int = getBestPowerOf2(Math.max(shapeBound.width + 40, shapeBound.height + 20));
			var checkerIndex:int = FastMath.log(powerOf2Size, 2);
			
			var boundChecker:BitmapData = boundCheckers[checkerIndex];
			
			boundChecker.drawWithQuality(shape, DRAWING_MATRIX, null, null, null, false, StageQuality.BEST);

			var bitmapBoundRect:Rectangle = boundChecker.getColorBoundsRect(0xFFFFFFFF, 0, false);
			
			shapeBound.width = bitmapBoundRect.width;
			shapeBound.height = bitmapBoundRect.height;
			shapeBound.x = lastPosition.x;
			shapeBound.y = lastPosition.y;
			
			//atlasData.fillRect(shapeBound, 0x33FF0000);
			atlasData.copyPixels(boundChecker, bitmapBoundRect, lastPosition);
			
			boundChecker.fillRect(bitmapBoundRect, 0);
			
			
			maxPadding = Math.max(maxPadding, shapeBound.height);
			lastPosition.x += shapeBound.width + padding * 2;
			subTextures[shapeId] = subtexture;
			
			return bitmapBoundRect;
		}
	}
}