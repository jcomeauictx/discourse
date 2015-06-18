package view
{
    import controller.server.events.DiscussionParametersEvent;
    
    import robotlegs.bender.bundles.mvcs.Mediator;
    
    import service.common.Persistence;
    
    public class DiscussionEditorMediator extends Mediator
    {
        
        
        [Inject]
        public var persistence:Persistence;
        [Inject]
        public var viewInstance:DiscussionEditor;
        
        private static const TOTAL_TIME:String = "TOTAL_TIME";
        private static const LENGTH_OF_TURN:String = "LENGTH_OF_TURN";
        
        public function DiscussionEditorMediator()
        {
            super();
        }
        
        override public function initialize():void
        {
            addViewListener(DiscussionParametersEvent.EDITED, onDiscussionParametersEdited, DiscussionParametersEvent);
            var totalTime:Number = Number(persistence.read(TOTAL_TIME));
            var lengthOfTurn:Number = Number(persistence.read(LENGTH_OF_TURN));
            if (!isNaN(totalTime) && totalTime > 0)
                viewInstance.totalTime = totalTime;
            if (!isNaN(lengthOfTurn) && lengthOfTurn > 0)
                viewInstance.lengthOfTurn = lengthOfTurn;
        }
        
        private function onDiscussionParametersEdited(e:DiscussionParametersEvent):void
        {
            persistence.write(TOTAL_TIME, e.totalTime);
            persistence.write(LENGTH_OF_TURN, e.turnLength);
            persistence.save();
            e.totalTime *= 1000 * 60;
            e.turnLength *= 1000;
            dispatch(e);
        }        
        
    }
}