package music
{
	//------------------------------------------------------------------------------
	//
	// Imports
	//
	//------------------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.media.Sound;
	
	import se.lnu.mediatechnology.stickossdk.core.Session;
	import se.lnu.mediatechnology.stickossdk.media.SoundManager;
	
	
	
	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	/**
	 *
	 *	Handles the sounds for the game. Use play("sound name"); to play a sound.
	 * 
	 *	@author		Pär Strandberg	
	 *	@version 	1.1
	 *
	 */
	
	public class Sounds 
	{
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------		
		//--------------------------------------------------------------------------
		//
		// Public static properties
		//
		//--------------------------------------------------------------------------
		//--------------------------------------------------------------------------
		//
		// Constructor method
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 *	The class constructor.
		 *
		 *	AVAILABLE SOUNDS:
		 * 	"bridgeBreak"
		 *	"bridgeCollapse"
		 *	"dynamiteFuse"
		 *	"explosion"
		 *	"flagCapture"
		 *	"flagRetake"
		 *	"hammerHit"
		 *	"rockBreak"
		 *	"menuMusic"
		 *	"gameMusic"
		 * 
		 *	@return void
		 *
		 */
		public function Sounds(state:String = "null") {
			initSoundBank();
			
			switch(state) {
				case ("game"):
					Session.application.state.sound.play("gameMusic",	1,0,100);
					break;
				
				case ("menu"):
					Session.application.state.sound.play("menuMusic",	1,0,10);
					break;
				
				case ("highscore"):
					Session.application.state.sound.play("highscoreMusic",1,0,10);
					break;
			}
		}
		
		private function initSoundBank():void {
		//Music
			Session.sound.add(sound_menuMusic,		"menuMusic");
			Session.sound.add(sound_gameMusic,		"gameMusic");
			Session.sound.add(sound_highscore, 		"highscoreMusic");

		//Menu
			Session.sound.add(sound_menuNavigation,	"menuMove");
			
		//Collect
			Session.sound.add(sound_collect, 		"goal");
		}
		
		public function play($sound:String = "menuMove"):void
		{
			Session.sound.play($sound);
		}
		
		public function stop():void
		{
			Session.application.state.sound.stopAll();
			Session.application.state.sound.removeAll();
		}
	
	}
}