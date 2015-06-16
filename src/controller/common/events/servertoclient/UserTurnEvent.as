package controller.common.events.servertoclient
{
    import flash.events.Event;
    
    import controller.common.DataEvent;
    
    public class UserTurnEvent extends DataEvent
    {
        public static const TURN_ACCEPTED:String = "UserTurnEvent_TURN_ACCEPTED";
        
        public function UserTurnEvent(type:String, userTurnEventData:UserTurnEventData, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, userTurnEventData, bubbles, cancelable);
        }
        
        public function get userTurnEventData():UserTurnEventData
        {
            return UserTurnEventData(eventData);
        }
        
        override public function clone():Event
        {
            return new UserTurnEvent(type, userTurnEventData, bubbles, cancelable);
        }
    }
}

