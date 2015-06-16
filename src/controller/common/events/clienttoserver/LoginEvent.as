package controller.common.events.clienttoserver
{
    import flash.events.Event;
    
    import controller.common.DataEvent;
    import controller.common.EventData;
    
    public class LoginEvent extends DataEvent
    {
        public static const LOGIN:String = "LOGIN";
        
        public function LoginEvent(type:String, eventData:EventData, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, eventData, bubbles, cancelable);
        }
        
        public function get loginEventData():LoginEventData
        {
            return LoginEventData(eventData);
        }
        
        override public function clone():Event
        {
            return new LoginEvent(type, loginEventData, bubbles, cancelable);
        }
    }
}
