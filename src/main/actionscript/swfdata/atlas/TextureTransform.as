package swfdata.atlas 
{
	public class TextureTransform 
	{
		public var tx:Number;
		public var ty:Number;
		
		public var scaleX:Number;
		public var scaleY:Number;
		
		public var positionMultiplierX:Number;
		public var positionMultiplierY:Number;
		
		public var isMultiplierCalculated:Boolean = false;
		
		public function TextureTransform(scaleX:Number, scaleY:Number, tx:Number = 0, ty:Number = 0) 
		{
			this.ty = ty;
			this.tx = tx;
			
			this.scaleY = scaleY;
			this.scaleX = scaleX;
		
			recalculate();
		}	
		
		[Inline]
		public final function recalculate():void
		{
			if (scaleX == 0 || scaleY == 0)
				return;
				
			isMultiplierCalculated = true;
			positionMultiplierX = 1 / scaleX;
			positionMultiplierY = 1 / scaleY;
			
			if (positionMultiplierX == Infinity || positionMultiplierY == Infinity)
				isMultiplierCalculated = false;
		}
		
		public function toString():String 
		{
			return "[TextureTransform tx=" + tx + " ty=" + ty + " scaleX=" + scaleX + " scaleY=" + scaleY + " positionMultiplierX=" + positionMultiplierX + 
						" positionMultiplierY=" + positionMultiplierY + " isMultiplierCalculated=" + isMultiplierCalculated + 
						"]";
		}
	}
}