package swfdata.atlas 
{
	import flash.geom.Rectangle;
	public class Subtexture 
	{
		public var bounds:Rectangle;
		public var id:int;
		public var transform:TextureTransform;
		
		public function Subtexture(id:int, bounds:Rectangle, scaleX:Number, scaleY:Number) 
		{
			this.bounds = bounds;
			this.id = id;
			transform = new TextureTransform(scaleX, scaleY);
		}
	}
}