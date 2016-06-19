protocol AtomSubscriber {
    associatedtype EventType: AtomEvent
    func stateChanged(event: EventType)
}

class AnyAtomSubscriber<E: AtomEvent>: AtomSubscriber {
    
    var _stateChanged: (E) -> Void
    
    init<D: AtomSubscriber where D.EventType == E>(_ dependency: D) {
        _stateChanged = dependency.stateChanged
    }
    
    func stateChanged(event: E) {
        _stateChanged(event)
    }
}