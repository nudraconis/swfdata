package swfdata.atlas.gl 
{
	import flash.display.BitmapData;
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	import swfdata.swfdata_inner;
	import swfdata.atlas.ITexture;
	import swfdata.atlas.TextureTransform;
	
	use namespace swfdata_inner;
	
	public class GLSubTexture implements ITexture 
	{
		private var _id:int;
		private var _bounds:Rectangle;
		private var _transform:TextureTransform;
		
		private var _atlas:GLTextureAtlas;
		
		public var _u:Number = 0;
		public var _v:Number = 0;
		
		public var _uscale:Number = 1;
		public var _vscale:Number = 1;
		
		public var _width:Number;
		public var _height:Number;
		
		private var _pivotX:Number = 0;
		private var _pivotY:Number = 0;
		
		public function GLSubTexture(id:int, bounds:Rectangle, transform:TextureTransform, atlas:GLTextureAtlas, scaleFactor:Number = 1) 
		{
			_id = id;
			_bounds = bounds;
			_transform = transform;
			_atlas = atlas;
			
			_width = _bounds.width * scaleFactor;
			_height = _bounds.height * scaleFactor;
			
			_u = _bounds.x / atlas.atlasData.width;
			_v = _bounds.y / atlas.atlasData.height;
			
			_uscale = _width / atlas.atlasData.width;
			_vscale = _height / atlas.atlasData.height;
		}
		
		public function getAlphaAtUV(u:Number, v:Number):Number
		{
			var bitmapData:BitmapData = _atlas.atlasData;
			
			if (bitmapData == null)  
				return 255;
				
			u = (u * width) / bitmapData.width;
			v = (v * height) / bitmapData.height;
			
			return bitmapData.getPixel32(int((_u + u) * bitmapData.width), int((_v + v) * bitmapData.height)) >> 24 & 0xFF;
		}	
		
		public function get u():Number 
		{
			return _u;
		}
		
		public function get v():Number 
		{
			return _v;
		}
		
		public function get uscale():Number 
		{
			return _uscale;
		}
		
		public function get vscale():Number 
		{
			return _vscale;
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function get height():int 
		{
			return _height;
		}
		
		public function get gpuData():Texture 
		{
			return _atlas.gpuData;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function get bounds():Rectangle 
		{
			return _bounds;
		}
		
		public function set bounds(value:Rectangle):void 
		{
			_bounds = value;
		}
		
		public function get transform():TextureTransform 
		{
			return _transform;
		}
		
		public function set transform(value:TextureTransform):void 
		{
			_transform = value;
		}
		
		public function get pivotX():Number 
		{
			return _pivotX;
		}
		
		public function set pivotX(value:Number):void 
		{
			_pivotX = value;
		}
		
		public function get pivotY():Number 
		{
			return _pivotY;
		}
		
		public function set pivotY(value:Number):void 
		{
			_pivotY = value;
		}
	}
}