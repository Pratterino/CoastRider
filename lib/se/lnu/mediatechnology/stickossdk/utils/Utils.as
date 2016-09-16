package se.lnu.mediatechnology.stickossdk.utils
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	//------------------------------------------------------------------------------
	//
	// Public static class
	//
	//------------------------------------------------------------------------------
	
	/**
	 * 
	 *	-- !WORKING COPY! --
	 * 
	 *	DESC..
	 * 
	 */
	public class Utils
	{
		//--------------------------------------------------------------------------
		//
		// Public static methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * DESC..
		 * 
		 */
		public static function reduceColors():void
		{
			
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		public static function distortBitmapData(bitmapData:BitmapData):void 
		{
			bitmapData.lock();
			
			var point:Point			= new Point();
			var rectangle:Rectangle	= new Rectangle();
				rectangle.height	= Math.ceil(Math.random() * 2);
				rectangle.width		= bitmapData.width;
			
			for(var currentLineNumber:uint = 0; currentLineNumber < bitmapData.height; currentLineNumber += Math.ceil(Math.random() * 20))
			{
				point.y		 = currentLineNumber;
				point.x		 = Math.ceil(Math.random() * 2);
				//rectangle.y	+= Math.ceil(Math.random() * 8);
				
				bitmapData.copyPixels(bitmapData, rectangle, point);
			}
			
			bitmapData.unlock();
		}
	}
}