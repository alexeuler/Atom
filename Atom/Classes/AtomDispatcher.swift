import Foundation

class Dispatcher<Event: AtomEvent, GlobalState: AtomGlobalState where GlobalState: AtomState> {
    
    private let queue: dispatch_queue_t = dispatch_queue_create("com.github.alleycat-at-git.atom", DISPATCH_QUEUE_SERIAL)
    private var subscribers: [AtomSubscriber] = []
    
    func handle(event: Event) {
        dispatch_async(queue) { [weak self] in
            guard self != nil else { return }
            let current: GlobalState = GlobalState.instance as! GlobalState
            let next = GlobalState.react(current, event: event)
            self!.globalState.instance = next
            dispatch_async(dispatch_get_main_queue()) { [weak self] in
                guard self != nil else { return }
                self!.notify(event)
            }
        }
    }
    
    func notify(event: Event) {
        for sub in subscribers {
            sub.stateChanged(event)
        }
    }
}
    
    
//    
//    class WeakSubscriber {
//        weak var value: Subscriber?
//        init(value: Subscriber) {
//            self.value = value
//        }
//    }
    
//    static let instance = Dispatcher()
//    
//    private let queue: dispatch_queue_t = dispatch_queue_create("ru.secret-lab.dispatcher", DISPATCH_QUEUE_SERIAL)
//    private var subscribers: [WeakSubscriber] = []
//    
//    func subscribe(target: DispatcherSubscriber) {
//        for sub in self.subscribers {
//            if sub.value === target {
//                return
//            }
//        }
//        self.subscribers.append(WeakSubscriber(value: target))
//        log.verbose("Subscribed \(target)")
//        log.verbose("Total subs count: \(subscribers.count)")
//    }
//    
//    func unsubscribe(target: DispatcherSubscriber) {
//        var result:[WeakSubscriber] = []
//        for weakSub in self.subscribers {
//            if weakSub.value !== target {
//                result.append(weakSub)
//            }
//        }
//        self.subscribers = result
//        log.verbose("Unsubscribed \(target)")
//        log.verbose("Total subs count: \(subscribers.count)")
//    }
//    
//    func perform(action: Action) {
//        log.info("Performed action: \(action)")
//        dispatch_async(queue) {
//            StateApp.instance.current = StateApp.instance.react(original: StateApp.instance.current, action: action)
//            dispatch_async(dispatch_get_main_queue()) { [unowned self] in
//                log.verbose("Current state:\n \(String.anyToString(StateApp.instance.current))")
//                
//                self.cleanUpSubscribers()
//                self.notifySubscribers(action)
//            }
//        }
//    }
//    
//    private func cleanUpSubscribers() {
//        var result: [WeakSubscriber] = []
//        for weakSub in self.subscribers {
//            if weakSub.value != nil {
//                result.append(weakSub)
//            }
//        }
//        subscribers = result
//    }
//    
//    
//    private func notifySubscribers(action: Action) {
//        log.verbose("Notifying \(subscribers.count) subs of \(action)")
//        for weakSub in subscribers {
//            if let sub = weakSub.value {
//                sub.stateChanged(action)
//            }
//        }
//    }


