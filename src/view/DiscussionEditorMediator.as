package view
{
    import controller.server.events.DiscussionParametersEvent;
    
    import robotlegs.bender.bundles.mvcs.Mediator;
    
    public class DiscussionEditorMediator extends Mediator
    {
        
        
        public function DiscussionEditorMediator()
        {
            super();
        }
        
        override public function initialize():void
        {
            addViewListener(DiscussionParametersEvent.EDITED, dispatch, DiscussionParametersEvent);
        }
        
        
    }
}