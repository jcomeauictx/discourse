package model
{
    import flash.utils.Dictionary;

    public class Synchronizer
    {
        public var lastClientReceivedTime:Number;
        private var serverReceivedMap:Dictionary;
        
        public function Synchronizer()
        {
            lastClientReceivedTime = 0;
            serverReceivedMap = new Dictionary(true);
        }

        public function getLastTimeReceivedFromClient(connectionId:Number):Number
        {
           var lastTime:Number = Number(serverReceivedMap[String(connectionId)]);
           if (isNaN(lastTime))
           {
               return 0;
           }
           return lastTime;
        }

        public function setLastTimeReceivedFromClient(connectionId:Number, time:Number):void
        {
            serverReceivedMap[String(connectionId)] = time;
        }

    }
}