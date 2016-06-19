import Foundation

protocol AtomProtocol {
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
    
    static func dispatch(event: RootType.EventType) {
        dispatcher.dispatch(event)
    }
    
    static func addSubscriber<T: AtomSubscriber where T.EventType == RootType.EventType>(subscriber: T) -> String {
        return dispatcher.addSubscriber(subscriber)
    }
    
    static func removeSubscriber(key: String) {
        dispatcher.removeSubscriber(key)
    }
}