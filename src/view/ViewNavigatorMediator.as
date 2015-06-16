package view
{
    import spark.components.ViewNavigator;
    
    import controller.client.events.UserDiscussionEvent;
    import controller.common.events.servertoclient.ConnectionEvent;
    import controller.common.events.servertoclient.DiscussionStateEvent;
    import controller.server.events.DiscussionParametersEvent;
    
    import robotlegs.bender.bundles.mvcs.Mediator;
    
    public class ViewNavigatorMediator extends Mediator
    {
        [Inject]
        public var viewInstance:ViewNavigator;
        
        public function ViewNavigatorMediator()
        {
            super();
        }
        
        override public function initialize():void
        {
            addContextListener(ConnectionEvent.LOGGED_IN, onUserLoggedIn);
            addContextListener(UserDiscussionEvent.START_SERVER_REQUESTED, onStartServerRequested);
            addContextListener(DiscussionParametersEvent.EDITED, onEdited);
            addContextListener(DiscussionStateEvent.DISCUSSION_OVER, onDiscussionOver);
        }
        
        private function onDiscussionOver(e:DiscussionStateEvent):void
        {
            viewInstance.pushView(Report, e.discussionEventData.users);
        }
        
        private function onEdited(e:DiscussionParametersEvent):void
        {
            viewInstance.popToFirstView();
        }
        
        private function onStartServerRequested(e:UserDiscussionEvent):void
        {
            viewInstance.pushView(DiscussionEditor);
        }
        
        private function onUserLoggedIn(e:ConnectionEvent):void
        {
            viewInstance.pushView(Discussion);
        }
        
    }
}