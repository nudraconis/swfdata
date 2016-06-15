package swfdata 
{
	public interface IDisplayObjectContainer extends ITimelineContainer, IUpdatable
	{
		function get numChildren():int;
		
		function addDisplayObject(displayObjectData:DisplayObjectData):void;
		
		function getObjectByDepth(depth:int):DisplayObjectData;
		
		//function getObjectByCharacterId(characterId:int):DisplayObjectData;
		
		function getChildByName(name:String):DisplayObjectData
		
		function get displayObjects():Vector.<DisplayObjectData>
	}
}