package controller.common.events.servertoclient
{
    import flash.events.Event;
    
    import controller.common.DataEvent;
    
    public class DiscussionStateEvent extends DataEvent
    {
        public static const DISCUSSION_IDLE:String = "DISCUSSION_IDLE";
        public static const DISCUSSION_OVER:String = "DISCUSSION_OVER";
        
        public function DiscussionStateEvent(type:String, discussionEventData:DiscussionStateEventData, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, discussionEventData, bubbles, cancelable);
        }
        
        public function get discussionEventData():DiscussionStateEventData
        {
            return DiscussionStateEventData(eventData);
        }
        
        override public function clone():Event
        {
            return new DiscussionStateEvent(type, discussionEventData, bubbles, cancelable);
        }
    }
}

