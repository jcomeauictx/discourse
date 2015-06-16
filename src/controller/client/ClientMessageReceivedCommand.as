package controller.client
{
    import flash.net.Socket;
    import flash.utils.getDefinitionByName;
    
    import base.BaseActor;
    
    import controller.client.events.MessengerEvent;
    import controller.common.ClientEventData;
    import controller.common.DataEvent;
    
    import model.Synchronizer;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommand;
    
    import service.common.SocketHelper;
    
    public class ClientMessageReceivedCommand extends BaseActor implements ICommand
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
            var eventData:ClientEventData = obj as ClientEventData;
            if (eventData)
            {
                
                var eventClass:Class = Class(getDefinitionByName(eventData.eventClassName));
                var newEvent:DataEvent = new eventClass(eventData.eventType, eventData);
                var eventTime:Number = eventData.eventTime as Number;
                trace('on server: ' + eventData.eventType + " event time: " + eventTime);
                if (eventTime && !isNaN(eventTime))
                {
                    var lastClientTime:Number = synchronizer.getLastTimeReceivedFromClient(eventData.connectionId);
                    if (lastClientTime < eventTime)
                    {
                        trace('last client time: ' + lastClientTime + ' event time: ' + eventTime);
                        dispatch(newEvent);
                        synchronizer.setLastTimeReceivedFromClient(eventData.connectionId, eventTime);
                        trace('new last client time: ' + synchronizer.getLastTimeReceivedFromClient(eventData.connectionId));
                    }
                }
            }
        }
        
    }
}