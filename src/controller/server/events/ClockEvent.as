package controller.server.events
{
	import flash.events.Event;
	
	
	public class ClockEvent extends Event
	{
		public static const TIME_TO_ACT:String = "TIME_TO_ACT";
		public static const RESET_CLOCK:String = "RESET_CLOCK";
        public function ClockEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new ClockEvent(type, bubbles, cancelable);
        }

	}
}