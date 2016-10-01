package swfdata.atlas.gl 
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	import swfdata.swfdata_inner;
	import swfdata.atlas.BaseSubTexture;
	import swfdata.atlas.TextureTransform;
	
	use namespace swfdata_inner;
	
	public class GLSubTexture extends BaseSubTexture 
	{
		private var _atlas:GLTextureAtlas;
		
		public function GLSubTexture(id:int, bounds:Rectangle, transform:TextureTransform, atlas:GLTextureAtlas, scaleFactor:Number = 1) 
		{
			super(id, bounds, transform, atlas, scaleFactor);
			
			_atlas = atlas;
		}
	}
}