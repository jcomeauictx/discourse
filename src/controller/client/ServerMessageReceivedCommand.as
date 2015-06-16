package controller.client
{
	import flash.net.Socket;
	import flash.utils.getDefinitionByName;
	
	import base.BaseActor;
	
	import controller.client.events.MessengerEvent;
	import controller.common.DataEvent;
	import controller.common.EventData;
	
	import model.Synchronizer;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	
	import service.common.SocketHelper;
	
	public class ServerMessageReceivedCommand extends BaseActor implements ICommand
	{
        [Inject]
        public var eventInstance:MessengerEvent;
        [Inject]
        public var synchronizer:Synchronizer;
        [Inject]
        public var socketHelper:SocketHelper;
        
		public function execute():void
		{
            var socket:Socket = eventInstance.socket;
            var obj:Object = socketHelper.readSocket(socket);
            var eventData:EventData = obj as EventData;
            if (eventData)
            {
               
                var eventClass:Class = Class(getDefinitionByName(eventData.eventClassName));
                var newEvent:DataEvent = new eventClass(eventData.eventType, eventData);
                var eventTime:Number = eventData.eventTime as Number;
                trace('on client: ' + eventData.eventType + " event time: " + eventTime);
                if (eventTime && !isNaN(eventTime) && eventTime > synchronizer.lastClientReceivedTime)
                {
                    dispatch(newEvent);
                    synchronizer.lastClientReceivedTime = eventTime;
                }
            }
		}
        
	}
}