package swfdata.atlas.genome 
{
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureManager;
	import flash.display.BitmapData;
	import flash.display3D.Context3DTextureFormat;
	import flash.geom.Rectangle;
	import swfdata.swfdata_inner;
	import swfdata.atlas.ITexture;
	import swfdata.atlas.ITextureAtlas;
	import swfdata.atlas.TextureTransform;
	import swfdata.atlas.genome.GenomeSubTexture;
	
	use namespace swfdata_inner;

	public class GenomeTextureAtlas implements ITextureAtlas 
	{
		public var gTextureAtlas:GTexture;
		public var atlasData:BitmapData;
		public var disposed:Boolean = false;
		
		public var gpuMemorySize:Number = 0;
		
		private var subTextures:Object = { };
		
		swfdata_inner var _padding:Number = 0;
		
		public function GenomeTextureAtlas(id:String, atlasData:BitmapData, format:String, padding:Number = 0) 
		{
			this.atlasData = atlasData;
			this._padding = padding;
				
			gTextureAtlas = GTextureManager.createTexture(id, atlasData, 1, false, format);
			gpuMemorySize = calculateGPUSize(format, atlasData.width, atlasData.height);
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
			var subTeture:GenomeSubTexture = new GenomeSubTexture(id, region, new TextureTransform(transformX, transformY), gTextureAtlas);
				
			putTexture(subTeture);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTexture(textureId:int):ITexture 
		{
			return subTextures[textureId];
		}
		
		/**
		 * @inheritDoc
		 */
		public function putTexture(texture:ITexture):void
		{
			subTextures[texture.id] = texture;
		}
		
		public function dispose(disposeSource:Boolean = false):void 
		{
			disposed = true;
			//gTextureAtlas.dispose(disposeSource);
			gTextureAtlas.dispose();
		}
		
		public function get padding():Number 
		{
			return _padding;
		}
		
		public function set padding(value:Number):void 
		{
			_padding = value;
		}
		
	}

}