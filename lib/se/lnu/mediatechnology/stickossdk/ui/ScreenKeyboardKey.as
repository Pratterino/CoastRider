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

package se.lnu.mediatechnology.stickossdk.ui
{
	//------------------------------------------------------------------------------
	//
	// Imports
	//
	//------------------------------------------------------------------------------
	
	import se.lnu.mediatechnology.stickossdk.display.BitmapSprite;
	import se.lnu.mediatechnology.stickossdk.display.IStickOsDisplayObject;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	
	/**
	 * 
	 * This class acts as a keyboard key. A key can also contain string values ​​such 
	 * as 'backspace' or 'enter'.
	 * 
	 * @author	Henrik Andersen
	 * @version 1.0
	 * 
	 */
	public class ScreenKeyboardKey extends BitmapSprite
	{
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		public const IDLE:String		= 'idle';
		public const SELECTED:String	= 'selected';
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 *	The keyboard key's value, ie 'q','w','e'.
		 * 
		 */
		public var value:String;
		
		//--------------------------------------------------------------------------
		//
		// Constructor method
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * Instantiate a new ScreenKeyboardKey-object.
		 *
		 */
		public function ScreenKeyboardKey(value:String, gfx:Class)
		{
			this.value = value;
			
			var tmpBitmap:Bitmap	= new gfx() as Bitmap;
			var tmpWidth:Number		= (tmpBitmap.width * 0.5);
			var tmpHeight:Number	= tmpBitmap.height;
			
			super(tmpWidth, tmpHeight, tmpBitmap.bitmapData);
			
			init();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public override methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * This method runs automatically when the object is created.
		 *
		 */
		public override function init():void
		{
			super.init();
			
			initAnimation();
		}
		
		/**
		 *
		 * This method keeps the object up to date.
		 *
		 */
		public override function update():void
		{
			super.update();
		}
		
		//--------------------------------------------------------------------------
		//
		// Private methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * Creates the animations for this keyboard key.
		 *
		 */
		private function initAnimation():void
		{
			this.addAnimation(IDLE,		[0], 1, true);
			this.addAnimation(SELECTED,	[1], 1, true);
		}
	}
}