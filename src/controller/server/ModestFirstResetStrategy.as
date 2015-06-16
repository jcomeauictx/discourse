package controller.server
{
	import base.BaseActor;
	
	import model.Clock;
	import model.ModestDiscussion;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	
	public class ModestFirstResetStrategy extends BaseActor implements ICommand
	{
		
		[Inject]
		public var discussion:ModestDiscussion;
		[Inject]
		public var clock:Clock;
		
		public function execute():void
		{
			var now:Number = new Date().getTime();
			reset(now);
		}
		
		private function reset(now:Number):void
		{
			var nextAction:Number = finish(now);
			if (nextAction < 0)
			{
				nextAction = getNext(now);
			}
			if (nextAction > 0)
			{
				clock.delay = nextAction;
			} else
            {
               trace('----- no next action -----------'); 
            }
		}
		
		private function finish(now:Number):Number
		{
			if (!discussion.currentSpeaker || 
				(discussion.currentSpeaker.startedSpeakingAt + discussion.turnLength) > discussion.endsAt)
			{
                trace('---- waiting for finish -----');
				return discussion.endsAt - now;
			}
			return -1;
		}
		
		private function getNext(now:Number):Number
		{
			if (discussion.currentSpeaker)
			{
                trace('---- waiting for next -----');
				return discussion.currentSpeaker.startedSpeakingAt + discussion.turnLength - now;
			}
			return -1;
		}
		
	}
}