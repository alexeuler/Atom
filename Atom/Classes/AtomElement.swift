protocol AtomElement {
    /*
     This is the global event class defined for the whole app
     */
    associatedtype EventType: AtomEvent
    
    /* This function returns the new state as a reaction to
     the dispathed event. Note that incoming state can be nil,
     in this case it is recommended to return initial state
     */
    static func react(optionalCurrent: Self?, event: EventType) -> Self
    
    /*
     This is the default initial state
     */
    static func initial() -> Self
}

extension AtomElement {
    static func react(optionalCurrent: Self?, event: EventType) -> Self {
        return optionalCurrent ?? initial()
    }
    
    func serialize() -> String {
        return AtomUtils.anyToString(self)
    }
}


