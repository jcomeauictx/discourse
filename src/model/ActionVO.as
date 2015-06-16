package model
{
	import flash.events.Event;
	
	public class ActionVO
	{
		public var actionEvent:Event;
		public var nextActionTime:Number;
		public function ActionVO(event:Event=null, nextAt:Number=NaN)
		{
			actionEvent = event;
			nextActionTime = nextAt;
		}
	}
}