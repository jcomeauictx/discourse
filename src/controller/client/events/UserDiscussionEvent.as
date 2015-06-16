package controller.client.events
{
    import flash.events.Event;
    
    public class UserDiscussionEvent extends Event
    {
        public static const REQUEST_TO_SPEAK:String = "UserDiscussionEvent_REQUEST_TO_SPEAK";
        public static const RELINQUISH_TURN:String = "UserDiscussionEvent_RELINQUISH_TURN";
        public static const START_SERVER:String = "START_SERVER";
        public static const START_SERVER_REQUESTED:String = "START_SERVER_REQUESTED";
        public static const CONNECT_TO_SERVER:String = "CONNECT_TO_SERVER";
        
        public function UserDiscussionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new UserDiscussionEvent(type, bubbles, cancelable);
        }
        
    }
}