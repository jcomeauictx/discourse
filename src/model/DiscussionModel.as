package model
{
	import flash.utils.Dictionary;
	
	import base.BaseActor;
	
	public class DiscussionModel extends BaseActor
	{
		public static var EPSILON:Number = 500;
		protected var members:Dictionary;
		private var _discussionLength:Number=10*60*1000;
		private var _beganAt:Number;
		private var _turnLength:Number=5*1000;
		private var _currentSpeakerName:String;
		
		public function DiscussionModel()
		{
			super();
			members = new Dictionary();
		}
		
        public function get hasBegun():Boolean
        {
            return !isNaN(beganAt);
        }
        
        public function set hasBegun(value:Boolean):void
        {
            if (!value)
            {
                beganAt = NaN;
            }
        }
        
		public function get beganAt():Number
		{
			return _beganAt;
		}

		public function set beganAt(value:Number):void
		{
			_beganAt = value;
		}

		public function get currentSpeaker():User
		{
			return _currentSpeakerName ? members[_currentSpeakerName] as User : null;
		}

		public function set currentSpeakerName(value:String):void
		{
			_currentSpeakerName = value;
		}

		public function get turnLength():Number
		{
			return _turnLength;
		}

		public function set turnLength(value:Number):void
		{
			_turnLength = value;
		}
		
		public function get discussionLength():Number
		{
			return _discussionLength;
		}

		public function set discussionLength(value:Number):void
		{
			_discussionLength = value;
		}

		public function addMember(user:User):void
		{
			members[user.name] = user;
		}
		
		public function removeUser(name:String):void
		{
			delete members[name];
		}
		
		public function get endsAt():Number
		{
			return isNaN(beganAt) || isNaN(discussionLength) ? NaN : beganAt + discussionLength;
		}
        
        public function getUserList():Array
        {
            var result:Array = [];
            for (var key:String in members)
            {
                result.push(members[key]);
            }
            return result;
        }
		
        public function reset():void
        {
            for (var key:String in members)
            {
                delete members[key];
            }
            currentSpeakerName = null;
            hasBegun = false;
        }
    }
}