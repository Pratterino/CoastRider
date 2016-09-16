package object
{
	//------------------------------------------------------------------------------
	//
	// Imports
	//
	//------------------------------------------------------------------------------
	import com.greensock.data.VarsCore;
	
	import control.ArduinoAcc;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import math.Collision;
	
	import se.lnu.mediatechnology.stickossdk.application.State;
	import se.lnu.mediatechnology.stickossdk.core.Session;
	import se.lnu.mediatechnology.stickossdk.display.IStickOsDisplayObject;
	import se.lnu.mediatechnology.stickossdk.input.SuperControls;
	import se.lnu.mediatechnology.stickossdk.utils.Utils;
	
	import state.GameState;
	
	import utils.CarReplay;
	
	//------------------------------------------------------------------------------
	//
	// Public class
	//
	//------------------------------------------------------------------------------
	
	/**
	 *
	 *	Class representing the singleplayer dwarf instance.  
	 * 
	 *	@author		Pär Strandberg
	 *	@version 	1.0
	 *
	 */
	public class Car extends MovieClip implements IStickOsDisplayObject
	{
		//--------------------------------------------------------------------------
		//
		// Private properties
		//
		//--------------------------------------------------------------------------			
		public var car:MovieClip			= new mc_car();
		
		private var controls:SuperControls	= new SuperControls();
		public  var arduino:ArduinoAcc		= new ArduinoAcc();
		private var runningState:GameState;
		
		private var acceleration:Number		= 0.4;
		private var speed_decay:Number		= 0.96;
		private var rotation_step:Number	= 4.3;
		private var max_speed:Number		= 5;
		private var back_speed:Number		= 2.5;
		private var speed:Number			= 0;
		
		public var hitBox:Sprite;
		
		//------------------------------------------------------------------------------
		//
		// Constructor method
		//
		//------------------------------------------------------------------------------
		/**
		 * 
		 *	The class constructor.
		 * 
		 *	@return void
		 * 
		 */
		public function Car($state:GameState) {
			super();
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
			buildPlayer();
		}
		/**
		 *
		 * 	Updates every frame.
		 * 
		 *	@return void
		 *
		 */
		public function update():void {			
			arduino.update();
			on_enter_frame();
			bounds();
			
			if (runningState.round.ROUND > 1)	{
				
				if (runningState.round.ROUND == 3 && runningState.collision.collectCount == 0) {
					for (var i:int = 0; i < runningState.collision.worldObjects.length; i++) 
					{
						if (runningState.collision.worldObjects[i] is CarReplay) {
							runningState.collision.worldObjects.splice(i,1);
						}
					}
				}
				
				else {
					runningState.replay.moveReplay();
				}
			}
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
			trace("single player car dealloc");
			super.removeChild(car);
			super.dealloc();
		}
		

		public function on_enter_frame():void {
			if (arduino.isDrivingForward && speed < max_speed) {
				speed += acceleration;
			}
			
			else if (arduino.isDrivingBackward && speed > -1) {
				speed -= back_speed;
			}
			
			var speed_x:Number = 	Math.sin(rotation*0.0174532925)*speed;
			var speed_y:Number =- 	Math.cos(rotation*0.0174532925)*speed;
			
			if (arduino.isTurningLeft) {
				rotation -= rotation_step*(speed/max_speed);
			}
			
			else if (arduino.isTurningRight) {
				rotation += rotation_step*(speed/max_speed);
			}
			
			y += speed_y;
			x += speed_x;
			
			if (Math.abs(speed)>0.3) {
				speed*=speed_decay;
			} 
			
			else {
				speed=0;
			}
		}
			
		//------------------------------------------------------------------------------
		//
		// Private methods
		//
		//------------------------------------------------------------------------------
		
		private function bounds():void
		{
			if (this.x > 800) 	this.x = 800;
			if (this.x < 0) 	this.x = 0;
			if (this.y < 0) 	this.y = 0;
			if (this.y > 550) 	this.y = 550;
			
			runningState.replay.pushArray(this.x, this.y);
		}
		
		/**
		 * This method is actually establishes the player on the map.  The score is set using
		 * update score and the flag is colored to the appropriate color of the player.  The dwarfs
		 * movie clip is then generated dynamically using the color string to build its reference and 
		 * then using this reference instanciates it and adds it to the scene.
		 * 
		 * 
		 * @return void
		 */
		private function buildPlayer():void
		{
			addCar();
		}
	
		/**
		 * 
		 * Matches the randomly generated color to the dwarf then adds the dwarf
		 * to the stage.
		 * 
		 * @return void
		 */
		private function addCar():void
		{		
			setInnerHitBox();
			addChild(car);
			car.gotoAndStop(1);
			trace("Car added!");
		}
		
		/**
		 * 
		 * Establishes a hitArea within the car.  This is what is used for most
		 * collision handling.  
		 * 
		 * @return void
		 */
		private function setInnerHitBox():void
		{
			car.hitArea 						= new Sprite();
			car.hitArea 						
			car.hitArea.graphics.beginFill		(0xFF00FF);
			car.hitArea.graphics.drawRect		(-9, -9, 25, 25);
			car.hitArea.graphics.endFill		();
			car.hitArea.visible 				= false;
			car.addChild						(car.hitArea);
			
			hitBox = car.hitArea; 
		}
	}
}