package swfdata.atlas.genome 
{
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureManager;
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	import swfdata.swfdata_inner;
	import swfdata.atlas.BaseSubTexture;
	import swfdata.atlas.BaseTextureAtlas;
	import swfdata.atlas.TextureTransform;
	
	use namespace swfdata_inner;
	
	public class GenomeSubTexture extends BaseSubTexture 
	{
		private var idAsString:String;
		public var gTexture:GTexture;
		
		public function GenomeSubTexture(id:int, bounds:Rectangle, transform:TextureTransform, atlas:BaseTextureAtlas) 
		{
			super(id, bounds, transform, atlas);
			
			idAsString = id.toString();
			uploadTexture();
		}
		
		public function uploadTexture():void
		{
			gTexture = GTextureManager.createSubTexture(atlas.id + "::" + idAsString, (atlas as GenomeTextureAtlas).gTextureAtlas, bounds, null, false);
			//gTexture.pivotX = -bounds.width / 2;
			//gTexture.pivotY = -bounds.height / 2;
		}
		
		override public function get gpuData():Texture 
		{
			return gTexture.g2d_nativeTexture as Texture;
		}
	}
}