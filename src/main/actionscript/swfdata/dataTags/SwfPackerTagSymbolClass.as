package swfdata.dataTags 
{
	public class SwfPackerTagSymbolClass extends SwfPackerTag 
	{
		public var characterIdList:Vector.<int>;
		public var linkageList:Vector.<String>;
		
		public var length:int;
		
		public function SwfPackerTagSymbolClass(length:int = 0) 
		{
			
			type = 76;//from swf tags specification
			
			this.length = length;
		
			if (length != 0)
			{
				initializeContent();
			}
		}
		
		public function initializeContent(fixedSize:Boolean = true):void 
		{
			characterIdList = new Vector.<int>(length, fixedSize);
			linkageList = new Vector.<String>(length, fixedSize);
		}
		
		override public function clear():void 
		{
			characterIdList = null;
			linkageList = null;
		}
	}
}