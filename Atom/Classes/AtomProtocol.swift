import Foundation

public protocol AtomProtocol {
    associatedtype RootType: AtomElement, AtomRoot
}

extension AtomProtocol {
    
    private static var dispatcher: AtomDispatcher<RootType.EventType, RootType> {
        get {
            dispatch_once(&AtomConfig.onceToken) {
                AtomConfig.dispatcher = AtomDispatcher<RootType.EventType, RootType>()
            }
            return AtomConfig.dispatcher as! AtomDispatcher<RootType.EventType, RootType>
        }
    }
    
    public static func dispatch(event: RootType.EventType) {
        dispatcher.dispatch(event)
    }
    
    public static func addSubscriber<T: AtomSubscriber where T.EventType == RootType.EventType>(subscriber: T) -> String {
        return dispatcher.addSubscriber(subscriber)
    }
    
    public static func removeSubscriber(key: String) {
        dispatcher.removeSubscriber(key)
    }
}