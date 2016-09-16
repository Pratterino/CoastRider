package state
{
	//------------------------------------------------------------------------------
	//
	// Imports
	//
	//------------------------------------------------------------------------------
	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	/**
	 *
	 *	This simple class acts as an object for the population of each row
	 * 	in the highscore state.  
	 * 
	 *	@author		Chris Shields
	 *	@version 	1.0
	 *
	 */
	public class HighScoreRow
	{
		//------------------------------------------------------------------------------
		//
		// Private properties
		//
		//------------------------------------------------------------------------------
		private var _name	:String		= "-";
		private var _time	:String 	= "-";
		private var _round	:String 	= "-";
		private var _date	:String   	= "-";
		//------------------------------------------------------------------------------
		//
		// Constructor method
		//
		//------------------------------------------------------------------------------
		/**
		 * 
		 *	The class constructor.
		 * 
		 *	@return void
		 * 
		 */
		public function HighScoreRow()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		// Public setter methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 *	Contains the name of the player in this high score row.  
		 * 
		 *	@param $name:String		The name of the player. 
		 * 
		 *	@return void
		 *
		 */
		public function set name($name:String):void
		{
			_name = $name;
		}
		
		/**
		 *
		 *	Contains the total time spent of the player in this high score row.  
		 * 
		 *	@param $time:String		The total time spent of the player. 	
		 * 
		 *	@return void
		 *
		 */
		public function set time($time:String):void
		{
			_time = $time;
		}
		
		/**
		 *
		 *	Contains the number of rounds played of the player in this high score row.  
		 * 
		 *	@param $round:String	The number of rounds played of the player. 	
		 * 
		 *	@return void
		 *
		 */
		public function set round($round:String):void
		{
			_round = $round;
		}
		
		/**
		 *
		 *	Contains the date the score entry was made in this high score row.  
		 * 
		 *	@param $date:String		The date the score entry was made 	
		 * 
		 *	@return void
		 *
		 */
		public function set date($date:String):void
		{
			_date = $date;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public getter methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 *	Contains the name of the player in this high score row.  
		 * 
		 *	@return _name:String
		 *
		 */
		public function get name():String
		{
			return _name;
		}
		
		/**
		 *
		 *	Contains the total time spent of the player in this high score row.  
		 * 
		 *	@return _time:String
		 *
		 */
		public function get time():String
		{
			return _time;
		}
		
		/**
		 * 
		 *	Contains the number of rounds played of the player in this high score row. 	
		 * 
		 *	@return _round:String
		 *
		 */
		public function get round():String
		{
			return _round;
		}
		
		/**
		 *
		 *	Contains the date the score entry was made in this high score row.  
		 * 
		 *	@return _date:String
		 *
		 */
		public function get date():String
		{
			return _date;
		}
		
	}
}