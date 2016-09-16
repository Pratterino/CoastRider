package ui
{
	//------------------------------------------------------------------------------
	//
	// Imports
	//
	//------------------------------------------------------------------------------
	import flash.display.MovieClip;
	
	import se.lnu.mediatechnology.stickossdk.display.IStickOsDisplayObject;
	
	import state.GameState;

	
	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	
	/**
	 *
	 *	Class representing the singleplayer goal instance.  
	 * 
	 *	@author		P�r Strandberg
	 *	@version 	1.0
	 *
	 */
	public class UserInterface extends MovieClip implements IStickOsDisplayObject
	{
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------			
		public var uibar:mc_ui	= new mc_ui();
		
		
		public var runningState:GameState;
		
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
		public function UserInterface($state:GameState) {
			runningState = $state;
		}
		
		/**
		 * 
		 *	This method is executed when the state is ready for use, See it as 
		 *	a secondary constructor.
		 * 
		 *	@return void
		 * 
		 */
		public function init():void {
			addUi();
		}
		/**
		 *
		 * 	Updates every frame.
		 * 
		 *	@return void
		 *
		 */
		public function update():void {	
		}
		
		/**
		 *
		 *  Cleaner method.  Extras like event listeners to be removed here
		 * 
		 *	@return void
		 *
		 */
		public function dealloc():void
		{
			trace("UserInterface.as dealloc");
			removeChild(uibar);
		}
		
		public function updateTime(round:uint, time:uint):void {
			var timeString:String = time.toString();
			
			uibar.timeCount.text = timeString;
			
			switch (round) {
				case 1:
					uibar.time1.text = timeString;
					break;
				
				case 2:
					uibar.time2.text = calculateRoundTime(uibar.time1.text, "0", time);
					break;
				
				case 3:
					uibar.time3.text = calculateRoundTime(uibar.time2.text, uibar.time1.text, time);
					break;
			}
		}
		
		private function calculateRoundTime(prev:String, prevprev:String, current:uint):String
		{
			var _prevprev:uint	= uint(prevprev);
			var prevInt:uint 	= uint(prev);
			
			
			if (_prevprev !== 0) {
				prevInt = prevInt + _prevprev; 
			}
			
			var calc:uint 		= (current - prevInt);
			var result:String 	= calc.toString();
			
			if (prevInt == 0) 	return "0";
			else				return result;
		}
		
		public function updateLap(round:uint, totalLaps:uint):void {
			var roundString:String = round.toString();
			
			uibar.roundCount.text = roundString + "/" + totalLaps.toString();
		}
		
		//------------------------------------------------------------------------------
		//
		// Private methods
		//
		//------------------------------------------------------------------------------
		
		/**
		 * This method is actually establishes the player on the map.  The score is set using
		 * update score and the flag is colored to the appropriate color of the player.  The goals
		 * movie clip is then generated dynamically using the color string to build its reference and 
		 * then using this reference instanciates it and adds it to the scene.
		 * 
		 * 
		 * @return void
		 */
		private function addUi():void
		{
			addChild(uibar);
		}
	}
}