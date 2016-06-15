package swfdata.atlas 
{
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
		
		/* INTERFACE swfdata.atlas.ITexture */
		
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