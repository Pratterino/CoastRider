package math
{
	//-----------------------------------------------------------------------
	//
	// Imports
	//
	//-----------------------------------------------------------------------
	import flash.display.MovieClip;
	
	import se.lnu.mediatechnology.stickossdk.core.Session;
	import se.lnu.mediatechnology.stickossdk.display.IStickOsDisplayObject;
	import se.lnu.mediatechnology.stickossdk.utils.Utils;
	
	import state.GameState;

	public class Round extends MovieClip implements IStickOsDisplayObject
	{
		//-----------------------------------------------------------------------
		//
		// Public properties
		//
		//-----------------------------------------------------------------------
		private var 	hidden	:mc_alert = new mc_alert();
		
		public var	 	LAPS	:uint = 3;	//Maximum laps for a whole game session.
		public var 		ROUND	:uint = 1;	//Current round.
		public var 		TIME	:uint = 0;	//Current time (seconds)

		
		private var runningState:GameState;
		public 	var legitCount	:Boolean = true;	//Counts each second toward the players final score.
		public 	var legitLap	:Boolean = false;	//Has the player collected every Collect?
		
		
		/**
		 * 
		 *	The class constructor.
		 * 
		 *	@return void
		 * 
		 */
		public function Round($state:GameState) {
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
			addChild(hidden);
			hidden.visible = false;
			
			initTimer();
			updateLap();
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
			stopCount();
			trace("Round.as dealloc");
		}
		
		public function updateLap():void {
			if(legitLap) {
				legitLap = false;
				ROUND++;
				runningState.uibar.updateLap(ROUND, LAPS);
				runningState.newRound(ROUND);
			}
			
			else {
				runningState.uibar.updateLap(ROUND, LAPS);
			}
		}
		
		
		private function initTimer():void {
			if (legitCount)		Session.setPause(1.5, everySecond);
		}
		
		private function everySecond():void {
			TIME++;
			runningState.uibar.updateTime(ROUND, TIME);
			initTimer();
		}
		
		private function stopCount():void
		{
			legitCount = false;
		}
	}
}