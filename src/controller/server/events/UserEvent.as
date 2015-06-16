package controller.server.events
{
	import flash.events.Event;
	
	import model.User;
	
	
	public class UserEvent extends Event
	{
		public static const TURN_ACCEPTED:String = "UserEvent_TURN_ACCEPTED";
		
		public var user:User;
		public function UserEvent(type:String, userValue:User=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			user = userValue;
		}
		
		override public function clone():Event
		{
			return new UserEvent(type, user, bubbles, cancelable);
		}
	}
}