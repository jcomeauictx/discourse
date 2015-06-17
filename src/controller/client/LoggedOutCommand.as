package controller.client
{
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	
	import service.client.Messenger;
	
	public class LoggedOutCommand implements ICommand
	{
        [Inject]
        public var messenger:Messenger;
        
		public function execute():void
		{
            messenger.reset();
		}
		
	}
}