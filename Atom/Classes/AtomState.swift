protocol AtomState: AtomSelector {
    /*
     This is the global event class defined for the whole app
     */
    associatedtype Event: AtomEvent
    
    /*
     This variable returns part of a global state corresponding to
     this class.
     NOTE: It is recommended to define this function in terms
     of instance var of the closest parent.
     */
//    static func instance(parent: AtomState, keys: Int...) -> Self
    
    /* This function returns the new state as a reaction to
     the dispathed event. Note that incoming state can be nil,
     in this case it is recommended to return initial state
     */
    static func react(optionalState: Self?, event: Event) -> Self
    
    /*
     This is the default initial state
     */
    static func initial() -> Self
}

extension AtomState {
    static func react(optionalState: Self?, event: Event) -> Self {
        return optionalState ?? initial()
    }
    
    func serialize() -> String {
        return AtomUtils.anyToString(self)
    }
}


