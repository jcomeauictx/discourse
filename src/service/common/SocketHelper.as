package service.common
{
    import flash.net.Socket;
    import flash.utils.ByteArray;

    public class SocketHelper
    {
        public function SocketHelper()
        {
        }
        
        public function readSocket(socket:Socket):Object
        {
            var fromServer:ByteArray = new ByteArray();
            while( socket.bytesAvailable )
            {
                socket.readBytes( fromServer );
            }
            fromServer.position = 0;
            var result:Object = fromServer.readObject();
            return result;
        }
    }
}