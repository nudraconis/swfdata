package swfdata 
{
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	use namespace swfdata_inner;
	
	public class ShapeData extends DisplayObjectData
	{
		public var tx:Number;
		public var ty:Number;
		
		swfdata_inner var _shapeBounds:Rectangle;
		
		public var normalized:Boolean;
		
		public var usedCount:int = 0;
		
		public function ShapeData(characterId:int = -1, shapeBounds:Rectangle = null) 
		{
			super(characterId, DisplayObjectTypes.SHAPE_TYPE);
			
			_shapeBounds = shapeBounds;
			//if (shapeBounds)
			//{
			//	this.shapeBounds = shapeBounds;
			//}
		}
		
		override public function destroy():void 
		{
			super.destroy();
			_shapeBounds = null;
		}
		
		//public function normalizeBounds():void
		//{
		//	return
		//	normalized = true;
		//	
		//	transform.tx += tx;
		//	transform.ty += ty;
		//	
		//	bounds.applyTransform();
		//}
		
		public function resetBound():void
		{
			//bounds.setTo(_shapeBounds.x, _shapeBounds.y, _shapeBounds.width, _shapeBounds.height);
		}
		
		public function get shapeBounds():Rectangle 
		{
			return _shapeBounds;
		}
		
		public function set shapeBounds(value:Rectangle):void 
		{
			_shapeBounds = value;
			
			//if (value)
			//{
				//bounds.setTo(_shapeBounds.x, _shapeBounds.y, _shapeBounds.width, _shapeBounds.height);
			//}
		}
		
		override protected function setDataTo(objectCloned:DisplayObjectData):void 
		{
			super.setDataTo(objectCloned);
			
			var objectAsShapeData:ShapeData = objectCloned as ShapeData;
			
			objectAsShapeData.shapeBounds = _shapeBounds;
			
			objectAsShapeData.tx = tx;
			objectAsShapeData.ty = ty;
			//(objectCloned as ShapeData).normalized = normalized;
		}
		
		override public function clone():DisplayObjectData 
		{
			var objectCloned:ShapeData = new ShapeData();
			setDataTo(objectCloned)
			
			return objectCloned;
		}
		
	
	}
}