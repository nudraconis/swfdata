package swfdata.atlas 
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	
	public class BaseTextureAtlas 
	{
		public var id:String;
		public var data:BitmapData;
		public var padding:Number = 0;
		
		public var width:Number;
		public var height:Number;
		
		public var gpuData:Texture;
		
		public var texturesCount:int = 0;
		public var subTextures:Object = { };
		
		public function BaseTextureAtlas(id:String, data:BitmapData, padding:Number = 0) 
		{
			this.data = data;
			this.id = id;
			this.padding = padding;
			
			setData(data);
		}
		
		public function dispose():void 
		{
			if (data)
			{
				data.dispose();
				data = null;
			}
			
			texturesCount = 0;
			subTextures = null;
		}
		
		public function setData(data:BitmapData):void 
		{
			this.data = data;
			
			if (data)
			{
				width = data.width;
				height = data.height;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTexture(textureId:int):BaseSubTexture 
		{
			return subTextures[textureId];
		}
		
		/**
		 * @inheritDoc
		 */
		public function putTexture(texture:BaseSubTexture):void
		{
			texturesCount++;
			subTextures[texture.id] = texture;
		}
		
		public function clear():void 
		{
			subTextures = null;
		}
		
		public function getAlphaAtUV(u:Number, v:Number):Number 
		{
			return data.getPixel32(u * width, v * height) >> 24 & 0xFF;
		}
	}
}