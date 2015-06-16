package model
{
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    public class ClientSynchronizer
    {
        private var timer:Timer;
        private var lastAction:Function;
        
        public function ClientSynchronizer()
        {
            timer = new Timer(500, 1);
            timer.addEventListener(TimerEvent.TIMER, onTimer);
        }
        
        protected function onTimer(event:TimerEvent):void
        {
            lastAction();
        }
        
        public function insertToQueue(action:Function):void
        {
            lastAction = action; // should be enough for now
            timer.reset();
            timer.start();
        }
        

    }
}