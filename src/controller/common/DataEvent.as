package controller.common
{
    import flash.events.Event;
    
    public class DataEvent extends Event
    {
        protected var eventData:EventData;
        
        public function DataEvent(type:String, data:EventData, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            eventData = data;
        }
    }
}