package swfdata 
{
	public interface ITimeline extends ITimelineContainer
	{
		function play():void;
		function gotoAndPlay(frame:Object):void;
		
		function stop():void;
		function gotoAndStop(frame:Object):void;
		
		function nextFrame():void;
		function prevFrame():void;
		
		function get framesCount():int;
		function get currentFrame():int;
		
		function addFrame(frameData:FrameData):void
		
		function advanceFrame(delta:int):void;
		
		function get isPlaying():Boolean;
	}
}