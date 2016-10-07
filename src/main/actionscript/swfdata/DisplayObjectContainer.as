package swfdata 
{
	use namespace swfdata_inner;
	
	public class DisplayObjectContainer implements IDisplayObjectContainer
	{
		swfdata_inner var _displayObjects:Vector.<DisplayObjectData>;
		
		swfdata_inner var displayObjectsCount:int = 0; //NOTE: это значение только для задание начальной длинны вектора
		swfdata_inner var displayObjectsPlacedCount:int = 0;
		
		//public var depthMap:Object;
		//public var charactersMap:Object = { };
		
		private var depthAndCharactersMapInitialize:Boolean = false;
		
		public function DisplayObjectContainer(displayObjectsCount:int = 0) 
		{
			this.displayObjectsCount = displayObjectsCount;
			_displayObjects = new Vector.<DisplayObjectData>(displayObjectsCount, false);
		}
		
		public function get numChildren():int
		{
			return displayObjectsPlacedCount;
		}
		
		public function destroy():void 
		{
			//depthMap = null;
			
			if (_displayObjects)
			{
				for (var i:int = 0; i < displayObjectsCount; i++)
				{
					if(_displayObjects[i])
						_displayObjects[i].destroy();
				}
				
				_displayObjects = null;
			}
		}
		
		public function addDisplayObject(displayObjectData:DisplayObjectData):void 
		{
			//if (!depthAndCharactersMapInitialize)
			//{
				//depthMap = {};
				//charactersMap = {};
				//depthAndCharactersMapInitialize = true;
			//}
			
			_displayObjects[displayObjectsPlacedCount++] = displayObjectData;
			
			
			//TODO если понадобится реально то нужно придумать что то получше
			//depthMap[displayObjectData.depth] = displayObjectData;
			//charactersMap[displayObjectData.characterId] = displayObjectData;
		}
		
		public function getObjectByDepth(depth:int):DisplayObjectData 
		{
			return null;
			//return depthMap? depthMap[depth]:null;
		}
		
		public function getChildByName(name:String):DisplayObjectData 
		{
			var currentDisplayObject:DisplayObjectData;
			var i:int;

			var currentDisplayList:Vector.<DisplayObjectData> = _displayObjects;
			var childsCount:int = displayObjectsPlacedCount;

			for (i = 0; i < childsCount; i++)
			{
				currentDisplayObject = currentDisplayList[i];

				if (currentDisplayObject.name == name)
					return currentDisplayObject;
			}

			for (i = 0; i < childsCount; i++)
			{
				currentDisplayObject = currentDisplayList[i];

				if (currentDisplayObject is IDisplayObjectContainer)
					return (currentDisplayObject as IDisplayObjectContainer).getChildByName(name);
			}

			return null;
		}
		
		//public function getObjectByCharacterId(characterId:int):DisplayObjectData 
		//{
		//	return charactersMap? charactersMap[characterId]:null;
		//}
		
		public function gotoAndPlayAll(frameIndex:int):void 
		{
			for (var i:int = 0; i < displayObjectsPlacedCount; i++)
			{
				if (_displayObjects[i] is ITimelineContainer)
				{
					(_displayObjects[i] as ITimelineContainer).gotoAndPlayAll(frameIndex);
				}
			}
		}
		
		public function gotoAndStopAll(frameIndex:int):void 
		{
			for (var i:int = 0; i < displayObjectsPlacedCount; i++)
			{
				var displayObjectAsTimeLine:ITimelineContainer = _displayObjects[i] as ITimelineContainer;
				if (displayObjectAsTimeLine)
					displayObjectAsTimeLine.gotoAndStopAll(frameIndex);
			}
		}
		
		public function update():void 
		{
			for (var i:int = 0; i < displayObjectsPlacedCount; i++)
			{
				var displayObjectAsUpdatable:IUpdatable = _displayObjects[i] as IUpdatable;
				
				if (displayObjectAsUpdatable != null)
					displayObjectAsUpdatable.update();
			}
		}
		
		protected function fillData(obj:DisplayObjectContainer):void
		{
			var objDisplayObjects:Vector.<DisplayObjectData> = obj.displayObjects;
			for (var i:int = 0; i < displayObjectsPlacedCount; i++)
			{
				//obj.displayObjects.push(_displayObjects[i].clone());
				objDisplayObjects[i] = _displayObjects[i];
			}
			
			obj.displayObjectsCount = displayObjectsCount;
			obj.displayObjectsPlacedCount = displayObjectsCount;
		}
		
		public function clone():IDisplayObjectContainer
		{
			var objectCloned:DisplayObjectContainer = new DisplayObjectContainer(displayObjectsCount);
			
			fillData(objectCloned);
			
			return objectCloned;
		}
		
		public function get displayObjects():Vector.<DisplayObjectData> 
		{
			return _displayObjects;
		}
	}
}