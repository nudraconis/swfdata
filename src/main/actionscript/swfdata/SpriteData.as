package swfdata 
{
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	
	use namespace swfdata_inner;
	
	public class SpriteData extends DisplayObjectData implements IDisplayObjectContainer
	{
		swfdata_inner var displayContainer:DisplayObjectContainer;
		
		public function SpriteData(characterId:int = -1, displayObjectType:int = DisplayObjectTypes.SPRITE_TYPE, isCreateContainer:Boolean = true, childsCount:int = 0) 
		{
			super(characterId, displayObjectType);
			
			if (isCreateContainer)
				displayContainer = new DisplayObjectContainer(childsCount);
		}
		
		public function get numChildren():int 
		{
			return displayContainer.displayObjectsCount;
		}
		
		override public function destroy():void 
		{
			super.destroy();
			
			if (displayContainer)
			{
				displayContainer.destroy();
				displayContainer = null;
			}
		}
		
		public function update():void
		{
			displayContainer.update();
		}
		
		public function updateMasks():void 
		{
			calculateMasks(this);
		}
		
		protected function calculateMasks(displayObjectContainer:IDisplayObjectContainer):void
		{
			var currentMask:DisplayObjectData;
			
			var displayObjectsCount:int = displayObjectContainer.displayObjects.length;
			for (var i:int = 0; i < displayObjectsCount; i++)
			{
				var currentDisplayObject:DisplayObjectData = displayObjectContainer.displayObjects[i];
				
				if (!currentDisplayObject)
					continue;
					
				if (currentDisplayObject.isMask)
				{
					currentMask = currentDisplayObject;
				}
				else if(currentMask != null && currentDisplayObject.depth <= currentMask.clipDepth)
				{
					currentDisplayObject.mask = currentMask;
				}
			}
		}
		
		override protected function setDataTo(objectCloned:DisplayObjectData):void 
		{
			super.setDataTo(objectCloned);
			
			if (displayContainer != null)
			{
				var objestAsSpriteData:SpriteData = objectCloned as SpriteData;
				objestAsSpriteData.displayContainer = displayContainer//.clone() as DisplayObjectContainer;
			}
		}
		
		override public function clone():DisplayObjectData 
		{
			var objectCloned:SpriteData = new SpriteData(-1, DisplayObjectTypes.SPRITE_TYPE, false);
			setDataTo(objectCloned);
			
			return objectCloned;
		}
		
		/* INTERFACE swfdata.IDisplayObjectContainer */
		
		public function addDisplayObject(displayObjectData:DisplayObjectData):void 
		{
			displayContainer.addDisplayObject(displayObjectData);
		}
		
		//public function getObjectByCharacterId(characterId:int):DisplayObjectData 
		//{
		//	return displayContainer.getObjectByCharacterId(characterId);
		//}
		
		public function gotoAndPlayAll(frameIndex:int):void 
		{
			displayContainer.gotoAndPlayAll(frameIndex);
		}
		
		public function gotoAndStopAll(frameIndex:int):void 
		{
			displayContainer.gotoAndStopAll(frameIndex);
		}
		
		public function getObjectByDepth(depth:int):DisplayObjectData 
		{
			return displayContainer.getObjectByDepth(depth);
		}
		
		public function getChildByName(name:String):DisplayObjectData 
		{
			return displayContainer.getChildByName(name);
		}
		
		public function get displayObjects():Vector.<DisplayObjectData> 
		{
			return displayContainer._displayObjects;
		}
	}
}