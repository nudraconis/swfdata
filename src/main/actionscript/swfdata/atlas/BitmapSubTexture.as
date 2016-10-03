package swfdata.atlas 
{
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	
	public class BitmapSubTexture extends BaseSubTexture
	{
		public function BitmapSubTexture(id:int, bounds:Rectangle, transform:TextureTransform) 
		{
			super(id, bounds, transform, null, 1);
		}		
	}
}