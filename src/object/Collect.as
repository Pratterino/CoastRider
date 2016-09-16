package object
{
	//------------------------------------------------------------------------------
	//
	// Imports
	//
	//------------------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import math.Collision;
	
	import se.lnu.mediatechnology.stickossdk.core.Session;
	import se.lnu.mediatechnology.stickossdk.display.IStickOsDisplayObject;
	
	import utils.GameUtils;
	
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
	public class Collect extends MovieClip implements IStickOsDisplayObject
	{
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------			
		public var collect:mc_collect	= new mc_collect();
		
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
		public function Collect($x:uint = 0, $y:uint = 0) {
			initCollect($x, $y);
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
		public function dealloc():void {
			trace("Collect.as dealloc");
			removeChild(collect);
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
		private function initCollect($x:uint, $y:uint):void	{
			super.addChild(collect);
			GameUtils.positionObject(collect, $x, $y);
			trace("collect added!");
		}
	}
}