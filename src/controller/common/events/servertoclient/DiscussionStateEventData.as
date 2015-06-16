package controller.common.events.servertoclient
{
    import avmplus.getQualifiedClassName;
    
    import controller.common.EventData;
    
    [RemoteClass(alias="controller.common.events.servertoclient.DiscussionStateEventData")]
    public class DiscussionStateEventData extends EventData
    {
        public var users:Array;
        
        public function DiscussionStateEventData()
        {
            eventClassName = getQualifiedClassName(DiscussionStateEvent);
        }
    }
}

