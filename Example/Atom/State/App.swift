extension State {
    struct App: AtomState, AtomRoot {
        typealias EventType = Event
        static var instance = App.initial()
        static var parentClass: AtomNode.Type = App.self
        
        var todos: [Todo]
        
        static func react(optionalCurrent: App?, event: Event) -> App {
            guard var current = optionalCurrent else { return App.initial() }
            switch event {
            case .AddTodo(let name):
                let todo = Todo(name: name, checked: false)
                current.todos.append(todo)
                return current
            case .ToggleTodo(let key):
                current.todos[key] = Todo.react(current.todos[key], event: .ToggleTodo(key: key))
                return current
            }
        }
        
        static func initial() -> App {
            return App(todos: [])
        }
        
    }
}
