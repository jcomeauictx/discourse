package controller.client.events
{
    import flash.events.Event;
    import flash.net.Socket;
    
    public class MessengerEvent extends Event
    {
        public static const SERVER_MESSAGE_RECEIVED:String = "SERVER_MESSAGE_RECEIVED";
        public static const CLIENT_MESSAGE_RECEIVED:String = "CLIENT_MESSAGE_RECEIVED";
        public var socket:Socket;
        
        public function MessengerEvent(type:String, socketValue:Socket, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
            socket = socketValue;
        }
        
        override public function clone():Event
        {
            return new MessengerEvent(type, socket, bubbles, cancelable);
        }
        
    }
}