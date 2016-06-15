package swfdata 
{
	
	public interface ITimelineContainer 
	{
		function gotoAndPlayAll(frameIndex:int):void;
		
		function gotoAndStopAll(frameIndex:int):void;
		
		
	}
}