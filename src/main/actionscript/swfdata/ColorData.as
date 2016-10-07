package swfdata 
{

	public class ColorData 
	{
		public var alphaMultiplier:Number = 1;
		public var redMultiplier:Number = 1;
		public var greenMultiplier:Number = 1;
		public var blueMultiplier:Number = 1;
		
		public var alphaAdd:int = 0;
		public var redAdd:int = 0;
		public var greenAdd:int = 0;
		public var blueAdd:int = 0;
		
		public function ColorData(redMultiplier:Number = 1, greenMultiplier:Number = 1, blueMultiplier:Number = 1, alphaMultiplier:Number = 1, 
									redAdd:int = 0, greenAdd:int = 0, blueAdd:int = 0, alphaAdd:int = 0) 
		{
			this.alphaMultiplier = alphaMultiplier;
			this.blueMultiplier = blueMultiplier;
			this.greenMultiplier = greenMultiplier;
			this.redMultiplier = redMultiplier;
			
			this.redAdd = redAdd;
			this.greenAdd = greenAdd;
			this.blueAdd = blueAdd;
			this.alphaAdd = alphaAdd;
		}
		
		public function setTo(redMultiplier:Number = 1, greenMultiplier:Number = 1, blueMultiplier:Number = 1, alphaMultiplier:Number = 1, 
									redAdd:int = 0, greenAdd:int = 0, blueAdd:int = 0, alphaAdd:int = 0):void
		{
			this.alphaMultiplier = alphaMultiplier;
			this.redMultiplier = redMultiplier;
			this.greenMultiplier = greenMultiplier;
			this.blueMultiplier = blueMultiplier;
			
			this.redAdd = redAdd;
			this.greenAdd = greenAdd;
			this.blueAdd = blueAdd;
			this.alphaAdd = alphaAdd;
			
			//isUseAdd = redAdd != 0 || greenAdd != 0 || blueAdd != 0 || alphaAdd != 0;
		}
		
		[Inline]
		public final function setFromData(colorData:ColorData):void 
		{
			alphaMultiplier = colorData.alphaMultiplier;
			redMultiplier = colorData.redMultiplier;
			greenMultiplier = colorData.greenMultiplier;
			blueMultiplier = colorData.blueMultiplier;
			
			redAdd = colorData.redAdd;
			greenAdd = colorData.greenAdd;
			blueAdd = colorData.blueAdd;
			alphaAdd = colorData.alphaAdd;
		}
		
		[Inline]
		public final function clear():void
		{
			alphaMultiplier = 1;
			redMultiplier = 1;
			blueMultiplier = 1;
			greenMultiplier = 1;
			
			redAdd = 0;
			greenAdd = 0;
			blueAdd = 0;
			alphaAdd = 0;
		}
		
		[Inline]
		public final function concat(colorData:ColorData):void
		{
			alphaMultiplier *= colorData.alphaMultiplier;
			redMultiplier *= colorData.redMultiplier;
			greenMultiplier *= colorData.greenMultiplier;
			blueMultiplier *= colorData.blueMultiplier;
			
			redAdd += colorData.redAdd;
			greenAdd += colorData.greenAdd;
			blueAdd += colorData.blueAdd;
			alphaAdd += colorData.alphaAdd;
			
			if (redAdd > 255)
				redAdd = 255;
				
			if (greenAdd > 255)
				greenAdd = 255;
				
			if (blueAdd > 255)
				blueAdd = 255;
			
			if (alphaAdd > 255)
				alphaAdd = 255;
		}
		
		[Inline]
		public final function preMultiply(colorData:ColorData): void 
		{
			this.redAdd += colorData.redAdd * this.redMultiplier;
			this.greenAdd += colorData.greenAdd * this.greenMultiplier;
			this.blueAdd += colorData.blueAdd * this.blueMultiplier;
			this.alphaAdd += colorData.alphaAdd * this.alphaMultiplier;
			
			this.redMultiplier *= colorData.redMultiplier;
			this.greenMultiplier *= colorData.greenMultiplier;
			this.blueMultiplier *= colorData.blueMultiplier;
			this.alphaMultiplier *= colorData.alphaMultiplier;
			
			if (redAdd > 255)
				redAdd = 255;
				
			if (greenAdd > 255)
				greenAdd = 255;
				
			if (blueAdd > 255)
				blueAdd = 255;
			
			if (alphaAdd > 255)
				alphaAdd = 255;
		}
		
		public function get color():int
		{
			return ((int (redAdd) << 16) | (int (greenAdd) << 8) | int (blueAdd));
		}
		
		public function set color(value:int):void
		{
			redAdd = (value >> 16) & 0xFF;
			greenAdd = (value >> 8) & 0xFF;
			blueAdd = value & 0xFF;
			
			redMultiplier = 0;
			greenMultiplier = 0;
			blueMultiplier = 0;
		}
		
		public function fillColorMatrix(colorMatrix:ColorMatrix):void
		{
			colorMatrix.matrix[0] = redMultiplier;
			colorMatrix.matrix[4] = redAdd / 255;
			colorMatrix.matrix[6] = greenMultiplier;
			colorMatrix.matrix[9] = greenAdd / 255;
			colorMatrix.matrix[12] = blueMultiplier;
			colorMatrix.matrix[14] = blueAdd / 255;
			colorMatrix.matrix[18] = alphaMultiplier;
			colorMatrix.matrix[19] = alphaAdd / 255;
		}
		
		public function toString():String 
		{
			return "[ColorData alphaMultiplier=" + alphaMultiplier + " redMultiplier=" + redMultiplier + " greenMultiplier=" + greenMultiplier + 
						" blueMultiplier=" + blueMultiplier + " alphaAdd=" + alphaAdd + " redAdd=" + redAdd + 
						" greenAdd=" + greenAdd + " blueAdd=" + blueAdd + " color=" + color + "]";
		}
	}
}