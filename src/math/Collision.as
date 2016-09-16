package math
{
	//------------------------------------------------------------------------------
	//
	// Imports
	//
	//------------------------------------------------------------------------------

	import com.greensock.plugins.RemoveTintPlugin;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import object.Car;
	import object.Collect;
	import object.Goal;
	
	import se.lnu.mediatechnology.stickossdk.core.Session;
	
	import state.GameState;
	
	import utils.CarReplay;
	
	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	
	/**
	 *
	 *	Class representing the singleplayer dwarf instance.  
	 * 
	 *	@author		P�r Strandberg
	 *	@version 	1.0
	 *
	 */
	public class Collision
	{
		//--------------------------------------------------------------------------
		//
		// Public Static Constants
		//
		//--------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		//public var worldObjects:Vector.<MovieClip> = new Vector.<MovieClip>();
		public var worldObjects:Vector.<MovieClip> = new Vector.<MovieClip>();
		
		public var ACTIVEHIT	:Boolean 	= false;
		public var collectCount	:uint 		= 0;
		
		private var runningState:GameState;
		
		
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
		public function Collision($state:GameState) {
			runningState = $state;
			
			initValue();
		}
		
		//------------------------------------------------------------------------------
		//
		// Public methods
		//
		//------------------------------------------------------------------------------	
		/**
		 * 
		 *	Checks for collision against all movie clips.
		 * 
		 * 	@param $hitArea:Sprite	The hit area of the car to test with.  
		 * 
		 *	@return void
		 * 
		 */
		public function checkCollision($hitArea:*):void
		{
			
			var obj:Sprite = $hitArea;	//hitArea for Car
			
			for (var j:int = 0; j < worldObjects.length; j++) {
				var currentObj:MovieClip	= worldObjects[j];
				
				ACTIVEHIT = obj.hitTestObject(currentObj);	//true : false ;; In case the Car collides with another MovieClip-object from worldObjects.Vector. 
				
				if (ACTIVEHIT) {
					if (collectCount == 0) runningState.round.legitLap = true;
					
					if (currentObj is Collect) {
						runningState.removeChild(worldObjects[j]);
						worldObjects.splice(j, 1);
						collectCount--;
						runningState.sounds.play("menuMove");
					}
					
					if (currentObj is CarReplay && runningState.round.ROUND > 1) {
						runningState.car.gotoAndStop(2);
						runningState.hitSelf = true;
						worldObjects.splice(j,1);
					}
					
					/**
					 * Deaktiverar självkrock med klonen vid mållinjen.
					 * Uppdaterar även ROUND till nästkommande vid passering av mållinjen
					 */ 
					if (currentObj is Goal && collectCount == 0 && runningState.round.legitLap) {
						if (runningState.round.ROUND > runningState.round.LAPS) {
							//Escape
						}
						
						else {
							for (var i:int = 0; i < worldObjects.length; i++) {
								if (worldObjects[i] is CarReplay) {
									runningState.hitSelf = false;
									worldObjects.splice(i, 1);
									runningState.endFollow();
								}
							}
							runningState.round.updateLap();
							initValue();
						}
					}
					
					/**
					 * Ifall den sista målgången skett.
					 * 
					 */ 
					if (runningState.round.ROUND > runningState.round.LAPS) {
						runningState.round.ROUND = runningState.round.LAPS
						runningState.finishGame();
					}
				}
			}
			obj			= null;
			currentObj 	= null;
		}
		
		//------------------------------------------------------------------------------
		//
		// Private methods
		//
		//------------------------------------------------------------------------------
		public function initValue():void
		{
			collectCount = runningState.collectsX.length;
		}
	}
}