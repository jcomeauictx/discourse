package view
{
    import flash.media.Sound;
    import flash.net.URLRequest;
    
    import spark.components.Alert;
    
    import controller.client.events.MessageToServerEvent;
    import controller.client.events.UserDiscussionEvent;
    import controller.common.events.clienttoserver.DiscussionEventData;
    import controller.common.events.clienttoserver.DiscussionViewEvent;
    import controller.common.events.servertoclient.DiscussionStateEvent;
    import controller.common.events.servertoclient.UserTurnEvent;
    
    import model.ClientSynchronizer;
    
    import robotlegs.bender.bundles.mvcs.Mediator;
    
    import service.client.Messenger;
    
    public class DiscussionMediator extends Mediator
    {
        [Inject]
        public var discussionView:Discussion;
        [Inject]
        public var messenger:Messenger;
        [Inject]
        public var clientSynchronizer:ClientSynchronizer;
        
        private var beep:Sound = new Sound(new URLRequest('resources/sounds/beep.mp3'));
        
        public function DiscussionMediator()
        {
            super();
        }
        
        override public function initialize():void
        {
            addViewListener(UserDiscussionEvent.REQUEST_TO_SPEAK, onUserDiscussionEvent, UserDiscussionEvent);
            addViewListener(UserDiscussionEvent.RELINQUISH_TURN, onUserDiscussionEvent, UserDiscussionEvent);
            addContextListener(DiscussionStateEvent.DISCUSSION_OVER, onDiscussionOver);
            addContextListener(DiscussionStateEvent.DISCUSSION_IDLE, onDiscussionIdle);
            addContextListener(UserTurnEvent.TURN_ACCEPTED, onTurnAccepted);
        }
        
        private function onUserDiscussionEvent(e:UserDiscussionEvent):void
        {
            var queueFunction:Function = e.type == UserDiscussionEvent.REQUEST_TO_SPEAK ?
                dispatchRequestToSpeakMessage : dispatchReliniquishTurn;
            trace('client considering sending ' + e.type);
            clientSynchronizer.insertToQueue(queueFunction);
        }
        
        private function dispatchRequestToSpeakMessage():void
        {
            dispatchMessage(DiscussionViewEvent.REQUEST_TO_SPEAK);
        }
        
        private function dispatchReliniquishTurn():void
        {
            dispatchMessage(DiscussionViewEvent.RELINQUISH_TURN);
        }
        
        private function dispatchMessage(eventType:String):void
        {
           var message:DiscussionEventData = new DiscussionEventData();
           message.eventType = eventType;
           dispatch(new MessageToServerEvent(MessageToServerEvent.MESSAGE_SEND_REQUESTED, message));
        }
        
        private function onDiscussionOver(e:DiscussionStateEvent):void
        {
            Alert.show("Discussion is over.");
            discussionView.message = "";
        }
        
        private function onDiscussionIdle(e:DiscussionStateEvent):void
        {
            discussionView.message = "Waiting for new speaker.";
        }
        
        private function onTurnAccepted(e:UserTurnEvent):void
        {
            discussionView.message = "Current speaker is " + e.userTurnEventData.userName + ".";
            beep.play();
        }
        
    }
}