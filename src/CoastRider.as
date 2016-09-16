package
{	
	//------------------------------------------------------------------------------
	//
	// Imports
	//
	//------------------------------------------------------------------------------
	
	import se.lnu.mediatechnology.stickossdk.core.Engine;
	
	import state.GameState;
	import state.MenuState;
	import state.WinState;
	
	//------------------------------------------------------------------------------
	//
	// SWF properties
	//
	//------------------------------------------------------------------------------
	
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#F0F0F0")]

	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	
	/**
	 *
	 *	REMEMBER TO CHANGE THE NAME OF THIS CLASS, THE CLASS SHOULD HAVE THE 
	 *	SAME NAME AS THE GAME.
	 * 
	 *	@author		XXX XXX
	 *	@version 	0.0
	 *
	 */
	public class CoastRider extends Engine
	{
		//------------------------------------------------------------------------------
		//
		// Constructor method
		//
		//------------------------------------------------------------------------------
		
		/**
		 * 
		 *	The game constructor.
		 * 
		 *	@return void
		 * 
		 */
		public function CoastRider():void
		{
			super(MenuState);
		}
	}
}