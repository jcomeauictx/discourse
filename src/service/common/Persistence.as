package service.common
{
    import spark.managers.PersistenceManager;

    public class Persistence
    {
        private var persistenceManager:PersistenceManager;
        public function Persistence()
        {
            persistenceManager = new PersistenceManager();
            persistenceManager.load();
        }
        
        public function write(name:String, value:Object):void
        {
            persistenceManager.setProperty(name, value);
        }
        
        public function read(name:String):Object
        {
            return persistenceManager.getProperty(name);
        }
        
        public function save():Boolean
        {
            return persistenceManager.save();
        }
    }
}