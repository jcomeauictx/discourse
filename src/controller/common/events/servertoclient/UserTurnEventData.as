package controller.common.events.servertoclient
{
    import avmplus.getQualifiedClassName;
    
    import controller.common.EventData;
    
    [RemoteClass(alias="controller.common.events.servertoclient.UserTurnEvent")]
    public class UserTurnEventData extends EventData
    {
        public var connectionId:int;
        public var userName:String;
        
        public function UserTurnEventData()
        {
            eventClassName = getQualifiedClassName(UserTurnEvent);
        }
    }
}

