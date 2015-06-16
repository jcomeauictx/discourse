package controller.server
{
    import base.BaseActor;
    
    import controller.client.events.UserDiscussionEvent;
    import controller.server.events.DiscussionParametersEvent;
    
    import model.DiscussionModel;
    
    import robotlegs.bender.extensions.commandCenter.api.ICommand;
    
    public class DiscussionParametersEditedCommand extends BaseActor implements ICommand
    {
        [Inject]
        public var discussion:DiscussionModel;
        [Inject]
        public var discussionParametersEvent:DiscussionParametersEvent;
        
        public function execute():void
        {
            discussion.discussionLength = discussionParametersEvent.totalTime;
            discussion.turnLength = discussionParametersEvent.turnLength;
            dispatch(new UserDiscussionEvent(UserDiscussionEvent.START_SERVER));
        }
        
    }
}
