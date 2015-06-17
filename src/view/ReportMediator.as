package view
{
    import mx.collections.ArrayCollection;
    
    import spark.formatters.DateTimeFormatter;
    
    import robotlegs.bender.bundles.mvcs.Mediator;
    
    public class ReportMediator extends Mediator
    {
        [Inject]
        public var viewInstance:Report;
        
        public function ReportMediator()
        {
            super();
        }
        
        override public function initialize():void
        {
            viewInstance.formatter = new DateTimeFormatter();
            viewInstance.formatter.dateTimePattern = "m:ss";
            provideDataProvider();
        }
        
        private function provideDataProvider():void
        {
            var usersArray:Array = viewInstance.data as Array;
            if (usersArray)
            {
                viewInstance.dataProvider = new ArrayCollection(usersArray);
            }
        }
        
    }
}