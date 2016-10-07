package swfdata 
{
	use namespace swfdata_inner;
	
	public class Timeline implements ITimeline, ITimelineContainer, IUpdatable
	{
		private var _isPlaying:Boolean = true;
		public var frames:Vector.<FrameData>;
		
		public var labelsCount:int = 0;
		public var lablesMap:Object = {};
		public var labelsSize:Object = {};
		
		swfdata_inner var _currentFrame:int = 0;
		swfdata_inner var _currentFrameData:FrameData;
		
		public var _framesCount:int = 0;
		
		private var currentLable:String;
		
		public function Timeline(framesCount:int) 
		{
			_framesCount = framesCount;
			frames = new Vector.<FrameData>(_framesCount, true);
			
			_currentFrameData = frames[_currentFrame];
		}
		
		public function destroy():void 
		{
			lablesMap = null;
			labelsSize = null;
			currentLable = null;
			
			if (frames)
			{
				var framesCount:int = frames.length;
				for (var i:int = 0; i < framesCount; i++)
				{
					frames[i].destroy();
				}
				
				frames = null;
			}
		}
		
		public function getLabelSize(label:String):int
		{
			return labelsSize[label];
		}
		
		public function hasFrame(label:String):Boolean
		{
			return lablesMap[label] != null;
		}
		
		public function setLabel(labelKey:String, startFrame:int, framesCount:int):void 
		{
			if (lablesMap[labelKey] != null)
				return;
				
			frames[startFrame].frameLabel = labelKey;
			
			labelsSize[labelKey] = framesCount;
			lablesMap[labelKey] = startFrame;
			labelsCount++;
		}
		
		public function addFrame(frameData:FrameData):void 
		{
			if (frameData.frameLabel != null)
			{
				currentLable = frameData.frameLabel;
				
				labelsSize[currentLable] = 0;
				lablesMap[frameData.frameLabel] = frameData.frameIndex;
				labelsCount++;
			}
			
			if (currentLable)
				labelsSize[currentLable]++;
				
			frames[frameData.frameIndex] = frameData;
			
			if (!_currentFrameData)
				_currentFrameData = frameData;
		}
		
		public function gotoAndPlayAll(frameIndex:int):void 
		{
			gotoAndPlay(frameIndex);
			
			for (var i:int = 0; i < _framesCount; i++)
			{
				frames[i].gotoAndPlayAll(frameIndex);
			}
		}
		
		public function gotoAndStopAll(frameIndex:int):void 
		{
			gotoAndStop(frameIndex);
			
			for (var i:int = 0; i < _framesCount; i++)
			{
				frames[i].gotoAndStopAll(frameIndex);
			}
		}
		
		public function play():void 
		{
			this._isPlaying = true;
			_currentFrameData = frames[_currentFrame];
		}
		
		public function gotoAndPlay(frame:Object):void 
		{
			play();
			setFrameByObject(frame);
		}
		
		public function stop():void 
		{
			this._isPlaying = false;
		}
		
		public function gotoAndStop(frame:Object):void 
		{
			stop();
			setFrameByObject(frame);
		}
		
		public function nextFrame():void 
		{
			_currentFrame++;
			
			if (_currentFrame >= _framesCount)
				_currentFrame = 0;
				
			_currentFrameData = frames[_currentFrame];
		}
		
		public function prevFrame():void 
		{
			_currentFrame--;
			
			if (_currentFrame < 0)
				_currentFrame = _framesCount - 1;
				
			_currentFrameData = frames[_currentFrame];
		}
		
		[Inline]
		public final function setFrameByObject(frame:Object):void
		{
			if (frame is String)
				_currentFrame = lablesMap[frame];
			else
			{
				_currentFrame = int(frame);
			}
			
			if (_currentFrame >= _framesCount)
			{
				_currentFrame = _framesCount-1;
				//throw new Error("end of frame bounds reach");
			}
			
			_currentFrameData = frames[_currentFrame];
		}
		
		public function update():void 
		{
			if (_isPlaying)
				nextFrame();
				
			var displayObjectsList:Vector.<DisplayObjectData> = _currentFrameData._displayObjects;
			var displayObjectsCount:int = _currentFrameData.displayObjectsPlacedCount;
			
			for (var i:int = 0 ; i < displayObjectsCount; i++)
			{
				var currentDisplayObject:IUpdatable = displayObjectsList[i] as IUpdatable;
				
				if (currentDisplayObject != null)
					currentDisplayObject.update();
			}
		}
		
		public function currentFrameData():FrameData 
		{
			return _currentFrameData;
		}
		
		public function advanceFrame(delta:int):void 
		{
			_currentFrame+= delta;
			
			if (_currentFrame < 0)
				_currentFrame = _framesCount-1;
				
			if (_currentFrame >= _framesCount)
				_currentFrame = 0;
				
			_currentFrameData = frames[_currentFrame];
		}
		
		public function get framesCount():int 
		{
			return _framesCount;
		}
		
		public function get currentFrame():int 
		{
			return _currentFrame;
		}
		
		public function get isPlaying():Boolean 
		{
			return _isPlaying;
		}
	}
}