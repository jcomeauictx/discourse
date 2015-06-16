package controller.common.events.clienttoserver
{
    import avmplus.getQualifiedClassName;
    
    import controller.common.ClientEventData;
    
    [RemoteClass(alias="controller.common.events.clienttoserver.DiscussionEventData")]
    public class DiscussionEventData extends ClientEventData
    {
        public function DiscussionEventData()
        {
            eventClassName = getQualifiedClassName(DiscussionViewEvent);
        }
    }
}