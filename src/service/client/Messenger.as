package service.client
{
    import flash.desktop.NativeApplication;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.Socket;
    import flash.utils.ByteArray;
    
    import base.BaseActor;
    
    import controller.client.events.MessengerEvent;
    
    public class Messenger extends BaseActor
    {
        private var socket:Socket;
        public var connectionId:int;
        
        public function Messenger()
        {
            super();
            socket = new Socket();
            NativeApplication.nativeApplication.executeInBackground = true; // make sure sockets don't die in ios sleep mode
            socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
        }
        
        protected function socketDataHandler(event:ProgressEvent):void
        {
            var messengerEvent:MessengerEvent = new MessengerEvent(MessengerEvent.SERVER_MESSAGE_RECEIVED, socket);
            dispatch(messengerEvent);
        }
        
        protected function ioErrorHandler(event:IOErrorEvent):void
        {
            trace("ioErrorHandler: " + event);
        }
        
        public function sendMessage(obj:Object):void
        {
            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(obj);
            socket.writeBytes(bytes);
            socket.flush();
        }
        
        public function connect(host:String, port:int):void
        {
            socket.connect(host, port);
        }
                
    }
}