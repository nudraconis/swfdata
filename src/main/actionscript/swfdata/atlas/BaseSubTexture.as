package swfdata.atlas 
{
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	
	public class BaseSubTexture 
	{
		public var id:int;
		public var bounds:Rectangle;
		public var transform:TextureTransform;
		
		public var atlas:BaseTextureAtlas;
		
		public var u:Number = 0;
		public var v:Number = 0;
		
		public var uscale:Number = 1;
		public var vscale:Number = 1;
		
		public var width:Number;
		public var height:Number;
		
		public var pivotX:Number = 0;
		public var pivotY:Number = 0;
		
		public function BaseSubTexture(id:int, bounds:Rectangle, transform:TextureTransform, atlas:BaseTextureAtlas, scaleFactor:Number = 1) 
		{
			this.id = id;
			this.bounds = bounds;
			this.transform = transform;
			this.atlas = atlas;
			
			this.width = bounds.width * scaleFactor;
			this.height = bounds.height * scaleFactor;
			
			if (atlas)
			{
				this.u = bounds.x / atlas.width;
				this.v = bounds.y / atlas.height;
				
				this.uscale = width / atlas.width;
				this.vscale = height / atlas.height;
			}
		}
		
		public function get gpuData():Texture 
		{
			return atlas.gpuData;
		}
		
		public function getAlphaAtUV(u:Number, v:Number):Number
		{
			if (atlas.data == null)  
				return 255;
			
			u = (u * width) / atlas.width;
			v = (v * height) / atlas.height;
			
			return atlas.getAlphaAtUV(this.u + u, this.v + v);
		}	
	}
}