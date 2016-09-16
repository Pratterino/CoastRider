package utils
{
	//------------------------------------------------------------------------------
	//
	// Public static class
	//
	//------------------------------------------------------------------------------
	
	/**
	 * 
	 *	Help methods
	 * 
	 */	
	public class GameUtils
	{
		public function GameUtils(){
		}
		
		/**
		 * Places an object in x- and y-position given as parameters.
		 * 
		 * @param _x The x-coordinate.	Default 0.
		 * @param _y The y-coordinate.	Default 0.
		 * 
		 * @return void
		 */
		public static function positionObject(_object:*, _x:int = 0, _y:int = 0):void {
			_object.x = _x;
			_object.y = _y;			
		}
	}
}