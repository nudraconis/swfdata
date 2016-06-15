package utils 
{

	public class BitMask 
	{
		public var mask:uint;
		
		public function BitMask(mask:uint = 0) 
		{
			this.mask = mask;
		}
		
		public function invertBit(bitIndex:uint):void
		{
			mask ^= (1 << bitIndex);
		}
		
		public function clearBit(bitIndex:uint):void
		{
			mask &= ~(1 << bitIndex);
		}
		
		[Inline]
		public final function setBit(bitIndex:uint):void
		{
			mask |= (1 << bitIndex);
		}
		
		[Inline]
		public final function isBitSet(bitIndex:uint):Boolean
		{
			return Boolean(mask & ( 1 << bitIndex));
		}
	}
}