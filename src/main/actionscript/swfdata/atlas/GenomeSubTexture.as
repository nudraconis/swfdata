package swfdata.atlas 
{
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureManager;
	import flash.geom.Rectangle;
	import swfdata.swfdata_inner;
	
	use namespace swfdata_inner;
	
	public class GenomeSubTexture implements ITexture 
	{
		private var _id:int;
		private var idAsString:String;
		swfdata_inner var _transform:TextureTransform;
		private var _bounds:Rectangle;
		
		private var atlas:GTexture;
		
		public var gTexture:GTexture;
		
		public function GenomeSubTexture(id:int, bounds:Rectangle, transform:TextureTransform, atlas:GTexture) 
		{
			this.atlas = atlas;
			
			_bounds = bounds;
			_id = id;
			idAsString = id.toString();
			_transform = transform;
			
			uploadTexture();
		}
		
		public function uploadTexture():void
		{
			gTexture = GTextureManager.createSubTexture(atlas.id + "::" + idAsString, atlas, _bounds, null, false);
			//gTexture.pivotX = -bounds.width / 2;
			//gTexture.pivotY = -bounds.height / 2;
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