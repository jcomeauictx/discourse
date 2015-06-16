package model
{
    [RemoteClass(alias="model.User")]
	public class User
	{
		public var name:String;
		private var _timeUsedInPreviousTurns:Number = 0;
		private var _startedSpeakingAt:Number;
		private var _requestingToSpeak:Boolean;
		
		public function get requestingToSpeak():Boolean
		{
			return _requestingToSpeak;
		}

		public function set requestingToSpeak(value:Boolean):void
		{
			_requestingToSpeak = value;
		}

		public function get startedSpeakingAt():Number
		{
			return _startedSpeakingAt;
		}

		public function set startedSpeakingAt(value:Number):void
		{
			_startedSpeakingAt = value;
		}

		public function get timeUsedInPreviousTurns():Number
		{
			return _timeUsedInPreviousTurns;
		}

		public function set timeUsedInPreviousTurns(value:Number):void
		{
			_timeUsedInPreviousTurns = value;
		}

	}
}