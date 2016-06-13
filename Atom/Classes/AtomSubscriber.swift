protocol AtomSubscriber {
    associatedtype Event
    func stateChanged(event: Event)
}