package controller.client.events
{
    import flash.events.Event;
    
    import controller.common.ClientEventData;
    
    public class MessageToServerEvent extends Event
    {
        public static const MESSAGE_SEND_REQUESTED:String = "MESSAGE_SEND_REQUESTED";
        public var clientEventData:ClientEventData;
        
        public function MessageToServerEvent(type:String, clientEventDataValue:ClientEventData, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            clientEventData = clientEventDataValue;
        }
        
        override public function clone():Event
        {
            return new MessageToServerEvent(type, clientEventData, bubbles, cancelable);
        }
        
    }
}