package controller.server
{
	import base.BaseActor;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	
	import service.server.Server;
	
	public class ConnectToServerCommand extends BaseActor implements ICommand
	{
        [Inject]
        public var server:Server;
        
		public function execute():void
		{
            
		}
		
	}
}