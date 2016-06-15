package swfdata 
{
	import flash.geom.Matrix;
	
	public class FrameObjectData 
	{
		public var depth:int;
		public var characterId:int;
		public var className:String;
		public var placedAtIndex:int;
		public var lastModifiedAtIndex:int;
		public var isKeyframe:Boolean;
		public var layer:LayerData;
		
		public function FrameObjectData(depth:int, characterId:int, className:String, placedAtIndex:int, lastModifiedAtIndex:int, isKeyframe:Boolean) 
		{
			this.isKeyframe = isKeyframe;
			this.lastModifiedAtIndex = lastModifiedAtIndex;
			this.placedAtIndex = placedAtIndex;
			this.className = className;
			this.characterId = characterId;
			this.depth = depth;
		}
	}
}