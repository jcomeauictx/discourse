package controller.server
{
	import base.BaseActor;
	
	import controller.common.events.clienttoserver.DiscussionViewEvent;
	import controller.server.events.ClockEvent;
	
	import model.DiscussionModel;
	import model.User;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	
	import service.server.UserFetcher;
	
	public class RequestOrRelinquishTurnCommand extends BaseActor implements ICommand
	{
		
		[Inject]
		public var discussion:DiscussionModel;
        [Inject]
        public var speakEvent:DiscussionViewEvent;
        [Inject]
        public var userFetcher:UserFetcher;
		
		public function execute():void
		{
            if (!discussion.hasBegun)
            {
                discussion.beganAt = new Date().time;
            }
            // get user
            var user:User = userFetcher.getUserById(speakEvent.discussionEventData.connectionId);
            // change its atts
            user.requestingToSpeak = speakEvent.type == DiscussionViewEvent.REQUEST_TO_SPEAK ? true : false;
            // let strategy decide on discussion atts
            dispatch(new ClockEvent(ClockEvent.TIME_TO_ACT));
		}
		
	}
}