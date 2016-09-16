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

package se.lnu.mediatechnology.stickossdk.utils
{
	//------------------------------------------------------------------------------
	//
	// Import
	//
	//------------------------------------------------------------------------------
	
	// IMPORT FROM STICKOS SDK
	
	import se.lnu.mediatechnology.stickossdk.display.IStickOsDisplayObject;
	
	// IMPORT FROM FLASH IDE
	
	import flash.display.DisplayObject;

	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	
	/**
	 *	
	 * 	-- !WORKING COPY! --
	 *	
	 * 	This class is used to manage and keep track of items in a list format. Think 
	 *	of it as an array with enhanced functionality.
	 * 
	 *	@author		Henrik Andersen
	 *	@version	1.0
	 *
	 */
	public class List
	{
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		public var objects:Array;
		
		//--------------------------------------------------------------------------
		//
		// Constructor method
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * Instantiate a new boot object.
		 *
		 */
		public function List()
		{
			objects = new Array();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public getter methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 *	A non-negative integer specifying the number of elements in the array. 
		 *	This property is automatically updated when new elements are added to the 
		 *	array. When you assign a value to an array element, if index is a number, 
		 *	and index+1 is greater than the length property, the length property is 
		 *	updated to index+1.
		 * 
		 *	Note: If you assign a value to the length property that is shorter than the 
		 *	existing length, the array will be truncated.
		 *
		 */
		public function get length():uint
		{
			return objects.length;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public setter methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 *	A non-negative integer specifying the number of elements in the array. 
		 *	This property is automatically updated when new elements are added to the 
		 *	array. When you assign a value to an array element, if index is a number, 
		 *	and index+1 is greater than the length property, the length property is 
		 *	updated to index+1.
		 * 
		 *	Note: If you assign a value to the length property that is shorter than the 
		 *	existing length, the array will be truncated.
		 *
		 */
		public function set length(length:uint):void
		{
			objects.length = length;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 *	Adds an item to the list.
		 *
		 *	@param		object		The item to be added to the list.
		 * 
		 */
		public function add(object:*):*
		{
			objects.push(object);
			
			return object;
		}
		
		/**
		 *
		 *	Removes a specific item from the list.
		 *
		 *	@param		object		The item to be removed from the list.
		 * 
		 */
		public function remove(object:*):*
		{
			var index:uint = objects.indexOf(object);
			
			if(index < 0 || index > (objects.length - 1)){
				return null;
			}
			
			var tmpObject:Object = objects[index];
			objects.splice(index, 1);
			
			return tmpObject;
		}
		
		/**
		 *
		 * Clears the entire list in a secure manner, is used to avoid memory leaks.
		 *
		 */
		public function clear():void
		{
			for(var i:uint = 0; i < objects.length; i++)
			{
				if( objects[i] != null){
					objects[i]  = null;
				}
			}
			
			objects.length = 0;
		}
		
		/**
		 *
		 *	Quick update of all the items in the list.
		 *
		 */
		public function update():void
		{
			for(var i:uint = 0; i < objects.length; i++)
			{
				if( objects[i] is IStickOsDisplayObject){
					objects[i].update();
				}
			}
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		public function getFirst(splice:Boolean = false):*
		{
			return objects[0];
		}
	}
}