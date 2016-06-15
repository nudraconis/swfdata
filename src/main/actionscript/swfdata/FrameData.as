package swfdata 
{
	use namespace swfdata_inner;
	
	public class FrameData extends DisplayObjectContainer
	{
		public var frameIndex:int;
		public var frameLabel:String;
		
		public function FrameData(frameIndex:int, frameLabel:String = null, numChildren:int = 0) 
		{
			super(numChildren);
			
			if(frameLabel)
				this.frameLabel = frameLabel;
				
			this.frameIndex = frameIndex;
		}
		
		override public function destroy():void 
		{
			super.destroy();
			
			frameLabel = null;
		}
		
		override public function clone():IDisplayObjectContainer
		{
			var objectCloned:FrameData = new FrameData(frameIndex, frameLabel, numChildren);
			
			fillData(objectCloned);
			
			return objectCloned;
		}
		
		public function toString():String 
		{
			return "FrameData " + frameIndex + " frameObjects=" + displayObjects.length;
		}
		
		public function clear():void 
		{
			frameLabel = null;
		}
	}
}