package swfdata.atlas.gl 
{
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	import swfdata.swfdata_inner;
	import swfdata.atlas.BaseSubTexture;
	import swfdata.atlas.BaseTextureAtlas;
	import swfdata.atlas.TextureTransform;
	
	use namespace swfdata_inner;

	public class GLTextureAtlas extends BaseTextureAtlas
	{
		public var disposed:Boolean = false;
		
		public var gpuMemorySize:Number = 0;

		public function GLTextureAtlas(id:String, data:BitmapData, format:String, padding:Number = 0) 
		{
			super(id, data, padding);
				
			gpuData = GLTextureManager.createTexture(id, data, 1, false, format);
			gpuData.uploadFromBitmapData(data);
			
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
			//gTextureAtlas.invalidateNativeTexture(true);
		}
		
		public function createSubTexture(id:int, region:Rectangle, transformX:Number, transformY:Number):void
		{
			var subTeture:GLSubTexture = new GLSubTexture(id, region, new TextureTransform(transformX, transformY), this);
				
			putTexture(subTeture);
		}
		
		override public function dispose():void//(disposeSource:Boolean = false):void 
		{
			super.dispose();
			
			disposed = true;
			//gTextureAtlas.dispose(disposeSource);
			//textureAtlas.dispose();
		}
	}
}