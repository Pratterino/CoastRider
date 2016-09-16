package control
{
	
	/* 
	Flash - Arduino Example script
	version 2.0 : 20-10-2011
	copyleft : Kasper Kamperman - Art & Technology - Saxion
	
	This version includes support for the Arduino Mega. 
	Just set the isMega boolean below to true. 
	
	More info on how to setup up Arduino Flash communication : 
	http://www.kasperkamperman.com/blog/arduino/arduino-flash-communication-as3/
	The included 'readme.rtf'.
	
	Summary :
	- Set pinmodes (input, output, pwm, servo) in the defaultPinConfig array to the setup you use. 
	- Change the speed of the timer to your preference (now 25 fps).
	- Read/set inputs-outputs in the timerEvent function. The value of analog pin 0 is 
	now connected to the y-position of the ball instance on the stage.         
	*/
	
	//-----------------------------------------------------------------------
	//
	// Imports
	//
	//-----------------------------------------------------------------------
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import net.eriksjodin.arduino.Arduino;
	import net.eriksjodin.arduino.ArduinoWithServo;
	import net.eriksjodin.arduino.events.ArduinoEvent;
	import net.eriksjodin.arduino.events.ArduinoSysExEvent;
	
	public class ArduinoAcc
	{	
		
		// == VARIABLES =========================================================================
		//Arduino Object
		
		private var a:ArduinoWithServo = new ArduinoWithServo("127.0.0.1", 5331);	// connect to a serial proxy on port 5331
		private var maxAnaloginputs:int = 6;	//Arduino UNO Analog 
		
		public var ARDUINO_X:int; //Pin A0;
		public var ARDUINO_Y:int; //Pin A1;
		public var ARDUINO_Z:int; //Pin A2;
		
		//-----------------------------------------------------------------------
		//
		// Public Arduino-control properties
		//
		//-----------------------------------------------------------------------
		public var isTurningRight	:Boolean 	= false;
		public var isTurningLeft	:Boolean	= false;
		public var isDrivingForward	:Boolean	= false;
		public var isDrivingBackward:Boolean	= false;

		// Change this array to the pin configuration you use in your own setup.
		private var defaultPinConfig:Array = new Array(
			null,			// Pin 0   null (is RX)
			null,			// Pin 1   null (is TX)
			'digitalOut',  	// Pin 2   digitalIn or digitalOut 
			'digitalOut',  	// Pin 3   pwmOut or digitalIn or digitalOut 
			'digitalOut',  	// Pin 4   digitalIn or digitalOut  
			'digitalOut',  	// Pin 5   pwmOut or digitalIn or digitalOut 
			'digitalOut',  	// Pin 6   pwmOut or digitalIn or digitalOut 
			'digitalOut',  	// Pin 7   digitalIn or digitalOut  
			'digitalOut',  	// Pin 8   digitalIn or digitalOut  
			'digitalOut',  	// Pin 9   pwmOut or digitalIn or digitalOut or servo 
			'digitalOut',  	// Pin 10  pwmOut or digitalIn or digitalOut or servo
			'digitalOut',  	// Pin 11  pwmOut or digitalIn or digitalOut 
			'digitalOut',  	// Pin 12  digitalIn or digitalOut 
			'digitalOut'  	// Pin 13  digitalIn or digitalOut ( led connected )
		);
		
		public function ArduinoAcc() {
			
			// listen for connection 
			a.addEventListener(Event.CONNECT,onSocketConnect); 
			a.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			
			// listen for firmware (sent on startup)
			a.addEventListener(ArduinoEvent.FIRMWARE_VERSION, onReceiveFirmwareVersion);			
		}
		
		
		
		/**
		 *
		 * 	Updates every frame. (From Car)
		 * 
		 *	@return void
		 *
		 */
		public function update():void
		{
			readValues();
		}
		// == SETUP AND INITIALIZE CONNECTION ( don't modify ) ==================================
		
		// triggered when there is an IO Error
		private function errorHandler(errorEvent:IOErrorEvent):void 
		{   trace("- "+errorEvent.text);
			trace("- Did you start the Serproxy program ?");
		}
		
		// triggered when a serial socket connection has been established
		private function onSocketConnect(e:Object):void 
		{	trace("- Connection with Serproxy established. Wait one moment.");
			
			// request the firmware version
			a.requestFirmwareVersion();	
		}
		
		private function onReceiveFirmwareVersion(e:ArduinoEvent):void 
		{   trace("- Connection with Arduino - Firmata version: " + String(e.value)); 		
			trace("- Set default pin configuration.");
			
			// set Pinmodes by the default array. 
			for(var i:int = 2; i<defaultPinConfig.length; i++)
			{ // set digital output pins
				if(defaultPinConfig[i] == "digitalOut") a.setPinMode(i, Arduino.OUTPUT);
				if(defaultPinConfig[i] == "digitalIn")  a.setPinMode(i, Arduino.INPUT);
				if(defaultPinConfig[i] == "pwmOut")		a.setPinMode(i, Arduino.PWM);
			}	
			
			// you have to turn on reporting for every ANALOG pin individualy. 
			for(var j:int = 0; j<maxAnaloginputs; j++) {
				a.setAnalogPinReporting(j, Arduino.ON);	
			}
			// for digital pins its only one setting
			//a.enableDigitalPinReporting();	
		}
		
		// == YOUR PROGRAM HERE =================================================================
		
		
		private function readValues():void {
			ARDUINO_X = a.getAnalogData(0);
			//ARDUINO_Y = a.getAnalogData(1);
			//ARDUINO_Z = a.getAnalogData(2);
				
			isTurning(ARDUINO_X);
			isDriving(a.getAnalogData(3), a.getAnalogData(4));
		}
		
		
		private function isDriving(forwBtn:uint, backBtn:uint):void
		{
			if (forwBtn == 0 && backBtn > 0) {
				isDrivingForward 	= true;
				isDrivingBackward	= false;
			}
			
			else if (backBtn == 0 && forwBtn > 0) {
				isDrivingForward 	= false;
				isDrivingBackward	= true;
			}
			
			else {
				isDrivingForward 	= false;
				isDrivingBackward	= false;
			}
		}
		
		
		private function isTurning(number:uint):void {			
			if 		(number > 385) {
				isTurningLeft 	= true;
				isTurningRight 	= false;
			}
				
			else if (number < 305) {
				isTurningLeft 	= false;
				isTurningRight 	= true;
			}
			
			else {
				isTurningLeft 	= false;
				isTurningRight 	= false;
			}
		}
	}
}