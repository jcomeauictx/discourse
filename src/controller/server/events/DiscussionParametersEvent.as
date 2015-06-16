package controller.server.events
{
    import flash.events.Event;
    
    public class DiscussionParametersEvent extends Event
    {
        public static const EDITED:String = "DiscussionParametersEvent_EDITED";
        public var totalTime:Number;
        public var turnLength:Number;
        
        public function DiscussionParametersEvent(type:String, totalTimeValue:Number, turnLengthValue:Number, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            totalTime = totalTimeValue;
            turnLength = turnLengthValue;
            super(type, bubbles, cancelable);
        }
        
        override public function clone():Event
        {
            return new DiscussionParametersEvent(type, totalTime, turnLength, bubbles, cancelable);
        }
        
    }
}