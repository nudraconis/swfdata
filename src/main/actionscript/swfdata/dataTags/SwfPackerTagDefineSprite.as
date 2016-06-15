package swfdata.dataTags 
{
	import swfdata.FrameData;
	
	public class SwfPackerTagDefineSprite extends SwfPackerTag 
	{
		public var characterId:int
		public var frameCount:int
		
		public var tags:Vector.<SwfPackerTag>;
		public var frames:Vector.<FrameData>;
		
		public function SwfPackerTagDefineSprite() 
		{
			type = 39;//from swf tags specification
		}
			
		override public function clear():void 
		{
			var i:int;
			for (i = 0; i < frames.length; i++)
			{
				frames[i].clear();
			}
			
			for (i = 0; i < tags.length; i++)
			{
				tags[i].clear();
			}
			
			frames = null;
			tags = null;
		}
	}
}

