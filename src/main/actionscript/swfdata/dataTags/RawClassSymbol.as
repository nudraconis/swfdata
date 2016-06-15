package swfdata.dataTags 
{
	/**
	 * ...
	 * @author ...
	 */
	public class RawClassSymbol 
	{
		public var characterId:int;
		public var linkage:String;
		
		public function RawClassSymbol(characterId:int = 0, linkage:String = null) 
		{
			this.linkage = linkage;
			this.characterId = characterId;
		}
		
		public function clear():void
		{
			linkage = null;
		}
		
		public function toString():String 
		{
			return "[RawClassSymbol characterId=" + characterId + " linkage=" + linkage + "]";
		}
	}
}