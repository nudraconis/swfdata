package swfdata 
{

	public class ColorData 
	{
		public var a:Number = 1;
		public var r:Number = 1;
		public var g:Number = 1;
		public var b:Number = 1;
		
		public function ColorData(r:Number = 1, g:Number = 1, b:Number = 1, a:Number = 1) 
		{
			this.a = a;
			this.b = b;
			this.g = g;
			this.r = r;
		}
		
		public function clear():void
		{
			a = 1;
			r = 1;
			b = 1;
			g = 1;
		}
		
		public function mulColorData(colorData:ColorData):void
		{
			//TODO: Поидеи нужно умножать колор на альфу чтобы премультиплайд колор поулчать но пока посомтрим может и не нужно
			//UPD: Хотя вероятно это единственный вариант как комплексному объекту выставить одинаковую прозрачность
			a *= colorData.a;
			r *= colorData.r;
			g *= colorData.g;
			b *= colorData.b;
		}
	}
}