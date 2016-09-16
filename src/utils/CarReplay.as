package utils
{
	import flash.display.MovieClip;
	
	import se.lnu.mediatechnology.stickossdk.display.IStickOsDisplayObject;

	public class CarReplay extends MovieClip implements IStickOsDisplayObject
	{
		public var lastLapX:Vector.<Number> = new Vector.<Number>();
		public var lastLapY:Vector.<Number> = new Vector.<Number>();
		
		private var _x:Number;
		private var _y:Number;
		
		private var replay:mc_car = new mc_car();
		
		
		public function CarReplay($x:Number, $y:Number){
			_x = $x;
			_y = $y;
			trace("carrep")
		}
		
		public function init():void {
			addChild(replay);
			this.alpha = 0;
			this.x = _x;
			this.y = _y;
			trace("initCarprerp" + this);
		}

		public function update():void {			
		}
		
		public function dealloc():void {
			resetArray();
			removeChild(replay);
		}
		
		public function pushArray($x:Number, $y:Number):void
		{
			lastLapX.push($x);
			lastLapY.push($y);
		}
		
		public function moveReplay():void
		{
			this.x = lastLapX[0];
			this.y = lastLapY[0];
			
			lastLapX.splice(0,1);
			lastLapY.splice(0,1);
		}
		
		public function resetArray():void
		{
			lastLapX.splice(0, lastLapX.length);
			lastLapY.splice(0, lastLapY.length);
		}
	}
}