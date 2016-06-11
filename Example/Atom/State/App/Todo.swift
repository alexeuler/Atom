extension State {
    struct Todo: AtomState {
        var name: String
        var checked: Bool
        
        typealias AtomEvent = Event
        
        static var parent: AtomSelector.Type = App.self
        static func resolve(parent: AtomSelector, keychain: AtomSelectorKeychain) -> Todo {
            let typedParent = parent as! App
            let key = keychain.getKey() as! Int
            return typedParent.todos[key]
        }
        
        static func react(optionalState: Todo?, event: AtomEvent) -> Todo {
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
