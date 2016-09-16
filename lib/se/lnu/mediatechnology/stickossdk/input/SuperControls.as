﻿////////////////////////////////////////////////////////////////////////////////////  LINNAEUS UNIVERSITY//  Copyright 2012 Linnaeus university, Media Technology, sweden.//  Some Rights Reserved.////  NOTICE: LNU Media Technology permits you to use and modify this file//  in accordance with the terms of the license agreement accompanying it.//////////////////////////////////////////////////////////////////////////////////package se.lnu.mediatechnology.stickossdk.input{	//------------------------------------------------------------------------------	//	//  Public class	//	//------------------------------------------------------------------------------		/**	 *	 *	SuperControls can be used to handle the controls for player one or two 	 *	depending on the class settings. Switch player by changing the variable 	 *	player to either <code>PLAYER_CODE</code> or <code>PLAYER_TWO</code>	 *	 */	public class SuperControls	{		//--------------------------------------------------------------------------		//		// Public constants		//		//--------------------------------------------------------------------------				public const PLAYER_ONE:uint = 0;		public const PLAYER_TWO:uint = 1;				//--------------------------------------------------------------------------		//		// Public properties		//		//--------------------------------------------------------------------------				public var player:uint;				//--------------------------------------------------------------------------		//		// Constructor method		//		//--------------------------------------------------------------------------				/**		 *		 *	Instantiate a new SuperControls object and sets the selected player to 		 *	player one. To change the active player, change the value of 		 *	<code>player<code> to <code>PLAYER_TWO</code>		 * 		 */		public function SuperControls() 		{			player = PLAYER_ONE;		}				//--------------------------------------------------------------------------		//		// Public getter methods		//		//--------------------------------------------------------------------------				/**		 * 		 *	Gets the keyboard button for UP, depending on the selected 		 *	player(could be player one or two).		 * 		 *	@return	String	The UP key on your keyboard.		 * 		 */		public function get PLAYER_UP():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_UP;			}						return Controls.PLAYER_2_UP;		}				/**		 * 		 *	Gets the keyboard button for RIGHT, depending on the selected 		 *	player(could be player one or two).		 * 		 *	@return	String	The RIGHT key on your keyboard.		 * 		 */		public function get PLAYER_RIGHT():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_RIGHT;			}						return Controls.PLAYER_2_RIGHT;		}				/**		 * 		 *	Gets the keyboard button for DOWN, depending on the selected 		 *	player(could be player one or two).		 * 		 *	@return	String	The DOWN key on your keyboard.		 * 		 */		public function get PLAYER_DOWN():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_DOWN;			}						return Controls.PLAYER_2_DOWN;		}				/**		 * 		 *	Gets the keyboard button for LEFT, depending on the selected 		 *	player(could be player one or two).		 * 		 *	@return	String	The LEFT key on your keyboard.		 * 		 */		public function get PLAYER_LEFT():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_LEFT;			}						return Controls.PLAYER_2_LEFT;		}				/**		 * 		 *	Gets the keyboard button for BUTTON_1 on the joystick, depending on the 		 *	selected player(could be player one or two).		 * 		 *	@return	String	The BUTTON_1 key on your keyboard.		 * 		 */		public function get PLAYER_BUTTON_1():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_BUTTON_1;			}						return Controls.PLAYER_2_BUTTON_1;		}				/**		 * 		 *	Gets the keyboard button for BUTTON_2 on the joystick, depending on the 		 *	selected player(could be player one or two).		 * 		 *	@return	String	The BUTTON_2 key on your keyboard.		 * 		 */		public function get PLAYER_BUTTON_2():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_BUTTON_2;			}						return Controls.PLAYER_2_BUTTON_2;		}				/**		 * 		 *	Gets the keyboard button for BUTTON_3 on the joystick, depending on the 		 *	selected player(could be player one or two).		 * 		 *	@return	String	The BUTTON_3 key on your keyboard.		 * 		 */		public function get PLAYER_BUTTON_3():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_BUTTON_3;			}						return Controls.PLAYER_2_BUTTON_3;		}				/**		 * 		 *	Gets the keyboard button for BUTTON_4 on the joystick, depending on the 		 *	selected player(could be player one or two).		 * 		 *	@return	String	The BUTTON_4 key on your keyboard.		 * 		 */		public function get PLAYER_BUTTON_4():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_BUTTON_4;			}						return Controls.PLAYER_2_BUTTON_4;		}				/**		 * 		 *	Gets the keyboard button for BUTTON_5 on the joystick, depending on the 		 *	selected player(could be player one or two).		 * 		 *	@return	String	The BUTTON_5 key on your keyboard.		 * 		 */		public function get PLAYER_BUTTON_5():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_BUTTON_5;			}						return Controls.PLAYER_2_BUTTON_5;		}				/**		 * 		 *	Gets the keyboard button for BUTTON_6 on the joystick, depending on the 		 *	selected player(could be player one or two).		 * 		 *	@return	String	The BUTTON_6 key on your keyboard.		 * 		 */		public function get PLAYER_BUTTON_6():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_BUTTON_6;			}						return Controls.PLAYER_2_BUTTON_6;		}				/**		 * 		 *	Gets the keyboard button for BUTTON_7 on the joystick, depending on the 		 *	selected player(could be player one or two).		 * 		 *	@return	String	The BUTTON_7 key on your keyboard.		 * 		 */		public function get PLAYER_BUTTON_7():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_BUTTON_7;			}						return Controls.PLAYER_2_BUTTON_7;		}				/**		 * 		 *	Gets the keyboard button for BUTTON_8 on the joystick, depending on the 		 *	selected player(could be player one or two).		 * 		 *	@return	String	The BUTTON_8 key on your keyboard.		 * 		 */		public function get PLAYER_BUTTON_8():String 		{			if(player == PLAYER_ONE){				return Controls.PLAYER_1_BUTTON_8;			}						return Controls.PLAYER_2_BUTTON_8;		}	}}