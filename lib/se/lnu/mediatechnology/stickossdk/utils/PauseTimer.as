﻿package se.lnu.mediatechnology.stickossdk.utils{	//------------------------------------------------------------------------------	//	// Import	//	//------------------------------------------------------------------------------	import se.lnu.mediatechnology.stickossdk.core.Session;		//------------------------------------------------------------------------------	//	// Public class	//	//------------------------------------------------------------------------------		/**	 *	 * DESC..	 * 	 * TODO: IMPLEMENTERA LIST?..	 *	 */	public class PauseTimer extends List	{		//--------------------------------------------------------------------------		//		// Protected properties		//		//--------------------------------------------------------------------------				//--------------------------------------------------------------------------		//		// Constructor method		//		//--------------------------------------------------------------------------				/**		 *		 * DESC..		 *		 */		public function PauseTimer()		{			super();			}				//--------------------------------------------------------------------------		//		// Public methods		//		//--------------------------------------------------------------------------				/**		 *		 * DESC..		 * 		 * TODO: BYGG IN FRAME SKIPPING		 *		 */		public override function update():void 		{						for(var i:uint = 0; i < objects.length; i++)			{				objects[i].update();								if( objects[i].pauseTicker <= 0){					objects[i].callback();										remove(objects[i]);				}			}		}				/**		 *		 * DESC..		 *		 */		public function setPause(Seconds:Number, Callback:Function):PauseTimerObject 		{			var tmpObject:PauseTimerObject	= new PauseTimerObject();				tmpObject.pauseTicker		= int(Seconds * Session.application.frameRate);				tmpObject.callback			= Callback;						return add(tmpObject);		}	}}