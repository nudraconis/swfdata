package swfdata.atlas 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	
	/**
	 * Для дебага и промежуточного состояния при формировании атласа пакером
	 */
	public class BitmapTextureAtlas implements ITextureAtlas
	{
		private var width:Number;
		private var height:Number;
		public var atlasData:BitmapData;
		
		public var texturesCount:int = 0;
		public var subTextures:Object = {};
		
		private var _padding:Number = 0;
		
		public function BitmapTextureAtlas(width:Number, height:Number, padding:Number = 0) 
		{
			this.height = height;
			this.width = width;
			_padding = padding;
			
			atlasData = new BitmapData(width, height, true, 0x0);
		}
		
		/**
		 * @inheritDoc
		 */
		public function getTexture(textureId:int):ITexture 
		{
			return subTextures[textureId]
		}
		
		/**
		 * @inheritDoc
		 */
		public function putTexture(texture:ITexture):void
		{
			texturesCount++;
			subTextures[texture.id] = texture;
		}
		
		public function createSubTexture(id:int, region:Rectangle, scaleX:Number, scaleY:Number):void 
		{
			var subTexture:BitmapSubTexture = new BitmapSubTexture(id, region, new TextureTransform(scaleX, scaleY));
			putTexture(subTexture);
		}
		
		public function refrash():void 
		{
			subTextures = { };
			atlasData.fillRect(atlasData.rect, 0x0);
		}
		
		public function clear():void 
		{
			subTextures = null;
			//atlasData.dispose();
			//atlasData = null;
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