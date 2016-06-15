package swfdata.atlas 
{
	import flash.geom.Rectangle;
	
	public interface ITextureAtlas 
	{
		/**
		 * put sub-texture in to atlas by specified id (ITexture.id)
		 * @param	texture
		 */
		function putTexture(texture:ITexture):void;
		
		/**
		 * return sub-texture from atlas by specified id
		 * @param	textureId
		 * @return
		 */
		function getTexture(textureId:int):ITexture;
		
		function createSubTexture(id:int, region:Rectangle, scaleX:Number, scaleY:Number):void;
		
		function set padding(value:Number):void;
		
		function get padding():Number;
	}
	
}