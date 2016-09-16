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
	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	//--------------------------------------------------------------------------
	//
	// Public abstract class
	//
	//--------------------------------------------------------------------------
	
	/**
	 *
	 *	Ticker is an abstract class that is used to update text values ​​after a 
	 *	certain time interval. The class serves as a base class for FPSTicker 
	 *	and RAMTicker.
	 * 
	 *	@author		Henrik Andersen
	 *	@version 	1.0
	 *
	 */
	public class Ticker extends TextField
	{
		/**
		 * 
		 *	The number of milliseconds that have elapsed since the Flash runtime 
		 *	virtual machine for ActionScript 3.0 (AVM2) started.
		 * 
		 */
		protected var now:uint;
		
		/**
		 * 
		 *	The number of milliseconds that have elapsed since the Flash runtime 
		 *	virtual machine for ActionScript 3.0 (AVM2) started minus one frame.
		 * 
		 */
		protected var last:uint;
		
		/**
		 * 
		 *	Used to keep track of the time interval.
		 * 
		 */
		protected var ticks:uint;
		
		//-----------------------------------------------------------------------
		//
		// Constructor method
		//
		//-----------------------------------------------------------------------
		
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
		public function Ticker(x:Number = 10, y:Number = 10, size:uint = 12, color:uint = 0xFFFFFF, font:String = 'Arial')
		{
			super();
			
			this.x					= x;
			this.y					= y;
			this.defaultTextFormat	= new TextFormat(font, size);
			this.textColor			= color;
			this.selectable			= false;
			this.cacheAsBitmap		= true;
			this.last  				= getTimer();
			this.ticks 				= 0;
			this.autoSize			= TextFieldAutoSize.LEFT;
		}
		
		//-----------------------------------------------------------------------
		//
		// Public getter methods
		//
		//-----------------------------------------------------------------------
		
		/**
		 *
		 *	The change in time between frames (Δt).
		 *
		 */
		public function get delta():uint
		{
			return (now - last);
		}
		
		//-----------------------------------------------------------------------
		//
		// Public methods
		//
		//-----------------------------------------------------------------------
		
		/**
		 *
		 *	The object's internal update loop.
		 * 
		 *	@param	frequent	How often the object will be updated in 
		 *						milliseconds (default: 500).
		 *
		 */
		public function update(frequent:uint = 500):void
		{
			ticks++;
			now = getTimer();
			
			if(delta >= frequent)
			{
				updateText();
				
				ticks	= 0;
				last	= now;
			}
		}
		
		//-----------------------------------------------------------------------
		//
		// Protected methods
		//
		//-----------------------------------------------------------------------
		
		/**
		 *
		 *	This method updates the text. Override this method to create your 
		 *	own functionality.
		 *
		 */
		protected function updateText():void
		{
			// OVERRIDE THIS METHOD.
		}
	}
}