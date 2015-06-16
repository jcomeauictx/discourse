package model
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import base.BaseActor;
	
	import controller.server.events.ClockEvent;
	
	public class Clock extends BaseActor
	{
		private var timer:Timer;
		
		public function Clock()
		{
			super();
			timer = new Timer(100);
			timer.repeatCount = 1;
			timer.addEventListener(TimerEvent.TIMER, timerEventHandler, false, 0, true);
		}
		
		protected function timerEventHandler(event:TimerEvent):void
		{
			dispatch(new ClockEvent(ClockEvent.TIME_TO_ACT));
		}
		
		public function get delay():Number
		{
			return timer.delay;
		}

		public function set delay(value:Number):void
		{
			timer.delay = value;
			timer.reset();
			timer.start();
		}
		
		public function stop():void
		{
			timer.stop();	
		}

	}
}