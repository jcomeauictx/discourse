package
{
    import spark.components.ViewNavigator;
    
    import controller.client.ClientMessageReceivedCommand;
    import controller.client.ConnectToServerCommand;
    import controller.client.LoggedOutCommand;
    import controller.client.MessageSendRequestedCommand;
    import controller.client.ServerMessageReceivedCommand;
    import controller.client.UserRegisteredCommand;
    import controller.client.events.MessageToServerEvent;
    import controller.client.events.MessengerEvent;
    import controller.client.events.UserDiscussionEvent;
    import controller.common.events.clienttoserver.DiscussionViewEvent;
    import controller.common.events.clienttoserver.LoginEvent;
    import controller.common.events.servertoclient.ConnectionEvent;
    import controller.server.CallItADayCommand;
    import controller.server.DiscussionIdleCommand;
    import controller.server.DiscussionOverCommand;
    import controller.server.DiscussionParametersEditedCommand;
    import controller.server.LoginCommand;
    import controller.server.ModestFirstResetStrategy;
    import controller.server.ModestFirstStrategy;
    import controller.server.RequestOrRelinquishTurnCommand;
    import controller.server.StartOverCommand;
    import controller.server.StartServerCommand;
    import controller.server.UserTurnCommand;
    import controller.server.events.ClockEvent;
    import controller.server.events.DiscussionEvent;
    import controller.server.events.DiscussionParametersEvent;
    import controller.server.events.UserEvent;
    
    import model.ClientSynchronizer;
    import model.Clock;
    import model.DiscussionModel;
    import model.ModestDiscussion;
    import model.Synchronizer;
    
    import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.framework.api.IConfig;
    import robotlegs.bender.framework.api.IInjector;
    
    import service.client.Messenger;
    import service.common.Persistence;
    import service.common.SocketHelper;
    import service.server.Server;
    import service.server.UserFetcher;
    
    import view.Discussion;
    import view.DiscussionEditor;
    import view.DiscussionEditorMediator;
    import view.DiscussionMediator;
    import view.HomePage;
    import view.HomePageMediator;
    import view.Report;
    import view.ReportMediator;
    import view.ViewNavigatorMediator;
    
    public class DiscourseConfig implements IConfig
    {
        [Inject]
        public var injector:IInjector;
        
        [Inject]
        public var mediatorMap:IMediatorMap;
        
        [Inject]
        public var commandMap:IEventCommandMap;
        
        public function configure():void
        {
            // client commands
            commandMap.map(MessengerEvent.SERVER_MESSAGE_RECEIVED, MessengerEvent).toCommand(ServerMessageReceivedCommand);
            commandMap.map(MessengerEvent.CLIENT_MESSAGE_RECEIVED, MessengerEvent).toCommand(ClientMessageReceivedCommand);
            commandMap.map(UserDiscussionEvent.CONNECT_TO_SERVER, UserDiscussionEvent).toCommand(ConnectToServerCommand);
            commandMap.map(MessageToServerEvent.MESSAGE_SEND_REQUESTED, MessageToServerEvent).toCommand(MessageSendRequestedCommand);
            commandMap.map(ConnectionEvent.USER_REGISTERED, ConnectionEvent).toCommand(UserRegisteredCommand);
            commandMap.map(ConnectionEvent.LOGGED_OUT, ConnectionEvent).toCommand(LoggedOutCommand);
            // server commands
            // UserDiscussionEvent is a client side event but it can serve for turning a client into a server
            commandMap.map(UserDiscussionEvent.START_SERVER, UserDiscussionEvent).toCommand(StartServerCommand);
            commandMap.map(ClockEvent.TIME_TO_ACT, ClockEvent).toCommand(ModestFirstStrategy);
            commandMap.map(ClockEvent.RESET_CLOCK, ClockEvent).toCommand(ModestFirstResetStrategy);
            commandMap.map(DiscussionEvent.DISCUSSION_IDLE, DiscussionEvent).toCommand(DiscussionIdleCommand);
            commandMap.map(DiscussionEvent.DISCUSSION_OVER, DiscussionEvent).toCommand(DiscussionOverCommand);
            commandMap.map(DiscussionViewEvent.RELINQUISH_TURN, DiscussionViewEvent).toCommand(RequestOrRelinquishTurnCommand);
            commandMap.map(DiscussionViewEvent.REQUEST_TO_SPEAK, DiscussionViewEvent).toCommand(RequestOrRelinquishTurnCommand);
            commandMap.map(DiscussionViewEvent.CALL_IT_A_DAY, DiscussionViewEvent).toCommand(CallItADayCommand);
            commandMap.map(DiscussionViewEvent.START_OVER, DiscussionViewEvent).toCommand(StartOverCommand);
            commandMap.map(UserEvent.TURN_ACCEPTED, UserEvent).toCommand(UserTurnCommand);
            commandMap.map(LoginEvent.LOGIN, LoginEvent).toCommand(LoginCommand);
            commandMap.map(DiscussionParametersEvent.EDITED, DiscussionParametersEvent).toCommand(DiscussionParametersEditedCommand);

            // mediators
            mediatorMap.map(Discussion).toMediator(DiscussionMediator);
            mediatorMap.map(DiscussionEditor).toMediator(DiscussionEditorMediator);
            mediatorMap.map(HomePage).toMediator(HomePageMediator);
            mediatorMap.map(ViewNavigator).toMediator(ViewNavigatorMediator);
            mediatorMap.map(Report).toMediator(ReportMediator);
            // services
            injector.map(Server).asSingleton();
            injector.map(Messenger).asSingleton();
            injector.map(UserFetcher).asSingleton();
            injector.map(Clock).asSingleton();
            injector.map(SocketHelper).asSingleton();
            injector.map(Persistence).asSingleton();
            // models
            var modestDiscussion:ModestDiscussion = new ModestDiscussion();
            injector.map(ModestDiscussion).toValue(modestDiscussion);
            injector.map(DiscussionModel).toValue(modestDiscussion);
            injector.map(Synchronizer).asSingleton();
            injector.map(ClientSynchronizer).asSingleton();
        }
    }
}