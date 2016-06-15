package swfdata 
{
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import swfdata.atlas.AtlasDrawer;
	
	public class ShapeLibrary 
	{
		public var shapes:Object = { };
		private var numShapes:int = 0;
		
		public function ShapeLibrary() 
		{
			
		}
		
		public function clear(callDestroy:Boolean = true):void 
		{
			numShapes = 0;
			if (callDestroy)
			{
				for each(var shapeLibraryItem:ShapeLibraryItem in shapes)
				{
					shapeLibraryItem.clear();
				}
			}
			
			shapes = { };
		}
		
		public function addShape(shape:Shape, shapeData:ShapeData):void
		{
			numShapes++;
			
			if (shapes[shapeData.characterId] != null)
				return;
				
			var shapeLibraryItem:ShapeLibraryItem = new ShapeLibraryItem();
			shapeLibraryItem.shape = shape;
			shapeLibraryItem.shapeData = shapeData;
			
			shapes[shapeData.characterId] = shapeLibraryItem;
		}
		
		public function getShape(id:int):ShapeLibraryItem
		{
			return shapes[id];
		}
		
		public function drawToAtlas(atlas:AtlasDrawer, drawAdditionalAA:Boolean):void
		{
			for each(var shapeLibraryItem:ShapeLibraryItem in shapes)
			{
				var shapeData:ShapeData = shapeLibraryItem.shapeData;
				
				var boundRectnagle:Rectangle = atlas.addShape(shapeData.characterId, shapeLibraryItem.shape, shapeData.shapeBounds, shapeLibraryItem.transform, drawAdditionalAA);
				shapeLibraryItem.shape.graphics.clear();
				shapeLibraryItem.shape = null;
				
				if(!shapeLibraryItem.transform.isMultiplierCalculated)
					shapeLibraryItem.transform.recalculate();
					
				//trace("transform", shapeLibraryItem.transform);
				//trace("OLD", shapeData.shapeBounds);
				
				
					
				shapeData.shapeBounds.width = boundRectnagle.width * shapeLibraryItem.transform.positionMultiplierX; //поидеи умножать не надо т.к баунд чек и так выдаст уже нужный размер а приводить его назад не нужено т.к рисоватся то будет такой
				shapeData.shapeBounds.height = boundRectnagle.height * shapeLibraryItem.transform.positionMultiplierY;
				
				shapeData.shapeBounds.x = boundRectnagle.x * shapeLibraryItem.transform.positionMultiplierX;
				shapeData.shapeBounds.y = boundRectnagle.y * shapeLibraryItem.transform.positionMultiplierY;
				
				//trace("NEW", shapeData.shapeBounds);
				//trace(shapeData.shapeBounds, shapeLibraryItem.transform);
				
				//shapeData.resetBound();
			}
		}
	}
}