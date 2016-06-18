extension State {
    struct Todo: AtomState, AtomSelector {
        var name: String
        var checked: Bool
        
        typealias AtomStateEvent = Event
        
        static var parentClass: AtomSelector.Type = App.self
        
        static func react(optionalState: Todo?, event: Event) -> Todo {
            guard var state = optionalState else { return initial() }
            
            switch event {
            case .ToggleTodo(let name):
                if name == state.name {
                    state.checked = !state.checked
                }
            default:
                break
            }
            
            return state
        }
        
        static func initial() -> Todo {
            return Todo(name: "", checked: false)
        }
    }
}
