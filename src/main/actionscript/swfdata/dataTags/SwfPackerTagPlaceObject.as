package swfdata.dataTags 
{
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import swfdata.ColorMatrix;
	
	public class SwfPackerTagPlaceObject extends SwfPackerTag 
	{
		public static const PLACE_MODE_UNKNOWN:int = -1;
		public static const PLACE_MODE_PLACE:int = 0;
		public static const PLACE_MODE_REPLACE:int = 1;
		public static const PLACE_MODE_MOVE:int = 2;
		
		//public var hasClipActions:Boolean;
		public var hasClipDepth:Boolean;
		public var hasName:Boolean;
		//public var hasRatio:Boolean;
		public var hasColorTransform:Boolean;
		public var hasMatrix:Boolean;
		public var hasCharacter:Boolean;
		public var hasMove:Boolean;
		//public var hasVisible:Boolean;
		//public var hasImage:Boolean;
		//public var hasBlendMode:Boolean;
		//public var hasFilterList:Boolean;
		
		public var characterId:int;
		public var depth:int;
		//public var matrix:Matrix;
		
		//matrix
		public var a:Number = 1;
		public var b:Number = 0;
		public var c:Number = 0;
		public var d:Number = 1;
		public var tx:Number = 0;
		public var ty:Number = 0;
		//matrix
		
		public var redColor0:Number = 0;
		public var redColor1:Number = 0;
		public var redColor2:Number = 0;
		public var redColor3:Number = 0;
		public var redColorOffset:Number = 0;
		
		public var greenColor0:Number = 0;
		public var greenColor1:Number = 0;
		public var greenColor2:Number = 0;
		public var greenColor3:Number = 0;
		public var greenColorOffset:Number = 0;
		
		public var blueColor0:Number = 0;
		public var blueColor1:Number = 0;
		public var blueColor2:Number = 0;
		public var blueColor3:Number = 0;
		public var blueColorOffset:Number = 0;
		
		public var alpha0:Number = 0;
		public var alpha1:Number = 0;
		public var alpha2:Number = 0;
		public var alpha3:Number = 0;
		public var alphaOffset:Number = 0;
		
		
		public function toColorMatrixString():String 
		{
			return "[Tag#ColorMatrix" +
						"\n" + redColor0 + "\t" + redColor1 + "\t" + redColor2 + "\t" + redColor3 + "\t" + redColorOffset + 
						"\n" + greenColor0 + "\t" + greenColor1 + "\t" + greenColor2 + "\t" + greenColor3 + "\t" + greenColorOffset + 
						"\n" + blueColor0 + "\t" + blueColor1 + "\t" + blueColor2 + "\t" + blueColor3 + "\t" + blueColorOffset + 
						"\n" + alpha0 + "\t" + alpha1 + "\t" + alpha2 + "\t" + alpha3 + "\t" + alphaOffset + "\n]";
		}
		
		//public var colorTransform:ColorMatrix;
		
		public var placeMode:int = PLACE_MODE_UNKNOWN;
		
		// Forward declarations for TagPlaceObject2
		//public var ratio:uint;
		public var instanceName:String;
		public var clipDepth:int;

		// Forward declarations for TagPlaceObject3
		//public var blendMode:int;
		//public var bitmapCache:int;
		//public var bitmapBackgroundColor:int;
		public var visible:int;
		
		//public var surfaceFilterList:Vector.<*>;

		public function isEquals(eqTo:SwfPackerTagPlaceObject):Boolean
		{
			return depth == eqTo.depth && characterId == eqTo.characterId && placeMode == eqTo.placeMode && hasMatrix == eqTo.hasMatrix && clipDepth == eqTo.clipDepth && eqTo.instanceName == instanceName;
		}
		
		public function SwfPackerTagPlaceObject() 
		{
			type = 4;//from swf tags specification
		}
		
		override public function clear():void 
		{
			//matrix = null;
			//colorTransform = null;
			instanceName = null;
		}
		
		public function addColorMatrixArray(matrix:Array):void 
		{
			var v:Vector.<Number> = new Vector.<Number>;
			v.push.apply(null, matrix);
		}
		
		public function toString():String 
		{
			return "[SwfPackerTagPlaceObject depth=" + depth + " characterId=" + characterId + " placeMode=" + placeMode + 
						" hasMatrix=" + hasMatrix + " clipDepth=" + clipDepth + " instanceName=" + instanceName + "]";
		}
		
		public function fillData(_placeMode:int, _depth:int, _hasClipDepth:Boolean, _hasName:Boolean, _hasMatrix:Boolean, _hasCharacter:Boolean, _instanceName:String, _clipDepth:int, _characterId:int):void 
		{
			placeMode = _placeMode;
			depth = _depth;
			hasClipDepth = _hasClipDepth;
			hasName = _hasName;
			hasMatrix = _hasMatrix;
			hasCharacter = _hasCharacter;
			instanceName = _instanceName;
			clipDepth = _clipDepth;
			characterId = _characterId;
		}
		
		public function setMatrix(a:Number, b:Number, c:Number, d:Number, tx:Number, ty:Number):void 
		{
			this.a = a;
			this.b = b;
			this.c = c;
			this.d = d;
			this.tx = tx;
			this.ty = ty;
		}
		
		private var colorMatrix:ColorMatrix;
		
		public function getColorTransformMatrix():ColorMatrix 
		{
			if (colorMatrix == null)
			{
				colorMatrix = new ColorMatrix(	new <Number>[
													redColor0, redColor1, redColor2, redColor3, redColorOffset,
													greenColor0, greenColor1, greenColor2, greenColor3, greenColorOffset,
													blueColor0, blueColor1, blueColor2, blueColor3, blueColorOffset,
													alpha0, alpha1, alpha2, alpha3, alphaOffset
												]
											);
			}
			
			return colorMatrix;
		}
	}
}