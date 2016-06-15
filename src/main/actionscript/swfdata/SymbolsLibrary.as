package swfdata 
{
	/**
	 * Библиотека символов, шейпы, спрайты и тд по чар идам или линкейджам 
	 */
	public class SymbolsLibrary 
	{
		private var __library:Object = { };
		private var __linkagesLibrary:Object = { };
		
		public var shapesList:Vector.<ShapeData> = new Vector.<ShapeData>;
		
		public var spritesList:Vector.<SpriteData> = new Vector.<SpriteData>;
		public var linkagesList:Vector.<SpriteData> = new Vector.<SpriteData>;
		
		public function SymbolsLibrary() 
		{
			
		}
		
		public function clear(callDestroy:Boolean = true):void 
		{
			var i:int;
			
			
			if (callDestroy)
			{
				var shapesCount:int = shapesList.length;
				for (i = 0; i < shapesCount; i++)
				{
					shapesList[i].destroy();
				}
				
				var spritesCount:int = spritesList.length;
				for (i = 0; i < spritesCount; i++)
				{
					spritesList[i].destroy();
				}
				
				var linagesCount:int = linkagesList.length;
				for (i = 0; i < linagesCount; i++)
				{
					linkagesList[i].destroy();
				}
				
				for each(var dObject:DisplayObjectData in __library)
					dObject.destroy();
					
				for each(var dObject2:DisplayObjectData in __linkagesLibrary)
					dObject2.destroy();
			}
			
			__library = { };
			__linkagesLibrary = { };
			
			shapesList.length = 0;
			spritesList.length = 0;
			linkagesList.length = 0;
		}
		
		public function addDisplayObject(displayObject:DisplayObjectData):void
		{
			if (displayObject is ShapeData)
				shapesList.push(displayObject);
				
			//if (displayObject is SpriteData)
			//	spritesList.push(displayObject);
				
			__library[displayObject.characterId] = displayObject;
		}
		
		public function getDisplayObject(characterId:int):DisplayObjectData
		{
			return __library[characterId];
		}
		
		public function addDisplayObjectByLinkage(displayObject:DisplayObjectData):void 
		{
			//if (displayObject is SpriteData)
				spritesList.push(displayObject);
				
			linkagesList.push(displayObject);	
			__linkagesLibrary[displayObject.libraryLinkage] = displayObject;
		}
		
		public function getDisplayObjectByLinkage(libraryLinkage:String):DisplayObjectData 
		{
			return __linkagesLibrary[libraryLinkage];
		}
		
		public function addShapes(shapeLibrary:ShapeLibrary):void 
		{
			for each(var shapeData:ShapeLibraryItem in shapeLibrary.shapes)
			{
				addDisplayObject(shapeData.shapeData);
			}
		}
	}
}