package swfdata.atlas.genome 
{
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureManager;
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.geom.Rectangle;
	import swfdata.swfdata_inner;
	import swfdata.atlas.BaseTextureAtlas;
	import swfdata.atlas.TextureTransform;
	import swfdata.atlas.genome.GenomeSubTexture;
	
	use namespace swfdata_inner;

	public class GenomeTextureAtlas extends BaseTextureAtlas 
	{
		public var gTextureAtlas:GTexture;
		public var disposed:Boolean = false;
		public var gpuMemorySize:Number = 0;
		
		public function GenomeTextureAtlas(id:String, data:BitmapData, format:String, padding:Number = 0) 
		{
			super(id, data, padding);
				
			gTextureAtlas = GTextureManager.createTexture(id, data, 1, false, format);
			gpuMemorySize = calculateGPUSize(format, data.width, data.height);
		}
		
		private function calculateGPUSize(format:String, nativeWidth:int, nativeHeight:int):Number
		{
			var pixelsCount:Number = nativeWidth * nativeHeight;
			
			var bytesPerPixel:int = 0;
			
			if (format == Context3DTextureFormat.BGRA)
				bytesPerPixel = 4;
			else if (format == Context3DTextureFormat.BGR_PACKED || format == Context3DTextureFormat.BGRA_PACKED)
				bytesPerPixel = 2;
			else if (format == Context3DTextureFormat.COMPRESSED || format == Context3DTextureFormat.COMPRESSED_ALPHA)
				bytesPerPixel = 2;
			else if (format == Context3DTextureFormat.RGBA_HALF_FLOAT)
				bytesPerPixel = 8;
				
			return (bytesPerPixel * pixelsCount) / 1048576;
		}
		
		public function reupload():void
		{
			gTextureAtlas.invalidateNativeTexture(true);
		}
		
		public function createSubTexture(id:int, region:Rectangle, transformX:Number, transformY:Number):void
		{
			var subTeture:GenomeSubTexture = new GenomeSubTexture(id, region, new TextureTransform(transformX, transformY), this);
				
			putTexture(subTeture);
		}
		
		public function dispose(disposeSource:Boolean = false):void 
		{
			disposed = true;
			//gTextureAtlas.dispose(disposeSource);
			gTextureAtlas.dispose();
		}
	}
}