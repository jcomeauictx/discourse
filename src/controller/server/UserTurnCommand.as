package controller.server
{
    import base.BaseActor;
    
    import controller.common.events.servertoclient.UserTurnEvent;
    import controller.common.events.servertoclient.UserTurnEventData;
    import controller.server.events.UserEvent;
    
    import model.DiscussionModel;
    import model.User;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommand;
    
    import service.server.Server;
    
    public class UserTurnCommand extends BaseActor implements ICommand
    {
        [Inject]
        public var server:Server;
        [Inject]
        public var userEvent:UserEvent;
        [Inject]
        public var discussion:DiscussionModel;
        
        public function execute():void
        {
            var oldUser:User = discussion.currentSpeaker;
            var newUser:User = userEvent.user;
            var userName:String = newUser.name;
            var userChanged:Boolean = oldUser && newUser && oldUser.name != newUser.name;
            var now:Number = new Date().time;
            // change old user atts
            if (oldUser)
            {
                oldUser.timeUsedInPreviousTurns += now - oldUser.startedSpeakingAt;
            }
            // change new user atts
            newUser.startedSpeakingAt = now;
            //            newUser.requestingToSpeak = false;
            // change discussion state
            discussion.currentSpeakerName = userName;
            if (!oldUser || userChanged)
            {
                // relay message to clients
                var userTurnEventData:UserTurnEventData = new UserTurnEventData();
                userTurnEventData.userName = userName;
                userTurnEventData.eventType = UserTurnEvent.TURN_ACCEPTED;
                server.broadCast(userTurnEventData);
            }
        }
        
    }
}

