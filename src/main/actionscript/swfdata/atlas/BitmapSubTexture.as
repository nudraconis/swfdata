package swfdata.atlas 
{
	import flash.display3D.textures.Texture;
	import flash.geom.Rectangle;
	
	public class BitmapSubTexture implements ITexture
	{
		private var _bounds:Rectangle;
		private var _id:int;
		private var _transform:TextureTransform;
		
		public function BitmapSubTexture(id:int, bounds:Rectangle, transform:TextureTransform) 
		{
			_bounds = bounds;
			_id = id;
			_transform = transform;
		}
		
		public function get width():int 
		{
			return bounds.width;
		}
		
		public function get height():int 
		{
			return bounds.height;
		}
		
		public function get gpuData():Texture 
		{
			return null;
		}
		
		public function getAlphaAtUV(u:Number, v:Number):Number
		{
			return null;
		}	
		
		public function get pivotX():Number 
		{
			return 0;
		}
		
		public function set pivotX(value:Number):void 
		{
			
		}
		
		public function get pivotY():Number 
		{
			return 0;
		}
		
		public function set pivotY(value:Number):void 
		{
			
		}
		
		public function get u():Number 
		{
			return 0;
		}
		
		public function get v():Number 
		{
			return 0;
		}
		
		public function get uscale():Number 
		{
			return 0;
		}
		
		public function get vscale():Number 
		{
			return 0;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function get transform():TextureTransform 
		{
			return _transform;
		}
		
		public function get bounds():Rectangle 
		{
			return _bounds;
		}
	}
}