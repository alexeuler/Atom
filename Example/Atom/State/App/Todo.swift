extension State {
    struct Todo: AtomState {
        var name: String
        var checked: Bool
        
        typealias EventType = Event
        
        static var parentClass: AtomNode.Type = App.self
        
        static func react(optionalCurrent: Todo?, event: EventType) -> Todo {
            guard var current = optionalCurrent else { return initial() }
            
            switch event {
            case .ToggleTodo:
                current.checked = !current.checked
            default:
                break
            }
            
            return current
        }
        
        static func initial() -> Todo {
            return Todo(name: "", checked: false)
        }
    }
}
