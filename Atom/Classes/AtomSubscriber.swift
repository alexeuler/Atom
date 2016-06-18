protocol AtomSubscriber {
    associatedtype AtomSubscriberEvent: AtomEvent
    func stateChanged(event: AtomSubscriberEvent)
}

class AnyAtomSubscriber<E: AtomEvent>: AtomSubscriber {
    
    var _stateChanged: (E) -> Void
    
    init<D: AtomSubscriber where D.AtomSubscriberEvent == E>(_ dependency: D) {
        _stateChanged = dependency.stateChanged
    }
    
    func stateChanged(event: E) {
        _stateChanged(event)
    }
}