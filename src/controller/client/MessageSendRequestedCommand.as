package controller.client
{
	import base.BaseActor;
	
	import controller.client.events.MessageToServerEvent;
	import controller.common.ClientEventData;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	
	import service.client.Messenger;
	
	public class MessageSendRequestedCommand extends BaseActor implements ICommand
	{
        [Inject]
        public var eventInstance:MessageToServerEvent;
        [Inject]
        public var messenger:Messenger;
        
		public function execute():void
		{
            var clientData:ClientEventData = eventInstance.clientEventData;
            clientData.connectionId = messenger.connectionId;
            clientData.eventTime = new Date().time;
            trace('sending message from client: ' + clientData.eventType);
            messenger.sendMessage(clientData);
		}
		
	}
}