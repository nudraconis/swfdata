package swfdata.atlas 
{
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	
	public interface ITexture 
	{
		function get u():Number;
		function get v():Number;
		function get uscale():Number;
		function get vscale():Number;
		
		function get width():int;
		function get height():int;
		
		function get id():int;
		function get transform():TextureTransform;
		function get bounds():Rectangle;
		function get gpuData():Texture;
		
		function getAlphaAtUV(u:Number, v:Number):Number;
		
		function get pivotX():Number;
		function set pivotX(value:Number):void;
		function get pivotY():Number;
		function set pivotY(value:Number):void;
	}
}