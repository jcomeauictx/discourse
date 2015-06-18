package controller.server
{
    import controller.common.events.servertoclient.ConnectionEvent;
    import controller.common.events.servertoclient.ConnectionEventData;
    
    import model.DiscussionModel;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommand;
    
    import service.server.Server;
    import service.server.UserFetcher;
    
    public class CallItADayCommand implements ICommand
    {
        [Inject]
        public var server:Server;
        [Inject]
        public var discussionModel:DiscussionModel;
        [Inject]
        public var userFetcher:UserFetcher;
        
        
        public function execute():void
        {
            var connectionEventData:ConnectionEventData = new ConnectionEventData();
            connectionEventData.eventType = ConnectionEvent.LOGGED_OUT;
            server.broadCast(connectionEventData);
            discussionModel.reset();
            userFetcher.reset();
            server.disconnect();
        }
        
    }
}

