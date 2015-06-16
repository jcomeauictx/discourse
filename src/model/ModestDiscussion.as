package model
{
	public class ModestDiscussion extends DiscussionModel
	{
		public function get modestCandidate():User
		{
			var modestMember:User;
			for (var userName:String in members)
			{
                var user:User = User(members[userName]);
				if (user.requestingToSpeak && (!modestMember || user.timeUsedInPreviousTurns < modestMember.timeUsedInPreviousTurns))
				{
					modestMember = user;
				}
			}
			return modestMember;
		}
		
		public function isCurrentSpeakerUntouchable(now:Number):Boolean
		{
			var currentSpeaker:User = currentSpeaker;
			var dontInterrupt:Boolean = currentSpeaker && (now - currentSpeaker.startedSpeakingAt + EPSILON) < turnLength;
			return dontInterrupt;
		}

	}
}