package controller.server.events
{
    import flash.events.Event;
    
    public class DiscussionEvent extends Event
    {
        public static const DISCUSSION_OVER:String = "DiscussionEvent_DISCUSSION_OVER";
        public static const DISCUSSION_IDLE:String = "DiscussionEvent_DISCUSSION_IDLE";
        
        public function DiscussionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new DiscussionEvent(type, bubbles, cancelable);
        }
        
    }
}