package swfdata.atlas 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ...
	 */
	public interface ITexture 
	{
		function get id():int;
		function get transform():TextureTransform;
		function get bounds():Rectangle;
	}
	
}