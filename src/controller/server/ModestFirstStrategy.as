package controller.server
{
	import flash.events.Event;
	
	import base.BaseActor;
	
	import controller.server.events.ClockEvent;
	import controller.server.events.DiscussionEvent;
	import controller.server.events.UserEvent;
	
	import model.DiscussionModel;
	import model.ModestDiscussion;
	import model.User;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	
	public class ModestFirstStrategy extends BaseActor implements ICommand
	{
		
		private static var EPSILON:Number = 500;
		[Inject]
		public var discussion:ModestDiscussion;
		
		public function execute():void
		{
			var now:Number = new Date().getTime();
			publishCurrentState(now);
			dispatch(new ClockEvent(ClockEvent.RESET_CLOCK));
		}
		
		private function publishCurrentState(now:Number):void
		{
			var event:Event = getDiscussionOverEvent(now);
			if (!event)
			{
				event = getNewSpeakerEvent(now);
			}
			if (!event)
			{
				event = getDiscussionIdleEvent(now);
			}
			if (event)
			{
                trace('strategy says: ' + event.type);
				dispatch(event);
			}
            trace('strategy is silent');
		}
		
		private function getNewSpeakerEvent(now:Number):Event
		{
			var modest:User = discussion.modestCandidate;
            trace('modest speaker is: ' + (modest ?  modest.name : 'non-existent'));
			if (modest && !discussion.isCurrentSpeakerUntouchable(now))
			{
				return new UserEvent(UserEvent.TURN_ACCEPTED, modest);
			}
			return null;
		}
		
		private function getDiscussionIdleEvent(now:Number):Event
		{
            var currentSpeakerInBusiness:Boolean = 
                discussion.currentSpeaker && discussion.currentSpeaker.requestingToSpeak;
			if (!currentSpeakerInBusiness && !discussion.modestCandidate)
			{
				return new DiscussionEvent(DiscussionEvent.DISCUSSION_IDLE);
			}
			return null;
		}
		
		private function getDiscussionOverEvent(now:Number):Event
		{
            var difference:Number = discussion.endsAt - now;
			var condition:Boolean = difference < 0 || Math.abs(difference) < DiscussionModel.EPSILON;
			if (condition)
			{
				return new DiscussionEvent(DiscussionEvent.DISCUSSION_OVER);
			}
			return null;
		}
        
	}
}