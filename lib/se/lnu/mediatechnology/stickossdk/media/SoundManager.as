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

package se.lnu.mediatechnology.stickossdk.media
{
	//--------------------------------------------------------------------------
	//
	// Imports
	//
	//--------------------------------------------------------------------------
	
	// IMPORT FROM GREENSOCK
	
	import com.greensock.TweenLite;
	
	// IMPORT FROM FLASH IDE
	
	import flash.media.ID3Info;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	//--------------------------------------------------------------------------
	//
	// Singleton class
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 
	 *	Sound Manager is a singelton class used to handle external audio files in 
	 *	StickOS SDK based games and applications.
	 * 
	 *	@author		Henrik Andersen
	 *	@version	1.0
	 * 
	 */
	public class SoundManager
	{
		//--------------------------------------------------------------------------
		//
		// Private static properties
		//
		//--------------------------------------------------------------------------
		
		private static var _instance:SoundManager;
		private static var _allowInstance:Boolean;
		
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _soundsDict:Dictionary;
		private var _sounds:Array;
		
		//--------------------------------------------------------------------------
		//
		// Constructor method
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 *	DESC..
		 *  
		 */
		public function SoundManager() 
		{
			this._soundsDict	= new Dictionary(true);
			this._sounds		= new Array();
		}
		
		//--------------------------------------------------------------------------
		//
		// Public getter methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 *	DESC..
		 * 
		 *	@return Array	The list that contains all the sounds.
		 * 
		 */
		public function get sounds():Array
		{
			return this._sounds;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public static methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 *	DESC..
		 * 
		 *	@return SoundManager	A instance of this class.
		 * 
		 */
		public static function getInstance():SoundManager 
		{
			if( SoundManager._instance == null){
				SoundManager._allowInstance	= true;
				SoundManager._instance		= new SoundManager();
				SoundManager._allowInstance = false;
			}
			
			return SoundManager._instance;
		}
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 
		 *	Adds a sound from the library to the sounds dictionary for playing in the future.
		 * 
		 *	@param 		linkageID 		The class name of the extenal sound object.
		 *	@param 		name 			The string identifier of the sound to be used when calling other methods on the sound.
		 * 
		 *	@return		Boolean			A boolean value representing if the sound was added successfully.
		 * 
		 */
		public function add(linkageID:*, name:String):Boolean
		{
			for (var i:int = 0; i < this._sounds.length; i++){
				if (this._sounds[i].name == name) return false;
			}
			
			var sndObj:Object		= new Object();
			var snd:Sound			= new linkageID;
			
			sndObj.name 			= name;
			sndObj.sound 			= snd as Sound;
			sndObj.channel 			= new SoundChannel();
			sndObj.position 		= 0;
			sndObj.paused 			= true;
			sndObj.volume 			= 1;
			sndObj.startTime 		= 0;
			sndObj.loops	 		= 0;
			sndObj.pausedByAll 		= false;
			
			this._soundsDict[name]	= sndObj;
			this._sounds.push(sndObj);
			
			return true;
		}
		
		/**
		 * 
		 *	Removes a sound from the sound dictionary. After calling this, the sound will not be 
		 *	available until it is re-added.
		 * 
		 *	@param	$name	The string identifier of the sound to remove
		 *
		 *	@return void
		 * 
		 */
		public function remove(name:String):void
		{
			for(var i:int = 0; i < this._sounds.length; i++)
			{
				if( this._sounds[i].name == name){
					this._sounds[i] = null;
					this._sounds.splice(i, 1);
				}
			}
			
			delete this._soundsDict[name];
		}
		
		/**
		 * 
		 *	Removes all sounds from the sound dictionary.
		 * 
		 *	@return void
		 * 
		 */
		public function removeAll():void
		{
			this.stopAll();
			
			for (var i:int = 0; i < this._sounds.length; i++){
				this._sounds[i] = null;
			}
			
			this._sounds	 = new Array();
			this._soundsDict = new Dictionary(true);
		}
		
		/**
		 * 
		 *	Plays or resumes a sound from the sound dictionary with the specified name.
		 * 
		 *	@param	name		The string identifier of the sound to play
		 *	@param	volume		A number from 0 to 1 representing the volume at which to play the sound (default: 1)
		 *	@param	startTime	A number (in milliseconds) representing the time to start playing the sound at (default: 0)
		 *	@param	loops		An integer representing the number of times to loop the sound (default: 0)
		 * 
		 *	@return void
		 * 
		 */
		public function play(name:String, volume:Number = 1, startTime:Number = 0, loops:int = 0):void
		{
			var snd:Object		= this._soundsDict[name];
				snd.volume		= volume;
				snd.startTime	= startTime;
				snd.loops		= loops;
			
			if(snd.paused)
			{
				snd.channel = snd.sound.play(snd.position, snd.loops, new SoundTransform(snd.volume));
			}
			else
			{
				snd.channel = snd.sound.play(startTime, snd.loops, new SoundTransform(snd.volume));
			}
			
			snd.paused = false;
		}
		
		/**
		 * 
		 *	Stops the specified sound.
		 * 
		 *	@param	name	The string identifier of the sound to stop.
		 * 
		 *	@return void
		 * 
		 */
		public function stop($name:String):void
		{
			var snd:Object	= this._soundsDict[$name];
				snd.paused	= true;
				
				snd.channel.stop();
				
				snd.position = snd.channel.position;
		}
		
		/**
		 * 
		 *	Pauses the specified sound.
		 * 
		 *	@param	name	The string identifier of the sound to pause.
		 * 
		 *	@return void
		 * 
		 */
		public function pause(name:String):void
		{
			var snd:Object 		= this._soundsDict[name];
				snd.paused 		= true;
				snd.position	= snd.channel.position;
				
				snd.channel.stop();
		}
		
		/**
		 * 
		 *	Plays all the sounds that are in the sound dictionary.
		 * 
		 *	@param	useCurrentlyPlayingOnly		A boolean that only plays the sounds which were currently playing before a pauseAll() or stopAll() call (default: false)
		 * 
		 *	@return void
		 * 
		 */
		public function playAll(useCurrentlyPlayingOnly:Boolean = false):void
		{
			for(var i:int = 0; i < this._sounds.length; i++)
			{
				var id:String = this._sounds[i].name;
				
				if(useCurrentlyPlayingOnly)
				{
					if( this._soundsDict[id].pausedByAll){
						this._soundsDict[id].pausedByAll = false;
						this.play(id);
					}
				}
				else
				{
					this.play(id);
				}
			}
		}
		
		/**
		 * 
		 *	Stops all the sounds that are in the sound dictionary.
		 * 
		 *	@param	useCurrentlyPlayingOnly		A boolean that only stops the sounds which are currently playing (default: true)
		 * 
		 * 	@return void
		 * 
		 */
		public function stopAll(useCurrentlyPlayingOnly:Boolean = true):void
		{
			for(var i:int = 0; i < this._sounds.length; i++)
			{
				var id:String = this._sounds[i].name;
				
				if(useCurrentlyPlayingOnly)
				{
					if(!this._soundsDict[id].paused){
						this._soundsDict[id].pausedByAll = true;
						this.stop(id);
					}
				}
				else
				{
					this.stop(id);
				}
			}
		}
		
		/**
		 * 
		 *	Pauses all the sounds that are in the sound dictionary.
		 * 
		 *	@param	useCurrentlyPlayingOnly		A boolean that only pauses the sounds which are currently playing (default: true)
		 *	
		 *	@return void
		 * 
		 */
		public function pauseAll(useCurrentlyPlayingOnly:Boolean = true):void
		{
			for(var i:int = 0; i < this._sounds.length; i++)
			{
				var id:String = this._sounds[i].name;
				
				if(useCurrentlyPlayingOnly)
				{
					if(!this._soundsDict[id].paused){
						this._soundsDict[id].pausedByAll = true;
						this.pause(id);
					}
				}
				else
				{
					pause(id);
				}
			}
		}
		
		/**
		 * 
		 *	Fades the sound to the specified volume over the specified amount of time.
		 * 
		 *	@param	name			The string identifier of the sound
		 *	@param	targVolume		The target volume to fade to, between 0 and 1 (default: 0)
		 *	@param	fadeLength		The time to fade over, in seconds (default: 1)
		 * 
		 *	@return void
		 * 
		 */
		public function fade(name:String, targVolume:Number = 0, fadeLength:Number = 1):void
		{
			var curTransform:SoundTransform = new SoundTransform();
			var fadeChannel:SoundChannel	= this._soundsDict[name].channel;
			
			TweenLite.to(curTransform, fadeLength, {volume: targVolume, onUpdate:function():void{
				fadeChannel.soundTransform	= curTransform;
			}});
		}
		
		/**
		 * 
		 *	Mutes the volume for all sounds in the sound dictionary.
		 * 
		 *	@return void
		 * 
		 */
		public function muteAll():void
		{
			for(var i:int = 0; i < this._sounds.length; i++){
				var id:String = this._sounds[i].name;
				
				this.setVolume(id, 0);
			}
		}
		
		/**
		 * 
		 *	Resets the volume to their original setting for all sounds in the sound dictionary.
		 * 
		 *	@return void
		 * 
		 */
		public function unmuteAll():void
		{
			for(var i:int = 0; i < this._sounds.length; i++){
				var id:String					= this._sounds[i].name;
				var snd:Object 					= this._soundsDict[id];
				var curTransform:SoundTransform = snd.channel.soundTransform;
					curTransform.volume 		= snd.volume;
					
				snd.channel.soundTransform		= curTransform;
			}
		}
		
		/**
		 * 
		 *	Sets the volume of the specified sound.
		 * 
		 *	@param	name	The string identifier of the sound
		 *	@param	volume	The volume, between 0 and 1, to set the sound to
		 * 
		 *	@return void
		 * 
		 */
		public function setVolume(name:String, volume:Number):void
		{
			var snd:Object					= this._soundsDict[name];
			var curTransform:SoundTransform = snd.channel.soundTransform;
				curTransform.volume			= volume;
				
			snd.channel.soundTransform = curTransform;
		}
		
		/**
		 * 
		 *	Gets the volume of the specified sound.
		 * 
		 *	@param	name	The string identifier of the sound.
		 * 
		 *	@return	Number	The current volume of the sound.
		 * 
		 */
		public function getVolume(name:String):Number
		{
			return this._soundsDict[name].channel.soundTransform.volume;
		}
		
		/**
		 * 
		 *	Gets the position of the specified sound.
		 * 
		 *	@param $name The string identifier of the sound
		 * 
		 *	@return Number The current position of the sound, in milliseconds.
		 * 
		 */
		public function getSoundPosition(name:String):Number
		{
			return this._soundsDict[name].channel.position;
		}
		
		/**
		 * 
		 *	Gets the duration of the specified sound.
		 * 
		 *	@param $name The string identifier of the sound.
		 * 
		 *	@return Number The length of the sound, in milliseconds.
		 * 
		 */
		public function getDuration(name:String):Number
		{
			return this._soundsDict[name].sound.length;
		}
		
		/**
		 * 
		 *	Gets the sound object of the specified sound.
		 * 
		 *	@param $name The string identifier of the sound.
		 * 
		 *	@return Sound The sound object.
		 * 
		 */
		public function getObject(name:String):Sound
		{
			return this._soundsDict[name].sound;
		}
		
		/**
		 * 
		 *	Retrieves the ID3 tag from an audio file, useful if you want the 
		 *	promote the sound artist during gameplay.
		 * 
		 *	@param $name The string identifier of the sound
		 * 
		 *	@return String The boolean value of paused or not paused
		 * 
		 */
		public function getID3(name:String):ID3Info
		{
			return this._soundsDict[name].id3;
		}
		
		/**
		 * 
		 *	Identifies if the sound is paused or not.
		 * 
		 *	@param	name	The string identifier of the sound.
		 * 
		 *	@return	Boolean	The boolean value of paused or not paused.
		 * 
		 */
		public function isPaused(name:String):Boolean
		{
			return this._soundsDict[name].paused;
		}
		
		/**
		 * 
		 *	Identifies if the sound was paused or stopped by calling the stopAll() or pauseAll() methods.
		 * 
		 *	@param	name	The string identifier of the sound.
		 * 
		 *	@return	Number	The boolean value of pausedByAll or not pausedByAll.
		 * 
		 */
		public function isPausedByAll(name:String):Boolean
		{
			return this._soundsDict[name].pausedByAll;
		}
	}
}