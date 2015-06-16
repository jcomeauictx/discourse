package controller.common.events.clienttoserver
{
    import avmplus.getQualifiedClassName;
    
    import controller.common.ClientEventData;
    
    [RemoteClass(alias="controller.common.events.clienttoserver.LoginEventData")]
    public class LoginEventData extends ClientEventData
    {
        public var loginName:String;
        public function LoginEventData()
        {
            eventClassName = getQualifiedClassName(LoginEvent);
        }
    }
}

