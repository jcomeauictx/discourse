package service.server
{
    import flash.utils.Dictionary;
    
    import controller.client.events.MessageToServerEvent;
    
    import model.User;
    
    public class UserFetcher
    {
        private var dictionary:Dictionary = new Dictionary();
        
        public function UserFetcher()
        {
            super();
        }
        
        public function getUserById(connectionId:int):User
        {
            return dictionary[connectionId] as User;
        }
        
        public function getUserByEvent(e:MessageToServerEvent):User
        {
            return getUserById(e.clientEventData.connectionId);
        }
        
        public function setUser(connectionId:int, user:User):void
        {
            dictionary[connectionId] = user;
        }
        
        public function removeUser(connectionId:int):void
        {
            delete dictionary[connectionId];
        }
        
        public function reset():void
        {
            for (var key:String in dictionary)
            {
                delete dictionary[key];
            }
        }
    }
}