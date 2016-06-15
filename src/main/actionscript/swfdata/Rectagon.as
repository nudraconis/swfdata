package swfdata 
{
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class Rectagon 
	{
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		
		public var localX:Number;
		public var localY:Number;
		public var localWidth:Number;
		public var localHeight:Number;
		
		public var topLeft:Point = new Point();
		public var topRight:Point = new Point();
		public var bottomLeft:Point = new Point();
		public var bottomRight:Point = new Point();
		
		public var resultTopLeft:Point = new Point();
		public var resultTopRight:Point = new Point();
		public var resultBottomLeft:Point = new Point();
		public var resultBottomRight:Point = new Point();
		
		private var _transform:Matrix;
		
		public function Rectagon(x:Number, y:Number, width:Number, height:Number, transform:Matrix) 
		{
			this._transform = transform;
			
			localX = x;
			localY = y;
			localWidth = width;
			localHeight = height;
			
			topLeft.setTo(x, y);
			topRight.setTo(x + width, y);
			bottomLeft.setTo(x, y + height);
			bottomRight.setTo(x + width, y + height);
			
			//applyTransform();
		}
		
		[Inline]
		public static function transformX(px:Number, py:Number, transform:Matrix):Number
		{
			return px * transform.a + py * transform.c + transform.tx;
		}
		
		[Inline]
		public static function transformY(px:Number, py:Number, transform:Matrix):Number
		{
			return px * transform.b + py * transform.d + transform.ty;
		}
		
		public function union(rectagon:Rectagon):void
		{
			if (_transform == rectagon._transform)
				_transform = _transform.clone();
				
			_transform.concat(rectagon._transform);
			
			localX = Math.min(localX, rectagon.localX);
			localY = Math.min(localY, rectagon.localY);
			localWidth = Math.max(localWidth, localWidth) - localX;
			localHeight = Math.max(localHeight, localHeight) - localY;
			
			setTo(localX, localY, localWidth, localHeight);
		}
		
		public function clear():void 
		{
			localX = 0;
			localY = 0;
			localWidth = 0;
			localHeight = 0;
			
			topLeft.setTo(0, 0);
			topRight.setTo(0, 0);
			bottomLeft.setTo(0, 0);
			bottomRight.setTo(0, 0);
		}
		
		public function setToWithTransform(x:Number, y:Number, width:Number, height:Number, transform:Matrix):void 
		{
			localX = x;
			localY = y;
			localWidth = width;
			localHeight = height;
			
			topLeft.setTo(x, y);
			topRight.setTo(x + width, y);
			bottomLeft.setTo(x, y + height);
			bottomRight.setTo(x + width, y + height);
			
			_transform = transform;
			
			applyTransform();
		}
		
		public function setTo(x:Number, y:Number, width:Number, height:Number):void 
		{
			localX = x;
			localY = y;
			localWidth = width;
			localHeight = height;
			
			topLeft.setTo(x, y);
			topRight.setTo(x + width, y);
			bottomLeft.setTo(x, y + height);
			bottomRight.setTo(x + width, y + height);
			
			applyTransform();
		}
		
		public function get transform():Matrix
		{
			return _transform;
		}
		
		public function set transform(value:Matrix):void
		{
			_transform = value;
			
			applyTransform();
		}
		
		public function applyTransform():void 
		{
			if (!_transform)
				return;
				
			resultTopLeft.setTo(transformX(topLeft.x, topLeft.y, _transform), 
								transformY(topLeft.x, topLeft.y, _transform));
								
			resultTopRight.setTo(transformX(topRight.x, topRight.y, _transform), 
								 transformY(topRight.x, topRight.y, _transform));
								 
			resultBottomLeft.setTo(transformX(bottomLeft.x, bottomLeft.y, _transform),
								   transformY(bottomLeft.x, bottomLeft.y, _transform));
								   
			resultBottomRight.setTo(transformX(bottomRight.x, bottomRight.y, _transform),
									transformY(bottomRight.x, bottomRight.y, _transform));
									
			x = Math.min(resultTopLeft.x, resultTopRight.x, resultBottomLeft.x, resultBottomRight.x);
			y = Math.min(resultTopLeft.y, resultTopRight.y, resultBottomLeft.y, resultBottomRight.y);
			width = Math.max(resultTopLeft.x, resultTopRight.x, resultBottomLeft.x, resultBottomRight.x);
			height = Math.max(resultTopLeft.y, resultTopRight.y, resultBottomLeft.y, resultBottomRight.y);
			
			width -= x;
			height -= y;
		}
	}
}