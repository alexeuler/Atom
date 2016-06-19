import Foundation

class AtomDispatcher<Event: AtomEvent, GlobalState: AtomState where GlobalState.AtomStateEvent == Event, GlobalState: AtomRootState> {
    
    private let queue: dispatch_queue_t = dispatch_queue_create("com.github.alleycat-at-git.atom", DISPATCH_QUEUE_SERIAL)
    private var subscribers: [String:AnyAtomSubscriber<Event>] = [:]
    
    func dispatch(event: Event) {
        dispatch_async(queue) { [weak self] in
            guard self != nil else { return }
            let current: GlobalState = GlobalState.instance
            let next: GlobalState = GlobalState.react(current, event: event)
            GlobalState.instance = next
            print(event)
            print(next.serialize())
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                guard self != nil else { return }
                self!.notify(event)
            }
        }
    }
    
    func addSubscriber<T: AtomSubscriber where T.AtomSubscriberEvent == Event>(subscriber: T) -> String {
        let uuid = NSUUID().UUIDString
        subscribers[uuid] = AnyAtomSubscriber(subscriber)
        return uuid
    }
    
    func removeSubscriber(key: String) {
        subscribers.removeValueForKey(key)
    }
    
    
    func notify(event: Event) {
        for (_, sub) in subscribers {
            sub.stateChanged(event)
        }
    }
}
