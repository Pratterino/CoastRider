package object
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
	 *	@author		Pär Strandberg
	 *	@version 	1.0
	 *
	 */
	public class Goal extends MovieClip implements IStickOsDisplayObject
	{
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------			
		public var goal:mc_goal	= new mc_goal();
		
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
		public function Goal($state:GameState) {
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
			addGoal();
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
			removeChild(goal);
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
		private function addGoal():void
		{
			addChild(goal);
		}
	}
}