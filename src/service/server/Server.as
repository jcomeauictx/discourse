package service.server
{
    import flash.errors.IOError;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.ServerSocketConnectEvent;
    import flash.net.ServerSocket;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    import flash.utils.setTimeout;
    
    import base.BaseActor;
    
    import controller.client.events.MessengerEvent;
    import controller.common.EventData;
    import controller.common.events.servertoclient.ConnectionEvent;
    import controller.common.events.servertoclient.ConnectionEventData;
    import controller.common.events.servertoclient.UserTurnEventData;
    import controller.server.events.ServerEvent;
    
    import model.User;

	public class Server extends BaseActor
	{
        private var connectionId:int = 0;
        private var server:ServerSocket;
        private var dictionary:Dictionary;
        
        [Inject]
        public var userFetcher:UserFetcher;
        
		public function Server()
		{
            server = new ServerSocket();
            dictionary = new Dictionary();
		}
        
        public function connect(port:int):void
        {
            server.addEventListener(Event.CONNECT, onConnect);
            server.bind(port);
            server.listen();
            dispatch(new ServerEvent(ServerEvent.STARTED));
        }
        
        public function get isOn():Boolean
        {
            return server && server.listening;
        }
        
        protected function onConnect(event:ServerSocketConnectEvent):void
        {
            trace(event.socket.localAddress + " just connected");
            connectionId++;
            dictionary[String(connectionId)] = event.socket;
            userFetcher.setUser(connectionId, new User());
            event.socket.addEventListener( ProgressEvent.SOCKET_DATA, onClientSocketData);
            var data:ConnectionEventData = new ConnectionEventData();
            data.eventType = ConnectionEvent.USER_REGISTERED;
            data.connectionId = connectionId;
            data.eventTime = new Date().time;
            event.socket.writeObject(data);
        }
        
        protected function onClientSocketData(event:ProgressEvent):void
        {
            var messengerEvent:MessengerEvent = new MessengerEvent(MessengerEvent.CLIENT_MESSAGE_RECEIVED, Socket(event.target));
            trace('client socket data received on server, sending messenger event');
            dispatch(messengerEvent);
        }
        
        public function broadCast(eventData:EventData):void
        {
            var now:Number = new Date().time;
            for (var currentConnectionId:String in dictionary)
            {
                sendMessage(Number(currentConnectionId), eventData, now);
            }
        }
        
        public function sendMessage(messageConnectionId:int, eventData:EventData, time:Number=NaN):void
        {
            if (isNaN(time))
            {
                time = new Date().time;
            }
            var socket:Socket = Socket(dictionary[String(messageConnectionId)]);
            var userEventData:UserTurnEventData = eventData as UserTurnEventData;
            if (userEventData)
            {
                trace("user name: " + userEventData.userName);
            }
            if (eventData)
            {
                eventData.eventTime = time;
                trace("=============Server sends message: " + eventData.eventType + " to: " + messageConnectionId + " or: " + userFetcher.getUserById(messageConnectionId).name + " time: " + eventData.eventTime);
                try {
                    var bytes:ByteArray = new ByteArray();
                    bytes.writeObject(eventData);
                    socket.writeBytes(bytes);
                    socket.flush();
                } catch (error:IOError)
                {
                    setTimeout(function():void
                    {
                        trace("XXX RETRY XXX Server sends message: " + eventData.eventType + " to: " + messageConnectionId + " or: " + userFetcher.getUserById(messageConnectionId).name + " time: " + eventData.eventTime);
                        try {
                            socket.flush();
                            socket.writeObject(eventData);
                        } catch (e:Error)
                        {
                            trace('Socket data lost');
                        }
                    }, 1000);
                }
            }
        }
    }
}