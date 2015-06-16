package controller.client
{
	import base.BaseActor;
	
	import controller.common.events.servertoclient.ConnectionEvent;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	
	import service.client.Messenger;
	
	public class UserRegisteredCommand extends BaseActor implements ICommand
	{
        [Inject]
        public var messenger:Messenger;
        [Inject]
        public var eventInstance:ConnectionEvent;
        
		public function execute():void
		{
            messenger.connectionId = eventInstance.connectionEventData.connectionId;
		}
		
	}
}