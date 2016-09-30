package swfdata.atlas.gl 
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.display3D.textures.Texture;
	import starling.core.Starling;
	
	public class GLTextureManager 
	{
		private static var _instance:GLTextureManager;
		
		static public function get instance():GLTextureManager 
		{
			if (_instance == null)
				_instance = new GLTextureManager();
				
			return _instance;
		}
		
		public function GLTextureManager() 
		{
			
		}
		
		static public function createTexture(id:String, atlasData:BitmapData, number:Number, optimezeForRender:Boolean, format:String):Texture 
		{
			return Starling.context.createTexture(atlasData.width, atlasData.height, format, optimezeForRender, 0);
		}
	}
}