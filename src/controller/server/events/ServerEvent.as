package controller.server.events
{
	import flash.events.Event;
	
	
	public class ServerEvent extends Event
	{
		public static const STARTED:String = "STARTED";
        
        public function ServerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }

        override public function clone():Event
        {
            return new ServerEvent(type, bubbles, cancelable);
        }

	}
}