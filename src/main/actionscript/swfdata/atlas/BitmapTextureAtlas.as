package swfdata.atlas 
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	
	/**
	 * Для дебага и промежуточного состояния при формировании атласа пакером
	 */
	public class BitmapTextureAtlas extends BaseTextureAtlas
	{	
		public function BitmapTextureAtlas(width:Number, height:Number, padding:Number = 0) 
		{
			super(id, new BitmapData(width, height, true, 0x0), padding);
		}
		
		public function createSubTexture(id:int, region:Rectangle, scaleX:Number, scaleY:Number):void 
		{
			var subTexture:BitmapSubTexture = new BitmapSubTexture(id, region, new TextureTransform(scaleX, scaleY));
			putTexture(subTexture);
		}
		
		public function refrash():void 
		{
			subTextures = { };
			data.fillRect(data.rect, 0x0);
		}
	}
}