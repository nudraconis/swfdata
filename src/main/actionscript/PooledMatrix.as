package 
{
	import flash.geom.Matrix;
	
	public class PooledMatrix extends Matrix 
	{
		private static var availableInstance:PooledMatrix;
		
		[Inline]
		public static function get(a:Number, b:Number, c:Number, d:Number, tx:Number, ty:Number):PooledMatrix 
		{
			var instance:PooledMatrix = PooledMatrix.availableInstance;
			
			if (instance != null) 
			{
				PooledMatrix.availableInstance = instance.nextInstance;
				instance.nextInstance = null;
				instance.disposed = false;
				
				instance.setTo(a, b, c, d, tx, ty);
			}
			else 
			{
				instance = new PooledMatrix(a, b, c, d, tx, ty);
			}
			
			return instance;
		}
		
		public var disposed:Boolean = false;
		public var nextInstance:PooledMatrix;
		
		public function PooledMatrix(a:Number, b:Number, c:Number, d:Number, tx:Number, ty:Number) 
		{
			super(a, b, c, d, tx, ty);
		}
		
		[Inline]
		public final function dispose():void 
		{
			if (disposed)
				return;
				
			this.nextInstance = PooledMatrix.availableInstance;
			PooledMatrix.availableInstance = this;
			
			disposed = true;
		}
		
		[Inline]
		override final public function concat(m:Matrix):void 
		{
			var ma:Number = m.a;
			var mb:Number = m.b;
			var mc:Number = m.c;
			var md:Number = m.d;
			var mtx:Number = m.tx;
			var mty:Number = m.ty;
			
			var a1:Number = a * ma + b * mc;
			b = a * mb + b * md;
			a = a1;
			
			var c1:Number = c * ma + d * mc;
			d = c * mb + d * md;
			c = c1;
			
			var tx1:Number = tx * ma + ty * mc + mtx;
			ty = tx * mb + ty * md + mty;
			tx = tx1;
		}
	}
}