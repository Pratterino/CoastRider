////////////////////////////////////////////////////////////////////////////////
//
//  LINNAEUS UNIVERSITY
//  Copyright 2012 Linnaeus university, Media Technology, sweden.
//  Some Rights Reserved.
//
//  NOTICE: LNU Media Technology permits you to use and modify this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package se.lnu.mediatechnology.stickossdk.debug
{
	//------------------------------------------------------------------------------
	//
	// Imports
	//
	//------------------------------------------------------------------------------
	
	import se.lnu.mediatechnology.stickossdk.core.Session;

	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	
	/**
	 *
	 *	Used to calculate and display the current frame rate of the application. 
	 *	Values ​​are visualized in text format.
	 * 
	 *	@author		Henrik Andersen
	 *	@version 	1.0
	 *
	 */
	public class OBJTicker extends Ticker
	{
		//--------------------------------------------------------------------------
		//
		// Constructor method
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 *	The class constructor.
		 * 
		 *	@param	x		The object's x position (Default: 10).
		 * 	@param	y		The object's y position (Default: 10).
		 *	@param	size	The text size (Default: 12).
		 *	@param	color	the text color (Default: 0xFFFFFF).
		 *	@param	font	the text font (Default: Arial).
		 *
		 */
		public function OBJTicker(x:Number=10, y:Number=10, size:uint=12, color:uint=0xFFFFFF, font:String='Arial')
		{
			super(x, y, size, color, font);
			
			this.text = '0 SO / 0 DO';
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * Shows the number of RAM the application is using.
		 *
		 */
		protected override function updateText():void
		{
			var stageObjects:uint	= Session.application.state.stageObjects.length;
			var displayObjects:uint	= Session.application.state.numChildren;
			
			this.text = String(stageObjects)+" SO / "+String(displayObjects)+" DO";
		}
	}
}