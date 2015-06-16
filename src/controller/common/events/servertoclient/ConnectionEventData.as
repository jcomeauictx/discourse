package controller.common.events.servertoclient
{
    import flash.utils.getQualifiedClassName;
    
    import controller.common.EventData;
    
    [RemoteClass(alias="controller.common.events.servertoclient.ConnectionEventData")]
    public class ConnectionEventData extends EventData
    {
        public var connectionId:int;
        public function ConnectionEventData()
        {
            eventClassName = getQualifiedClassName(ConnectionEvent);
        }
    }
}