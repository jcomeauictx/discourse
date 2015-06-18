package controller.server
{
    import base.BaseActor;
    
    import controller.common.events.servertoclient.DiscussionStateEvent;
    import controller.common.events.servertoclient.DiscussionStateEventData;
    
    import model.DiscussionModel;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommand;
    
    import service.server.Server;
    
    public class DiscussionOverCommand extends BaseActor implements ICommand
    {
        [Inject]
        public var server:Server;
        [Inject]
        public var discussion:DiscussionModel;
        
        public function execute():void
        {
            // relay message to clients
            var discussionStateEventData:DiscussionStateEventData = new DiscussionStateEventData();
            discussionStateEventData.eventType = DiscussionStateEvent.DISCUSSION_OVER;
            discussionStateEventData.users = discussion.getUserList();
            server.broadCast(discussionStateEventData);
        }
        
    }
}

