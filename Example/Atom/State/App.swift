extension State {
    struct App: AtomState, AtomRoot {
        typealias EventType = Event
        static var instance = App.initial()
        static var parentClass: AtomNode.Type = App.self
        
        var todos: [Todo]
        
        static func react(optionalState: App?, event: Event) -> App {
            guard var state = optionalState else { return App.initial() }
            switch event {
            case .AddTodo(let name):
                let todo = Todo(name: name, checked: false)
                state.todos.append(todo)
                return state
            case .ToggleTodo(let key):
                state.todos[key] = Todo.react(state.todos[key], event: .ToggleTodo(key: key))
                return state
            }
        }
        
        static func initial() -> App {
            return App(todos: [])
        }
        
    }
}
