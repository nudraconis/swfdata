package swfdata 
{
	public class LayerData 
	{
		public var depth:uint;
		public var frameCount:uint;
		public var isMask:Boolean;
		public var clipDepth:int;
		public var isMasked:Boolean;
		public var mask:LayerData;
		public var maskedLayers:Vector.<LayerData> = new Vector.<LayerData>();
		
		public function LayerData(depth:uint, frameCount:uint) 
		{
			this.frameCount = frameCount;
			this.depth = depth;
		}
		
		public function setClipAndDepthData(hasClipDepth:Boolean, clipDepth:uint):void 
		{
			isMask = hasClipDepth;
			this.clipDepth = clipDepth
		}
		
		public function addFrame(frameData:FrameData):void
		{
			
		}
		
		public function maskLayer(maskedLayer:LayerData):void 
		{
			maskedLayers.push(mask);
			maskedLayer.maskBy(this);
		}
		
		private function maskBy(mask:LayerData):void 
		{
			isMasked = true;
			this.mask = mask;
		}
		
		public function toString():String 
		{	
			return "[LayerData depth=" + depth + " frameCount=" + frameCount + " isMask=" + isMask + " mask=" + mask + "]";
		}
	}
}