package controller.server
{
    import base.BaseActor;
    
    import controller.common.events.servertoclient.DiscussionStateEvent;
    import controller.common.events.servertoclient.DiscussionStateEventData;
    
    import model.DiscussionModel;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommand;
    
    import service.server.Server;
    
    public class DiscussionIdleCommand extends BaseActor implements ICommand
    {
        [Inject]
        public var server:Server;
        [Inject]
        public var discussion:DiscussionModel;
        
        public function execute():void
        {
            // change discussion data
            discussion.currentSpeakerName = null;
            // relay message to clients
            var discussionStateEventData:DiscussionStateEventData = new DiscussionStateEventData();
            discussionStateEventData.eventType = DiscussionStateEvent.DISCUSSION_IDLE;
            server.broadCast(discussionStateEventData);
        }
        
    }
}

