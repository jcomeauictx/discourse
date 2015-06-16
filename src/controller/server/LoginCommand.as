package controller.server
{
    import flash.desktop.NativeApplication;
    
    import base.BaseActor;
    
    import controller.common.events.clienttoserver.LoginEvent;
    import controller.common.events.clienttoserver.LoginEventData;
    import controller.common.events.servertoclient.ConnectionEvent;
    import controller.common.events.servertoclient.ConnectionEventData;
    
    import model.DiscussionModel;
    import model.User;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommand;
    
    import service.server.Server;
    import service.server.UserFetcher;
    
    public class LoginCommand extends BaseActor implements ICommand
    {
        [Inject]
        public var loginEvent:LoginEvent;
        [Inject]
        public var userFetcher:UserFetcher;
        [Inject]
        public var discussion:DiscussionModel;
        [Inject]
        public var server:Server;
        
        public function execute():void
        {
            var user:User = new User();
            user.name = loginEvent.loginEventData.loginName;
            var connectionId:int = loginEvent.loginEventData.connectionId;
            userFetcher.setUser(connectionId, user);
            discussion.addMember(user);
            var connectionEventData:ConnectionEventData = new ConnectionEventData();
            connectionEventData.eventType = ConnectionEvent.LOGGED_IN;
            server.sendMessage(connectionId, connectionEventData);
        }
        
    }
}
