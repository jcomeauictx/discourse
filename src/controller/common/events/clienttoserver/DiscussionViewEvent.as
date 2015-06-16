package controller.common.events.clienttoserver
{
    import flash.events.Event;
    
    import controller.common.DataEvent;
    import controller.common.EventData;
    
    public class DiscussionViewEvent extends DataEvent
    {
        public static const REQUEST_TO_SPEAK:String = "REQUEST_TO_SPEAK";
        public static const RELINQUISH_TURN:String = "RELINQUISH_TURN";
        
        public function DiscussionViewEvent(type:String, eventData:EventData, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, eventData, bubbles, cancelable);
        }
        
        public function get discussionEventData():DiscussionEventData
        {
            return DiscussionEventData(eventData);
        }
        
        override public function clone():Event
        {
            return new DiscussionViewEvent(type, discussionEventData, bubbles, cancelable);
        }
    }
}