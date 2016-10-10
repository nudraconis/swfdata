package swfdata 
{
	use namespace swfdata_inner;
	
	public class MovieClipData extends SpriteData implements ITimeline
	{
		//TODO: нужно экстендить дисплей обжект, и имплементить таймлайн, таймлайн в свою очередь должен имплементить контейнер и отдавтаь дату текущего кадра по интерфейсу контейнера
		public var timeline:Timeline;
		
		swfdata_inner var _currentFrameData:FrameData;
		
		public function MovieClipData(characterId:int = -1, framesCount:int = 0) 
		{
			super(characterId, DisplayObjectTypes.MOVIE_CLIP_TYPE, false);
			
			if (framesCount > 0)
			{
				timeline = new Timeline(framesCount);
				_currentFrameData = timeline._currentFrameData;
			}
		}
		
		public function invalidateCurrentFrame():void
		{
			_currentFrameData = timeline._currentFrameData;
		}
		
		override public function get numChildren():int 
		{
			return _currentFrameData.displayObjectsPlacedCount;
		}
		
		override public function destroy():void 
		{
			super.destroy();
			
			if(timeline)
				timeline.destroy();
				
			timeline = null;
		}
		
		override public function updateMasks():void 
		{
			calculateMasks(timeline._currentFrameData);
		}
		
		public function getFrameByIndex(index:int):FrameData
		{
			return timeline.frames[index];
		}
		
		public function nextFrame():void 
		{
			timeline.nextFrame();
			_currentFrameData = timeline._currentFrameData;
		}
		
		public function prevFrame():void 
		{
			timeline.prevFrame();
			_currentFrameData = timeline._currentFrameData;
		}
		
		public function get framesCount():int 
		{
			return timeline.framesCount;
		}
		
		public function get currentFrame():int 
		{
			return timeline._currentFrame;
		}
		
		public function addFrame(frameData:FrameData):void 
		{
			timeline.addFrame(frameData);
			_currentFrameData = timeline._currentFrameData;
		}
		
		public function play():void 
		{
			timeline.play();
			_currentFrameData = timeline._currentFrameData;
		}
		
		public function gotoAndPlay(frame:Object):void 
		{
			timeline.gotoAndPlay(frame);
			_currentFrameData = timeline._currentFrameData;
		}
		
		override public function gotoAndPlayAll(frameIndex:int):void 
		{
			timeline.gotoAndPlayAll(frameIndex);
			_currentFrameData = timeline._currentFrameData;
		}
		
		public function stop():void 
		{
			timeline.stop();
			_currentFrameData = timeline._currentFrameData;
		}
		
		public function gotoAndStop(frame:Object):void
		{
			timeline.gotoAndStop(frame);
			_currentFrameData = timeline._currentFrameData;
		}
		
		override public function gotoAndStopAll(frameIndex:int):void 
		{
			timeline.gotoAndStopAll(frameIndex);
			_currentFrameData = timeline._currentFrameData;
		}
		
		public function get isPlaying():Boolean 
		{
			return timeline.isPlaying;
		}
		
		//public function getFrameBounds(frameIndex:int = 0):Rectagon
		//{
			/*var frameData:FrameData = timeline.currentFrameData();
			
			childsBoundUnion.clear();
			
			for (var i:int = 0; i < frameData.displayObjects.length; i++)
			{
				var currentDisplayObject:DisplayObjectData = frameData.displayObjects[i];
				
				var currentChildBound:Rectagon;
				
				if (currentDisplayObject is ShapeData)
					currentChildBound = (currentDisplayObject as ShapeData).bounds//.clone();
				
				childsBoundUnion.union(currentChildBound);
			}
			
			return childsBoundUnion;*/
			
		//	return null;
		//}
		
		override public function get displayObjects():Vector.<DisplayObjectData> 
		{
			return _currentFrameData._displayObjects;
		}
		
		public function get currentFrameData():FrameData 
		{
			return _currentFrameData;
		}
		
		override public function addDisplayObject(displayObjectData:DisplayObjectData):void 
		{
			_currentFrameData.addDisplayObject(displayObjectData);
		}
		
		override public function getObjectByDepth(depth:int):DisplayObjectData
		{
			//var currentFrame:FrameData = timeline._currentFrameData;
			//return currentFrame.getObjectByDepth(depth);
			throw new Error("getObjectByDepth not implemented");
			return null;
		}
		
		override public function getChildByName(name:String):DisplayObjectData
		{	
			var currentDisplayObject:DisplayObjectData;
			var i:int;
			
			var currentFrameData:FrameData = _currentFrameData;
			
			if (currentFrameData == null)
				currentFrameData = timeline._currentFrameData;
			
			var currentDisplayList:Vector.<DisplayObjectData> = currentFrameData.displayObjects;
			var frameChildsCount:int = _currentFrameData.displayObjectsPlacedCount;
			
			for (i = 0; i < frameChildsCount; i++)
			{
				currentDisplayObject = currentDisplayList[i];
				
				if (currentDisplayObject.name == name)
					return currentDisplayObject;
			}
			
			for (i = 0; i < frameChildsCount; i++)
			{
				currentDisplayObject = currentDisplayList[i];
				
				if (currentDisplayObject is IDisplayObjectContainer)
					return (currentDisplayObject as IDisplayObjectContainer).getChildByName(name);
			}
			
			return null;
		}
		
		override public function update():void 
		{
			timeline.update();
			_currentFrameData = timeline._currentFrameData;
		}
		
		public function advanceFrame(delta:int):void 
		{
			timeline.advanceFrame(delta);
			_currentFrameData = timeline._currentFrameData;
		}
		
		override protected function setDataTo(objectCloned:DisplayObjectData):void 
		{
			super.setDataTo(objectCloned);
			
			var objestAsSpriteData:MovieClipData = objectCloned as MovieClipData;
			objestAsSpriteData.timeline = timeline;
			_currentFrameData = timeline._currentFrameData;
		}
		
		[Inline]
		public final function inlineClone():DisplayObjectData
		{
			var objectCloned:MovieClipData = new MovieClipData(-1, 0);
			setDataTo(objectCloned);
			
			return objectCloned;
		}
		
		override public function clone():DisplayObjectData 
		{
			var objectCloned:MovieClipData = new MovieClipData(-1, 0);
			setDataTo(objectCloned);
			
			return objectCloned;
		}	
	}
}