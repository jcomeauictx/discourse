package view
{
    import controller.client.events.MessageToServerEvent;
    import controller.client.events.UserDiscussionEvent;
    import controller.common.events.clienttoserver.LoginEvent;
    import controller.common.events.clienttoserver.LoginEventData;
    import controller.common.events.servertoclient.ConnectionEvent;
    import controller.server.events.ServerEvent;
    
    import robotlegs.bender.bundles.mvcs.Mediator;
    
    import service.client.Messenger;
    import service.server.Server;
    
    public class HomePageMediator extends Mediator
    {
        [Inject]
        public var viewInstance:HomePage;
        [Inject]
        public var messenger:Messenger;
        [Inject]
        public var server:Server;
        
        public function HomePageMediator()
        {
            super();
        }
        
        override public function initialize():void
        {
            addViewListener(UserDiscussionEvent.START_SERVER_REQUESTED, dispatch, UserDiscussionEvent);
            addViewListener(UserDiscussionEvent.CONNECT_TO_SERVER, dispatch, UserDiscussionEvent);
            addContextListener(ServerEvent.STARTED, onServerStarted);
            addContextListener(ConnectionEvent.USER_REGISTERED, onUserRegistered);
            if (server.isOn)
            {
                hideStartServer();
            }
        }
        
        private function onServerStarted(event:ServerEvent):void
        {
            hideStartServer();
        }
        
        private function hideStartServer():void
        {
            viewInstance.showStartServer = false;
        }
        
        private function onUserRegistered(e:ConnectionEvent):void
        {
            var userName:String = viewInstance.userName;
            if (userName)
            {
                var loginData:LoginEventData = new LoginEventData;
                loginData.eventType = LoginEvent.LOGIN;
                loginData.loginName = viewInstance.userName;
                dispatch(new MessageToServerEvent(MessageToServerEvent.MESSAGE_SEND_REQUESTED, loginData));
            }
        }
        
    }
}