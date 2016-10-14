package swfdata 
{
	import flash.geom.Matrix;
	
	use namespace swfdata_inner;
	
	public class DisplayObjectData 
	{
		swfdata_inner var isCalculatedInPrevFrame:Boolean = false;
		
		public var prototype:DisplayObjectData;
		
		//public var layer:LayerData;
		//public var frameData:FrameObjectData;
		
		public var depth:int = -1;
		public var clipDepth:int = 0;
		
		public var characterId:int;
		public var libraryLinkage:String;
		
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		public var transform:Matrix;
		
		//public var bounds:Rectagon;
		
		//public var colorTransform:ColorMatrix// = new ColorTransform();
		
		swfdata_inner var colorData:ColorData;
		
		swfdata_inner var displayObjectType:int;

		public var isMask:Boolean;
		public var mask:DisplayObjectData;
		
		public var hasMoved:Boolean = false;
		public var hasPlaced:Boolean = false;
		
		public var name:String;
		public var blendMode:int;	
		
		public function DisplayObjectData(characterId:int = -1, displayObjectType:int = 0) 
		{
			this.displayObjectType = displayObjectType;
			this.characterId = characterId;
			
			//transform = new Matrix();
			//bounds = new Rectagon(0, 0, 0, 0, transform);
		}

		public function set alpha(value:Number):void
		{
			colorData.alphaMultiplier = value;
		}
		
		public function get alpha():Number
		{
			return colorData.alphaMultiplier;
		}
		
		public function destroy():void 
		{
			prototype = null;
			mask = null;
			//colorTransform = null;
			transform = null;
			name = null;
			libraryLinkage = null;
			colorData = null;
			//frameData = null;
		}
		
		//public function setColorTransform(matrix:ColorMatrix):void 
		//{
		//	colorTransform = matrix;
		//}
		
		public function setColorData(mr:Number = 1, mg:Number = 1, mb:Number = 1, ma:Number = 1, ar:int = 0, ag:int = 0, ab:int = 0, aa:int = 0):void
		{
			if (colorData == null)
				colorData = new ColorData(mr, mg, mb, ma, ar, ag, ab, aa);
			else
				colorData.setTo(mr, mg, mb, ma, ar, ag, ab, aa);
		}
		
		public function setTransformMatrix(matrix:Matrix):void
		{
			transform = matrix;
			//bounds.transform = matrix;
		}
		
		public function setTransformFromMatrix(matrix:Matrix):void
		{
			setTransformFromRawMatrix(matrix.a, matrix.b, matrix.c, matrix.d, matrix.tx, matrix.ty);
		}
		
		public function setTransformFromRawMatrix(a:Number, b:Number, c:Number, d:Number, tx:Number, ty:Number):void
		{
			if (!transform)
			{
				transform = new Matrix(a, b, c, d, tx, ty);
				//bounds.transform = transform;
			}
			else
			{
				transform.setTo(a, b, c, d, tx, ty);
				//bounds.applyTransform();
			}
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		//public function draw(graphics:Graphics, color:uint):void
		//{
		//	graphics.lineStyle(1, 0);
		//	graphics.beginFill(color, 0.5);
			
		//	graphics.moveTo(bounds.resultTopLeft.x, bounds.resultTopLeft.y);
		//	graphics.lineTo(bounds.resultTopRight.x, bounds.resultTopRight.y);
		//	graphics.lineTo(bounds.resultBottomRight.x, bounds.resultBottomRight.y);
		//	graphics.lineTo(bounds.resultBottomLeft.x, bounds.resultBottomLeft.y);
		//	graphics.lineTo(bounds.resultTopLeft.x, bounds.resultTopLeft.y);
			
		//	graphics.lineStyle();
		//	graphics.endFill();
		//}
		
		public function fillFrom(displayObject:DisplayObjectData):void 
		{
			setTransformFromMatrix(displayObject.transform);
			//setTransformMatrix(displayObject.transform);
			
			isMask = displayObject.isMask;
			
			if(displayObject.name)
				name = displayObject.name;
			
			if(displayObject.libraryLinkage)
				libraryLinkage = displayObject.libraryLinkage;
		}
		
		protected function setDataTo(objectCloned:DisplayObjectData):void
		{
			objectCloned.name = name;
			objectCloned.depth = depth;
			objectCloned.characterId = characterId;
			objectCloned.libraryLinkage = libraryLinkage;
			objectCloned.prototype = prototype;
			//objectCloned.colorTransform = colorTransform;
			objectCloned.isMask = isMask;
			objectCloned.mask = mask;
			objectCloned._x = _x;
			objectCloned._y = _y;
			objectCloned.blendMode = blendMode;
			
			//objectCloned.maskData.isMask = maskData.isMask;
			//objectCloned.maskData.isMasked = maskData.isMasked;
			//objectCloned.maskData.maskId = maskData.maskId;
		}
		
		public function deepClone():DisplayObjectData 
		{
			return this;
		}
		
		public function clone():DisplayObjectData 
		{
			var objectCloned:DisplayObjectData = new DisplayObjectData();
			setDataTo(objectCloned);
			
			return objectCloned;
		}
		
		
		

		
		
	}
}