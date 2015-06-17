package controller.server
{
    import controller.common.events.servertoclient.ConnectionEvent;
    import controller.common.events.servertoclient.ConnectionEventData;
    import controller.common.events.servertoclient.DiscussionStateEvent;
    import controller.common.events.servertoclient.DiscussionStateEventData;
    
    import model.DiscussionModel;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommand;
    
    import service.server.Server;
    
    public class StartOverCommand implements ICommand
    {
        [Inject]
        public var server:Server;
        [Inject]
        public var discussionModel:DiscussionModel;
        
        
        public function execute():void
        {
            var discussionStateEventData:DiscussionStateEventData = new DiscussionStateEventData();
            discussionStateEventData.eventType = DiscussionStateEvent.DISCUSSION_RESTARTED;
            discussionModel.beganAt = new Date().time;
            server.broadCast(discussionStateEventData);
        }
        
    }
}

