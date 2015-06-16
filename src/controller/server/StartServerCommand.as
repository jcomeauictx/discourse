package controller.server
{
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	
	import service.server.Server;
	
	public class StartServerCommand implements ICommand
	{
        [Inject]
        public var server:Server;
        
		public function execute():void
		{
            if (!server.isOn)
            {
                server.connect(7934);
            }
		}
		
	}
}