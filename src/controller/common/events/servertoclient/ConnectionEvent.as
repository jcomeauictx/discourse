package controller.common.events.servertoclient
{
    import flash.events.Event;
    
    import controller.common.DataEvent;
    
    public class ConnectionEvent extends DataEvent
    {
        public static const USER_REGISTERED:String = "USER_REGISTERED";
        public static const LOGGED_IN:String = "LOGGED_IN";
        public static const LOGGED_OUT:String = "LOGGED_OUT";
        
        public function ConnectionEvent(type:String, connectionEventData:ConnectionEventData, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, connectionEventData, bubbles, cancelable);
        }
        
        public function get connectionEventData():ConnectionEventData
        {
            return ConnectionEventData(eventData);
        }
        
        override public function clone():Event
        {
            return new ConnectionEvent(type, connectionEventData, bubbles, cancelable);
        }
    }
}