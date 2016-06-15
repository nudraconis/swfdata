package swfdata.dataTags 
{
	
	public class SwfPackerTagRemoveObject extends SwfPackerTag 
	{
		public var characterId:int;
		public var depth:int;
		
		public function SwfPackerTagRemoveObject(characterId:uint = 0, depth:uint = 0) 
		{
			this.depth = depth;
			this.characterId = characterId;
			
			type = 5;//from swf tags specification
		}
		
		override public function clear():void 
		{
			
		}
		
		public function isEquals(tagRemoveObject:SwfPackerTagRemoveObject):Boolean 
		{
			return tagRemoveObject.characterId == characterId && tagRemoveObject.depth == depth;
		}
		
		public function toString():String 
		{
			return "[SwfPackerTagRemoveObject characterId=" + characterId + " depth=" + depth + "]";
		}
	}
}