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
	
	import com.greensock.TweenLite;
	import com.greensock.easing.Quad;
	import se.lnu.mediatechnology.stickossdk.core.Session;
	import se.lnu.mediatechnology.stickossdk.input.SuperControls;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	
	/**
	 *	
	 * 	-- !WORKING COPY! --
	 *	
	 *	This is an on-screen keyboard for entering numbers, letters and characters 
	 *	through the the arcade machine's joysticks.
	 * 
	 *	@author	Henrik Andersen
	 *	@version 1.0
	 * 
	 */
	public class ScreenKeyboard extends Sprite
	{
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		public var controls:SuperControls;
		public var transitionSpeed:Number;
		public var volume:Number;
		
		//--------------------------------------------------------------------------
		//
		// Private static properties
		//
		//--------------------------------------------------------------------------
		
		private static var _instance:ScreenKeyboard;
		private static var _allowInstance:Boolean;
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var textField:TextField;
		private var background:Bitmap;
		private var keys:Array;
		private var selectedKey:Point;
		private var _active:Boolean;
		private var callback:Function;
		private var forceQuit:Boolean;
		
		//--------------------------------------------------------------------------
		//
		// Private constants
		//
		//--------------------------------------------------------------------------
		
		private const KEY_INIT_MARGIN:Point			= new Point(12,60);
		private const KEY_MARGIN:Point				= new Point(6,6);
		private const KEY_SIZE:Point				= new Point(42,42);
		private const SOUND_MOVE:String				= 'move';
		private const SOUND_SELECT:String			= 'select';
		private const DEFAULT_FONT:String			= 'Arial';
		
		//--------------------------------------------------------------------------
		//
		// Embeded private properties
		//
		//--------------------------------------------------------------------------
		
		[Embed("../data/sound_move.mp3")]						private static const SoundMove:Class;
		[Embed("../data/sound_select.mp3")]						private static const SoundSelect:Class;
		[Embed("../data/screenkeyboard_BACKGROUND.png")]		private static const ImageBackground:Class;
		[Embed("../data/screenkeyboard_key_1.png")]				private static const ImageKeyOne:Class;
		[Embed("../data/screenkeyboard_key_2.png")]				private static const ImageKeyTwo:Class;
		[Embed("../data/screenkeyboard_key_3.png")]				private static const ImageKeyThree:Class;
		[Embed("../data/screenkeyboard_key_4.png")]				private static const ImageKeyFour:Class;
		[Embed("../data/screenkeyboard_key_5.png")]				private static const ImageKeyFive:Class;
		[Embed("../data/screenkeyboard_key_6.png")]				private static const ImageKeySix:Class;
		[Embed("../data/screenkeyboard_key_7.png")]				private static const ImageKeySeven:Class;
		[Embed("../data/screenkeyboard_key_8.png")]				private static const ImageKeyEight:Class;
		[Embed("../data/screenkeyboard_key_9.png")]				private static const ImageKeyNine:Class;
		[Embed("../data/screenkeyboard_key_0.png")]				private static const ImageKeyZero:Class;
		[Embed("../data/screenkeyboard_key_Q.png")]				private static const ImageKeyQ:Class;
		[Embed("../data/screenkeyboard_key_W.png")]				private static const ImageKeyW:Class;
		[Embed("../data/screenkeyboard_key_E.png")]				private static const ImageKeyE:Class;
		[Embed("../data/screenkeyboard_key_R.png")]				private static const ImageKeyR:Class;
		[Embed("../data/screenkeyboard_key_T.png")]				private static const ImageKeyT:Class;
		[Embed("../data/screenkeyboard_key_Y.png")]				private static const ImageKeyY:Class;
		[Embed("../data/screenkeyboard_key_U.png")]				private static const ImageKeyU:Class;
		[Embed("../data/screenkeyboard_key_I.png")]				private static const ImageKeyI:Class;
		[Embed("../data/screenkeyboard_key_O.png")]				private static const ImageKeyO:Class;
		[Embed("../data/screenkeyboard_key_P.png")]				private static const ImageKeyP:Class;
		[Embed("../data/screenkeyboard_key_A.png")]				private static const ImageKeyA:Class;
		[Embed("../data/screenkeyboard_key_S.png")]				private static const ImageKeyS:Class;
		[Embed("../data/screenkeyboard_key_D.png")]				private static const ImageKeyD:Class;
		[Embed("../data/screenkeyboard_key_F.png")]				private static const ImageKeyF:Class;
		[Embed("../data/screenkeyboard_key_G.png")]				private static const ImageKeyG:Class;
		[Embed("../data/screenkeyboard_key_H.png")]				private static const ImageKeyH:Class;
		[Embed("../data/screenkeyboard_key_J.png")]				private static const ImageKeyJ:Class;
		[Embed("../data/screenkeyboard_key_K.png")]				private static const ImageKeyK:Class;
		[Embed("../data/screenkeyboard_key_L.png")]				private static const ImageKeyL:Class;
		[Embed("../data/screenkeyboard_key_BACKSPACE.png")]		private static const ImageKeyBACKSPACE:Class;
		[Embed("../data/screenkeyboard_key_Z.png")]				private static const ImageKeyZ:Class;
		[Embed("../data/screenkeyboard_key_X.png")]				private static const ImageKeyX:Class;
		[Embed("../data/screenkeyboard_key_C.png")]				private static const ImageKeyC:Class;
		[Embed("../data/screenkeyboard_key_V.png")]				private static const ImageKeyV:Class;
		[Embed("../data/screenkeyboard_key_B.png")]				private static const ImageKeyB:Class;
		[Embed("../data/screenkeyboard_key_N.png")]				private static const ImageKeyN:Class;
		[Embed("../data/screenkeyboard_key_M.png")]				private static const ImageKeyM:Class;
		[Embed("../data/screenkeyboard_key_SLASH.png")]			private static const ImageKeySLASH:Class;
		[Embed("../data/screenkeyboard_key_AT.png")]			private static const ImageKeyAT:Class;
		[Embed("../data/screenkeyboard_key_HASHTAG.png")]		private static const ImageKeyHASHTAG:Class;
		[Embed("../data/screenkeyboard_key_DOT.png")]			private static const ImageKeyDOT:Class;
		[Embed("../data/screenkeyboard_key_DASH.png")]			private static const ImageKeyDASH:Class;
		[Embed("../data/screenkeyboard_key_ENTER.png")]			private static const ImageKeyENTER:Class;
		[Embed("../data/screenkeyboard_key_UNDERSCORE.png")]	private static const ImageKeyUNDERSCORE:Class;
		[Embed("../data/screenkeyboard_key_SPACE.png")]			private static const ImageKeySPACE:Class;
		
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
		public function ScreenKeyboard()
		{
			super();
			
			selectedKey 	= new Point();
			controls		= new SuperControls();
			transitionSpeed	= 0.65;
			volume			= 0.33;
			
			initBackground();
			initTextField();
			initKeys();
			
			cacheAsBitmap = true;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public getter method
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * DESC..
		 *
		 */
		public function get active():Boolean
		{
			return _active;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public static methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 * DESC..
		 * 
		 */
		public static function getInstance():ScreenKeyboard 
		{
			if( ScreenKeyboard._instance		== null){
				ScreenKeyboard._allowInstance	 = true;
				ScreenKeyboard._instance		 = new ScreenKeyboard();
				ScreenKeyboard._allowInstance	 = false;
			}
			
			return ScreenKeyboard._instance;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public method
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * DESC..
		 *
		 */
		public function update():void
		{
			updateKeys();
			updateSelectedKey();
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		public function useKeyboard(callback:Function, defaultText:String = 'Enter Name'):void
		{
			if(_active) return;
			
			initSound();
			
			this.callback				= callback;
			this.textField.text			= defaultText;
			this.textField.textColor	= 0xCCCCCC;
			this.x						= ((Session.width  * 0.5) - (width  * 0.5));
			this.y						= (Session.height);
			this.selectedKey.x 			= 0;
			this.selectedKey.y			= 0;
			this.forceQuit				= false;
			
			slideIn();
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		public function quit(abort:Boolean = true):void
		{
			forceQuit = abort;
			slideOut();
		}
		
		//--------------------------------------------------------------------------
		//
		// Private method
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function initSound():void
		{
			Session.sound.add(SoundMove,	SOUND_MOVE);
			Session.sound.add(SoundSelect,	SOUND_SELECT);
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function initBackground():void
		{
			background		= new ImageBackground() as Bitmap;
			background.x	= 0;
			background.y	= 0;
			
			addChild(background);
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function initTextField():void
		{
			var textFormat:TextFormat	= new TextFormat();
			textFormat.size			= 23;
			textFormat.color		= 0x333333;
			textFormat.font			= DEFAULT_FONT;
			textFormat.kerning		= true;
			
			textField 					= new TextField();
			textField.x					= 12;
			textField.y					= 12;
			textField.width				= 474;
			textField.height			= 31;
			textField.textColor			= 0xCCCCCC;
			textField.selectable		= false;
			textField.defaultTextFormat	= textFormat;
			
			textField.setTextFormat(textFormat);
			
			addChild(textField);
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function initKeys():void
		{
			initKeyContent();
			initKeyLayout();
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function initKeyContent():void
		{
			keys	= new Array();
			keys[0]	= new Array();
			keys[1]	= new Array();
			keys[2]	= new Array();
			keys[3]	= new Array();
			keys[4]	= new Array();
			
			keys[0].push(new ScreenKeyboardKey('1', 			ImageKeyOne));
			keys[0].push(new ScreenKeyboardKey('2', 			ImageKeyTwo));
			keys[0].push(new ScreenKeyboardKey('3', 			ImageKeyThree));
			keys[0].push(new ScreenKeyboardKey('4', 			ImageKeyFour));
			keys[0].push(new ScreenKeyboardKey('5',				ImageKeyFive));
			keys[0].push(new ScreenKeyboardKey('6',				ImageKeySix));
			keys[0].push(new ScreenKeyboardKey('7',				ImageKeySeven));
			keys[0].push(new ScreenKeyboardKey('8',				ImageKeyEight));
			keys[0].push(new ScreenKeyboardKey('9',				ImageKeyNine));
			keys[0].push(new ScreenKeyboardKey('0',				ImageKeyZero));
			
			keys[1].push(new ScreenKeyboardKey('Q',				ImageKeyQ));
			keys[1].push(new ScreenKeyboardKey('W',				ImageKeyW));
			keys[1].push(new ScreenKeyboardKey('E',				ImageKeyE));
			keys[1].push(new ScreenKeyboardKey('R',				ImageKeyR));
			keys[1].push(new ScreenKeyboardKey('T',				ImageKeyT));
			keys[1].push(new ScreenKeyboardKey('Y',				ImageKeyY));
			keys[1].push(new ScreenKeyboardKey('U',				ImageKeyU));
			keys[1].push(new ScreenKeyboardKey('I',				ImageKeyI));
			keys[1].push(new ScreenKeyboardKey('O',				ImageKeyO));
			keys[1].push(new ScreenKeyboardKey('P',				ImageKeyP));
			
			keys[2].push(new ScreenKeyboardKey('A',				ImageKeyA));
			keys[2].push(new ScreenKeyboardKey('S',				ImageKeyS));
			keys[2].push(new ScreenKeyboardKey('D',				ImageKeyD));
			keys[2].push(new ScreenKeyboardKey('F', 			ImageKeyF));
			keys[2].push(new ScreenKeyboardKey('G',				ImageKeyG));
			keys[2].push(new ScreenKeyboardKey('H',				ImageKeyH));
			keys[2].push(new ScreenKeyboardKey('J',				ImageKeyJ));
			keys[2].push(new ScreenKeyboardKey('K',				ImageKeyK));
			keys[2].push(new ScreenKeyboardKey('L',				ImageKeyL));
			keys[2].push(new ScreenKeyboardKey('BACKSPACE',		ImageKeyBACKSPACE));
			
			keys[3].push(new ScreenKeyboardKey('Z',				ImageKeyZ));
			keys[3].push(new ScreenKeyboardKey('X',				ImageKeyX));
			keys[3].push(new ScreenKeyboardKey('C',				ImageKeyC));
			keys[3].push(new ScreenKeyboardKey('V',				ImageKeyV));
			keys[3].push(new ScreenKeyboardKey('B',				ImageKeyB));
			keys[3].push(new ScreenKeyboardKey('N',				ImageKeyN));
			keys[3].push(new ScreenKeyboardKey('M',				ImageKeyM));
			keys[3].push(new ScreenKeyboardKey('/',				ImageKeySLASH));
			keys[3].push(new ScreenKeyboardKey('ENTER',			ImageKeyENTER));
			
			keys[4].push(new ScreenKeyboardKey('@',				ImageKeyAT));
			keys[4].push(new ScreenKeyboardKey('#',				ImageKeyHASHTAG));
			keys[4].push(new ScreenKeyboardKey('.',				ImageKeyDOT));
			keys[4].push(new ScreenKeyboardKey('-',				ImageKeyDASH));
			keys[4].push(new ScreenKeyboardKey('_',				ImageKeyUNDERSCORE));
			keys[4].push(new ScreenKeyboardKey(' ',				ImageKeySPACE));
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function initKeyLayout():void
		{	
			for(var y:uint = 0; y < keys.length; y++)
			{
				for(var x:uint = 0; x < keys[y].length; x++)
				{
					var tmpKey:ScreenKeyboardKey	= keys[y][x];
					tmpKey.x					= (((x * KEY_SIZE.x) + (x * KEY_MARGIN.x)) + KEY_INIT_MARGIN.x);
					tmpKey.y					= (((y * KEY_SIZE.y) + (y * KEY_MARGIN.y)) + KEY_INIT_MARGIN.y);
					
					addChild(tmpKey);
				}
			}
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function updateKeys():void
		{	
			for(var y:uint = 0; y < keys.length; y++)
			{
				for(var x:uint = 0; x < keys[y].length; x++)
				{
					var tmpKey:ScreenKeyboardKey = keys[y][x];
					tmpKey.playAnimation(tmpKey.IDLE);
					tmpKey.update();
				}
			}
			
			var selectedKey:ScreenKeyboardKey = keys[selectedKey.y][selectedKey.x];
			selectedKey.playAnimation(selectedKey.SELECTED);
			selectedKey.update();
		}
		
		/**
		 *
		 * DESC..
		 *
		 * TODO: SNYGGA TILL..
		 */
		private function updateSelectedKey():void
		{	
			if(!_active) return;
			
			var rowSkip:Boolean	= false;
			var tmpX:uint		= selectedKey.x;
			var tmpY:uint		= selectedKey.y
			
			if(Session.keyboard.pressedOnce(controls.PLAYER_UP)){
				selectedKey.y--;
				rowSkip = true;
			}
			
			if(Session.keyboard.pressedOnce(controls.PLAYER_DOWN)){
				selectedKey.y++;
				rowSkip = true;
			}
			
			if( selectedKey.y < 0){
				selectedKey.y = (keys.length - 1);
			}
			
			if( selectedKey.y > (keys.length - 1)){
				selectedKey.y = 0;
			}
			
			if(Session.keyboard.pressedOnce(controls.PLAYER_LEFT)){
				selectedKey.x--;
			}
			
			if(Session.keyboard.pressedOnce(controls.PLAYER_RIGHT)){
				selectedKey.x++;
			}
			
			if( selectedKey.x < 0){
				
				if(!rowSkip)
				{
					selectedKey.x = (keys[selectedKey.y].length - 1);
					return;
				}
				
				while(selectedKey.x < (keys[selectedKey.y].length - 1))
				{
					selectedKey.x++;
				}
			}
			
			if(selectedKey.x > (keys[selectedKey.y].length - 1))
			{
				if(!rowSkip)
				{
					selectedKey.x = 0;
					return;
				}
				
				while(selectedKey.x > (keys[selectedKey.y].length - 1))
				{
					selectedKey.x--;
				}
			}
			
			if(Session.keyboard.pressedOnce(controls.PLAYER_BUTTON_1)){
				handleInput(keys[selectedKey.y][selectedKey.x].value);
			}
			
			if(tmpX != selectedKey.x || tmpY != selectedKey.y)
			{
				Session.sound.play(SOUND_MOVE, volume);
			}
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function handleInput(value:String):void
		{	
			Session.sound.play(SOUND_SELECT, volume);
			
			if(textField.textColor != 0x333333){
				textField.textColor = 0x333333;
				textField.text		= '';
			}
			
			switch(value)
			{
				case 'BACKSPACE':
					textField.text = textField.text.substring(0, (textField.text.length - 1));
					break;
				
				case 'ENTER':
					slideOut();
					break;
				
				default:
					textField.appendText(value);
					break;
			}
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function slideIn():void
		{	
			if(_active == true) return;
			
			Session.application.stage.addChild(this);
			
			this.y 						= Session.height;
			this._active				= true;
			
			var tweenSettings:Object	= new Object();
			tweenSettings.y			= ((Session.height * 0.5) - (height * 0.5));
			tweenSettings.ease		= Quad.easeOut;
			
			TweenLite.to(this, transitionSpeed, tweenSettings);
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function slideOut():void
		{	
			if(_active == false) return;
			
			this.y						= ((Session.height * 0.5) - (height * 0.5));
			this._active				= false;
			
			var tweenSettings:Object 	= new Object();
			tweenSettings.y		 		= (0 - height);
			tweenSettings.onComplete	= this.dealloc;
			tweenSettings.ease			= Quad.easeIn;
			
			TweenLite.to(this, transitionSpeed, tweenSettings);
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function dealloc(abort:Boolean = false):void
		{	
			deallocSound();
			parent.removeChild(this);
			
			if(!forceQuit){
				callback(textField.text);
			}
		}
		
		/**
		 *
		 * DESC..
		 *
		 */
		private function deallocSound():void
		{
			Session.sound.remove(SOUND_MOVE);
			Session.sound.remove(SOUND_SELECT);
		}
	}
}