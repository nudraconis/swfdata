package swfdata 
{
	import flash.display.Shape;
	import flash.geom.Matrix;
	import swfdata.atlas.TextureTransform;
	
	public class ShapeLibraryItem 
	{
		public var shape:Shape;
		public var shapeData:ShapeData;
		public var transform:TextureTransform = new TextureTransform(0, 0);
		
		public function ShapeLibraryItem() 
		{
			
		}	
		
		public function clear():void 
		{
			if(shape)
				shape.graphics.clear();
				
			shape = null;
			shapeData = null;
			transform = null;
		}
		
		[Inline]
		public final function correctScale(a:Number, a2:Number):Number
		{
			if (a == a2)
				return a2;
				
			if (a < 0)
				a = -a;
			
			if (a > a2)
				return a;
			else
				return a2;
		}
		
		public final function checkTransform2(matrix:Matrix, tx:Number, ty:Number):void
		{
			transform.scaleX = correctScale(matrix.a, transform.scaleX);
			transform.scaleY = correctScale(matrix.d, transform.scaleY);
			
			var shapeWidth:Number = shape.width;
			var shapeHeight:Number = shape.height;
			
			var maxSize:int = 1024;
			
			if (shapeWidth * transform.scaleX > maxSize)
			{
				transform.scaleX = (maxSize / shapeWidth);
				//transform.scaleX = 1;
			}
				
			if (shapeHeight * transform.scaleY > maxSize)
			{
				transform.scaleX = (maxSize / shapeHeight);
				//transform.scaleY = 1;
			}
				
			transform.tx = tx;
			transform.ty = ty;
		}
		
		[Inline]
		public final function checkTransform(matrix:Matrix, tx:Number, ty:Number):void
		{
			transform.scaleX = correctScale(matrix.a, transform.scaleX);//Math.max(Math.abs(matrix.a), transform.scaleX);
			transform.scaleY = correctScale(matrix.d, transform.scaleY);//Math.max(Math.abs(matrix.d), transform.scaleY);
			
			transform.tx = tx;
			transform.ty = ty;
			
			//transform.recalculate();
		}
		

	}
}